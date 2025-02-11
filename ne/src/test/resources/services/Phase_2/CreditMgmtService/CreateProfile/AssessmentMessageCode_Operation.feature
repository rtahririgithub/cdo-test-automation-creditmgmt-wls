@Ignore
Feature: Operation createOrder

	Background: Configuration and Precondition steps
  * def envName = karate.env
  * def headerData = {env: '#(envName)' }
  * def res = PATH_TMF+ 'getAuthToken.feature'
  * def token = karate.call(res)
  * headerData.Authorization = token.authToken
  * print 'final headerData: ' + headerData 
  * headers headerData
   
    * def xmlName =  testData.payloadName
		
  Scenario: get Credit management profile
		* print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditProfile/listener/v1/'
    And path 'customer/assessmentChangeEvent' 
    And def CreateCreditPayload = read(PATH_SERVICES_CREATECPROFILE+'AssessmentMessageCode_payload.json') 
    * print 'AssessmentMessageCode_payload: ' + CreateCreditPayload
    And request CreateCreditPayload
    When method post
    * def sleep = read('classpath:utils/Wait.js')
   * call sleep 6
