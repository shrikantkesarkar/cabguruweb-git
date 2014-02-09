package com.cabguru.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetInTouchServlet
 */
public class GetInTouchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetInTouchServlet() {
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
		
		String firstName = request.getParameter("name");
		String mailId = request.getParameter("mailid");
		String phone = request.getParameter("phone");
		String message = request.getParameter("message");
		
		String callerPage = request.getParameter("callerPage");
		
		
		if (phone == null || phone.length() != 10) {			
			dispatch(request, response, callerPage, "Please enter 10 Digit Mobile Number.");
		} else if (firstName == null || firstName.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter your Name.");
		} else if (mailId == null || mailId.length() < 1) {			
			dispatch(request, response, callerPage, "Please enter your E-Mail Id.");
		} else if (message == null || message.length() < 10) {			
			dispatch(request, response, callerPage, "Please enter message of at-least 10 chars.");
		} else{
			dispatch(request, response, callerPage, "Thanks for your feedback. We will get back to you.");
		}
				
		
		
		
		
	}
	
	
	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String callerPage, String msg){		
		
		try {
			request.setAttribute("gitsMsg", msg);
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
