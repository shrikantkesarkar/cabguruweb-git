package com.cabguru.util;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class DriversCache {

	static final Logger log = Logger
			.getLogger(com.cabguru.util.DriversCache.class.getName());

	

	public static void main(String[] args) {

		getGPSData();

	}

	public static String getGPSData() {
		// String gpsData = "";
		String locationData = "";
		log.debug("getGPSData");
		try {

			String responseData = HTTPConnectionManager.sendGet("http://"
					+ Constants.CABGURU_SERVER_IP_PORT
					+ "/cabserver/drivers/locations");

			if (responseData != null) {

				JSONParser parser = new JSONParser();
				JSONArray jsonArrayResponse;
				try {
					jsonArrayResponse = (JSONArray) parser.parse(responseData);
					locationData = "[\n";

					for (int i = 0; i < jsonArrayResponse.size(); i++) {

						JSONObject obj = (JSONObject) jsonArrayResponse.get(i);

						if (i == (jsonArrayResponse.size() - 1)) {
							locationData += "['Taxi-" + obj.get("driverId")
									+ " " + obj.get("firstName") + " "
									+ obj.get("phoneNumber") + " "
									+ obj.get("driverStatus") + "',"
									+ obj.get("currLat") + ","
									+ obj.get("currLongt") + "," + (i + 1)
									+ "]\n]";
						} else {
							locationData += "['Taxi-" + obj.get("driverId")
									+ " " + obj.get("firstName") + " "
									+ obj.get("phoneNumber") + " "
									+ obj.get("driverStatus") + "',"
									+ obj.get("currLat") + ","
									+ obj.get("currLongt") + "," + (i + 1)
									+ "],\n";
						}

					}

					log.debug("getGPSData >> var=" + locationData);

				} catch (Exception e) {					
					e.printStackTrace();
				}

			}

		} catch (Exception e) {			
			e.printStackTrace();
		}

		return locationData;
	}

}
