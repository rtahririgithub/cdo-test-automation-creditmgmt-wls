@HappyPath @OrgDLBICIdentification
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  UpdateCreditProfile HappyPath test


  @CreateCreditProfile_happyPath_test
  Scenario Outline: UpdateCreditProfile : <testScenario>
    # GET DATA FROM TDM
    * def testDataSpec = read('Update_Existing_Single_IdData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    # generate new Customer ID, set it in testData
    * def generateRandomNumber = read(PATH_FILES + 'generateRandomNumber.js')
    * set testData.Id = 11 + generateRandomNumber(3)
    * set testData.payloadName = 'OrgIdentificationTyp_payload.json'
    * print testData
    
    
    # Call createCreditProfile service to create User
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    And match Id == Id
    
    # Call UpdateCreditProfile service to update User data
    * set testData.payloadUpdate = 'OrgIdentification_payload.json'
    * def response =  call read(PATH_SERVICES_UPDATECPROFILE+'UpdateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def res = $.response
    And def Id = $.response.id
    
    #Response Validations
    And match Id == Id
    Then match res.engagedParty.organizationIdentification[1].identificationId == testData.IdNumUpdate
    Then match res.engagedParty.organizationIdentification[1].validFor.endDateTime == testData.endDateTimeUpdate
    Then match res.engagedParty.organizationIdentification[1].validFor.startDateTime == testData.startDateTimeUpdate
    
    #Db validations
    
    * def testSpecFileRead = read(PATH_QUERIES+ 'UpdateCreditQueries.json')
    * def TSValidator = Java.type("com.telus.api.test.utils.CurrentDate")
    * def DateVal = Java.type("com.telus.api.test.utils.DateValidator")
    
    #Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * def party_id = CustomerResult[0].party_id
    
    #Assertion data in Party_TABLE
    * def PartyQry = testSpecFileRead.Queries.PartyQry
    * replace PartyQry.party_id = party_id
    * def PartyQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyQry)'}
    * def PartyResult = PartyQryResult.dbResult
    * print 'PARTY TABLE Result: ' + PartyResult
    Then match PartyResult[0].party_id != null
    Then match PartyResult[0].party_type == testData.ReffTyp
    
    #Assertion data in Party_Identification_TABLE
    * def PartyIdentificationQry = testSpecFileRead.Queries.PartyIdentifctnQryUpdate
    * replace PartyIdentificationQry.party_id = party_id
    * def PartyIdentificationQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyIdentificationQry)'}
    * def PartyIdentificationResult = PartyIdentificationQryResult.dbResult
    * print 'PARTY_IDENTIFICATION TABLE Result: ' + PartyIdentificationResult
    * def IdntID_id = PartyIdentificationResult[0].identificaton_id
    Then match PartyIdentificationResult[0].id_type == testData.id_typ2
    Then match PartyIdentificationResult[0].version == 1
    * string partyEndTS = PartyIdentificationResult[0].valid_end_ts
    * string partyStartTS = PartyIdentificationResult[0].valid_start_ts
    Then match partyEndTS == testData.endDateUpdated
    Then match partyStartTS == testData.startDateUpdated
    * def partyTSValidation = TSValidator.dateValitade(partyEndTS,partyStartTS)
    Then match partyTSValidation == 'ValidDate'
    
    #Assertion data in Identification_Char TABLE
    * def IdentificationCharQry = testSpecFileRead.Queries.IdentCharUpdate
    * replace IdentificationCharQry.IdntID_id = IdntID_id
    * def IdentificationCharQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentificationCharQry)'}
    * def IdentificationCharResult = IdentificationCharQryResult.dbResult
    * print 'IDENTIFICATION_CHAR TABLE Result: ' + IdentificationCharResult
    Then match IdentificationCharResult[0] contains { Key:'identificationId' }
    Then match IdentificationCharResult[0].version == 1
   
    
    #Assertion data in Identification_Char_Hash TABLE
    * def IdentCharHashQry = testSpecFileRead.Queries.IdentCharHashUpdate
    * replace IdentCharHashQry.IdntID_id = IdntID_id
    * def IdentCharHashQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentCharHashQry)'}
    * def IdentCharHashResult = IdentCharHashQryResult.dbResult
    * print 'IDENTIFICATION_CHAR_HASH TABLE Result: ' + IdentCharHashResult
    Then match IdentCharHashResult[0] contains { Key:'identificationId' }
    Then match IdentCharHashResult[0].version == 1

    Examples: 
      | testScenario          | data                |
      | Existing DL Add BIC | 'ExistingDL_AddBIC' |
