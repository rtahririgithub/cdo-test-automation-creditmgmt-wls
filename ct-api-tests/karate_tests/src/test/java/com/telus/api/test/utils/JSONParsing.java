package com.telus.api.test.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import groovy.json.JsonException;
import groovy.json.JsonSlurper;

public class JSONParsing {
	int k = 0;
	String val;

	public String readJSONNodeValue(Object json, String node, int pos) throws Exception {
		Map<Object, Object> map = new HashMap<Object, Object>();
		List<Object> list = new ArrayList<Object>();
		if (json instanceof Map) {
			map = (HashMap) json;
			Iterator<Entry<Object, Object>> itr = map.entrySet().iterator();
			while (itr.hasNext()) {
				Map.Entry<Object, Object> mapElement = (Map.Entry<Object, Object>) itr.next();
				if (mapElement.getValue() instanceof JSONObject || mapElement.getValue() instanceof HashMap) {
					readJSONNodeValue((Object) mapElement.getValue(), node, pos);
				} else if (mapElement.getValue() instanceof JSONArray) {
					JSONArray jsonArray = (JSONArray) (mapElement.getValue());
					List<Object> jsonArrayList = new ArrayList<Object>();
					jsonArrayList.addAll(jsonArray);
					for (int i = 0; i < jsonArrayList.size(); i++) {
						readJSONNodeValue((JSONObject) jsonArrayList.get(i), node, pos);
					}
				} else {
					if (((String) mapElement.getKey()).equalsIgnoreCase(node)) {
						if (pos == k) {
							val = (String) mapElement.getValue();
						} else {

						}

						k++;
					}
				}
			}
		} else {
			list = (ArrayList) json;
			for (int i = 0; i < list.size(); i++) {
				readJSONNodeValue((JSONObject) list.get(i), node, pos);
			}
		}
		return val;
	}

	public void resetValue() {
		this.k = 0;
		this.val = null;
	}

	public Object getNodeValue(Object jsonObject, String node) throws Exception {
		resetValue();
		Object obj = null;
		String str1 = node.substring(0, node.lastIndexOf("["));
		String posString = node.substring(node.lastIndexOf("[") + 1, node.lastIndexOf("]"));
		if (posString != null) {
			int pos = Integer.parseInt(posString);
			obj = readJSONNodeValue(jsonObject, str1, pos);
		}
		return obj;

	}
	
	public static boolean isJSONValid(String fileName) {
		String path = System.getProperty("user.dir") + fileName;
		Collection<File> jsonFiles = FileUtils.listFiles(new File(path), new String[] { "json" }, true);
		boolean flag = true;
		for (File file : jsonFiles) {
			try {
				System.out.println(file.getAbsolutePath());
				new JsonSlurper().parse(file);
				System.out.println("Valid Json");

			} catch (JsonException e) {
				System.out.println("InValid Json ");
				flag = false;
			}
		}
		return flag;
	}
}
