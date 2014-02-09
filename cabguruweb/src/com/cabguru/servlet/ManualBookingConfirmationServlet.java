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
import org.json.simple.parser.ParseException;

import com.cabguru.util.Constants;
import com.cabguru.util.HTTPConnectionManager;

/**
 * Servlet implementation class ManualBookingConfirmationServlet
 */
public class ManualBookingConfirmationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.ManualBookingConfirmationServlet.class
					.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ManualBookingConfirmationServlet() {
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
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String bookingId = request.getParameter("bookingId");
		String userId = request.getParameter("userId");
		String bookingStatus = request.getParameter("bookingStatus");
		String bookingStatusCode = request.getParameter("bookingStatusCode");
		String driverId = request.getParameter("driverElem");
		String oprType = request.getParameter("oprType");

		/*for update booking*/
		String noOfPassengers = request.getParameter("noOfPassengers");
		String mobileOperator = request.getParameter("mobileOperator");
		String airline = request.getParameter("airline");
		String flightNumber = request.getParameter("flightNumber");
		/*for update booking*/
		
		String callerPage = request.getParameter("callerPage");

		log.debug("doPost >> bookingId = " + bookingId);
		// log.debug("doPost >> userId = " + userId);
		// log.debug("doPost >> bookingStatus = " + bookingStatus);
		// log.debug("doPost >> bookingStatusCode = " + bookingStatusCode);
		// log.debug("doPost >> callerPage = " + callerPage);
		log.debug("doPost >> driverId = " + driverId);
		log.debug("doPost >> oprType = " + oprType);

		try {

			JSONObject signupJson = new JSONObject();
			signupJson.put("bookingId", bookingId);
			signupJson.put("userId", userId);
			signupJson.put("bookingStatus", bookingStatus);
			signupJson.put("bookingStatusCode", bookingStatusCode);
			signupJson.put("driverId", driverId);
			String responseData = "";
			if (oprType.equalsIgnoreCase("assignDriver")) {

				if (driverId != null && driverId.length() > 0) {
					responseData = HTTPConnectionManager.sendPost("http://"
							+ Constants.CABGURU_SERVER_IP_PORT
							+ "/cabserver/admin/bookings/assign-driver",
							signupJson.toString());
					if (responseData != null) {

						JSONParser parser = new JSONParser();
						JSONObject obj = (JSONObject) parser
								.parse(responseData);

						String code = (String) obj.get("code");
						String msg = (String) obj.get("msg");

						// log.debug("doPost >> code"+code);

						if (code.equalsIgnoreCase("200")) {

							dispatch(request, response, callerPage,
									"Manual Booking Updated.");
						} else {
							dispatch(request, response, callerPage, msg);
						}
					}
				} else {
					dispatch(request, response, callerPage,
							"Please select a DriverId.");
				}

			} else if (oprType.equalsIgnoreCase("deleteDriver")
					|| oprType.equalsIgnoreCase("cancelBooking")) {

				responseData = HTTPConnectionManager
						.sendPost(
								"http://"
										+ Constants.CABGURU_SERVER_IP_PORT
										+ "/cabserver/admin/bookings/delete-driver-cancel-booking",
								signupJson.toString());

				log.debug("doPost >> responseData=" + responseData);
				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");

					// log.debug("doPost >> code"+code);

					if (code.equalsIgnoreCase("200")) {

						dispatch(request, response, "/abhs",
								"Manual Booking Updated.");
						// dispatch(request, response, callerPage,
						// "Manual Booking Updated.");
					} else {
						dispatch(request, response, callerPage, msg);
					}
				}
			} else if (oprType.equalsIgnoreCase("updateBookingPageForward")) {
				dispatch(request, response, "/updateBooking.jsp",
						"");

			} else if (oprType.equalsIgnoreCase("updateBooking")) {

				String name = request.getParameter("name");
				String from = request.getParameter("from");
				String to = request.getParameter("to");

				log.debug("doPost >> name = " + name);
				log.debug("doPost >> from = " + from);
				log.debug("doPost >> to = " + to);

				signupJson.put("userId", userId);
				signupJson.put("bookingId", bookingId);
				signupJson.put("bookingStatus", bookingStatus);
				signupJson.put("bookingStatusCode", bookingStatusCode);
				signupJson.put("driverId", driverId);
				signupJson.put("name", name);
				signupJson.put("from", from);
				signupJson.put("to", to);
				signupJson.put("noOfPassengers", noOfPassengers != null ? noOfPassengers.trim(): "1");
				signupJson.put("mobileOperator", mobileOperator.trim());
				signupJson.put("airline", airline != null ? airline.trim(): "");
				signupJson.put("flightNumber", flightNumber != null ? flightNumber.trim(): "");

				responseData = HTTPConnectionManager.sendPost("http://"
						+ Constants.CABGURU_SERVER_IP_PORT
						+ "/cabserver/admin/bookings/update-booking-data",
						signupJson.toString());

				log.debug("doPost >> responseData=" + responseData);
				if (responseData != null) {

					JSONParser parser = new JSONParser();
					JSONObject obj = (JSONObject) parser.parse(responseData);

					String code = (String) obj.get("code");
					String msg = (String) obj.get("msg");

					log.debug("doPost >> code" + code);

					if (code.equalsIgnoreCase("200")) {

						dispatch(request, response, "/pendingBookings.jsp",
								"Booking Data Updated.");

					} else {
						dispatch(request, response, callerPage, msg);
					}
				}

			}

		} catch (ParseException e) {
			e.printStackTrace();
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
