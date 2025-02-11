package com.telus.api.test.utils;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class DateValidator {
	


	    public static boolean isValid(String date) {

	    	DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        sdf.setLenient(false);
	        try {
	            sdf.parse(date);
	        } catch (ParseException e) {
	            return false;
	        }
	        return true;
	    }
	}

