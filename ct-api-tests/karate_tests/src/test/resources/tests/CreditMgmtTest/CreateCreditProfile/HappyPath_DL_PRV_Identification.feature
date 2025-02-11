@HappyPath @DlAndPrvIdentification
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile HappyPath test


  @CreateCreditProfile_happyPath_test
  Scenario Outline: CreateCreditProfile : Valid Data with <testScenario>
    Given json testData = {Id: <Id>, idTyp: <idTyp>, ReffTyp: <ReffTyp>, DOB: <DOB>, medTyp: <medTyp>, creditSCR: <crdtSCR>, bureauDC: <bureauDC>, creditCls: <crdtCls>, creditPrgNM: <CPrgNM>, WarngCd:<WarngCd>, Country: <Country>, province:<province>, IdNum:<IdNum>, warStsCd: <warStsCd>, warCd: <warCd>, riskRatng: <rRtng>, city: <city>, Wdate: <Wdate> }
    * set testData.payloadName = 'IndvlIdentificationDL_PRV_payload.json'
    * print testData
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    #Asssertion on REST response
    And def resp = $.response
    And def Id = $.response.id
    And match Id == Id
    * def testSpecFileRead = read(PATH_QUERIES+ 'CreateCreditQueries.json')
    * def TSValidator = Java.type("com.telus.api.test.utils.CurrentDate")
    * def DateVal = Java.type("com.telus.api.test.utils.DateValidator")
    #DB Validations
    #Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * string id = CustomerResult[0].customer_id
    And match id == Id
    * def party_id = CustomerResult[0].party_id
    #Assertion data in Credit_profile_relationship_TABLE
    * def cprQry = testSpecFileRead.Queries.cprQry
    * def cprQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(cprQry)'}
    * def cprResult = cprQryResult.dbResult
    * print 'CUSTOMER_CREDIT_PROFILE_REL TABLE Result: ' + cprResult
    Then match cprResult contains { credit_profile_id: '#notnull' }
    * def credit_profile_id = cprResult[0].credit_profile_id
    #Assertion data in Credit_profile_TABLE
    * def crdProfileQry = testSpecFileRead.Queries.crdProfile
    * replace crdProfileQry.credit_profile_id = credit_profile_id
    * def crdProfileQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(crdProfileQry)'}
    * def crdProfileResult = crdProfileQryResult.dbResult
    * print 'CREDIT_PROFILE TABLE Result: ' + crdProfileResult
    Then match crdProfileResult[0].agency_decision_code == <bureauDC>
    Then match crdProfileResult[0].credit_risk_rating == <rRtng>
    Then match crdProfileResult[0].credit_score == <crdtSCR>
    Then match crdProfileResult[0].credit_program_name == <CPrgNM>
    Then match crdProfileResult[0].credit_class_code == <crdtCls>
    Then match crdProfileResult[0].credit_score_type_code == 'CUSTOM'
    Then match crdProfileResult[0].credit_profile_id_legacy == null
    Then match crdProfileResult[0].credit_decision_code == 'TABNELCM0028'
    Then match crdProfileResult[0].risk_level_decision_code == 'TNSBCWOCM003'
    Then match crdProfileResult[0].clp_credit_limit_amt == 250.00
    Then match crdProfileResult[0].security_dep_amt == null
    Then match crdProfileResult[0].credit_assessment_id != null
    * def credit_profile_ts = crdProfileResult[0].credit_profile_ts
    * def credit_profile_ts_TS = DateVal.isValid(credit_profile_ts)
    Then match credit_profile_ts_TS == true
    * string endTS = crdProfileResult[0].valid_end_ts
    * string startTS = crdProfileResult[0].valid_start_ts
    * def TSValidation = TSValidator.dateValitade(endTS,startTS)
    Then match TSValidation == 'ValidDate'
    
    
    
    
    
    #Assertion data in Party_TABLE
    * def PartyQry = testSpecFileRead.Queries.PartyQry
    * replace PartyQry.party_id = party_id
    * def PartyQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyQry)'}
    * def PartyResult = PartyQryResult.dbResult
    * print 'PARTY TABLE Result: ' + PartyResult
    Then match PartyResult[0].party_id != null
    Then match PartyResult[0].party_type == <ReffTyp>
    #Assertion data in Party_Identification_TABLE
    * def PartyIdentificationQry = testSpecFileRead.Queries.PartyIdentifctnQry
    * replace PartyIdentificationQry.party_id = party_id
    * def PartyIdentificationQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyIdentificationQry)'}
    * def PartyIdentificationResult = PartyIdentificationQryResult.dbResult
    * print 'PARTY_IDENTIFICATION TABLE Result: ' + PartyIdentificationResult
    * def IdntID_id = PartyIdentificationResult[0].identificaton_id
    Then match PartyIdentificationResult[0].id_type == <id_typ>
    * string partyEndTS = PartyIdentificationResult[0].valid_end_ts
    * string partyStartTS = PartyIdentificationResult[0].valid_start_ts
    * def partyTSValidation = TSValidator.dateValitade(partyEndTS,partyStartTS)
    Then match partyTSValidation == 'ValidDate'
    #Assertion data in Identification_Char TABLE
    * def IdentificationCharQry = testSpecFileRead.Queries.IdentChar
    * replace IdentificationCharQry.IdntID_id = IdntID_id
    * def IdentificationCharQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentificationCharQry)'}
    * def IdentificationCharResult = IdentificationCharQryResult.dbResult
    * print 'IDENTIFICATION_CHAR TABLE Result: ' + IdentificationCharResult
    Then match IdentificationCharResult[0] contains { Key:'provinceCd' }
    Then match IdentificationCharResult[0] contains { value: <province> }
    Then match IdentificationCharResult[1] contains { Key:'issuingAuthority' }
    Then match IdentificationCharResult[1] contains { value: <province> }
    Then match IdentificationCharResult[2] contains { Key:'identificationId' }
    #Assertion data in Identification_Char_Hash TABLE
    * def IdentCharHashQry = testSpecFileRead.Queries.IdentCharHash
    * replace IdentCharHashQry.IdntID_id = IdntID_id
    * def IdentCharHashQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentCharHashQry)'}
    * def IdentCharHashResult = IdentCharHashQryResult.dbResult
    * print 'IDENTIFICATION_CHAR_HASH TABLE Result: ' + IdentCharHashResult
    Then match IdentCharHashResult[0] contains { Key:'identificationId' }
    #Assertion data in Credit_Warning_History TABLE
    * def CrdWarQry = testSpecFileRead.Queries.CrdWar
    * replace CrdWarQry.credit_profile_id = credit_profile_id
    * def CrdWarQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CrdWarQry)'}
    * def CrdWarResult = CrdWarQryResult.dbResult
    * print 'CREDIT_WARNING_HISTORY TABLE Result: ' + CrdWarResult
    * string warStatusCode = '<warStsCd>'
    * string warCode = '<warCd>'
    Then match CrdWarResult[0].warning_legacy_id == 5936
    Then match CrdWarResult[0].warning_status_cd == warStatusCode
    Then match CrdWarResult[0].warning_cd == warCode
    Then match CrdWarResult[0].warning_category_cd == <WarngCd>
    Then match CrdWarResult[0].warning_type_cd == 'WT3'
    Then match CrdWarResult[0].credit_assessment_id == 24197
    Then match CrdWarResult[0].memo_type_cd == 'HCDF'
    * string crdWarEndTS = CrdWarResult[0].valid_end_ts
    * string crdWarStartTS = CrdWarResult[0].valid_start_ts
    * def CrdWarTSValidation = TSValidator.dateValitade(crdWarEndTS,crdWarStartTS)
    Then match CrdWarTSValidation == 'ValidDate'
    #Assertion data in INDIVIDUAL TABLE
    * def IndvlQry = testSpecFileRead.Queries.IndvlQry
    * replace IndvlQry.party_id = party_id
    * def IndvlQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IndvlQry)'}
    * def IndvlResult = IndvlQryResult.dbResult
    * print 'INDIVIDUAL TABLE Result: ' + IndvlResult
    * string birthDT = IndvlResult[0].birth_date
    Then match birthDT == <DOB>
    #Assertion data in PARTY_CONTACT_MEDIUM TABLE
    * def parContMedQry = testSpecFileRead.Queries.parContMed
    * replace parContMedQry.party_id = party_id
    * def parContMedQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(parContMedQry)'}
    * def parContMedResult = parContMedQryResult.dbResult
    * print 'PARTY_CONTACT_MEDIUM TABLE Result: ' + parContMedResult
    Then match parContMedResult[0].medium_type == <medTyp>
    Then match parContMedResult[0].state_province_code == <province>
    Then match parContMedResult[0].country_code == <Country>
    Then match parContMedResult[0].city == <city>
    Then match parContMedResult[0].contact_type == 'home'
    * string PartyCMEndTS = parContMedResult[0].valid_end_ts
    * string partyCMStartTS = parContMedResult[0].valid_start_ts
    * def partyCMTSValidation = TSValidator.dateValitade(PartyCMEndTS,partyCMStartTS)
    Then match partyCMTSValidation == 'ValidDate'
    #Assertion data in READDB_SYNC_STATUS TABLE
    * def ReadDBSynQry = testSpecFileRead.Queries.ReadDBSyn
    * def ReadDBSynQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(ReadDBSynQry)'}
    * def ReadDBSynResult = ReadDBSynQryResult.dbResult
    * print 'READDB_SYNC_STATUS TABLE Result: ' + ReadDBSynResult
    Then match ReadDBSynResult[0].need_to_sync == false

    Examples: 
      | testScenario                | Id   | idTyp             | DOB          | ReffTyp      | crdtSCR | bureauDC | crdtCls | CPrgNM | WarngCd | Country | province | medTyp          | IdNum      | id_typ | warStsCd   | warCd              | rRtng | city      | Wdate                    |
      | IdTyp DL CCls X & prgm CLP  | 2004 | 'Drivers License' | '1990-02-01' | 'Individual' |     470 | 'E29'    | 'X'     | 'CLP'  | 'SEW'   | 'CAN'   | 'AB'     | 'postalAddress' | DL12345678 | 'DL'   | UNVERIFIED | CITADEL            |   400 | 'Toronto' | 2019-01-10T16:51:22.620Z |
      | IdTyp DL region SK          | 3036 | 'Drivers License' | '1990-02-01' | 'Individual' |     700 | 'E29'    | 'C'     | 'DEP'  | 'SEW'   | 'CAN'   | 'SK'     | 'postalAddress' | DL12343378 | 'DL'   | VERIFIED   | IDENTITY_FRAUD_01  |   400 | 'Toronto' | 2019-01-10T16:51:22.620Z |
      | IdTyp DL region BC          | 3038 | 'Drivers License' | '1990-02-01' | 'Individual' |     250 | 'E29'    | 'L'     | 'DCL'  | 'BCW'   | 'CAN'   | 'BC'     | 'postalAddress' | DL12115678 | 'DL'   | VERIFIED   | DELINQUENT_ACCOUNT |   400 | 'Toronto' | 2019-01-10T16:51:22.620Z |
      | IdTyp DL region AB          | 3040 | 'Drivers License' | '1990-02-01' | 'Individual' |     600 | 'E29'    | 'K'     | 'NDP'  | 'SEW'   | 'CAN'   | 'QC'     | 'postalAddress' | DL12000678 | 'DL'   | UNVERIFIED | IDENTITY_FRAUD_01  |   400 | 'Toronto' | 2019-01-10T16:51:22.620Z |
      | IdTyp PRV CCls C & prgm CLP | 2005 | 'Provincial card' | '1990-02-01' | 'Individual' |     600 | 'E29'    | 'C'     | 'CLP'  | 'BCW'   | 'CAN'   | 'BC'     | 'postalAddress' |  044023678 | 'PRV'  | VERIFIED   | CITADEL            |   400 | 'Toronto' | 2019-01-10T16:51:22.620Z |
      | Invalid DL-no.              | 2006 | 'Drivers License' | '1990-02-01' | 'Individual' |     600 | 'E29'    | 'L'     | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'     | 'postalAddress' | 123@AB   | 'DL'   | UNVERIFIED | CITADEL            |   400 | 'Toronto' | 2019-01-10T16:51:22.620Z |

      
     