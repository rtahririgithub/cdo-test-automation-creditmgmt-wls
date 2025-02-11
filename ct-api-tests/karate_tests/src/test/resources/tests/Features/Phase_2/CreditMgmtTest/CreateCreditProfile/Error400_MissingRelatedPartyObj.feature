
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


   @CreateCreditProfile_Negative_TC  @CreateCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs 
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    
 
     * def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
    Given json testData = { ReffTyp: <ReffTyp>,creditRiskLevelDecisionCd:<creditRiskLevelDecisionCd>,creditDecisionCd:<creditDecisionCd>, creditRiskLevelNum:<creditRiskLevelNum>, creditSCR: <creditSCR>, bureauDC: <bureauDC>, creditCls: <creditCls>, creditPrgNM: <creditPrgNM>, WarngCd:<WarngCd>, WarngCd2:<WarngCd2>,  province:<province>, warStsCd: <warStsCd>, warCd: <warCd>,warCd2: <warCd2>,role1:<role1>,warningDetectionTs:<warningDetectionTs> }
    * testData.Id=RandomCustomerID
    * set testData.payloadName = 'MissingRelatedPartyObj_payload.json'
    * print testData
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    
    
    #Asssertion on REST response
    Then def resp = $.response
    And match response.responseStatus == 400
    And match resp.code == <code>
    And match resp.reason == <reason>

Examples: 
| testScenario                |  ReffTyp          |creditRiskLevelNum| creditSCR|creditRiskLevelDecisionCd|creditDecisionCd  | bureauDC | creditCls | creditPrgNM | WarngCd |WarngCd2|province| warStsCd     | warCd  |warCd2|warningDetectionTs        |code   | reason                                 |      
|  Missing RelatedPartyObj    |  'RiskAssessment' | 2019             |      500 |'TNSCRCCM0034 '          |'TCLPELCM2109 '   | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'AB'    |'UNVERIFIED' | 'M'    | 'F'  |'2021-12-15T20:49:01.839Z'|'1000' | 'Missing  relatedparty with customer role'|
      