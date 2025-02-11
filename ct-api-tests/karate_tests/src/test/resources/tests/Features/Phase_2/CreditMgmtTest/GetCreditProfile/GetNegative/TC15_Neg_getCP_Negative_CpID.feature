
Feature: CreditManagement - GetCreditProfile

  Background:
  *print  Get - Provide NegativeCREDIT_ PROFILE_ ID in ID to get the Credit Profile

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
    
    Examples:
| testScenario                 | credit_profile_id                     | code   | reason | message|
| TC15_Neg_getCP_Negative_CpID| -47d788fe-d45e-456b-a806-0443bec4dcfe  | '1402' | 'Invalid credit profile Id' | 'Credit profile not found for the given Id'|

