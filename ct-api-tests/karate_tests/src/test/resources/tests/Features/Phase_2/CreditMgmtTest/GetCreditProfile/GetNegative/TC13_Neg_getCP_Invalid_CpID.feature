
Feature: CreditManagement - GetCreditProfile

  Background:
  *print  Get - Provide Invalid CREDIT_ PROFILE_ ID number to get the Credit Profile
  
 @GetCreditProfile_Negative_TC @GetCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs
  Scenario Outline: GetCP : Negative <testScenario>
    Given json testData = {credit_profile_id: <credit_profile_id> }
   
    * testData.credit_profile_id = credit_profile_id 
    #Calling of Get Credit Profile Operation
    * def response =  call read(PATH_SERVICES+'GetProfile/getCreditProfile.feature') testData
    Then print "final response: " + response.response
    And def getResp = $.response
    * print getResp
    #And def orderId = $.response.id
    #* print orderId
    And match  $.response.code == <code>
    And match  $.response.reason == <reason>
    And match  $.response.message == <message>
    

    Examples:
| testScenario                 | credit_profile_id                 | code   | reason | message|
| TC13_Neg_getCP_Invalid_CpID | qpqpoe1213131090909898-9123uhh9-   | '1402' | 'Invalid credit profile Id' | 'Credit profile not found for the given Id'|

    