@ErrorScenario
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


  @CreateCreditProfile_negative_test
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    Given json testData = {Id: <Id>, idTyp: <idTyp>, ReffTyp: <ReffTyp>, DOB: <DOB>, medTyp: <medTyp>, creditSCR: <creditSCR>, bureauDC: <bureauDC>, creditCls: <creditCls>, creditPrgNM: <creditPrgNM>, WarngCd:<WarngCd>, Country: <Country>, province:<province>, IdNum:<IdNum>, riskRatng: <riskRatng>, city: <city>  }
    * set testData.payloadName = 'MissingCreateProfileObj_payload.json'
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
      | testScenario             | Id   | idTyp                     | DOB          | ReffTyp      | creditSCR | bureauDC | creditCls | creditPrgNM | WarngCd | Country | province | medTyp          | IdNum      | city        | riskRatng | code   | reason                                   |
      | Missing creditProfileObj | 3009 | 'Social Insurance Number' | '1990-02-01' | 'Individual' |       600 | 'E29'    | 'C'       | 'DEP'       | 'BCW'   | 'CAN'   | 'AB'     | 'postalAddress' | '12345678' | 'Vancouver' |       400 | '1100' | 'Credit Profile information is required' |
