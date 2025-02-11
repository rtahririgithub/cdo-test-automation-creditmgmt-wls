@TestDB @AllTests
Feature: Process Test Specs to obtain data
  
	Scenario: Get the Data based on Test Specs	
	#Build the query
	* def json = __arg
	* def tmpResultSet = {}
	* def DbUtils = Java.type('com.test.dbutils.TDMQueryBuilder')
	* def query = DbUtils.constructQueryForAPI(json)
	* print 'QUERY GENERATED: ' + query

	#Run the query	
	* def dbResults = call read(CORE_DB_UTILS+'runQuery.feature') {dbName: 'TDM'}#dbAuth.tdmRepo
	* def tdmResults = dbResults.qryResult  
	* eval tmpResultSet[dataType] = tdmResults