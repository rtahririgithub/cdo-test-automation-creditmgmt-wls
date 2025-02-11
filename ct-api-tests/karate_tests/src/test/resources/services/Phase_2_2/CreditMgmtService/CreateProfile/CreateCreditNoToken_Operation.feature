@Ignore
Feature: Operation createOrder

  Background: Configuration and Precondition steps
    * def envName = karate.env
  * def headerData = {env: '#(envName)' }
    * print 'final headerData: ' + headerData
    * headers headerData
    * configure proxy = 'http://pac.tsl.telus.com:8080'
     * def xmlName =  testData.payloadName

  Scenario: get Credit management profile
    * print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/customer/' + Id
    And def CreateCreditPayload = read(PATH_SERVICES_PH2_2+'CreateProfile/'+xmlName)  
    * print 'CreateCreditPayload: ' + CreateCreditPayload
    And request CreateCreditPayload
    When method patch

    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    