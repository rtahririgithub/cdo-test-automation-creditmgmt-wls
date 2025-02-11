@ignore 
Feature: RUN a query to the DB providing the name of the DB and query statement

Scenario: Run a query to the DB and get values
	# Get the db credentials based on name provided in calling feature
	* def dbAuth = call read(CORE_DB_UTILS+'getAuthDB.js') dbName
	* print dbAuth
	# Trigger the query 
	* def con = call read(CORE_DB_UTILS+'connectDB.feature') dbAuth
	# Execute query and get results
  * def qryResult = con.db.readRows(query)