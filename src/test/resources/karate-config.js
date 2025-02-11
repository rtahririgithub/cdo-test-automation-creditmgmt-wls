function() {    
    
    karate.log('Env Params :', karate.env);
     
     var envName = karate.env;
  
  var config = karate.read('classpath:config/AppConfig.json');  

  config.myEndPoints = karate.read('classpath:config/EndPoints.json');
  	if (envName == 'it01') {
	  	config.ENDPOINT_URL= config.myEndPoints.IT01.ENDPOINT_URL;
	  	config.ENDPOINT_CLIENT_CREDENTIAL= config.myEndPoints.IT01.ENDPOINT_CLIENT_CREDENTIAL;
	  	config.DB_NAME= config.myEndPoints.IT01.DB_NAME;
  	} 	
  	else if (envName == 'it02') {
  		config.ENDPOINT_URL= config.myEndPoints.IT02.ENDPOINT_URL;
  		config.ENDPOINT_CLIENT_CREDENTIAL= config.myEndPoints.IT02.ENDPOINT_CLIENT_CREDENTIAL;
    } 	
  	else if (envName == 'it03') {
    	config.ENDPOINT_URL= config.myEndPoints.IT03.ENDPOINT_URL;
  	  	config.ENDPOINT_CLIENT_CREDENTIAL= config.myEndPoints.IT03.ENDPOINT_CLIENT_CREDENTIAL;
    }  	
  	else if (envName == 'it04') {
    	config.ENDPOINT_URL= config.myEndPoints.IT04.ENDPOINT_URL;
  	  	config.ENDPOINT_CLIENT_CREDENTIAL= config.myEndPoints.IT04.ENDPOINT_CLIENT_CREDENTIAL;
   } 
    else if (envName == 'DV') {
    	config.ENDPOINT_URL= config.myEndPoints.DV.ENDPOINT_URL;
  	  	config.ENDPOINT_CLIENT_CREDENTIAL= config.myEndPoints.DV.ENDPOINT_CLIENT_CREDENTIAL;
     } 
    else if (envName == 'AUTO') {
    	config.ENDPOINT_URL= config.myEndPoints.AUTO.ENDPOINT_URL;
  	  	config.ENDPOINT_CLIENT_CREDENTIAL= config.myEndPoints.AUTO.ENDPOINT_CLIENT_CREDENTIAL;
     } 
  
  karate.configure('connectTimeout', 116000);
  karate.configure('readTimeout', 116000);
  return config;
}