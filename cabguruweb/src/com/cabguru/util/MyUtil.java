package com.cabguru.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class MyUtil {

	public static void main(String[] args) {

		String from = "Gallagher Drive, Minneapolis, MN, United States";


		//String newfrom = from.replaceAll("(?=[]\\[+&|!(){}^\"~*?:\\\\-])`@#", "+");
		// System.out.println(newfrom);


		Pattern pt = Pattern.compile("[^a-zA-Z0-9]");
		Matcher match= pt.matcher(from);
		while(match.find())
		{
			String s= match.group();
			from=from.replaceAll("\\"+s, "+");
		}
		System.out.println(from);



	}



	public static ArrayList<JSONObject> getCompanyDrivers() {

		//System.out.println("getCompanyDrivers");
		ArrayList<JSONObject> companyDrivers = null;
		try {

			String companyDriverData = HTTPConnectionManager.sendGet("http://"
					+ Constants.CABGURU_SERVER_IP_PORT
					+ "/cabserver/admin/drivers/list/company");
			if (companyDriverData != null) {
				JSONParser companyDriverParser = new JSONParser();
				JSONArray companyDriverArr = (JSONArray) companyDriverParser.parse(companyDriverData);
				Iterator<JSONObject> i = companyDriverArr.iterator();

				companyDrivers = new ArrayList<JSONObject>();
				while (i.hasNext()) {
					JSONObject companydriver = (JSONObject) i.next();

					if(companydriver.get("code").equals("200")){
						companyDrivers.add(companydriver);
					}
				}

			}

		} catch (Exception e) {			
			e.printStackTrace();
		}

		return companyDrivers;
	}


	public static ArrayList<JSONObject> getNonCompanyDrivers() {

		//System.out.println("getNonCompanyDrivers");
		ArrayList<JSONObject> noncompanyDrivers = null;
		try {

			String noncompanyDriverData = HTTPConnectionManager.sendGet("http://"
					+ Constants.CABGURU_SERVER_IP_PORT
					+ "/cabserver/admin/drivers/list/non-company");
			if (noncompanyDriverData != null) {
				JSONParser noncompanyDriverParser = new JSONParser();
				JSONArray noncompanyDriverArr = (JSONArray) noncompanyDriverParser.parse(noncompanyDriverData);
				Iterator<JSONObject> i = noncompanyDriverArr.iterator();

				noncompanyDrivers = new ArrayList<JSONObject>();
				while (i.hasNext()) {
					JSONObject noncompanydriver = (JSONObject) i.next();
					if(noncompanydriver.get("code").equals("200")){
						noncompanyDrivers.add(noncompanydriver);
					}
				}

			}

		} catch (Exception e) {			
			e.printStackTrace();
		}

		return noncompanyDrivers;
	}





	public static String getFormattedAddress(String addrStr){
		String address = addrStr;

		Pattern pt = Pattern.compile("[^a-zA-Z0-9]");
		Matcher match= pt.matcher(address);
		while(match.find())
		{
			String s= match.group();
			address=address.replaceAll("\\"+s, "+");
		}
		// System.out.println("getFormattedAddress >> "+address);

		return address;

	}


	public static HashMap<String,String> getDateComonents(String datetime){

		HashMap<String, String> dateComponents = new HashMap<String, String>();

		String tmpArry[] = datetime.split(" ");

		dateComponents.put("date", tmpArry[0]);
		dateComponents.put("month", tmpArry[1]);
		dateComponents.put("year", tmpArry[2]);
		dateComponents.put("hour", tmpArry[4].split(":")[0]);
		dateComponents.put("min", tmpArry[4].split(":")[1]);
		dateComponents.put("ampm", tmpArry[5]);

		return dateComponents;
	}


	public static int getMonth(String monthStr){

		if(monthStr.equalsIgnoreCase("January")){
			return 1;
		}else if(monthStr.equalsIgnoreCase("February")){
			return 2;
		}else if(monthStr.equalsIgnoreCase("March")){
			return 3;
		}else if(monthStr.equalsIgnoreCase("April")){
			return 4;
		}else if(monthStr.equalsIgnoreCase("May")){
			return 5;
		}else if(monthStr.equalsIgnoreCase("June")){
			return 6;
		}else if(monthStr.equalsIgnoreCase("July")){
			return 7;
		}else if(monthStr.equalsIgnoreCase("August")){
			return 8;
		}else if(monthStr.equalsIgnoreCase("September")){
			return 9;
		}else if(monthStr.equalsIgnoreCase("October")){
			return 10;
		}else if(monthStr.equalsIgnoreCase("November")){
			return 11;
		}else if(monthStr.equalsIgnoreCase("December")){
			return 12;
		}else{
			return 13;
		}

	}




}
