@get
Feature: getCreditProfile

  Scenario Outline: get Credit management profile
     * def credit_profile_id = "011cd1ad-cacb-4bb9-adfa-9a7477e403b4"
     ###DB Validations
    # Calling CryptoService class to convert from encryption values to decrypto values which are stored IN DB
    #Create instance for Cryptoclass and calling the Decrypt() method
    * def CryptoServices = Java.type('com.telus.api.test.utils.CryptoService')
    
    ###Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * string id = CustomerResult[0].customer_id
    And match id == CustomerID
    * string role = CustomerResult[0].role
    #And match role == role1
    
    
    ###Assertion data in Credit_profile_relationship_TABLE
    * def cprQry = testSpecFileRead.Queries.cprQry
    * def cprQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(cprQry)'}
    * def cprResult = cprQryResult.dbResult
    * print 'CUSTOMER_CREDIT_PROFILE_REL TABLE Result: ' + cprResult
    * string  DB_credit_profile_id = cprResult[0].credit_profile_id
    And match DB_credit_profile_id == credit_profile_id
    
    
    ###Assertion data in Credit_profile_TABLE
    * def crdProfileQry = testSpecFileRead.Queries.crdProfile
    * replace crdProfileQry.credit_profile_id = credit_profile_id
    * def crdProfileQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(crdProfileQry)'}
    * def crdProfileResult = crdProfileQryResult.dbResult
    * print 'CREDIT_PROFILE TABLE Result: ' + crdProfileResult
    * string  DB_credit_profile_id = crdProfileResult[0].credit_profile_id
    Then match crdProfileResult[0].credit_profile_id != null
    Then match DB_credit_profile_id  == credit_profile_id
    Then match crdProfileResult[0].agency_decision_code == <bureauDC>
    * def DecryptCrediRiskRating = new CryptoServices().decrypt(crdProfileResult[0].credit_risk_rating)
    Then match DecryptCrediRiskRating == <creditRiskLevelNum>
    * def Decryptcredit_score = new CryptoServices().decrypt(crdProfileResult[0].credit_score)
    Then match Decryptcredit_score == <creditSCR>
   
    * def Decryptcredit_class_code = new CryptoServices().decrypt(crdProfileResult[0].credit_class_code)
     Then match Decryptcredit_class_code == <creditCls>
     
     * def Decryptrisk_level_decision_code = new CryptoServices().decrypt(crdProfileResult[0].risk_level_decision_code)
     Then match Decryptrisk_level_decision_code ==  <creditRiskLevelDecisionCd>
     
     * def Decryptcredit_decision_code = new CryptoServices().decrypt(crdProfileResult[0].credit_decision_code)
     Then match Decryptcredit_decision_code == <creditDecisionCd>
     
     
     Then match crdProfileResult[0].credit_program_name == <creditPrgNM>
    Then match crdProfileResult[0].credit_score_type_code == 'CUSTOM'
    Then match crdProfileResult[0].credit_profile_id_legacy == null
    Then match crdProfileResult[0].clp_credit_limit_amt == 210.00
    Then match crdProfileResult[0].security_dep_amt == null
    #Then match crdProfileResult[0].credit_assessment_id != null
    Then match crdProfileResult[0].application_sub_prov_cd == <province>
    Then match crdProfileResult[0].clp_contract_term == 24
    Then match crdProfileResult[0].clp_rate_plan_amt == 170
    * def credit_profile_ts = crdProfileResult[0].credit_profile_ts
    * def credit_profile_ts_TS = DateVal.isValid(credit_profile_ts)
    Then match credit_profile_ts_TS == true
    * string endTS = crdProfileResult[0].valid_end_ts
    * string startTS = crdProfileResult[0].valid_start_ts
    * def TSValidation = TSValidator.dateValitade(endTS,startTS)
    Then match TSValidation == 'ValidDate'
    Then match crdProfileResult[0] contains { credit_profile_id: '#notnull' }
    
    
    ###Assertion data in Credit_Warning_History TABLE
    * def CrdWarQry = testSpecFileRead.Queries.CrdWar
    * replace CrdWarQry.credit_profile_id = credit_profile_id
    * def CrdWarQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CrdWarQry)'}
    * def CrdWarResult = CrdWarQryResult.dbResult
    * print 'CREDIT_WARNING_HISTORY TABLE Result: ' + CrdWarResult
    * def Decryptwarning_status_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_status_cd)
    Then match Decryptwarning_status_cd == <warStsCd>
    * def Decryptwarning_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_cd)
    Then match Decryptwarning_cd == <warCd>
    * def Decryptwarning_category_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_category_cd)
    Then match Decryptwarning_category_cd == <WarngCd>
    * def Decryptwarning_type_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_type_cd)
    Then match Decryptwarning_type_cd == 'SAFESCAN'
    * def Decryptwarning_Item_Type_Cd = new CryptoServices().decrypt(CrdWarResult[0].warning_Item_Type_Cd)
    Then match Decryptwarning_Item_Type_Cd == 'DL'
    Then match CrdWarResult[0].approval_external_id == null
    
    * def Decryptwarning_status_cd = new CryptoServices().decrypt(CrdWarResult[1].warning_status_cd)
    Then match Decryptwarning_status_cd == <warStsCd>
    * def Decryptwarning_cd = new CryptoServices().decrypt(CrdWarResult[1].warning_cd)
    Then match Decryptwarning_cd == <warCd2>
    * def Decryptwarning_category_cd = new CryptoServices().decrypt(CrdWarResult[1].warning_category_cd)
    Then match Decryptwarning_category_cd == <WarngCd2>
    * def Decryptwarning_type_cd = new CryptoServices().decrypt(CrdWarResult[1].warning_type_cd)
    Then match Decryptwarning_type_cd == 'SAFESCAN'
    

    #* string crdWarEndTS = CrdWarResult[0].valid_end_ts
    #* string crdWarStartTS = CrdWarResult[0].valid_start_ts
    #* def CrdWarTSValidation = TSValidator.dateValitade(crdWarEndTS,crdWarStartTS)
    #Then match CrdWarTSValidation == 'ValidDate'
    #
 
  
#Assertion data in READDB_SYNC_STATUS TABLE
    #* def ReadDBSynQry = testSpecFileRead.Queries.ReadDBSyn
    #* def ReadDBSynQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(ReadDBSynQry)'}
    #* def ReadDBSynResult = ReadDBSynQryResult.dbResult
    #* print 'READDB_SYNC_STATUS TABLE Result: ' + ReadDBSynResult
    #Then match ReadDBSynResult[0].need_to_sync == false

 Examples:
      | testScenario                             |  ReffTyp          |creditRiskLevelNum| creditSCR|creditRiskLevelDecisionCd|creditDecisionCd| bureauDC | creditCls | creditPrgNM | WarngCd |WarngCd2|province| warStsCd   | warCd  |warCd2|role1   |warningDetectionTs      |
      | TC1_get  CCls B & prgm DEP   |  'RiskAssessment' | 600              |      600 |'RL001'                  |'D001'            | 'E29'    | 'L'       | 'CLP'       | 'AFM'   |   'BCW'|'BC'    |'VERIFIED'   | 'F'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|
     
  