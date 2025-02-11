
Feature: CreditManagement - GetCreditProfile

     Background: Configuration and Precondition steps
     *print  Search - Provide CREDIT_ PROFILE_ ID  for which there is no entry in Read/Write DB
   

  @SearchCreditProfile_Negative_TC @SearchCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs
  Scenario Outline: Search Customer : Negative <testScenario>
    Given json testData = {CustomerID: <CustomerID> }
   
    * testData.CustomerID = CustomerID 
    #Calling of Get Credit Profile Operation
    * def response =  call read(PATH_SERVICES+'SearchCustomerDetails/SearchCustomer.feature') testData
  
    Then print "final response: " + response.response
    And def getResp = $.response
    * print getResp
    * def status = response.responseStatus
    And match status == 200
    #And def orderId = $.response.id
    #* print orderId
    #And match  $.response.code == <code>
    #And match  $.response.message == <message>
    #And match  $.response.reason == <reason>

    Examples:
      | testScenario                                                      | CustomerID | code   | message                | reason|
      | Search_GET_  CP with customerID for Customer ID="ALPHANUMERIC"    | 45we54565  | '1402' |'VALID ERROR MESSAGE'    | 'Customer ID must be numeric'|
      
    
 
 @SearchCreditProfile_Negative_TC @SearchCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs
  Scenario Outline: Search Customer : Negative <testScenario>
  
   * def envName = karate.env
    * def headerData = env: '#(envName)' }
    * def res = PATH_TMF+ 'getAuthToken.feature'
    * def token = karate.call(res)
    * headerData.Authorization = token.authToken
    * print 'final headerData: ' + headerData
    * headers headerData
  
    * print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/creditProfile'
    And param customerId = ''
    When method get

    Then print "final response: " + response
    And match  response.code == <code>
    And match  response.reason == <reason>
    And match  response.message == <message>
   
     Examples:
      | testScenario                                                       | code   | message                | reason|
      | TC1_Neg_Search_GET_  CP with customerID for Customer ID="BLANK"    | '1000' | 'At least one valid search parameter is required.'| 'Invalid or missing mandatory request parameter(s)'|
     
      
     @SearchCreditProfile_Party   @Regression_Suite @Regression_Suite_CreditProfile_TCs
  Scenario Outline: Search Customer : Negative <testScenario>
  
   * def envName = karate.env
    * def headerData = env: '#(envName)' }
    * def res = PATH_TMF+ 'getAuthToken.feature'
    * def token = karate.call(res)
    * headerData.Authorization = token.authToken
    * print 'final headerData: ' + headerData
    * headers headerData
  
     * print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/creditProfile'
    Given  param DLL = '987655577'
    When method get

    Then print "final response: " + response
    And match  response.code == <code>
    And match  response.reason == <reason>
    And match  response.message == <message>
  Examples:
      | testScenario                                          | code   | message                | reason|
      | Search_GET_  CP with invalid identification Type"     | '1505' | 'INVALID SEARCH PARAM' | 'Invalid search criteria provided. Some or all fields param(s) are invalid'|
      