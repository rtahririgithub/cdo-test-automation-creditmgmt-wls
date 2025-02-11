package com.telus.api.test.runners;

import com.intuit.karate.KarateOptions;
import org.junit.BeforeClass;

@KarateOptions(
		features = "classpath:tests/Features/Phase_2_2/CreditMgmtTest/SearchCustomerDetilas/Search_CP_by_Multiple_identificationType_OR_Function.feature"
	
		//tags = "@SearchCreditProfile_Party"
		)


/*       ,tags = "@CreateCreditProfile"
	
		AND tags
	     ,tags = {"@CreateCreditProfile" ,"@CreateCreditProfile_Positive_TC",  "@CreateCreditProfile_Negative_TC"}
		
		OR Tags
		,tags = {"~@GetCreditProfile, ~@GetCreditProfile_Positive_TC","@GetCreditProfile_Negative_TC"}
		
		Skip Tags
		,tags = {"@test" ,"~@CreateCreditProfile_negative_test",  "@CreateCreditProfile_Positive_test"}
		
		
 ******************************************************** Configure Tags for Execution********************************************************************

To Run CreateCreditProfile Scripts,Add this tag-------------------@CreateCreditProfile , @CreateCreditProfile_Positive_TC , @CreateCreditProfile_Negative_TC 

To Run GetCreditProfile Scripts,Add this tag----------------------@GetCreditProfile , @GetCreditProfile_Positive_TC , @GetCreditProfile_Negative_TC

To Run SearchCreditProfile Scripts,Add this tag------------------@SearchCreditProfile , @SearchCreditProfile_Positive_TC  ,@SearchCreditProfile_Negative_TC

To Run UpdateCreditProfile Scripts,Add this tag-----------------@UpdateCreditProfile ,@UpdateCreditProfile_Positive_TC ,@UpdateCreditProfile_Negative_TC 


To Run Regression_Suite which includes entire test cases of  CREATE,GET,SEARCH,UPDATE and DELETE,Add this tag-------- @Regression_Suite 

To Run Delete CreditProfile Scripts,Add this tag---------------------------------------------@DeleteCreditProfile
To Run Update Warning details for existing CreditProfile Scripts,Add this tag------------------@UpdateWarningObj
To Run adding new Warning details for existing CreditProfile Scripts,Add this tag-----------@AddNewWarningObj

*/

		
public class AppParallelRunner extends BaseParallel {
  @BeforeClass
    public static void beforeClass() {
    	//Uncomment this line when running locally and provide env to use:
    	//telus.appName: OMNI / NC/ ESS / TDM
    	//threads: number of threads to be used
    	System.setProperty("karate.env", "it03");  
    	//System.setProperty("telus.appName", "SC");
    	System.setProperty("threads", "1");

    }    
     	   
}
