@Ignore
Feature: Get Device Return Order record

  Scenario: Get device return order
		# Get the db credentials based on name provided in calling feature
    * def dbName = karate.env
    #* def dbName = envName
    * def dbAuth = call read('classpath:utils/dataBase/getAuthDB.js') dbName
   # * print dbAuth

    # Trigger the query
    * def con = call read('classpath:utils/dataBase/connectDB.feature') dbAuth
    
    * print  Trigger the query
    
    * def dbResult = con.db.readRows(query)   