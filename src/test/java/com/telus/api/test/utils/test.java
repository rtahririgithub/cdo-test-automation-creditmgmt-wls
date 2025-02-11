package com.telus.api.test.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.json.JSONException;
import org.json.JSONObject;

import com.test.utils.EncryptDecrypt;

public class test {
	public static JSONObject jsonObject= null;
//	public static void main(String[] args) {
//		// TODO Auto-generated method stub
//
//		String path = System.getProperty("user.dir") + "\\src\\test\\resources\\test.json";
//		System.out.println(path);
//		try {
//			File jsonInputFile = new File("jsonFile.json"); 
//			//InputStream is = new FileInputStream(jsonInputFile);
//			//JsonReader reader = Json.createReader(is);
//			//JsonObject frameObj = reader.readObject();
//			//reader.close();
//		     jsonObject = new JSONObject(path);
//		     String labelDataString=jsonObject.getString("primaryCreditScoreTypeCd");
//		     JSONObject labelDataJson= null;
//		     labelDataJson= new JSONObject(labelDataString);
//		     if(labelDataJson.has("primaryCreditScoreTypeCd")&&labelDataJson.getString("primaryCreditScoreTypeCd")!=null){
//		       String video=labelDataJson.getString("video");
//		       System.out.println(video);
//		     }
//		    } catch (JSONException e) {
//		      e.printStackTrace();
//		 }
//	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		try {
			//String  enpaddword=EncryptDecrypt.("desktop", "a06ea6ac-c8a0-490c-a838-dec4a4302e64");
			 System.out.println("Murthy: "+EncryptDecrypt.generateEncryptData("a06ea6ac-c8a0-490c-a838-dec4a4302e64", EncryptDecrypt.PASSWORD));
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
