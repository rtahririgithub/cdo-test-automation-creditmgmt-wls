@Ignore
Feature: Operation updateProfile

	Background: Configuration and Precondition steps
  * def envName = karate.env
  * def headerData = {env: '#(envName)' }
    * def res = PATH_TMF+ 'getAuthToken.feature'
    * def token = karate.call(res)
    * headerData.Authorization = token.authToken
    * print 'final headerData: ' + headerData 
    * headers headerData
    #* configure proxy = 'http://pac.tsl.telus.com:8080'
    * def requestPayload =  testData.payloadUpdate
		
  Scenario: Update Credit management profile
		* print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditProfile/' + SERVICE_VERSION
    And path '/customer/' + Id
    And def UpdateCreditPayload = read(PATH_SERVICES_UPDATECPROFILE+requestPayload) 
    * print 'UpdateCreditPayload: ' + UpdateCreditPayload
    And request UpdateCreditPayload
    When method patch
