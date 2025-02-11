
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


 @CreateCreditProfile_Negative_TC  @CreateCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs 
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
  * def envName = karate.env
  * def headerData = {env: '#(envName)' }
  * def res = PATH_TMF+ 'getAuthToken.feature'
  * def token = karate.call(res)
  * headerData.Authorization = token.authToken
  * print 'final headerData: ' + headerData 
  * headers headerData
   
    
		
		* def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
     Given json testData = { ReffTyp: <ReffTyp>,creditRiskLevelDecisionCd:<creditRiskLevelDecisionCd>,creditDecisionCd:<creditDecisionCd>, creditRiskLevelNum:<creditRiskLevelNum>, creditSCR: <creditSCR>, bureauDC: <bureauDC>, creditCls: <creditCls>, creditPrgNM: <creditPrgNM>,   province:<province> }
    * testData.Id=RandomCustomerID
    * set testData.payloadName = 'MissingWarningObj_payload.json'
    * print testData
 
 * def xmlName =  testData.payloadName
		* print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/creditProfile' 
    And def CreateCreditPayload = read(PATH_SERVICES_CREATECPROFILE+'MissingWarningObj_payload.json') 
    * print 'CreateCreditPayload: ' + CreateCreditPayload
    And request CreateCreditPayload
    When method post
    * def sleep = read('classpath:utils/Wait.js')
   * call sleep 6
    
 
    #Asssertion on REST response
      Then def response = response
    Then match responseStatus == 400
    And match response.code == <code>
    And match response.reason == <reason>

Examples: 
     
| testScenario               |  ReffTyp          |creditRiskLevelNum| creditSCR|creditRiskLevelDecisionCd|creditDecisionCd  | bureauDC | creditCls | creditPrgNM |province|role1     |code   | reason  |
| Missing Warning info Obj   |  'RiskAssessment' | 2019             |      500 |'TNSCRCCM0034'           |'TCLPELCM2109'    | 'E30'    | 'B'       | 'CLP'       |'AB'    |'Customer |'1000' | 'Missing  relatedparty with customer role'|
      

 