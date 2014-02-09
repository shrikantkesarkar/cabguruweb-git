package com.cabguru.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.cabguru.util.Constants;
import com.cabguru.util.HTTPConnectionManager;

/**
 * Servlet implementation class AddDriverServlet
 */
public class AddDriverServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger log = Logger.getLogger(
			com.cabguru.servlet.AddDriverServlet.class.getName());
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddDriverServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String callerPage = request.getParameter("callerPage");
		//log.debug("doPost >> callerPage = " + callerPage);
		
		String phone = request.getParameter("phone");
		String firstName = request.getParameter("firstName");
		//String middleName = request.getParameter("middleName");
		String lastName = request.getParameter("lastName");
		String age = request.getParameter("age");
		String sex = request.getParameter("sex");
		String mailId = request.getParameter("mailId");
		String licNumber = request.getParameter("licNumber");
		String address = request.getParameter("address");
		String mobileOperator = request.getParameter("mobileOperator");
		String driverCategory = request.getParameter("driverCategory");

		/*log.debug("doPost >> phone = " + phone);
		log.debug("doPost >> firstname = " + firstName);		
		log.debug("doPost >> lastname = " + lastName);
		log.debug("doPost >> mobileOperator = " + mobileOperator);
		log.debug("doPost >> driverCategory = " + driverCategory);
		log.debug("doPost >> age = " + age);
		log.debug("doPost >> sex = " + sex);
		log.debug("doPost >> mailId = " + mailId);
		log.debug("doPost >> licNumber = " + licNumber);
		log.debug("doPost >> address = " + address);*/
		

		if (phone == null || phone.length() != 10) {
			dispatch(request, response, callerPage, "Please enter 10 Digit Mobile Number.");			
		} else if (mobileOperator == null || mobileOperator.length() < 1) {
			dispatch(request, response, callerPage,
					"Select a valid mobile operator.");			
		} else if (firstName == null || firstName.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter driver's First Name.");
		} else if (lastName == null || lastName.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter driver's Last Name.");
		} else if (age == null || age.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter driver's age.");
		} else if (sex == null || sex.length() < 1) {		
			dispatch(request, response, callerPage, "Please enter driver's gender.");
		} else if (licNumber == null || licNumber.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter driver's License Number.");
		} else if (address == null || address.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter driver's address.");
		} else if (mailId == null || mailId.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter driver's mailId.");
		} else {
						
			try {
				JSONObject signupJson = new JSONObject();
				String responseData = "";
				
				 if(callerPage.equalsIgnoreCase("updateDriver.jsp")){
					 
					 	String driverId = request.getParameter("driverId");
					 
					 	signupJson.put("driverId",driverId);
					 	signupJson.put("firstName",firstName.trim());
					 	signupJson.put("lastName", lastName.trim());
						signupJson.put("phone", phone.trim());
						signupJson.put("mobileOperator", mobileOperator != null ? mobileOperator.trim(): "");
						signupJson.put("driverCategory", driverCategory != null ? driverCategory.trim(): "");
						signupJson.put("age", age.trim());
						signupJson.put("sex", sex.trim());
						signupJson.put("mailId", mailId.trim());
						signupJson.put("licNumber", (licNumber.trim()).replaceAll(" ", ""));
						signupJson.put("address", address.trim());
						

						responseData = HTTPConnectionManager.sendPost(
								"http://" + Constants.CABGURU_SERVER_IP_PORT
										+ "/cabserver/admin/drivers/update-driver-data",
								signupJson.toString());
					 
				 }else{
					 
					    signupJson.put("name", firstName.trim() + " " + lastName.trim());
						signupJson.put("phone", phone.trim());
						signupJson.put("mobileOperator", mobileOperator != null ? mobileOperator.trim(): "");
						signupJson.put("driverCategory", driverCategory != null ? driverCategory.trim(): "");
						signupJson.put("age", age.trim());
						signupJson.put("sex", sex.trim());
						signupJson.put("mailId", mailId.trim());
						signupJson.put("licNumber", (licNumber.trim()).replaceAll(" ", ""));
						signupJson.put("address", address.trim());
						

						responseData = HTTPConnectionManager.sendPost(
								"http://" + Constants.CABGURU_SERVER_IP_PORT
										+ "/cabserver/drivers/signup",
								signupJson.toString());
				 }
				
				
				
				
				//log.debug("doPost >> responseData="+ responseData);
				if (responseData != null) {				

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");				
					
					log.debug("doPost >> code"+code);
					
					if (code.equalsIgnoreCase("200")) {						
						dispatch(request, response, callerPage, msg);
					} else if (code.equalsIgnoreCase("409")) {						
						dispatch(request, response, callerPage, msg);
					}

				} else {					
					dispatch(request, response, callerPage, "Data Error. Please try again.");
				}
			} catch (Exception e) {			
				dispatch(request, response, callerPage, "Driver SignUp Error. Please try again.");
				e.printStackTrace();
			}			
			

		}

	}
	
	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String callerPage, String msg){		
		
		try {
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request
					.getRequestDispatcher(callerPage);
			rd.forward(request, response);
		} catch (ServletException e) {			
			e.printStackTrace();
		} catch (IOException e) {			
			e.printStackTrace();
		}
		
	}

}
