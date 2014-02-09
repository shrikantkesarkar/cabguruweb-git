package com.cabguru.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.cabguru.util.Constants;
import com.cabguru.util.HTTPConnectionManager;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.LoginServlet.class.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
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

		String phone = request.getParameter("phone");
		String password = request.getParameter("passwd");
		String callerPage = request.getParameter("callerPage");
		// log.debug("doPost >> callerPage = " + callerPage);

		// log.debug("doPost >> phone = " + phone);
		// log.debug("doPost >> password = " + password);

		response.setContentType("text/html");

		try {

			if (phone == null || phone.length() != 10) {
				dispatch(request, response, callerPage,
						"Please enter 10 Digit Mobile Number.");
			} else if (password == null || password.length() < 5) {
				dispatch(request, response, callerPage,
						"Password length should be at least 5 characters.");
			} else {

				JSONObject signupJson = new JSONObject();
				signupJson.put("phone", phone.trim());
				signupJson.put("password", password.trim());

				String responseData = HTTPConnectionManager.sendPost("http://"
						+ Constants.CABGURU_SERVER_IP_PORT
						+ "/cabserver/customers/login", signupJson.toString());
				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					// String msg = (String) obj.get("msg");
					String authLevel = (String) obj.get("authLevel");
					String name = (String) obj.get("name");
					String userId = (String) obj.get("userId");

					String mobileOperator = "";
					JSONObject profileReqJson = new JSONObject();
					profileReqJson.put("userId", userId);

					//log.debug(" userId " + userId);

					if (code.equalsIgnoreCase("200")) {

						if (authLevel != null
								&& authLevel.equalsIgnoreCase("1")) {

							String profileData = HTTPConnectionManager
									.sendPost("http://"
											+ Constants.CABGURU_SERVER_IP_PORT
											+ "/cabserver/customers/get",
											profileReqJson.toString());
							if (profileData != null) {
								JSONParser profileParser = new JSONParser();
								JSONObject profileobj = (JSONObject) profileParser
										.parse(profileData);
								mobileOperator = (String) profileobj
										.get("mobileOperator");
								//log.debug(" mobileOperator* " + profileobj);
							}

							HttpSession session = request.getSession(true);
							session.setAttribute("authid", "user");
							session.setAttribute("authkey", "usersecret");
							session.setAttribute("userName", name.trim());
							session.setAttribute("phone", phone.trim());
							session.setAttribute("userId", userId);
							session.setAttribute("mobileOperator",
									mobileOperator);
														
							dispatch(request, response, "/custMain.jsp",
									"");

						} else if (authLevel != null
								&& authLevel.equalsIgnoreCase("2")) {

							HttpSession session = request.getSession(true);
							session.setAttribute("authid", "admin");
							session.setAttribute("authkey",
									"987654321secure!@#$%");
							session.setAttribute("userName", name.trim());
							session.setAttribute("phone", phone.trim());
							session.setAttribute("userId", userId);

							/* starts Pop driver list */

							String companyDriverData = HTTPConnectionManager
									.sendGet("http://"
											+ Constants.CABGURU_SERVER_IP_PORT
											+ "/cabserver/admin/drivers/list/company");
							if (companyDriverData != null) {
								JSONParser companyDriverParser = new JSONParser();
								JSONArray companyDriverArr = (JSONArray) companyDriverParser
										.parse(companyDriverData);
								Iterator<JSONObject> i = companyDriverArr
										.iterator();

								ArrayList<JSONObject> companyDrivers = new ArrayList<JSONObject>();
								while (i.hasNext()) {
									JSONObject companydriver = (JSONObject) i
											.next();
									companyDrivers.add(companydriver);
								}
								session.setAttribute("companyDrivers",
										companyDrivers);
							}

							String noncompanyDriverData = HTTPConnectionManager
									.sendGet("http://"
											+ Constants.CABGURU_SERVER_IP_PORT
											+ "/cabserver/admin/drivers/list/non-company");
							if (noncompanyDriverData != null) {
								JSONParser noncompanyDriverParser = new JSONParser();
								JSONArray noncompanyDriverArr = (JSONArray) noncompanyDriverParser
										.parse(noncompanyDriverData);
								Iterator<JSONObject> i = noncompanyDriverArr
										.iterator();

								ArrayList<JSONObject> noncompanyDrivers = new ArrayList<JSONObject>();
								while (i.hasNext()) {
									JSONObject noncompanydriver = (JSONObject) i
											.next();
									noncompanyDrivers.add(noncompanydriver);
								}
								session.setAttribute("noncompanyDrivers",
										noncompanyDrivers);
							}

							/* ends Pop driver list */
							
							dispatch(request, response, "/adminMain.jsp",
									"");

						}

					} else {			
						
						dispatch(request, response, callerPage,
								"Incorrect phone or password.");
					}

				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String callerPage, String msg) {

		try {
			request.setAttribute("loginMsg", msg);
			RequestDispatcher rd = request.getRequestDispatcher(callerPage);
			rd.forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
