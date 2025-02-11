function(jsonFileLocation) {    

  // get system property 'karate.env'
  var env = karate.env;   
  // read the json file, pass the complete path
  var config = karate.read(jsonFileLocation);
  //Save data in a variable, this will choose the right node base on 'env'
  //var testData = config.testDataRequirements.testData[env];
  //No need to filter by env
  if (config['testDataRequirements']) {
	  var testData = config.testDataRequirements.testData; 	  
  }

  return testData;
}


/*
  // get system property 'karate.env'
  var env = karate.env;   
  // read the json file, pass the complete path
  var testSpec = karate.read(jsonFileLocation);
  var overrideTDMSwitch = karate.properties['overrideTDMSwitch'];	 
  var testdata = (overrideTDMSwitch.toLowerCase() === 'true') ? testSpec.testDataRequirements.defaultTestData : testSpec.testDataRequirements.testData;
  
  return testdata;
}*/