@ErrorScenario @Error400
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test

  @Mul_Same_IdTyp
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    #Validate multiple identipication for a given identification type error case
    Given json testData = {Id: <Id>, idtyp1: <idtyp1>, idtyp2: <idtyp2>}
    * set testData.payloadName = 'MultipleIdentificationTyp_payload.json'
    * print testData
    #Operation 1: CreateCreditProfile in CreditManagementAPI
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    #Asssertion on REST response
    Then def resp = $.response
    And match response.responseStatus == 400
    And match resp.code == <code>
    And match resp.reason == <reason>

    Examples: 
      | testScenario        | Id   | code   | idtyp1            | idtyp2            | reason                                                                 |
      | Multiple same idTyp | 3018 | '1107' | 'Drivers License' | 'Drivers License' | 'Only one identification for a given identification type is supported' |