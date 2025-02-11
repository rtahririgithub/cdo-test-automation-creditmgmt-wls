@Demo1
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


  @CreateCreditProfile_negative_test
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    Given json testData = {Id: <Id>, idTyp: <idTyp>, ReffTyp: <ReffTyp>, DOB: <DOB>, medTyp: <medTyp>, creditSCR: <CScore>, bureauDC: <bureauDC>, creditCls: <Cls>, creditPrgNM: <CPrgNM>, WarngCd:<WarngCd>, Country: <Country>, province:<Prvnc>, IdNum:<IdNum>, city: <city>, riskRatng: <rRtng>, warStsCd:<wStsCD>, warCd: <warCd>, Wdate: <Wdate>}
    * set testData.payloadName = 'IndvlIdentificationTyp_payload.json'
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
      | testScenario      | Id   | idTyp             | DOB          | ReffTyp      | CScore | bureauDC | Cls | CPrgNM | WarngCd | Country | Prvnc | medTyp          | IdNum        | rRtng | city        | code   | reason               | wStsCD       | warCd   | Wdate                    |
      | DOB before yr1900 | 4001 | 'Drivers License' | '1899-02-22' | 'Individual' | '500'  | 'E32'    | 'L' | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1104' | 'Invalid birth date' | 'UNVERIFIED' | CITADEL | 2019-01-10T16:51:22.620Z |
