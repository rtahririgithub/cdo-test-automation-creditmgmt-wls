#Phase2
Feature: CreditManagement - Update_CreditProfile

  Background: 
    *print  UpdateCreditProfile HappyPath test


  @UpdateCreditProfile_Positive_TC  @UpdateCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs  @WLN  @WLN_UpdateCreditProfile
  Scenario Outline: UpdateCreditProfile : Valid Data with <testScenario>
  
 	 
    * def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
    
    * def RandomIdNum =  RandomNum.getRandom9digitNumber()
    * print  'RandomIdNum=='+ RandomIdNum
   
   * def testDataSpec = read('Update_Warning_Obj_TestData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    * testData.Id=RandomCustomerID
    * testData.IdNum = "'"+RandomIdNum+"'"
    * set testData.payloadName = 'WLN_CreateCreditProfile_MultipleWarning_Obj.json'
    * print testData
    
    # Call createCreditProfile service to create User
    * def response =  call read(PATH_SERVICES_PH2_2+'CreateProfile/CreateCreditProfile_Operation.feature') testData
 	 Then print "final response: " + response.response
 	 
    
    ## #Asssertion on REST response
    And def resp = $.response
    
    And def credit_profile_id = $.response.id
    * print "credit_profile_id : " +credit_profile_id
    And def CustomerID = $.response.relatedParty[0].id
    * print "CustomerID : " + CustomerID
    And match CustomerID == RandomCustomerID
     * set testData.credit_profile_id = credit_profile_id
    * print testData
    #
   
    
      #Calling of Get Credit Profile Operation
    * def response =  call read(PATH_SERVICES+'GetProfile/getCreditProfile.feature') testData
    Then print "final response: " + response.response
    And def getResp = $.response
    * print getResp
    And def orderId = $.response.id
    * print orderId
    And match orderId == credit_profile_id
    * def creditRiskLevelNum = getResp.creditRiskLevelNum
    * print creditRiskLevelNum
    And def WarningId1 = $.response.warnings[0].id
    And def WarningId2 = $.response.warnings[1].id
    
    
     Then match $.response.warnings[0].warningCategoryCd == testData.WarngCd
    Then match $.response.warnings[0].warningCd == testData.warCd
    #Then match $.response.warnings[0].warningTypeCd == 'SAFESCAN'
    Then match $.response.warnings[0].warningItemTypeCd == 'DL'
    Then match $.response.warnings[0].warningStatusCd == testData.warStsCd
 
    Then match $.response.warnings[1].warningCategoryCd == testData.WarngCd2
    Then match $.response.warnings[1].warningCd == testData.warCd2
    #Then match $.response.warnings[1].warningTypeCd == 'SAFESCAN'
    Then match $.response.warnings[1].warningStatusCd == testData.warStsCd
 
 
    
    # Call UpdateCreditProfile service to update User data
    * set testData.WarningId1 = WarningId1 
    * set testData.WarningId2 = WarningId2
    
    # Call UpdateCreditProfile service to update User data
     * def updateRandomIdNum =  RandomNum.getRandom9digitNumber()
    * print  'updateRandomIdNum=='+ updateRandomIdNum
     * testData.UpdateIdNum = "'"+updateRandomIdNum+"'"
   
    
    * set testData.payloadUpdate = 'WLN_Update_Warning_Obj_payload.json'
    * def response =  call read(PATH_SERVICES_PH2_2+'UpdateCreditProfile/UpdateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    And def resp = $.response
    And def Id = $.response.id
    
    #Response Validations
    And match Id == Id
   
     #Calling of Get Credit Profile Operation
    * testData.credit_profile_id=credit_profile_id 
    * def response =  call read(PATH_SERVICES_PH2_2+'GetProfile/getCreditProfile.feature') testData
    Then print "final response: " + response.response
    And def getResp = $.response
    * print getResp
    And def orderId = $.response.id
    * print orderId
    And match orderId == credit_profile_id
    * def creditRiskLevelNum = getResp.creditRiskLevelNum
    * print creditRiskLevelNum
    And  match $.response.creditClassCd == testData.creditClsUpdate
    Then match $.response.relatedParty[0].engagedParty.birthDate == testData.UpdtaeDOB

    # Assertion - Validation - "Validate Get Response value"
    * print "Validate Get Response value"

    
    
     Then match $.response.statusCd == 'A'

    Then match $.response.primaryCreditScoreCd == testData.creditSCRUpdate
    Then match $.response.bureauDecisionCd == testData.bureauDCUpdate
    Then match $.response.creditProgramName == ''
    Then match $.response.creditClassCd == testData.creditClsUpdate
    Then match $.response.creditDecisionCd == testData.creditDCdUpdate
    Then match $.response.creditRiskLevelNum == testData.riskLNumUpdate
    Then match $.response.creditRiskLevelDecisionCd == testData.riskLevelDCdUpdate
    Then match $.response.clpRatePlanAmt == 170
    Then match $.response.applicationProvinceCd == testData.provinceUpdate
    Then match $.response.lineOfBusiness == 'WIRELINE'
    ## Then match $.response.clpCreditLimitAmt == 210
    ## Then match $.response.clpContractTermNum == 24
 
    Then match $.response.creditDecisionTs != null 
    Then match $.response.creditClassTs != null
    Then match $.response.creditRiskLevelTs != null
    Then match $.response.creationTs != null 
    
     
		      
    Then match $.response.relatedParty[0].engagedParty.birthDate == testData.UpdtaeDOB
    Then match $.response.relatedParty[0].engagedParty.contactMedium[1].mediumType == testData.UpdatemedTyp
    Then match $.response.relatedParty[0].engagedParty.contactMedium[1].characteristic.country == testData.UpdateCountry
    Then match $.response.relatedParty[0].engagedParty.contactMedium[1].characteristic.city == testData.Updatecity
    Then match $.response.relatedParty[0].engagedParty.contactMedium[1].characteristic.stateOrProvince == testData.provinceUpdate
    Then match $.response.relatedParty[0].engagedParty.contactMedium[1].characteristic.contactType == testData.contactType
    Then match $.response.relatedParty[0].engagedParty.contactMedium[1].characteristic.postCode == testData.PostCode
   
    Then match $.response.relatedParty[0].engagedParty.individualIdentification[1].identificationId == testData.UpdateIdNum
    Then match $.response.relatedParty[0].engagedParty.individualIdentification[1].identificationType == testData.UpdateidTyp
    #Then match $.response.relatedParty[0].engagedParty.individualIdentification[0].issuingAuthority == <province>
    #Then match $.response.relatedParty[0].engagedParty.individualIdentification[0].telusCharacteristic.provinceCd == <province>
   Then match $.response.relatedParty[0].engagedParty.individualIdentification[1].telusCharacteristic.provinceCd == testData.provinceUpdate
 
    Then match $.response.warnings[0].id == testData.WarningId1
    Then match $.response.warnings[0].warningCategoryCd == testData.warCtgryCdUpdate1
   Then match $.response.warnings[0].warningCategoryCd == testData.warCtgryCdUpdate1
    Then match $.response.warnings[0].warningCd == testData.warCdUpdate1
    Then match $.response.warnings[0].warningStatusCd == testData.warStatsCdUpdate1
 
   Then match $.response.warnings[1].id == testData.WarningId2
    Then match $.response.warnings[1].warningCategoryCd == testData.warCtgryCdUpdate2
    Then match $.response.warnings[1].warningCd == testData.warCdUpdate2
   Then match $.response.warnings[1].warningStatusCd == testData.warStatsCdUpdate2
    
    
      ###DB Validations
    # Calling CryptoService class to convert from encryption values to decrypto values which are stored IN DB
    #Create instance for Cryptoclass and calling the Decrypt() method
    * def CryptoServices = Java.type('com.telus.api.test.utils.CryptoService')
    
    * def testSpecFileRead = read(PATH_QUERIES+ 'CreateCreditQueries.json')
    * def TSValidator = Java.type("com.telus.api.test.utils.CurrentDate")
    * def DateVal = Java.type("com.telus.api.test.utils.DateValidator")
   
    #Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * string id = CustomerResult[0].customer_id
    And match id == CustomerID
    * string role = CustomerResult[0].role
    And match role == testData.role1
    * def party_id = CustomerResult[0].party_id
    *  print 'party_id--' +party_id
  
   
    ###Assertion data in Credit_profile_TABLE
    * def crdProfileQry = testSpecFileRead.Queries.crdProfile
    * replace crdProfileQry.credit_profile_id = credit_profile_id
    * def crdProfileQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(crdProfileQry)'}
    * def crdProfileResult = crdProfileQryResult.dbResult
    * print 'CREDIT_PROFILE TABLE Result: ' + crdProfileResult
    * string  DB_credit_profile_id = crdProfileResult[0].credit_profile_id
    Then match crdProfileResult[0].credit_profile_id != null
    Then match DB_credit_profile_id  == credit_profile_id
  
    ##Then match crdProfileResult[0].credit_class_ts !=null
    Then match crdProfileResult[0].application_sub_prov_cd == testData.provinceUpdate
    Then match crdProfileResult[0].Line_of_business == 'WIRELINE'
    ## Then match crdProfileResult[0].cred_check_consent_cd == testData.cred_check_consent_cd
  
    Then match crdProfileResult[0].credit_program_name == ''
    Then match crdProfileResult[0].credit_score_type_code == 'CUSTOM'
    Then match crdProfileResult[0].credit_profile_id_legacy == null
    Then match crdProfileResult[0].security_dep_amt == null
    Then match crdProfileResult[0].credit_assessment_id != null
    Then match crdProfileResult[0].clp_contract_term == 24
    Then match crdProfileResult[0].clp_rate_plan_amt == 170
    
     Then match crdProfileResult[0].agency_decision_code == testData.bureauDCUpdate
     
     * string  EncryptCrediRiskRating = crdProfileResult[0].credit_risk_rating
    * def DecryptCrediRiskRating =  new CryptoServices().decrypt(EncryptCrediRiskRating)
    Then match DecryptCrediRiskRating == testData.riskLNumUpdate
    
    * def Decryptcredit_score = new CryptoServices().decrypt(crdProfileResult[0].credit_score)
    Then match Decryptcredit_score == testData.creditSCRUpdate
    
     * def Decryptcredit_class_code = new CryptoServices().decrypt(crdProfileResult[0].credit_class_code)
     Then match Decryptcredit_class_code == testData.creditClsUpdate
     
     * def Decryptrisk_level_decision_code = new CryptoServices().decrypt(crdProfileResult[0].risk_level_decision_code)
     Then match Decryptrisk_level_decision_code == testData.riskLevelDCdUpdate
     
     * def Decryptcredit_decision_code = new CryptoServices().decrypt(crdProfileResult[0].credit_decision_code)
     Then match Decryptcredit_decision_code == testData.creditDCdUpdate
     
     * def credit_profile_ts = crdProfileResult[0].credit_profile_ts
    * def credit_profile_ts_TS = DateVal.isValid(credit_profile_ts)
    Then match credit_profile_ts_TS == true
    

   ###Assertion data in Credit_Warning_History TABLE
   * def CrdWarQry = testSpecFileRead.Queries.CrdWarning1
    * replace CrdWarQry.credit_profile_id = credit_profile_id
    * def CrdWarQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CrdWarQry)'}
    * def CrdWarResult = CrdWarQryResult.dbResult
    * print 'CREDIT_WARNING_HISTORY TABLE Result: ' + CrdWarResult
    
   		
    * def Decryptwarning_status_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_status_cd)
    Then match Decryptwarning_status_cd == testData.warStatsCdUpdate1
    * def Decryptwarning_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_cd)
    Then match Decryptwarning_cd == testData.warCdUpdate1
    * def Decryptwarning_category_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_category_cd)
    Then match Decryptwarning_category_cd == testData.warCtgryCdUpdate1
    
    * def CrdWarQry2 = testSpecFileRead.Queries.CrdWarning2
    * def CrdWarQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CrdWarQry2)'}
    * def CrdWarResult = CrdWarQryResult.dbResult
        * string warning_id2 =  CrdWarResult[0].warning_id
    Then match warning_id2  == WarningId2 
    
  * def Decryptwarning_status_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_status_cd)
    Then match Decryptwarning_status_cd == testData.warStatsCdUpdate2
    * def Decryptwarning_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_cd)
    Then match Decryptwarning_cd == testData.warCdUpdate2
    * def Decryptwarning_category_cd = new CryptoServices().decrypt(CrdWarResult[0].warning_category_cd)
    Then match Decryptwarning_category_cd == testData.warCtgryCdUpdate2
   Then match CrdWarResult[0].approval_external_id == null
   
   
   
     #Assertion data in Party_TABLE
    * def PartyQry = testSpecFileRead.Queries.PartyQry
    * replace PartyQry.party_id = party_id
    * def PartyQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyQry)'}
    * def PartyResult = PartyQryResult.dbResult
    * print 'PARTY TABLE Result: ' + PartyResult
    Then match PartyResult[0].party_id != null
    Then match PartyResult[0].party_type == testData.UpdateReffTyp
     Then match PartyResult[0].party_role == "Customer"
    
    
    
   #Assertion data in Party_Identification_TABLE
    * def PartyIdentificationQry = testSpecFileRead.Queries.PartyIdentifctnQry
    * replace PartyIdentificationQry.party_id = party_id
    * def PartyIdentificationQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyIdentificationQry)'}
    * def PartyIdentificationResult = PartyIdentificationQryResult.dbResult
    * print 'PARTY_IDENTIFICATION TABLE Result: ' + PartyIdentificationResult
    * def IdntID_id = PartyIdentificationResult[0].identificaton_id
    ##Then match PartyIdentificationResult[0].id_type == testData.UpdateidTyp
    ##Then match PartyIdentificationResult[0].version == 2
    
   #Assertion data in Identification_Char TABLE
    * def IdentificationCharQry = testSpecFileRead.Queries.IdentChar
    * replace IdentificationCharQry.IdntID_id = IdntID_id
    * def IdentificationCharQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentificationCharQry)'}
    * def IdentificationCharResult = IdentificationCharQryResult.dbResult
    * print 'IDENTIFICATION_CHAR TABLE Result: ' + IdentificationCharResult
  
    #Then match IdentificationCharResult[1] contains { Key:'issuingAuthority' }
    #Then match IdentificationCharResult[1] contains { value: '#(testData.province)' }
    #Then match IdentificationCharResult[] contains { Key:'provinceCd' }
    #Then match IdentificationCharResult[2] contains { value: '#(testData.province)' }
    #Then match IdentificationCharResult[3] contains { Key:'identificationId' }
    #Then match IdentificationCharResult[3] contains { value: 'IdntID_id' }


#Assertion data in INDIVIDUAL TABLE
    * def IndvlQry = testSpecFileRead.Queries.IndvlQry
    * replace IndvlQry.party_id = party_id
    * def IndvlQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IndvlQry)'}
    * def IndvlResult = IndvlQryResult.dbResult
    * print 'INDIVIDUAL TABLE Result: ' + IndvlResult
    * string birthDT = IndvlResult[0].birth_date
    Then match birthDT == testData.UpdtaeDOB

		      
    #Assertion data in PARTY_CONTACT_MEDIUM TABLE
    * def parContMedQry = testSpecFileRead.Queries.parContMed
    * replace parContMedQry.party_id = party_id
    * def parContMedQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(parContMedQry)'}
    * def parContMedResult = parContMedQryResult.dbResult
    * print 'PARTY_CONTACT_MEDIUM TABLE Result: ' + parContMedResult
    Then match parContMedResult[1].medium_type == testData.UpdatemedTyp
    Then match parContMedResult[1].state_province_code == testData.provinceUpdate
    Then match parContMedResult[1].country_code == testData.UpdateCountry
    Then match parContMedResult[1].city == testData.Updatecity
    Then match parContMedResult[0].contact_type == testData.contactType
    
   Then match parContMedResult[0].preffered == true
    Then match parContMedResult[0].post_code == testData.PostCode
    Then match parContMedResult[0].street1 == testData.street1
    Then match parContMedResult[0].street2 == testData.street2
    #Then match parContMedResult[0].email == testData.email
    #Then match parContMedResult[0].phonenumber == testData.phonenumber
    
    * string PartyCMEndTS = parContMedResult[0].valid_end_ts
    * string partyCMStartTS = parContMedResult[0].valid_start_ts
   
 
 
    Examples: 
      | testScenario                                       | data               |
      |Update Credit Profile with Valid   warningStatusCd  |'Update_Warning_Obj'|
  
    
   