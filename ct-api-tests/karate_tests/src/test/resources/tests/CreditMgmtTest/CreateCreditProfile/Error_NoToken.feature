@ErrorScenario @NoTokenTest
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


  @CreateCreditProfile_negative_test
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    Given json testData = {Id: <Id>, idTyp: <idTyp>, ReffTyp: <ReffTyp>, DOB: <DOB>, medTyp: <medTyp>, creditSCR: <creditSCR>, bureauDC: <bureauDC>, creditCls: <creditCls>, creditPrgNM: <creditPrgNM>, WarngCd:<WarngCd>, Country: <Country>, province:<province>, IdNum:<IdNum>, city: <city>,  riskRatng: <rRtng>, warStsCd:<wStsCD> }
    * set testData.payloadName = 'TestNegative_payload.json'
    * print testData
    #Operation 1: CreateCreditProfile in CreditManagementAPI
    * def response =  call read(PATH_SERVICES_CREATECPROFILE+'CreateCreditNoToken_Operation.feature') testData
    Then print "final response: " + response.response
    #Asssertion on REST response
    Then def resp = $.response
    And match response.responseStatus == <code>
    And match resp.message == <errorMSG>

    Examples: 
      | testScenario  | Id      | idTyp             | DOB          | ReffTyp      | code | errorMSG       | creditSCR | bureauDC | creditCls | creditPrgNM | WarngCd | Country | province | medTyp          | IdNum        | city        | rRtng | wStsCD       |
      | No Auth Token | '11111' | 'Drivers License' | '1990-02-01' | 'Individual' |  401 | 'Unauthorized' | '700'     | 'E45'    | 'C'       | 'NDP'       | 'AFM'   | 'CAN'   | 'AB'     | 'postalAddress' | 'DL12345678' | 'Vancouver' |   400 | 'UNVERIFIED' |
