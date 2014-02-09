package com.cabguru.servlet;

import java.io.IOException;
import java.io.PrintWriter;

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
 * Servlet implementation class ForgotpasswordServlet
 */
public class ForgotpasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.ForgotpasswordServlet.class
					.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ForgotpasswordServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String phone = request.getParameter("phone");
		log.debug("doPost >> phone = " + phone);
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		try {

			if (phone == null || phone.length() != 10) {

				dispatch(request, response, "/forgotPassword.jsp",
						"Enter a valid 10 digit phone number.");
			} else {

				JSONObject signupJson = new JSONObject();
				signupJson.put("phone", phone.trim());

				String responseData = HTTPConnectionManager.sendPost("http://"
						+ Constants.CABGURU_SERVER_IP_PORT
						+ "/cabserver/admin/forgot-password",
						signupJson.toString());
				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");

					if (code.equalsIgnoreCase("200")) {

						log.debug("doPost >> Password is sent to your registered E-Mail ID.");

						request.setAttribute("msg", msg);
						RequestDispatcher rd = request
								.getRequestDispatcher("/forgotPassword.jsp");
						rd.forward(request, response);

					} else {

						log.debug("doPost >> Password reset not done. Please call customer Care.");
						dispatch(request, response, "/forgotPassword.jsp", msg);
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
			request.setAttribute("msg", msg);
			RequestDispatcher rd = request.getRequestDispatcher(callerPage);
			rd.forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
