Feature: Run Query in Data Base
  	# Provide the following inputs: username, password , host , port, serviceName, query
	Background:
		* def con = call read(CORE_DB_UTILS+'connectDB.feature')

	Scenario: Execute UPDATE/INSERT Query		

		# Execute query and get results
		* print query
    * def updateStatement = con.db.executeUpdate(query)
    
    