# TELUS - Karate Test

Karate Test Project is created to ease the users to start with automation script creation as it includes a set of Karate examples that test these services as well as demonstrate various Karate features and best-practices.

## How to Execute

User needs to clone []from GIT and start creating feature file in respective application folder.

Core project dependency required for this project is already present in Maven dependencies:

		<dependency>
	  		<groupId></groupId>
	  		<artifactId>telus-api-test-core</artifactId>
	 	 	<version>1.2-SNAPSHOT</version>	
		</dependency>	
		

Now user needs to navigate to com.telus.api.test.runners and than run class TestRunnerCustomReport.Java by updating the below fields:
- feature : Path of Application specific feature file
- Tag : Which particular feature file user needs to execute
- karate.env : Environment name on which execution to be triggered
- telus.appName : Application for which execution to be triggered
- threads : number of threads for execution

## Framework components

#### config.properties

This framework contains a config.properties properties file which will be a general properties for any of the projects. It is used to set the default environment and default configurations.

#### Source folder - src/test/resources

 - module test package: This package contains config , service and test packages of particular module.
 		- config : This package contains all configuration details related to modue.
 		- service : This package contains service related operation related to modue.
 		- test : This package contains tests to test the module.
 		
 - Configuration files: Different configuration files used to do basic configurations .
 		- karate-config.js

This framework contains a karate-config.js configuration file which will be a general configuration for any of the projects. It is used to set the configurations , end points on the basis of appname.

#### Source folder - src/main/resources

- utils package: This package contains the different utilities you will need for data base connection, queries, and other general utilities.

 - Configuration files: Different configuration files used to define data base authentication and basic configurations.