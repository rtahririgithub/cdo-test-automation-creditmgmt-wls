@ErrorScenario @Error400
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
      | testScenario               | Id     | idTyp                          | DOB          | ReffTyp      | CScore | bureauDC | Cls   | CPrgNM | WarngCd | Country | Prvnc | medTyp          | IdNum        | rRtng | city        | code   | reason                                                             | wStsCD        | warCd   | Wdate                      |
      | More than one Invalid I/p  |   4001 | 'ABC'                          | '23-23-1988' | 'Individual' | '600'  | 'E29'    | 'B'   | 'DEP'  | 'CCW'   | 'XYZ'   | 'XY'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1104' | 'Invalid birth date'                                               | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid referredType       |   4001 | 'Business Registration Number' | '1990-01-09' | 'company'    | '60'   | 'E31'    | 'D'   | 'DEP'  | 'ODW'   | 'CAN'   | 'AB'  | 'postalAddress' | '843785112'  | '400' | 'Vancouver' | '1103' | 'Invalid referred type. Please specify individual or organization' | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | DOB before yr1900          |   4001 | 'Drivers License'              | '1899-02-22' | 'Individual' | '500'  | 'E32'    | 'L'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1104' | 'Invalid birth date'                                               | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid DOB                |   4001 | 'Drivers License'              | '1890-02-30' | 'Individual' | '500'  | 'E32'    | 'L'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1104' | 'Invalid birth date'                                               | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid DOB format         |   4001 | 'Drivers License'              | '02-02-1990' | 'Individual' | '500'  | 'E32'    | 'L'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1104' | 'Invalid birth date'                                               | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Missing mediumType         |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '700'  | 'E34'    | 'X'   | 'NDP'  | 'SEW'   | 'CAN'   | 'AB'  | ''              | 'DL12345678' | '400' | 'Vancouver' | '1105' | 'Contact medium mediumType is required'                            | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid UserId-BAN         | 'AB@2' | 'Drivers License'              | '1990-02-01' | 'Individual' | '700'  | 'E45'    | 'C'   | 'NDP'  | 'SEW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1000' | 'Invalid or missing mandatory request parameter(s)'                | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid CountryCd          |   4001 | 'Social Insurance Number'      | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'D'   | 'DEP'  | 'SEW'   | 'XYZ'   | 'AB'  | 'postalAddress' | '812345678'  | '400' | 'Vancouver' | '1109' | 'Country code is invalid'                                          | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid province           |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'B'   | 'DEP'  | 'SEW'   | 'CAN'   | 'XY'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1110' | 'Province code is invalid'                                         | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid idType input       |   4001 | 'ABC'                          | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'B'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1111' | 'Invalid identification type'                                      | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid CrdPrgm & no WarCD |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'D'   | 'ABC'  | ''      | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1114' | 'Invalid credit program name'                                      | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid CreditPrgm.        |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'C'   | 'XYZ'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1114' | 'Invalid credit program name'                                      | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid CreditClsCD        |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'asd' | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1115' | 'Invalid credit class code'                                        | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid WarngCD            |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'X'   | 'DEP'  | 'XYZ'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1116' | 'Invalid warning category code'                                    | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Missing referredType       |   4001 | 'Social Insurance Number'      | '1990-02-01' | ''           | '250'  | 'E33'    | 'K'   | 'NDP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | '812345678'  | '400' | 'Vancouver' | '1103' | 'Invalid referred type. Please specify individual or organization' | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid Bureau D Code_New  |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'XY2'    | 'B'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1102' | 'Invalid bureau decision code'                                     | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Missing Warning Status     |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'B'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1117' | 'Invalid warning status code'                                      | ''            | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Invalid Warning Status     |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'B'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1117' | 'Invalid warning status code'                                      | 'NOTVERIFIED' | CITADEL | '2019-01-10T16:51:22.620Z' |
      | missing Warning D Date     |   4001 | 'Drivers License'              | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'B'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | 'DL12345678' | '400' | 'Vancouver' | '1118' | 'Warning detection date is required'                               | 'UNVERIFIED'  | CITADEL | ''                         |
      | Missing SIN-no.            |   3009 | 'Social Insurance Number'      | '1990-02-01' | 'Individual' | '600'  | 'E29'    | 'C'   | 'DEP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | ''           |   400 | 'Vancouver' | '1123' | 'Missing identification Id'                                        | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Negative credit score      |   2016 | 'Social Insurance Number'      | '1990-02-01' | 'Individual' |   -500 | 'E33'    | 'K'   | 'NDP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | '812345678'  |   400 | 'Vancouver' | '1125' | 'Invalid credit score'                                             | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Negative rating param      |   2017 | 'Social Insurance Number'      | '1990-02-01' | 'Individual' |    500 | 'E33'    | 'K'   | 'NDP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | '812345678'  |  -400 | 'Vancouver' | '1124' | 'Invalid or missing credit rating'                                 | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |
      | Missing rating param       |   2020 | 'Social Insurance Number'      | '1990-02-01' | 'Individual' | ''     | 'E33'    | 'K'   | 'NDP'  | 'BCW'   | 'CAN'   | 'AB'  | 'postalAddress' | '812345678'  | ''    | 'Vancouver' | '1124' | 'Invalid or missing credit rating'                                 | 'UNVERIFIED'  | CITADEL | '2019-01-10T16:51:22.620Z' |









  @Timestamp_User_Val
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    #Validate date and AuditCharacteristics error scenario
    Given json testData = {Id: <Id>, endDt: <endDt>, strtDt: <strtDt> ,userId: <userId>, OrgAppId: <OrgAppId>}
    * set testData.payloadName = 'TimestampValidation_payload.json'
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
      | testScenario                        | Id   | code   | endDt                      | strtDt                     | reason                                                                                                                               | OrgAppId | userId    |
      | EndDateBeforeStartDate              | 3018 | '1101' | '2021-01-09T16:51:22.620Z' | '2026-01-09T16:51:22.620Z' | 'ValidFor time period is invalid.  The start date needs to be before the end date and the end date needs to be after the start date' |    19071 | 'ANSHIKA' |
      | New_TimestampInput Not in UTC       | 3018 | '1119' | '2026-01-09T16:51:22.620'  | '2021-01-09T16:51:22.620'  | 'Timestamp needs to be in UTC'                                                                                                       |    19071 | 'ANSHIKA' |
      | New_UserId Not provided             | 3018 | '1113' | '2026-01-09T16:51:22.620'  | '2021-01-09T16:51:22.620'  | 'UserId is required'                                                                                                                 |    19071 | ''        |
      | New_Org Application Id not provided | 3018 | '1112' | '2026-01-09T16:51:22.620'  | '2021-01-09T16:51:22.620'  | 'Originator application Id is required'                                                                                              | ''       | 'ANSHIKA' |
