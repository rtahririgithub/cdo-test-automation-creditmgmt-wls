@ignore
Feature: Read and process the data spec

  Background:
    * def jsonFileName = filename
    * def testSpec = read(jsonFileName)
    * def dataResultSet = {}
    * def testDataResults = {}
    * def isEmpty = read('classpath:utils/isEmpty.js')

  @ProcessTestSpec
  Scenario: Process data and SV requirements
    # GET VALUES FROM TDM REPO DB
    Given def testDataResultsTDM = isEmpty(testSpec.testDataRequirements.TDMRepo ? {} : karate.call('classpath:utils/dataBase/getDataFromTDM.feature', testSpec.testDataRequirements.TDMRepo))
    Then def testDataResultsTDM = get testDataResultsTDM[*].tmpResultSet
    And eval testDataResults["TDMRepo"] = testDataResultsTDM
    
    #GET VALUES FROM Test Data Section BASED IN ENV
    #* def filename = 'classpath:utils/testSpecs/getTestDataFromSpecs.js'
    * Given def testdata = call read('classpath:utils/testSpecs/getTestDataFromSpecs.js') jsonFileName
    * eval testDataResults["testData"] = testdata
    
    #invoke SV runner for auto env
    * def kEnv = call read('classpath:utils/toLowerCase.js') karate.env
    * eval if (kEnv == 'auto') karate.call('classpath:utils/callSVRunner.feature',  {testSpec: jsonFileName})
   
   
