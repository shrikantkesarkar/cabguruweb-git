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
 * Servlet implementation class signupservlet
 */
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger log = Logger.getLogger(
			com.cabguru.servlet.SignupServlet.class.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignupServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		String callerPage = request.getParameter("callerPage");
		//log.debug("doPost >> callerPage = " + callerPage);
		//String password = "";		
		
		String termsandconds = request.getParameter("termsandconds");
		String phone = request.getParameter("phone");
		String firstName = request.getParameter("firstName");		
		String lastName = request.getParameter("lastName");		
		String sex = request.getParameter("sex");
		String mailId = request.getParameter("mailId");
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");
		String mobileOperator = request.getParameter("mobileOperator");
		
		/*log.debug("doPost >> phone = " + phone);
		log.debug("doPost >> firstName = " + firstName);		
		log.debug("doPost >> lastName = " + lastName);		
		log.debug("doPost >> sex = " + sex);
		log.debug("doPost >> mailId = " + mailId);
		log.debug("doPost >> address = " + address);
		log.debug("doPost >> password = " + password);
		log.debug("doPost >> confirmPassword = " + confirmPassword);
		log.debug("doPost >> mobileOperator = " + mobileOperator);
		log.debug("doPost >> termsandconds = " + termsandconds);*/
		

		if (phone == null || phone.length() != 10) {			
			dispatch(request, response, callerPage, "Please enter 10 Digit Mobile Number.");
		} else if (mobileOperator == null || mobileOperator.length() < 1) {
			dispatch(request, response, callerPage,
					"Select a valid mobile operator.");			
		} else if (firstName == null || firstName.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter your First Name.");
		} else if (lastName == null || lastName.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter your Last Name.");
		} else if (mailId == null || mailId.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter your E-Mail Id.");
		} else if (password == null || password.length() < 5) {			
			dispatch(request, response, callerPage, "Password length should be at least 5 characters.");
		} else if (!password.equals(confirmPassword)) {			
			dispatch(request, response, callerPage, "Password and confirm password do not match.");
		} else if(termsandconds == null){
			dispatch(request, response, callerPage,
					"Please accept the terms of services.");
			return;
		}else {

			try {
				JSONObject signupJson = new JSONObject();
				String responseData = "";
				
			   if(callerPage.equalsIgnoreCase("updateCust.jsp") || callerPage.equalsIgnoreCase("myProfile.jsp")){
					
				   String userId = request.getParameter("userId");
				   
				    signupJson.put("userId", userId);
					signupJson.put("firstName", firstName.trim());
					signupJson.put("lastName", lastName.trim());
					signupJson.put("phone", phone.trim());		
					signupJson.put("mobileOperator", mobileOperator.trim());
					signupJson.put("sex", sex != null ? sex.trim(): "U");
					signupJson.put("mailId", mailId.trim());
					signupJson.put("address", address != null ? address.trim(): "U");
					signupJson.put("password", password.trim());
					
					responseData = HTTPConnectionManager.sendPost(
							"http://" + Constants.CABGURU_SERVER_IP_PORT
									+ "/cabserver/admin/customers/update-customer-data",
							signupJson.toString());
					
				}else{
					
					signupJson.put("name", firstName.trim() + " " + lastName.trim());
					signupJson.put("phone", phone.trim());		
					signupJson.put("mobileOperator", mobileOperator.trim());
					signupJson.put("sex", sex != null ? sex.trim(): "U");
					signupJson.put("email", mailId.trim());
					signupJson.put("address", address != null ? address.trim(): "U");
					signupJson.put("password", password.trim());
					
					responseData = HTTPConnectionManager.sendPost(
							"http://" + Constants.CABGURU_SERVER_IP_PORT
									+ "/cabserver/customers/signup",
							signupJson.toString());
				}
				
				
				log.debug("doPost >> responseData="+ responseData);
				if (responseData != null) {				

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");				
					
					log.debug("doPost >> code"+code);
					
					if (code.equalsIgnoreCase("200")) {
						
						dispatch(request, response, callerPage, msg);

					} else if (code.equalsIgnoreCase("409")) {

						dispatch(request, response, callerPage, "User already exists. Please Login.");
					}

				} else {					
					dispatch(request, response, callerPage, "Data Error. Please try again.");
				}
			} catch (Exception e) {			
				dispatch(request, response, callerPage, "SignUp Error. Please try again.");
				e.printStackTrace();
			}

		}

	}
	
	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String callerPage, String msg){		
		
		try {
			request.setAttribute("signupMsg", msg);
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
