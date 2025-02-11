Feature: Connect to the Data Base
  	# Provide the following inputs: username, password , host , port, serviceName, query

	Scenario: CONNECT to the DB
    # Establish the connection to the DB
		#* def conn = 'jdbc:oracle:thin:@' + host + ':' + port + '/' + serviceName
		* def conn = 'jdbc:postgresql://' + host + ':' + port + '/' + dbName
		#* def conn = "jdbc:postgresql://localhost:5432/creditDB"
		* def configDB = { username: '#(username)', password: '#(password)', url: '#(conn)', driverClassName: 'org.postgresql.Driver' }
		* print 'configDB: ' + configDB
		* def DbUtils = Java.type('com.telus.api.test.utils.DbUtils')
		* def db = new DbUtils(configDB)		
  
    