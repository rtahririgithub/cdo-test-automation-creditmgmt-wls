
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


  @CreateCreditProfile_Negative_Test @CreateProfie @Regression_Suite @Regression_Suite_CreditProfile_TCs   @CreateCreditProfile_Negative_TC
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    
    * def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
    
    Given json testData = { ReffTyp: <ReffTyp>,creditRiskLevelDecisionCd:<creditRiskLevelDecisionCd>,creditDecisionCd:<creditDecisionCd>, creditRiskLevelNum:<creditRiskLevelNum>, creditSCR: <creditSCR>, bureauDC: <bureauDC>, creditCls: <creditCls>, creditPrgNM: <creditPrgNM>, WarngCd:<WarngCd>, WarngCd2:<WarngCd2>,  province:<province>, warStsCd: <warStsCd>, warCd: <warCd>,warCd2: <warCd2>,role1:<role1>,warningDetectionTs:<warningDetectionTs> }
    * testData.Id=RandomCustomerID
    *  set testData.payloadName = 'Error400_Invalid_Missing_Scenarios.json'
    * print testData
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    
    #Asssertion on REST response
    Then def resp = $.response
    And match response.responseStatus == 400
    And match resp.code == <code>
    And match resp.reason == <reason>

 
  
  Examples:
   | testScenario                                 |  ReffTyp          |creditRiskLevelNum| creditSCR|creditRiskLevelDecisionCd|creditDecisionCd | bureauDC | creditCls | creditPrgNM | WarngCd |WarngCd2|province| warStsCd     | warCd  |warCd2|role1     |warningDetectionTs        |channelOrganizationId|userid     |reason                                                              |code  |
   |Invalid province                              |  'RiskAssessment' | 600              |      600 |'RL001'                   |'D001'          | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'XY'    |'UNVERIFIED'  | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' | 'Province code is invalid'                                         |'1110'|
   
   |Invalid Credit Program                        |  'RiskAssessment' | 600              |      600 |'RL001'                   |'D001'    		  | 'E29'    | 'B'       | 'XYZ'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|   04418             | 't9898989'| 'Invalid credit program name'                                      |'1114'|
   |Invalid Credit Class code                     |  'RiskAssessment' | 600              |      600 |'RL001'             			 |'D001'   			  | 'E29'    | 'Z'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|   04418             | 't9898989'| 'Invalid credit class code'                                        |'1115'|
   |Invalid warning code                          |  'RiskAssessment' | 600              |      600 |'TNSCRCCM0034'            |'D001'    			| 'E29'    | 'B'       | 'CLP'       | 'BBC'   |   'BBC'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|   04418             | 't9898989'| 'Invalid warning category code'                                    |'1116'|
   |Invalid Bureau Decision code                  |  'RiskAssessment' | 600              |      600 |'RL001'                   |'D001'    			| '1234'   | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' | 'Invalid bureau decision code'                                     |'1102'|
   |missing Warning detection date                |  'RiskAssessment' | 600              |      600 |'RL001'             			 |'D001'    			| 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'| ''                       |  04418              |'t9898989' | 'Warning detection date is required'                               |'1118'|
   |More than one Invalid I/p                     |  'RiskAssessment' | 600              |      -500|'RL001'            			 |'TCLPELCM2109'  | ' '      | 'B'       | 'CLPP'      | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' |  'Invalid credit program name'                                     |'1114'|
   | Invalid Warning Status                       |  'RiskAssessment' | 600              |      600 |'RL001'            			 |'D001'    			| 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    |'NOTVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' |   'Invalid warning status code'                                    |'1117'|
   |  Missing Warning Status                      |  'RiskAssessment' | 600              |      600 |'RL001'            			 |'D001'   			  | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    |' '           | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' |   'Invalid warning status code'                                    |'1117'|
   |Invalid Credit Program & no WarCD             |  'RiskAssessment' | 600              |      600 |'RL001'            			 |'D001'   				| 'E29'    | 'B'       | 'XYZ'       | ''      |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|   04418             | 't9898989'| 'Invalid credit program name'                                       |'1114'|
   | Negative creditRiskLevel Num                 |  'RiskAssessment' | -400             |      600 |'RL001'            			 |'D001'   			  | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' |  'Credit Risk Rating must be positive'                              |'1124'|
   
  #|missing reffered type                         |  '  '             | 600              |      600 |'TNSCRCCM0034'            |'TCLPELCM2109'    | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |Customer|'2021-12-15T20:49:01.839Z'|   04418             | 't9898989'| 'Invalid referred type. Please specify individual or organization' |'1103'|
  #|Invalid primaryCreditScoreCd                  |  'RiskAssessment' | 600              |      -500|'TNSCRCCM0034'            |'TCLPELCM2109 '   | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |Customer|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' |  'Invalid credit score'                                            |'1125'|
  #|missing Originatorapplication Id and User Id  |  'RiskAssessment' | 600              |      600 |'RL001'                   |'D001'   			  | 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|   ''                | ''        | 'Originator application Id and UserId is required'                 |'1103'|
  # |missing User Id                               |  'RiskAssessment' | 600              |      600 |'RL001'           				 |'D001'   			 	| 'E29'    | 'B'       | 'CLP'       | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              | ''        | 'UserId is required'                                               |'1103'|
   
  
  

    @CreateCreditProfile_Negative_Test @CreateProfie @Regression_Suite @Regression_Suite_CreditProfile_TCs  
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    
  * def envName = karate.env
  * def headerData = {env: '#(envName)' }
  * def res = PATH_TMF+ 'getAuthToken.feature'
  * def token = karate.call(res)
  * headerData.Authorization = token.authToken
  * print 'final headerData: ' + headerData 
  * headers headerData
		
 Given json testData = { ReffTyp: <ReffTyp>,creditRiskLevelDecisionCd:<creditRiskLevelDecisionCd>,creditDecisionCd:<creditDecisionCd>, creditRiskLevelNum:<creditRiskLevelNum>, creditSCR: <creditSCR>, bureauDC: <bureauDC>, creditCls: <creditCls>, creditPrgNM: <creditPrgNM>, WarngCd:<WarngCd>, WarngCd2:<WarngCd2>,  province:<province>, warStsCd: <warStsCd>, warCd: <warCd>,warCd2: <warCd2>,role1:<role1>,warningDetectionTs:<warningDetectionTs> }
   *  set testData.payloadName = 'MissingCustomerID_payload.json'
    * print testData
    
		* print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/creditProfile' 
    And def CreateCreditPayload = read(PATH_SERVICES_CREATECPROFILE+'MissingCustomerID_payload.json') 
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
  | testScenario                                 |  ReffTyp          |creditRiskLevelNum| creditSCR|creditRiskLevelDecisionCd|creditDecisionCd | bureauDC | creditCls | creditPrgNM | WarngCd |WarngCd2|province| warStsCd     | warCd  |warCd2|role1     |warningDetectionTs        |channelOrganizationId|userid     |reason                                                 |code  |
  | Missing Customer ID                          |  'RiskAssessment' | ''               |      600 |'RL001'             			 |'D001'   				| 'E29'    | 'B'       | ''         | 'BCW'   |   'BCW'|'BC'    | 'UNVERIFIED' | 'M'    | 'F'  |'Customer'|'2021-12-15T20:49:01.839Z'|  04418              |'t9898989' |  'Missing  relatedparty with customer role'   |'1000'|
  


  @CreateCreditProfile_Negative_TC  @CreateCreditProfile @Regression_Suite @CreditProfile_TCs
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    #Validate date and AuditCharacteristics error scenario
    
     
    * def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
    
     Given json testData = { strtDt: <strtDt> }
    * testData.Id=RandomCustomerID
    
    * set testData.payloadName = 'TimestampValidation_payload.json'
    * print testData
    #Operation 1: CreateCreditProfile in CreditManagementAPI
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'TimestampValidation_Operation.feature') testData
    Then print "final response: " + response.response
    #Asssertion on REST response
    Then def resp = $.response
    And match response.responseStatus == 400
    And match resp.code == <code>
    And match resp.reason == <reason>

    Examples: 
      | testScenario                        |  code   |  strtDt                     | reason                                                                                                                               | 
      | EndDateBeforeStartDate              |  '1101' |  '2026-01-09T16:51:22.620Z' | 'ValidFor time period is invalid.  The start date needs to be before the end date and the end date needs to be after the start date' |   
      | New_TimestampInput Not in UTC       |  '1101' | '2021-01-09T16:51:22.620Easdsad' | 'ValidFor time period is invalid.  The start date needs to be before the end date and the end date needs to be after the start date'                                                                                                       |   
      
