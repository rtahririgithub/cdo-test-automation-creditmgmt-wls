package com.telus.api.test.utils;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class CurrentDate {

	public static String dateValitade (String date2, String date1) {
	//SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
   Date date = new Date(System.currentTimeMillis());
	//String date = (formatter.format(date));
	String format = "";
	
	if (date1.compareTo(date2) < 0) {
		    System.out.println("End TS is after start TS");
		    format = "ValidDate";
		   
	}
	else if (date1.compareTo(date2) > 0) {
	    System.out.println("End TS is before start TS");
	    format = "InValidDate" ;
	}
	return format;
	}
	
	public static String DateToday () {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		Date date = new Date(System.currentTimeMillis());
		String date1 = (formatter.format(date));
		
		return date1;
		}
	
	public static String DateAssert (String ActualD, String ExpectedD) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String format = "";
		
		if (ActualD.equals(ExpectedD)) {
			    System.out.println("Actual & expected TS match");
			    format = "Valid";
			   
		}
		else {
		    System.out.println("Actual & expected TS does not match");
		    format = "InValid";
		   
	}
		return format;
		}
	
	
	
	
}

