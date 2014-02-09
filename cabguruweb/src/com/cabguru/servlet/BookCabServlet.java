package com.cabguru.servlet;

import java.io.IOException;
import java.util.HashMap;

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
import com.cabguru.util.MyUtil;

/**
 * Servlet implementation class BookCabServlet
 */
public class BookCabServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	static final Logger log = Logger
			.getLogger(com.cabguru.servlet.BookCabServlet.class.getName());

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookCabServlet() {
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

		String from = request.getParameter("from");
		from = MyUtil.getFormattedAddress(from);
		String to = request.getParameter("to");
		to = MyUtil.getFormattedAddress(to);
		String datetime = request.getParameter("datetime");
		String customername = request.getParameter("customername");
		String phone = request.getParameter("phone");
		String noOfPassengers = request.getParameter("noOfPassengers");
		String mobileOperator = request.getParameter("mobileOperator");
		//log.debug("doPost >> mobileOperator = " + mobileOperator);
		String airline = request.getParameter("airline");
		String flightNumber = request.getParameter("flightNumber");
		String termsandconds = request.getParameter("termsandconds");
		String driverId = request.getParameter("driverElem");
		//log.debug("phone "+phone);
		if(driverId == null)
		{
			driverId = "";
		}
		log.debug("driverId "+driverId);
		
		String callerPage = request.getParameter("callerPage");

		response.setContentType("text/html");

		//PrintWriter out = response.getWriter();

		log.debug("doPost >> from = " + from);
		log.debug("doPost >> to = " + to);
		//log.debug("doPost >> datetime = " + datetime);
		//log.debug("doPost >> customername = " + customername);
		//log.debug("doPost >> phone = " + phone);
		//log.debug("doPost >> callerPage = " + callerPage);
		
		if (phone == null || phone.length() != 10) {
			dispatch(request, response, callerPage,
					"Enter a valid 10 digit mobile number.");			
		}else if (mobileOperator == null || mobileOperator.length() < 1) {
			dispatch(request, response, callerPage,
					"Select a valid mobile operator.");			
		} else if (from == null || from.length() < 5) {
			dispatch(request, response, callerPage,
					"Enter a valid pickup address.");			
		} else if (to == null || to.length() < 5) {
			dispatch(request, response, callerPage,
					"Enter a valid destination address.");			
		} else if (customername == null || customername.length() < 1) {
			dispatch(request, response, callerPage, "Enter a valid name.");			
		} else if (datetime == null || datetime.length() < 1) {
			dispatch(request, response, callerPage,
					"Enter a booking date and time.");			
		}else if(termsandconds == null){
			dispatch(request, response, callerPage,
					"Please accept the terms of services.");			
		} else {

			try {

				HashMap<String, String> dateComponents = MyUtil
						.getDateComonents(datetime);

				JSONObject bookingJson = new JSONObject();
				bookingJson.put("from", from.trim());
				bookingJson.put("to", to.trim());
				bookingJson.put("date", dateComponents.get("date"));
				bookingJson.put("month", dateComponents.get("month"));
				bookingJson.put("year", dateComponents.get("year"));
				bookingJson.put("hour", dateComponents.get("hour"));
				bookingJson.put("min", dateComponents.get("min"));
				bookingJson.put("ampm", dateComponents.get("ampm"));
				bookingJson.put("name", customername.trim());
				bookingJson.put("phone", phone.trim());
				bookingJson.put("noOfPassengers", noOfPassengers != null ? noOfPassengers.trim(): "1");
				bookingJson.put("mobileOperator", mobileOperator.trim());
				bookingJson.put("airline", airline != null ? airline.trim(): "");
				bookingJson.put("flightNumber", flightNumber != null ? flightNumber.trim(): "");

				//log.debug("doPost >> bookingJson = " + bookingJson);

				String bookingResponseData = "";

				if(driverId == null || driverId.equals("")){
					log.debug(" inside no driverId ");
					bookingResponseData = HTTPConnectionManager.sendPost(
							"http://" + Constants.CABGURU_SERVER_IP_PORT
									+ "/cabserver/customers/bookings",
							bookingJson.toString());
				}else{
					bookingJson.put("driverId", driverId);
					bookingResponseData = HTTPConnectionManager.sendPost(
							"http://" + Constants.CABGURU_SERVER_IP_PORT
									+ "/cabserver/admin/bookings/manual",
							bookingJson.toString());
				}
				// String bookingResponseData = "";

				if (bookingResponseData != null) {

					JSONParser bookingParser = new JSONParser();
					JSONObject bookingObj = (JSONObject) bookingParser
							.parse(bookingResponseData);

					String bookingCode = (String) bookingObj.get("code");
					String bookingMsg = (String) bookingObj.get("msg");

					if (bookingCode.equalsIgnoreCase("200")) {
						dispatch(request, response, callerPage, bookingMsg
								+ ". SMS/EMail Notification will be sent with booking details.");
						return;

					} else if (bookingCode.equalsIgnoreCase(Constants.BOOKING_FAILED_CODE)) {
						dispatch(request, response, callerPage, bookingMsg);
						return;
					} else {
						dispatch(request, response, callerPage,
								"Server booking error. Please try again.");
						return;
					}

				} else {
					dispatch(request, response, callerPage,
							"Booking data error. Please try again.");
					return;
				}

			} catch (Exception e1) {

				e1.printStackTrace();
				dispatch(request, response, callerPage,
						"Booking Error. Please try again.");
				return;

			}

		}

	}

	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String callerPage, String msg) {

		try {
			request.setAttribute("bookingMsg", msg);
			RequestDispatcher rd = request.getRequestDispatcher(callerPage);
			rd.forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
