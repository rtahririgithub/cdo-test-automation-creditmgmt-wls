@ErrorScenario @Error400
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test

  @BothInd_OrgIdentfctn
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    #Validate Both individualIdentification and organizationalIdentification error case
    Given json testData = {Id: <Id>}
    * set testData.payloadName = 'Both_Indvl&OrgIdentificationTyp_payload.json'
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
      | testScenario                    | Id   | code   | reason                                                                      |
      | Both Indvl & org Identification | 3018 | '1106' | 'EngagedParty cannot have both individual and organization identifications' |