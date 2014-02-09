package com.cabguru.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;

import javax.net.ssl.HttpsURLConnection;

import org.apache.log4j.Logger;

public class HTTPConnectionManager {
	
	static final Logger log = Logger.getLogger(
			com.cabguru.util.HTTPConnectionManager.class.getName());

	
	public static void postDataToURL_old(String url,
			String jsonData) throws Exception {
		 
		
 
		//log.debug("Testing 1 - Send Http GET request");
		sendGet(url);
 
		//log.debug("\nTesting 2 - Send Http POST request");
		sendPost(url,
				jsonData);
 
	}
	
	// HTTP GET request
		public static String sendGet(String url) throws Exception {
	 
			//String url = "http://www.google.com/search?q=mkyong";
			StringBuilder sBuff = null;
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	 
			// optional default is GET
			con.setRequestMethod("GET");
	 
			//add request header
			//con.setRequestProperty("User-Agent", USER_AGENT);
	 
			int responseCode = con.getResponseCode();
			//log.debug("\nSending 'GET' request to URL : " + url);
			//log.debug("Response Code : " + responseCode);
	 
			BufferedReader in = new BufferedReader(
			        new InputStreamReader(con.getInputStream()));
			String inputLine;
			sBuff = new StringBuilder();
			StringBuffer response = new StringBuffer();
	 
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
				 sBuff.append(inputLine);
			}
			in.close();
	 
			//print result
			//log.debug(response.toString());
			return sBuff.toString();
	 
		}
	 
		// HTTP POST request
		public static String sendPost(String url,
				String jsonData) throws Exception {
	 
			
			//log.debug("Sending 'POST' request to URL : " + url);
			//log.debug("Inside >> HTTPConnectionManager >> Post parameters : " + jsonData);
			
			
			StringBuilder sBuff = null;
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	 
			//add reuqest header
			con.setRequestMethod("POST");
			//con.setRequestProperty("User-Agent", USER_AGENT);
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
	 
			//String urlParameters = "sn=C02G8416DRJM&cn=&locale=&caller=&num=12345";
	 
			// Send post request
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(jsonData);
			wr.flush();
			wr.close();
	 
			int responseCode = con.getResponseCode();
			//log.debug("Inside >> HTTPConnectionManager >> Response Code : " + responseCode);
	 
			BufferedReader in = new BufferedReader(
			        new InputStreamReader(con.getInputStream()));
			String inputLine;
			sBuff = new StringBuilder();
			StringBuffer response = new StringBuffer();
	 
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
				 sBuff.append(inputLine);
			}
			in.close();
	 
			//print result
			//log.debug(response.toString());
			return sBuff.toString();
	 
		}
	
	
	public static String postDataToURL1(String url,
			String jsonData) {

		StringBuilder sBuff = null;

		try {

			URL urldemo = new URL(URLDecoder.decode(url, "UTF-8"));
	        URLConnection yc = urldemo.openConnection();
	        BufferedReader in = new BufferedReader(new InputStreamReader(
	                yc.getInputStream()));
	        String inputLine;
	        sBuff = new StringBuilder();
	        while ((inputLine = in.readLine()) != null){
	        	// log.debug(inputLine);
	        	 sBuff.append(inputLine);
	        }
	           
	        in.close();

		} catch (IOException e) {
			e.printStackTrace();
		}

		if(sBuff != null){
			return sBuff.toString();
		}else{
			return null;
		}
		

	}

}
