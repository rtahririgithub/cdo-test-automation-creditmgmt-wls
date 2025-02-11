package com.telus.api.test.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;



public class DbUtils {

	private static final Logger logger = LoggerFactory.getLogger(DbUtils.class);

	 static JdbcTemplate jdbc;
	
	//private ReadJSON readJSON;

	/**
	 * @param config
	 * @Description which will contains details of DB Connection in Map
	 */
	
     public DbUtils() {}
   
    public DbUtils(Map<String, Object> config) {
    	super();
        String url = (String) config.get("url");
        String username = (String) config.get("username");
        String password = (String) config.get("password");
        String driver = (String) config.get("driverClassName");
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(driver);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        jdbc = new JdbcTemplate(dataSource);
        logger.info("init jdbc template: {}", url);
    }
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.telus.api.test.abstractutils.DbUtilsAbstract#readValue
	 */
	/*@Override
	public Object readValue(String query) {
		return jdbc.queryForObject(query, Object.class);

	}*/

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.telus.api.test.abstractutils.DbUtilsAbstract#readRow
	 */
	/*@Override
	public Map<String, Object> readRow(String query) {
		return jdbc.queryForMap(query);
	}*/

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.telus.api.test.abstractutils.DbUtilsAbstract#readRows
	 */
	
	public List<Map<String, Object>> readRows(String query) {
		return jdbc.queryForList(query);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.telus.api.test.abstractutils.DbUtilsAbstract#executeUpdate
	 * @Description This method works for UPDATE and INSERT, the query is input
	 */
	
	public void executeUpdate(String updateQuery) {
		jdbc.update(updateQuery);
	}

	/**
	 * @param nameDB
	 * @param jsonFileLocation
	 * @return List with all DB connection parameter loaded from a JSON file
	 */
	/*@Override
	public List<String> getConnectParametersFromJson(String nameDB, String jsonFileLocation) {
		List<String> val = new ArrayList<String>();
		try {
			JSONObject db = new JSONObject();
			JSONObject jsonFile = new JSONObject(readJSON.parse(jsonFileLocation));
			db = jsonFile.getJSONObject(nameDB);
			val.add(readJSON.getString(db, "username")); // username
			val.add(readJSON.getString(db, "password")); // password
			val.add(readJSON.getString(db, "host")); // host
			val.add(readJSON.getString(db, "port")); // port
			val.add(readJSON.getString(db, "serviceName")); // serviceName
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return val;
	}*/

}
