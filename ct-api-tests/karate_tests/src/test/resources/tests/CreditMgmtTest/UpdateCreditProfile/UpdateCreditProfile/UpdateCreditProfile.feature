@HappyPath @CreditProfile
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  UpdateCreditProfile HappyPath test


  @CreateCreditProfile_happyPath_test
  Scenario Outline: UpdateCreditProfile : <testScenario>
    # GET DATA FROM TDM
    * def testDataSpec = read('UpdateCreditProfileData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    # generate new Customer ID, set it in testData
    * def generateRandomNumber = read(PATH_FILES + 'generateRandomNumber.js')
    * set testData.Id = 21 + generateRandomNumber(3)
    * set testData.payloadName = 'IndvlIdentificationDL_PRV_payload.json'
    * print testData
    
    # Call createCreditProfile service to create User
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    And match Id == Id
    * def profileId = resp.creditProfile[0].id
    * set testData.profileId = profileId
    * print testData 
    
    # Call UpdateCreditProfile service to update User data
    * set testData.payloadUpdate = 'Update_CreditProfile_Payload.json'
    * def response =  call read(PATH_SERVICES_UPDATECPROFILE+'UpdateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    
    #Response Validations
    And match Id == Id
    
    #Db Validations
    
    * def testSpecFileRead = read(PATH_QUERIES+ 'UpdateCreditQueries.json')
    * def TSValidator = Java.type("com.telus.api.test.utils.CurrentDate")
    * def DateVal = Java.type("com.telus.api.test.utils.DateValidator")
    
    #Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * def party_id = CustomerResult[0].party_id
     * def DateToday = TSValidator.DateToday()
    #Then match DateToday == CustomerResult[0].updated_ts
    
    #Assertion data in Party_TABLE
    * def PartyQry = testSpecFileRead.Queries.PartyQry
    * replace PartyQry.party_id = party_id
    * def PartyQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyQry)'}
    * def PartyResult = PartyQryResult.dbResult
    * print 'PARTY TABLE Result: ' + PartyResult
    Then match PartyResult[0].party_id != null
    
     #Assertion data in Credit_profile_TABLE
    * def crdProfileQry = testSpecFileRead.Queries.crdProfile
    * replace crdProfileQry.credit_profile_id = testData.profileId
    * def crdProfileQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(crdProfileQry)'}
    * def crdProfileResult = crdProfileQryResult.dbResult
    * print 'CREDIT_PROFILE TABLE Result: ' + crdProfileResult
     Then match crdProfileResult[0] contains { credit_risk_rating: '#notnull' }
     Then match crdProfileResult[0] contains { credit_score: '#notnull' }
    * string ActualEndTs = crdProfileResult[0].valid_end_ts
    * string ExpectedEndTs = testData.endTimeAssert
    * def DateToday = TSValidator.DateAssert(ActualEndTs, ExpectedEndTs)
    Then match DateToday == 'Valid'
   

    Examples: 
      | testScenario                             | data                  |
      | Update fields for existing creditProfile | 'UpdateCreditProfile' |
