function(jsonFileLocation) {    

  // get system property 'karate.env'
  var env = karate.env;   
  // read the json file, pass the complete path
  var config = karate.read(jsonFileLocation);
  //Save data in a variable, this will choose the right node base on 'env'
  //var testData = config.testDataRequirements.testData[env];
  //No need to filter by env
  if (config['serviceVirtualization']) {
	  var svtestData = config.serviceVirtualization.operations; 
	  karate.log('getSVTestData from testSpec:: ', svtestData);
  }
  return svtestData;
}