@HappyPath @WarningObjHis
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  UpdateCreditProfile HappyPath test


  @CreateCreditProfile_happyPath_test
  Scenario Outline: UpdateCreditProfile : <testScenario>
    # GET DATA FROM TDM
    * def testDataSpec = read('WarningData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    # generate new Customer ID, set it in testData
    * def generateRandomNumber = read(PATH_FILES + 'generateRandomNumber.js')
    * set testData.Id = 10 + generateRandomNumber(3)
    * set testData.payloadName = 'Indvl_CreditDetails_payload.json'
    * print testData
    
    # Call createCreditProfile service to create User
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    And match Id == Id
    * def profileId = resp.creditProfile[0].id
    * set testData.profileId = profileId
    * def warHistoryId = resp.creditProfile[0].telusCharacteristic.warningHistoryList[0].warningHistoryId
    * set testData.warHistoryId = warHistoryId
    
    # Call UpdateCreditProfile service to update User data
    * set testData.payloadUpdate = 'UpdateExistingWarningObj_payload.json'
    * def response =  call read(PATH_SERVICES_UPDATECPROFILE+'UpdateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def res = $.response
    And def Id = $.response.id
    #Response Validations
    
    # Response validation with updated data 
    Then match res.creditProfile[0].telusCharacteristic.warningHistoryList[0].warningStatusCd == testData.warStatsCdUpdate
    Then match res.creditProfile[0].telusCharacteristic.warningHistoryList[0].warningCd == testData.warCdUpdate
    Then match res.creditProfile[0].telusCharacteristic.warningHistoryList[0].warningCategoryCd == testData.warCtgryCdUpdate
    
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
    
    #Assertion data in Credit_Warning_History TABLE
    * def CrdWarQry = testSpecFileRead.Queries.CrdWar
    * replace CrdWarQry.credit_profile_id = testData.profileId
    * def CrdWarQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CrdWarQry)'}
    * def CrdWarResult = CrdWarQryResult.dbResult
    * print 'CREDIT_WARNING_HISTORY TABLE Result: ' + CrdWarResult
    Then match CrdWarResult[0] contains { warning_status_cd: '#notnull' }
    Then match CrdWarResult[0] contains { warning_cd: '#notnull' }
    Then match CrdWarResult[0] contains { warning_category_cd: '#notnull' }
    * string warningHisIdUpdated = CrdWarResult[0].warning_id
    Then match warningHisIdUpdated == warHistoryId
    Then match CrdWarResult[0].version == 2
  

    Examples: 
      | testScenario                                           | data     |
      | Update Warning Details from Unverified to Irresolvable | 'UnToIr' |
      | Update Warning Details from Irresolvable to Unverified | 'IrToUn' |
