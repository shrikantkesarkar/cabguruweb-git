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
import com.cabguru.util.MyUtil;

/**
 * Servlet implementation class AdminBookingHistoryServlet
 */
public class AdminBookingHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger log = Logger.getLogger(
			com.cabguru.servlet.AdminBookingHistoryServlet.class.getName());
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminBookingHistoryServlet() {
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
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fromdate = request.getParameter("fromdate");
		String todate = request.getParameter("todate");		
		String bookingId = request.getParameter("bookingId");		
		//String callerPage = "adminBookingHistoryResult.jsp";
		String callerPage = request.getParameter("callerPage");
		
		HttpSession session = request.getSession(false);
		
		if(fromdate!= null && fromdate.length() > 1){			
			session.setAttribute("fromdate", fromdate);
		}else{
			
			fromdate = (String) session.getAttribute("fromdate");
		}
		if(todate!= null && todate.length() > 1){
			session.setAttribute("todate", todate);
		}else{
			
			todate = (String) session.getAttribute("todate");
		}
		
		//log.debug("doPost >> fromdate = " + fromdate);
		//log.debug("doPost >> todate = " + todate);		
		//log.debug("doPost >> bookingId = " + bookingId);
		
		JSONObject signupJson = new JSONObject();
		
		if (fromdate != null && fromdate.length() > 1
				&& todate != null && todate.length() > 1) {			
			//dispatch(request, response, callerPage, "Please enter from / to date.");
			
			String frpmTmpArry [] = fromdate.split(" ");
			String toTmpArry [] = todate.split(" ");
			
			signupJson.put("fromDate", frpmTmpArry[0]);
			signupJson.put("fromMonth", MyUtil.getMonth(frpmTmpArry[1])+"");
			signupJson.put("fromYear", frpmTmpArry[2]);
			signupJson.put("toDate", toTmpArry[0]);
			signupJson.put("toMonth", MyUtil.getMonth(toTmpArry[1])+"");
			signupJson.put("toYear", toTmpArry[2]);
			
			signupJson.put("bookingId", "");
			
			searchBookings(request, response, signupJson);
			
		} /*else if (todate == null || todate.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter to date.");
		}*/ else if (bookingId != null && bookingId.length() > 1) {
			
			signupJson.put("fromDate", "");
			signupJson.put("fromMonth", "");
			signupJson.put("fromYear", "");
			signupJson.put("toDate", "");
			signupJson.put("toMonth", "");
			signupJson.put("toYear", "");
			
			signupJson.put("bookingId", bookingId.trim());
			
			searchBookings(request, response, signupJson);
			
			
		}else{			
					
			dispatch(request, response, callerPage, "Please enter from / to or BookingId to search.");
		}
		
		
		
		
	}
	
	private void searchBookings(HttpServletRequest request,
			HttpServletResponse response,JSONObject signupJson){
		
		try {

			String responseData = HTTPConnectionManager.sendPost(
					"http://" + Constants.CABGURU_SERVER_IP_PORT
							+ "/cabserver/admin/bookings/list",
					signupJson.toString());
			
			//log.debug("doPost >> responseData="+ responseData);
			if (responseData != null) {					
				request.setAttribute("responseData", responseData);					
				dispatch(request, response, "adminBookingHistoryResult.jsp", 
						"Bookings found for the specified date range.");
			}else{
				request.setAttribute("responseData", responseData);					
				dispatch(request, response, "adminBookingHistory.jsp", 
						"Bookings Not found for the specified date range.");
			}
		}catch(Exception e){
			e.printStackTrace();
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
