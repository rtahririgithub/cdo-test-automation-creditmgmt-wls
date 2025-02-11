@Ignore
Feature: Operation UpdateCreditProfieChangeEvent

	Background: Configuration and Precondition steps
  * def envName = karate.env
  * def headerData = {env: '#(envName)' }
  * def res = PATH_TMF+ 'getAuthToken.feature'
  * def token = karate.call(res)
  * headerData.Authorization = token.authToken
  * print 'final headerData: ' + headerData 
  * headers headerData
   
    * def requestPayload =  testData.payloadUpdate
		
		
  Scenario: get Credit management profile
		* print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + 'v1'
    Given url ENDPOINT_URL + 'customer/creditProfile/listener/v1/'
    And path 'customer/creditProfileChangeEvent' 
    And def UpadteCreditChangeeventPayload = read(PATH_SERVICES+requestPayload) 
    * print 'UpadteCreditChangeeventPayload: ' + UpadteCreditChangeeventPayload
    And request UpadteCreditChangeeventPayload
    When method post
    * def sleep = read('classpath:utils/Wait.js')
   * call sleep 6
 

    

    
 
 