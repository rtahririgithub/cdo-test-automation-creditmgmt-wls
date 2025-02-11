@get
Feature: getCreditProfile

  Scenario Outline: get Credit management profile
    * def Id = '4001'
    * def todayDate = Java.type("com.telus.api.test.utils.CurrentDate")
    * def testSpecFileRead = read(PATH_QUERIES+ 'CreateCreditQueries.json')
    
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
    Then match crdProfileResult[0].credit_score == <creditSCR>
    Then match crdProfileResult[0].credit_program_name == <creditPrgNM>
    Then match crdProfileResult[0].credit_class_code == <creditCls>
    
    #Assertion data in Party_TABLE
    * def PartyQry = testSpecFileRead.Queries.PartyQry
    * replace PartyQry.party_id = party_id
    * def PartyQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyQry)'}
    * def PartyResult = PartyQryResult.dbResult
    * print 'PARTY TABLE Result: ' + PartyResult
    Then match PartyResult[0].party_type == <ReffTyp>
    
    #Assertion data in Party_Identification_TABLE
    * def PartyIdentificationQry = testSpecFileRead.Queries.PartyIdentifctnQry
    * replace PartyIdentificationQry.party_id = party_id
    * def PartyIdentificationQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(PartyIdentificationQry)'}
    * def PartyIdentificationResult = PartyIdentificationQryResult.dbResult
    * print 'PARTY_IDENTIFICATION TABLE Result: ' + PartyIdentificationResult
    * def IdntID_id = PartyIdentificationResult[0].identificaton_id
    Then match PartyIdentificationResult[0].id_type == <id_typ>
    * string DBTS = PartyIdentificationResult[0].valid_end_ts
    * def CurrentTS = todayDate.dateGen(DBTS)
    Then match CurrentTS == 'ValidDate'
    
    #Assertion data in Identification_Char TABLE
    * def IdentificationCharQry = testSpecFileRead.Queries.IdentChar
    * replace IdentificationCharQry.IdntID_id = IdntID_id
    * def IdentificationCharQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentificationCharQry)'}
    * def IdentificationCharResult = IdentificationCharQryResult.dbResult
    * print 'IDENTIFICATION_CHAR TABLE Result: ' + IdentificationCharResult
    * string encryptedId = 'ENCRYPTED: <IdNum>'
    Then match IdentificationCharResult[0] contains { Key:'identificationId' }
    Then match IdentificationCharResult[1] contains { Key:'issuingAuthority' }
    Then match IdentificationCharResult[2] contains { Key:'issuingDate' }
    Then match IdentificationCharResult[0] contains { value: #(encryptedId) }
    Then match IdentificationCharResult[1] contains { value: <province> }
    
    #Assertion data in Identification_Char_Hash TABLE
    * def IdentCharHashQry = testSpecFileRead.Queries.IdentCharHash
    * replace IdentCharHashQry.IdntID_id = IdntID_id
    * def IdentCharHashQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(IdentCharHashQry)'}
    * def IdentCharHashResult = IdentCharHashQryResult.dbResult
    * print 'IDENTIFICATION_CHAR_HASH TABLE Result: ' + IdentCharHashResult
    * string HashVal = 'Hash: <IdNum>'
    Then match IdentCharHashResult[0] contains { value: #(HashVal) }
    Then match IdentCharHashResult[0] contains { Key:'identificationId' }
    
    #Assertion data in Credit_Warning_History TABLE
    * def CrdWarQry = testSpecFileRead.Queries.CrdWar
    * replace CrdWarQry.credit_profile_id = credit_profile_id
    * def CrdWarQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CrdWarQry)'}
    * def CrdWarResult = CrdWarQryResult.dbResult
    * print 'CREDIT_WARNING_HISTORY TABLE Result: ' + CrdWarResult
    Then match CrdWarResult[0].warning_category_cd == <WarngCd>
    Then match CrdWarResult[0].warning_status_cd == <warStsCd>
    Then match CrdWarResult[0].warning_cd == <warCd>
    
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
    
    #Assertion data in READDB_SYNC_STATUS TABLE
    * def ReadDBSynQry = testSpecFileRead.Queries.ReadDBSyn
    * def ReadDBSynQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(ReadDBSynQry)'}
    * def ReadDBSynResult = ReadDBSynQryResult.dbResult
    * print 'READDB_SYNC_STATUS TABLE Result: ' + ReadDBSynResult
    Then match ReadDBSynResult[0].need_to_sync == false

    #* def response =  call read(PATH_SERVICES+'GetProfile/getCreditProfile.feature')
    #Then print "final response: " + response.response
    #And def resp = $.response
    #And def orderId = $.response.id
    #And match orderId == Id
    #* def riskRating = resp.creditProfile[0].creditRiskRating
    #* print riskRating
    Examples: 
      | testScenario                | Id   | idTyp      | DOB          | ReffTyp      | creditSCR | bureauDC | creditCls | creditPrgNM | WarngCd | Country | province | medTyp          | IdNum      | id_typ | warStsCd     | warCd               |
      | IdTyp PSP CCls B & prgm DEP | 4001 | 'Passport' | '1990-02-01' | 'Individual' |       500 | 'E29'    | 'B'       | 'DEP'       | 'AFM'   | 'CAN'   | 'AB'     | 'postalAddress' | DL12345678 | 'PSP'  | 'UNVERIFIED' | 'IDENTITY_FRAUD_01' |
