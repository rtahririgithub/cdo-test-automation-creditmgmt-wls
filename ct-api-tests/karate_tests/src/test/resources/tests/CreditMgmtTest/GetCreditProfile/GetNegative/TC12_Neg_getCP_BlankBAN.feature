@Get @GetTC12
Feature: CreditManagement - GetCreditProfile

  Background:
  *print  Get - Credit Profile(Credit Profile Params/Engage Party Details) by BAN number for customer having Identification type as DL and Credit Program = CLP, Credit Class=L


  @getCreditProfile_happyPath_test
  Scenario Outline: GetCP : Negative <testScenario>
    Given json testData = {Id: <Id> }
#
#
    #Calling of Get Credit Profile Operation
    * def response =  call read(PATH_SERVICES+'GetProfile/getCreditProfile.feature') testData
    Then print "final response: " + response.response
    And def getResp = $.response
    * print getResp
    #And def orderId = $.response.id
    #* print orderId
    And match  $.response.code == code
    And match  $.response.message == <message>
    And match  $.response.reason == <reason>

    Examples:
      | testScenario                | Id   | code | message | reason
      | TC12_Neg_getCP_BlankBAN     | '' | 1000 | 'searchCustomer.params: must not be empty' | 'Invalid or missing mandatory request parameter(s)'
