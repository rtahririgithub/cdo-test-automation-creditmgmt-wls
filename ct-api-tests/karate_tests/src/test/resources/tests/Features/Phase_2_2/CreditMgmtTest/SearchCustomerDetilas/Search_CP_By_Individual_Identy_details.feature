
Feature: CreditManagement - Search CP with customerID

  Background:
   *print  Search- Search CP with Customer details " 


  @SearchCreditProfile_Positive_TC @SearchCreditProfile @Regression_Suite @Regression_Suite_CreditProfile_TCs @WLN @WLN_SearchCreditProfile
  
  Scenario Outline: Search CP : <testScenario>
    
    # generate new Customer ID, set it in testData
  
    * def RandomNum = Java.type("com.telus.api.test.utils.GenerateRandom_Number")
    * def RandomCustomerID =  RandomNum.getRandom15digitNumber()
    * print  'RandomCustomerID=='+ RandomCustomerID
    
    * def RandomIdNum =  RandomNum.getRandom9digitNumber()
    * print  'RandomIdNum=='+ RandomIdNum
   
    * def testDataSpec = read('Search_Customer_details_TesData.json')
    * def testData = karate.jsonPath(testDataSpec, "$.testDataRequirements.testData." +<data>)
    
    * testData.Id=RandomCustomerID
     * testData.IdNum = RandomIdNum
    * set testData.payloadName = 'WLN_CreateCreditProfile_payload.json'
    *  testData.idTyp= <idTyp>
    * print testData
    
    # Call createCreditProfile service to create User
    * def response =  call read(PATH_SERVICES_PH2_2+'CreateProfile/CreateCreditProfile_Operation.feature') testData
 	 Then print "final response: " + response.response
 	 
    
    ## #Asssertion on REST response
    And def resp = $.response
    
    And def credit_profile_id = $.response.id
    * print "credit_profile_id : " +credit_profile_id
    And def CustomerID = $.response.relatedParty[0].id
    * print "CustomerID : " + CustomerID
    And match CustomerID == RandomCustomerID
    And def identificationvalue = $.response.relatedParty[0].engagedParty.individualIdentification[0].identificationId
    

   #Calling of Get Credit Profile Operation
   
    * def envName = karate.env
      * def headerData = {env: '#(envName)' }
    
    * def res = PATH_TMF+ 'getAuthToken.feature'
    * def token = karate.call(res)
    * headerData.Authorization = token.authToken
    * print 'final headerData: ' + headerData
    * headers headerData
  
    * print 'ENDPOINT_URL: ' + ENDPOINT_URL
    * print 'SERVICE_VERSION: ' + SERVICE_VERSION
    Given url ENDPOINT_URL + 'customer/creditprofile-mgmt/' + SERVICE_VERSION
    And path '/creditProfile'
     And param <identificationtype> = identificationvalue
    When method get
   
    
   Then print "final response: " + response
   And def response = response
   And def orderId = response[0].id
    * print orderId
    And match orderId == credit_profile_id
    


    # Assertion - Validation - "Validate Get Response value"
    * print "Validate Get Response value"

    
   
     Then match response[0].statusCd == 'A'

    Then match response[0].primaryCreditScoreCd == testData.creditSCR
    Then match response[0].bureauDecisionCd == testData.bureauDC
    Then match response[0].creditProgramName == ''
    Then match response[0].creditClassCd == testData.creditCls
    Then match response[0].creditDecisionCd == testData.creditDecisionCd
    Then match response[0].creditRiskLevelNum == testData.creditRiskLevelNum
    Then match response[0].creditRiskLevelDecisionCd == testData.creditRiskLevelDecisionCd
    Then match response[0].clpRatePlanAmt == 170
    Then match response[0].applicationProvinceCd == testData.province
    Then match response[0].lineOfBusiness == 'WIRELINE'
    Then match response[0].clpCreditLimitAmt == 210
    Then match response[0].clpContractTermNum == 24
 
   
     Then match response[0].warnings[0].id != null 
    Then match response[0].warnings[0].warningCategoryCd == testData.WarngCd
    Then match response[0].warnings[0].warningCd == testData.warCd
    Then match response[0].warnings[0].warningTypeCd == 'SAFESCAN'
    Then match response[0].warnings[0].warningItemTypeCd == 'DL'
    Then match response[0].warnings[0].warningStatusCd == testData.warStsCd
 
    Then match response[0].creditDecisionTs != null 
    Then match response[0].creditClassTs != null
    Then match response[0].creditRiskLevelTs != null
    Then match response[0].creationTs != null 
    
    Then match response[0].relatedParty[0].engagedParty.birthDate == testData.DOB
    Then match response[0].relatedParty[0].engagedParty.contactMedium[0].mediumType == testData.medTyp
    Then match response[0].relatedParty[0].engagedParty.contactMedium[0].characteristic.country == testData.Country
    Then match response[0].relatedParty[0].engagedParty.contactMedium[0].characteristic.city == testData.city
    Then match response[0].relatedParty[0].engagedParty.contactMedium[0].characteristic.stateOrProvince == testData.province
    Then match response[0].relatedParty[0].engagedParty.contactMedium[0].characteristic.contactType == testData.contactType
    Then match response[0].relatedParty[0].engagedParty.contactMedium[0].characteristic.postCode == testData.PostCode
     Then match response[0].relatedParty[0].engagedParty.contactMedium[0].characteristic.street1 == testData.street1
    
    * string identyid = RandomIdNum
    Then match response[0].relatedParty[0].engagedParty.individualIdentification[0].identificationId == identyid
    Then match response[0].relatedParty[0].engagedParty.individualIdentification[0].identificationType == testData.idTyp
   
    
   
    ###DB Validations
    
     * def testSpecFileRead = read(PATH_QUERIES+ 'CreateCreditQueries.json')
    * def TSValidator = Java.type("com.telus.api.test.utils.CurrentDate")
    * def DateVal = Java.type("com.telus.api.test.utils.DateValidator")
    
    
    ###Assertion data in CUSTOMER_TABLE
    * def CustomerQry = testSpecFileRead.Queries.CustomerQry
    * def CustomerQryResult = call read(PATH_QUERIES+'dbConnection.feature') {query: '#(CustomerQry)'}
    * def CustomerResult = CustomerQryResult.dbResult
    * print 'CUSTOMER TABLE Result: ' + CustomerResult
    * string id = CustomerResult[0].customer_id
    And match id == CustomerID
    * string role = CustomerResult[0].role
    And match role == testData.role1
     
    
    
  Examples: 
      | testScenario             |identificationtype|idTyp | data                     |
      |identificationtype as PRV | PRV              |'PRV' |  "Search_single_profile" |
      |identificationtype as PSP | PSP              |'PSP' |  "Search_single_profile" |
      |identificationtype as CC  | CC               |'CC'  |  "Search_single_profile" |
      |identificationtype as DL  | DL               |'DL'  |  "Search_single_profile" |
      |identificationtype as HC  | HC               |'HC'  |  "Search_single_profile" |
      |identificationtype as CRA | CRA              |'CRA' |  "Search_single_profile" |
      |identificationtype as NSJ | NSJ              |'NSJ' |  "Search_single_profile" |
      |identificationtype as QST | QST              |'QST' |  "Search_single_profile" |
      
    
     