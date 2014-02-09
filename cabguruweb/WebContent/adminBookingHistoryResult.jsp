
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi--BookingsHistoryResult</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Le styles -->
<link href="./css/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

@media ( max-width : 980px) {
	/* Enable use of floated navbar text */
	.navbar-text.pull-right {
		float: none;
		padding-left: 5px;
		padding-right: 5px;
	}
}
</style>
<link href="./css/bootstrap-responsive.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="../assets/js/html5shiv.js"></script>
    <![endif]-->

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="./ico/taxi_car.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="./ico/taxi_car.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="./ico/taxi_car.png">
<link rel="apple-touch-icon-precomposed" href="./ico/taxi_car.png">
<link rel="shortcut icon" href="./ico/taxi_car.png">

<link href="./css/bootstrap-datetimepicker.min.css" rel="stylesheet"
	media="screen">


</head>

<body>

	<%!
public String userName = "Guest";
%>

	<%
  userName = (String)session.getAttribute("userName");  
%>

	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<button type="button" class="btn btn-navbar" data-toggle="collapse"
					data-target=".nav-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="brand" href="./index.jsp"><img
					class="img-circle img-responsive text-center"
					src="./ico/taxi_car-small.png"></a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">
						Logged in as <a href="#" class="navbar-link"> <%out.print(userName.toUpperCase()); %>
						</a>
					</p>

				</div>
				<!--/.nav-collapse -->
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row-fluid">
			<div class="span3">
				<div class="well sidebar-nav">
					<ul class="nav nav-list">
						<li class="nav-header">Menu</li>
						<li><a href="./adminMain.jsp">Book Taxi</a></li>
						<li><a href="./addCust.jsp">Add Customer</a></li>
						<li><a href="./searchCust.jsp">Search Customer</a></li>
						<li><a href="./addDriver.jsp">Add Driver</a></li>
						<li><a href="./searchDriver.jsp">Search Driver</a></li>
						<li><a href="./currDriversLocation.jsp">Current Drivers
								Location</a></li>
						<li><a href="./pendingBookings.jsp">Pending Bookings</a></li>
						<li class="active"><a href="./adminBookingHistory.jsp">Bookings
								History</a></li>
						<li><a href="/cabguruweb/logout">Log Out</a></li>

						<!-- <li class="nav-header">Sidebar</li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li class="nav-header">Sidebar</li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li>
              <li><a href="#">Link</a></li> -->


					</ul>
				</div>
				<!--/.well -->
			</div>
			<!--/span-->

			<%!
public org.json.simple.JSONArray bookingsArry = null;
%>
			<%

try {	

	String responseData = (String)request.getAttribute("responseData");
	if (responseData != null) {

		org.json.simple.parser.JSONParser parser = new org.json.simple.parser.JSONParser();
		bookingsArry = (org.json.simple.JSONArray) parser.parse(responseData);		
	}
	
}catch(Exception e ){
	e.printStackTrace();
}



%>


			<div class="span9">

				<div class="row">
					<div class="span12">



						<%
								org.json.simple.JSONObject objMsg = (org.json.simple.JSONObject) bookingsArry
										.get(0);
								String bookingMessage = (String) objMsg.get("msg");
								if (bookingMessage != null && bookingMessage.length() > 1) {

									out.println("<div class=\"alert alert-error\">"
											+ "<button class=\"close\" data-dismiss=\"alert\" "
											+ "type=\"button\">×</button>" + "<strong>"
											+ bookingMessage + "</strong>" + "</div>");

								} else {

								}
							%>


						<table class="table table-striped table-condensed">
							<thead>
								<tr>
									<th>BookingId</th>
									<th>Name</th>
									<th>MobileNumber</th>
									<th>BookingDate(yyyy-mm-dd hh:mm:ss)</th>
									<th>From</th>
									<th>To</th>
									<th>BookingStatus</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<%
  					for(int i =0; i < bookingsArry.size(); i++){ 
  		
  					org.json.simple.JSONObject obj = (org.json.simple.JSONObject)bookingsArry.get(i);
  					
  					if(((String) obj.get("bookingId")) != null){
  	
  					%>
								<tr>

									<td>
										<% out.print((String) obj.get("bookingId"));%>
									</td>
									<td>
										<% out.print((String) obj.get("name"));%>
									</td>
									<td>
										<% out.print((String) obj.get("phone"));%>
									</td>
									<td>
										<% out.print((String) obj.get("datetime"));%>
									</td>
									<td>
										<% out.print((String) obj.get("from"));%>
									</td>
									<td>
										<% out.print((String) obj.get("to"));%>
									</td>
									<td>
										<% out.print((String) obj.get("bookingStatus"));%>
									</td>

									<%
											String bookingStatusCode = ((String) obj.get("bookingStatusCode"));
											boolean isBefore = ((Boolean) obj.get("isBefore"));
											
											if(bookingStatusCode != null && bookingStatusCode.equalsIgnoreCase("202")
													&& !isBefore){												
										%>

									<form class="form-horizontal" accept-charset="UTF-8"
										role="form" method="POST" action="/cabguruweb/mbcs">
										<td><button class="btn btn-success" type="submit"
												name="oprType" value="deleteDriver">DeleteDriver</button></td> <input
											type="hidden" name="bookingId"
											value="<% out.print((String) obj.get("bookingId"));%>" /> <input
											type="hidden" name="userId"
											value="<% out.print((String) obj.get("userId"));%>" /> <input
											type="hidden" name="bookingStatus" value="Booking Failed" />
										<input type="hidden" name="bookingStatusCode" value="404" />
										<input type="hidden" name="driverId"
											value="<% out.print((String) obj.get("driverId"));%>" /> <input
											type="hidden" id="callerPage" name="callerPage"
											value="adminBookingHistoryResult.jsp" />

									</form>

									<%
											}
										%>

									<%
											if(bookingStatusCode != null && (bookingStatusCode.equalsIgnoreCase("201")
													|| bookingStatusCode.equalsIgnoreCase("202")
													|| bookingStatusCode.equalsIgnoreCase("404")
													|| bookingStatusCode.equalsIgnoreCase("405")
													|| bookingStatusCode.equalsIgnoreCase("406"))
													&& !isBefore){
										%>

									<form class="form-horizontal" accept-charset="UTF-8"
										role="form" method="POST" action="/cabguruweb/mbcs">

										<td><button class="btn btn-success" type="submit"
												name="oprType" value="cancelBooking">CancelBooking</button></td>
										<input type="hidden" name="bookingId"
											value="<% out.print((String) obj.get("bookingId"));%>" /> <input
											type="hidden" name="userId"
											value="<% out.print((String) obj.get("userId"));%>" /> <input
											type="hidden" name="bookingStatus" value="BOOKING CANCELLED" />
										<input type="hidden" name="bookingStatusCode" value="205" />
										<input type="hidden" name="driverId"
											value="<% out.print((String) obj.get("driverId"));%>" /> <input
											type="hidden" id="callerPage" name="callerPage"
											value="adminBookingHistoryResult.jsp" />

									</form>

									<%
											}
										%>

								</tr>


								<%
									}
              					}
				                %>



							</tbody>
						</table>


					</div>
				</div>




				<div class="row-fluid">
					<div class="span4">
						<h2></h2>
						<p></p>

					</div>
					<!--/span-->
					<div class="span4">
						<h2></h2>
						<p></p>

					</div>
					<!--/span-->
					<div class="span4">
						<h2></h2>
						<p></p>

					</div>
					<!--/span-->
				</div>
				<!--/row-->

			</div>
			<!--/span-->
		</div>
		<!--/row-->

		<hr>

		<footer>
			<p>Copyright &copy; NousOnWork 2013</p>
		</footer>

	</div>
	<!--/.fluid-container-->

	<!-- Le javascript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="./js/jquery.js"></script>
	<script src="./js/bootstrap-transition.js"></script>
	<script src="./js/bootstrap-alert.js"></script>
	<script src="./js/bootstrap-modal.js"></script>
	<script src="./js/bootstrap-dropdown.js"></script>
	<script src="./js/bootstrap-scrollspy.js"></script>
	<script src="./js/bootstrap-tab.js"></script>
	<script src="./js/bootstrap-tooltip.js"></script>
	<script src="./js/bootstrap-popover.js"></script>
	<script src="./js/bootstrap-button.js"></script>
	<script src="./js/bootstrap-collapse.js"></script>
	<script src="./js/bootstrap-carousel.js"></script>
	<script src="./js/bootstrap-typeahead.js"></script>



	<script type="text/javascript" src="./js/jquery-1.8.3.min.js"
		charset="UTF-8"></script>
	<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/bootstrap-datetimepicker.js"
		charset="UTF-8"></script>
	<script type="text/javascript"
		src="./js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>
	<script type="text/javascript">
	    $('.form_datetime').datetimepicker({
	        //language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
	        showMeridian: 1
	    });
		$('.form_date').datetimepicker({
	        language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
		$('.form_time').datetimepicker({
	        language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 1,
			minView: 0,
			maxView: 1,
			forceParse: 0
	    });
</script>


</body>
</html>
