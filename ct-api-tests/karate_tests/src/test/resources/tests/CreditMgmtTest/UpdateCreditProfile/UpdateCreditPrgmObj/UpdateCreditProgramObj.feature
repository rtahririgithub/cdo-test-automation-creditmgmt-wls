@HappyPath @CreditPrgm
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  UpdateCreditProfile HappyPath test


  @CreateCreditProfile_happyPath_test
  Scenario Outline: UpdateCreditProfile : <testScenario>
    # GET DATA FROM TDM
    * def testDataSpec = read('UpdateCreditPrgmObjData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    # generate new Customer ID, set it in testData
    * def generateRandomNumber = read(PATH_FILES + 'generateRandomNumber.js')
    * set testData.Id = 20 + generateRandomNumber(3)
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
    * print testData
    
    # Call UpdateCreditProfile service to update User data
    * set testData.payloadUpdate = 'UpdateCreditDetails_payload.json'
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
    
    #Assertion data in Credit_profile_relationship_TABLE
    * def cprQry = testSpecFileRead.Queries.cprQryUpdate
    * def cprQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(cprQry)'}
    * def cprResult = cprQryResult.dbResult
    * print 'CUSTOMER_CREDIT_PROFILE_REL TABLE Result: ' + cprResult
    Then match cprResult contains { credit_profile_id: '#notnull' }
    * string CreditProfileId = cprResult[0].credit_profile_id
    Then match CreditProfileId == testData.profileId
    
    #Assertion data in Credit_profile_TABLE
    * def crdProfileQry = testSpecFileRead.Queries.crdProfile
    * replace crdProfileQry.credit_profile_id = testData.profileId
    * def crdProfileQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(crdProfileQry)'}
    * def crdProfileResult = crdProfileQryResult.dbResult
    * print 'CREDIT_PROFILE TABLE Result: ' + crdProfileResult
    Then match crdProfileResult[0].agency_decision_code == testData.bureauDCUpdate
    Then match crdProfileResult[0].credit_program_name == testData.creditPrgNMUpdate
    Then match crdProfileResult[0] contains { credit_class_code: '#notnull' }
    Then match crdProfileResult[0].credit_score_type_code == 'CUSTOM'
    Then match crdProfileResult[0] contains { credit_decision_code: '#notnull' }
    Then match crdProfileResult[0].clp_credit_limit_amt == testData.creditLimitUpdate
    Then match crdProfileResult[0].security_dep_amt == null
    * def credit_profile_ts = crdProfileResult[0].credit_profile_ts
    * def credit_profile_ts_TS = DateVal.isValid(credit_profile_ts)
    Then match credit_profile_ts_TS == true
    * string endTS = crdProfileResult[0].valid_end_ts
    * string startTS = crdProfileResult[0].valid_start_ts
    * def TSValidation = TSValidator.dateValitade(endTS,startTS)
    Then match TSValidation == 'ValidDate'

    Examples: 
      | testScenario                            | data       |
      | Update Credit Class from X To K         | 'XToK'     |
      | Updating Credit Program from CLP to DEP | 'CLPToDEP' |
      | Updating Credit Program from CLP to DCL | 'CLPToDCL' |
      | Updating Credit Program from DEP to CLP | 'DEPToCLP' |
      | Updating Credit Program from DEP to NDP | 'DEPToNDP' |
