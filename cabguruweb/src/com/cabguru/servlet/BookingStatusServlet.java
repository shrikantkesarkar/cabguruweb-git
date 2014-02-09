package com.cabguru.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.cabguru.util.Constants;
import com.cabguru.util.HTTPConnectionManager;

/**
 * Servlet implementation class BookingStatusServlet
 */
public class BookingStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.BookingStatusServlet.class.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookingStatusServlet() {
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

		String bookingId = request.getParameter("bookingId");
		log.debug("doPost >> bookingId = " + bookingId);
		
		String userId = request.getParameter("userId");
		log.debug("doPost >> userId = " + userId);
		

		String statusButton = request.getParameter("statusButton");
		log.debug("doPost >> statusButton = " + statusButton);
		
		String callerPage = request.getParameter("callerPage");
		log.debug("doPost >> callerPage = " + callerPage);
		
		try {
			if (bookingId == null || bookingId.length() < 1) {
				dispatch(request, response, callerPage,
						"Select a booking");			
			}else if (userId == null || userId.length() < 1) {
				dispatch(request, response, callerPage,
						"Please Login again.");			
			} else if (statusButton == null || statusButton.length() < 1) {
				dispatch(request, response, callerPage,
						"Select a valid button");			
			} else if (callerPage == null || callerPage.length() < 1) {
				dispatch(request, response, callerPage,
						"Please select a valid option.");
				
			} else if(statusButton.equalsIgnoreCase("cancel")) {

				HttpSession session = request.getSession(false);

				JSONObject signupJson = new JSONObject();
				signupJson.put("bookingStatus", Constants.BOOKING_CANCELLED_MSG);
				signupJson.put("bookingStatusCode", Constants.BOOKING_CANCELLED_CODE);
				signupJson.put("userId", userId.trim());
				signupJson.put("bookingId", bookingId.trim());

				String statusUpdateResponseData = HTTPConnectionManager
						.sendPost("http://" + Constants.CABGURU_SERVER_IP_PORT
								+ "/cabserver/drivers/bookings/status",
								signupJson.toString());
				if (statusUpdateResponseData != null) {

					JSONParser updateParser = new JSONParser();
					JSONObject updateObj = (JSONObject) updateParser
							.parse(statusUpdateResponseData);

					String updateCode = (String) updateObj.get("code");
					String updateMsg = (String) updateObj.get("msg");

					if (updateCode.equalsIgnoreCase("200")) {
						log.debug("doPost >> Booking cancelled by customer.");

						/*********/

						String responseData = HTTPConnectionManager.sendPost(
								"http://" + Constants.CABGURU_SERVER_IP_PORT
										+ "/cabserver/customers/bookings/get",
								signupJson.toString());
						if (responseData != null) {

							JSONParser parser = new JSONParser();
							JSONObject obj = (JSONObject) parser
									.parse(responseData);

							String code = (String) obj.get("code");
							String msg = (String) obj.get("msg");

							if (code.equalsIgnoreCase("200")) {

								String from = (String) obj.get("from");
								String to = (String) obj.get("to");
								String time = (String) obj.get("time");
								String bookingStatus = (String) obj
										.get("bookingStatus");
								String travellerName = (String) obj
										.get("travellerName");

								log.debug("doPost >> from = " + from);
								log.debug("doPost >> to = " + to);
								log.debug("doPost >> time = " + time);
								log.debug("doPost >> bookingStatus = "
										+ bookingStatus);
								log.debug("doPost >> travellerName = "
										+ travellerName);

								request.setAttribute("from", from);
								request.setAttribute("to", to);
								request.setAttribute("time", time);
								request.setAttribute("bookingStatus",
										bookingStatus);
								request.setAttribute("travellerName",
										travellerName);
								request.setAttribute("bookingId", bookingId);						
								
								dispatch(request, response, callerPage,
										msg);

							} else {
								
								dispatch(request, response, callerPage,
										msg);
							}

						} else {
								
							dispatch(request, response, callerPage,
									"BookingsStatus not found.");
						}

						/***********/

					} else {					
						
						dispatch(request, response, callerPage,
								updateMsg);

					}

				} else {
					
					dispatch(request, response, callerPage,
							"No booking data found.");

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
