
Feature: CreditManagement - CreateCreditProfile

  Background: 
    *print  CreateCreditProfile negative test


  @CreateCreditProfile_Negative_Test @CreateProfie @Regression_Suite @Regression_Suite_CreditProfile_TCs @WLN @WLN_CreateCreditProfile
  Scenario Outline: CreateCreditProfile -NegativeTC with <testScenario>
    
    * def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
    
    * def testDataSpec = read('Error400_Invalid_Missing_Scenarios_TestData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    * testData.Id=RandomCustomerID
    * set testData.payloadName = 'WLN_CreateCreditProfile_payload.json'
    * print testData
    

    * def response =  call read(PATH_SERVICES_PH2_2+'CreateProfile/CreateCreditProfile_Operation.feature') testData
    Then print "final response: " + response.response
    
    #Asssertion on REST response
    Then def resp = $.response
    And match response.responseStatus == 400
    And match resp.code == testData.code
    And match resp.reason == testData.reason


  Examples:
   | testScenario                   | data                   |
   | Invalid Warning Status         |"Invalid_Warning_Status"|
   | DOB before yr1900              |"DOB_before_yr1900"|
   |  Missing DL Number             |"Missing_DL_Number"|
   |  missing Credit Value Cd       |"Missing_Credit_Value_Cd"|
   |  invalid Credit Value Cd       |"Invalid_Credit_Value_Cd"|
   |   invalid SIN Number           |"Invalid_SIN_Number"    |
   
   
