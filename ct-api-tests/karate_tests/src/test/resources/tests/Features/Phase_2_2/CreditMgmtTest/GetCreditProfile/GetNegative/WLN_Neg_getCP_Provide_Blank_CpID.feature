
Feature: CreditManagement - GetCreditProfile

  Background:
  *print  Get -Provide Blank CREDIT_ PROFILE_ ID number in ID to get the Credit Profile
  * def envName = karate.env
    * def headerData = {env: '#(envName)' }
    * def res = PATH_TMF+ 'getAuthToken.feature'
    * def token = karate.call(res)
    * headerData.Authorization = token.authToken
    * print 'final headerData: ' + headerData
    * headers headerData
   
  
 @GetCreditProfile_Negative_TC @GetCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs @WLN @WLN_GetCreditProfile 
 Scenario Outline: GetCP : Negative <testScenario>
    * print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/creditProfile/' 
    When method get
    
     Then print "final response: " + response
    And match  response.code == <code>
    And match  response.reason == <reason>
    And match  response.message == <message>
    


    Examples:
      | testScenario                      | code   | message                      | reason                                             |
      | Neg_getCP_Provide_Blank_CpID      | '1500' | 'searchCreditProfile.params' | 'At least one valid search parameter is required.'|

 
 
 
 
 