@HappyPath @ContactMed
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  UpdateCreditProfile HappyPath test


  @CreateCreditProfile_happyPath_test
  Scenario Outline: UpdateCreditProfile : <testScenario>
    # GET DATA FROM TDM
    * def testDataSpec = read('ContactMediumData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    #generate new Customer ID, set it in testData
    * def generateRandomNumber = read(PATH_FILES + 'generateRandomNumber.js')
    * set testData.Id = 20 + generateRandomNumber(3)
    * set testData.payloadName = 'IndvlIdentificationDL_PRV_payload.json'
    * print testData
    
     #Call createCreditProfile service to create User
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    And match Id == Id
    * def profileId = resp.creditProfile[0].id
    * set testData.profileId = profileId
    * print testData
    
    # Call UpdateCreditProfile service to update User data
    * set testData.payloadUpdate = 'AddNewContactMedium.json'
    * def response =  call read(PATH_SERVICES_UPDATECPROFILE+'UpdateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    
    #Response Validations
    And match Id == Id
    
    #Db validations
    
    * def testSpecFileRead = read(PATH_QUERIES+ 'UpdateCreditQueries.json')
    * def TSValidator = Java.type("com.telus.api.test.utils.CurrentDate")
    * def DateVal = Java.type("com.telus.api.test.utils.DateValidator")
    
    #Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * string id = CustomerResult[0].customer_id
    And match id == Id
    * def party_id = CustomerResult[0].party_id
    
     #Assertion data in PARTY_CONTACT_MEDIUM TABLE
    * def parContMedQry = testSpecFileRead.Queries.parContMedUpdateNew
    * replace parContMedQry.party_id = party_id
    * def parContMedQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(parContMedQry)'}
    * def parContMedResult = parContMedQryResult.dbResult
    * print 'PARTY_CONTACT_MEDIUM TABLE Result: ' + parContMedResult

    Then match parContMedResult[0].medium_type == testData.medTyp
    Then match parContMedResult[0].state_province_code == testData.provinceNew
    Then match parContMedResult[0].country_code == testData.countryNew
    Then match parContMedResult[0].city == testData.cityNew
    Then match parContMedResult[0].contact_type == testData.cntctTypNew
    Then match parContMedResult[0].post_code == testData.postCdNew
    Then match parContMedResult[0].contact_type == testData.cntctTypNew
    * string PartyCMEndTS = parContMedResult[0].valid_end_ts
    * string partyCMStartTS = parContMedResult[0].valid_start_ts
    * def partyCMTSValidation = TSValidator.dateValitade(PartyCMEndTS,partyCMStartTS)
    Then match partyCMTSValidation == 'ValidDate'
    

    Examples: 
      | testScenario               | data    |
      | Add New Contact Medium Obj | 'NewCM' |
