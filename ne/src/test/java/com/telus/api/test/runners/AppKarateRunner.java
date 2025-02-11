package com.telus.api.test.runners;

import java.io.IOException;

import org.junit.BeforeClass;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.intuit.karate.junit4.Karate;

import cucumber.api.CucumberOptions;

@RunWith(Karate.class)
@CucumberOptions(

		// features = "classpath:nc/tests/",
		features = "classpath:tests/Phase_2/CreditMgmtTest/CreateCreditProfile/")
		//tags = { "@test" })

public class AppKarateRunner  {

	private final static Logger log = LoggerFactory.getLogger(AppKarateRunner.class);

	@BeforeClass
	public static void beforeClass() throws IOException {
		// Uncomment this line when running locally and provide env to use:

		System.setProperty("karate.env", "PT140");

		//System.setProperty("telus.appName", "nba");
		
		//Uncomment to use on CAPI project
		//System.setProperty("karate.apikey", "QE1234");
		//System.setProperty("karate.consumerkey", "myKey");
		//reviveTDMOverrideSwitchBasedOnEnv();
	}

	/**
	 * sets the "overrideTDMSwitch" system property based on env
	 */
	private static void reviveTDMOverrideSwitchBasedOnEnv() {
		String overrideTDMSwitch = "false";
		try {
			overrideTDMSwitch = System.getProperty("karate.env").equalsIgnoreCase("auto") ? "true" : "false";
		} catch (Exception e) {
			log.warn("Error encountered while setting overrideTDMSwitch, will default to false " + e.getMessage());
		}
		System.setProperty("overrideTDMSwitch", overrideTDMSwitch);
	}

}
