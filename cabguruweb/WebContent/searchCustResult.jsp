
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi--SearchCustomerResult</title>
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
						Logged in as <a href="#" class="navbar-link">
							<%out.print(userName.toUpperCase()); %>
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
						<li class="active"><a href="./searchCust.jsp">Search
								Customer</a></li>
						<li><a href="./addDriver.jsp">Add Driver</a></li>
						<li><a href="./searchDriver.jsp">Search Driver</a></li>
						<li><a href="./currDriversLocation.jsp">Current Drivers
								Location</a></li>
						<li><a href="./pendingBookings.jsp">Pending Bookings</a></li>
						<li><a href="./adminBookingHistory.jsp">Bookings History</a></li>
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
public org.json.simple.JSONArray delCustomerArry = null;
String delCustomerMessage = null;
%>
			<%

String phone = request.getParameter("contactNo");
String name = request.getParameter("name");
String mailId = request.getParameter("emailAddr");
String userId = request.getParameter("usrId");

System.out.println("phone = " + phone);
System.out.println("name = " + name);
System.out.println("mailId = " + mailId);
System.out.println("userId = " + userId);

if(phone == null || phone.length() < 1){
	phone = " ";
}
if(name == null || name.length() < 1){
	name = " ";
}
if(mailId == null || mailId.length() < 1){
	mailId = " ";
}

try {	
	if(userId!=null){
		org.json.simple.JSONObject delCustomerJson = new org.json.simple.JSONObject();
		delCustomerJson.put("userId", userId);
		String delCustomerData = com.cabguru.util.HTTPConnectionManager.sendPost("http://"
				+ com.cabguru.util.Constants.CABGURU_SERVER_IP_PORT
				+ "/cabserver/customers/delete",delCustomerJson.toJSONString());
		org.json.simple.parser.JSONParser deleCustomerParser = new org.json.simple.parser.JSONParser();
		org.json.simple.JSONObject delCustomerMsg = (org.json.simple.JSONObject) deleCustomerParser.parse(delCustomerData);
		delCustomerMessage = (String) delCustomerMsg.get("msg");
	}
	org.json.simple.JSONObject signupJson = new org.json.simple.JSONObject();	
	signupJson.put("phone", phone);
	signupJson.put("name", name);
	signupJson.put("mailId", mailId);

	String responseData = com.cabguru.util.HTTPConnectionManager.sendPost("http://"
			+ com.cabguru.util.Constants.CABGURU_SERVER_IP_PORT
			+ "/cabserver/admin/customers/list",signupJson.toJSONString());
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
							
							if (delCustomerMessage != null) {

								out.println("<div class=\"alert alert-error\">"
										+ "<button class=\"close\" data-dismiss=\"alert\" "
										+ "type=\"button\">×</button>" + "<strong>"
										+ delCustomerMessage + "</strong>" + "</div>");
								delCustomerMessage = null;

							}
							else if (bookingMessage != null) {

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
									<th>UserId</th>
									<th>First Name</th>
									<th>Last Name</th>
									<th>Mobile Number</th>
									<th>Gender</th>
									<th>Mail-Id</th>
									<th>Address</th>
									<th></th>
								</tr>
							</thead>
							<tbody>

								<%
              					for(int i =0; i < bookingsArry.size(); i++){ 
              		
              					org.json.simple.JSONObject obj = (org.json.simple.JSONObject)bookingsArry.get(i);
              					
              					if(((String) obj.get("userId")) != null){
              	
              					%>

								<form class="form-horizontal"
									name="customerListForm<% out.print((String) obj.get("driverId"));%>"
									id="customerListForm<% out.print((String) obj.get("userId"));%>"
									accept-charset="UTF-8" role="form" method="POST"
									action="/cabguruweb/updateCust.jsp">

									<tr>

										<td>
											<% out.print((String) obj.get("userId"));%>
										</td>
										<td>
											<% out.print((String) obj.get("firstName"));%>
										</td>
										<td>
											<% out.print((String) obj.get("lastName"));%>
										</td>
										<td>
											<% out.print((String) obj.get("phone"));%>
										</td>
										<td>
											<% out.print((String) obj.get("sex"));%>
										</td>
										<td>
											<% out.print((String) obj.get("mailId"));%>
										</td>
										<td>
											<% out.print((String) obj.get("address"));%>
										</td>


										<td><button class="btn btn-success updateButton"
												type="submit" name="oprType" value="update">Update</button></td>
										<td><button class="btn btn-success deleteButton"
												onclick="confirmCustomerDelete(<% out.print((String) obj.get("userId"));%>);">
												Delete</button></td>
										<input type="hidden" name="userId"
											value="<% out.print((String) obj.get("userId"));%>" />
										<input type="hidden" name="firstName"
											value="<% out.print((String) obj.get("firstName"));%>" />
										<input type="hidden" name="lastName"
											value="<% out.print((String) obj.get("lastName"));%>" />
										<input type="hidden" name="phone"
											value="<% out.print((String) obj.get("phone"));%>" />
										<input type="hidden" name="mobileOperator"
											value="<% out.print((String) obj.get("mobileOperator"));%>" />
										<input type="hidden" name="sex"
											value="<% out.print((String) obj.get("sex"));%>" />
										<input type="hidden" name="mailId"
											value="<% out.print((String) obj.get("mailId"));%>" />
										<input type="hidden" name="address"
											value="<% out.print((String) obj.get("address"));%>" />

										<!-- for search result retaining -->
										<input type="hidden" name="name" value="<%= name %>" />
										<input type="hidden" name="emailAddr" value="<%= mailId %>" />
										<input type="hidden" name="contactNo" value="<%= phone %>" />
										<!-- end for search result retaining -->

										<input type="hidden" id="callerPage" name="callerPage"
											value="searchCustResult.jsp" />
									</tr>
								</form>

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
	<script src="./js/util.js"></script>



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

	<script>
		$( ".deleteButton" ).mouseover(function() {
			$( ".form-horizontal" ).on( "submit", false );
		});
		$( ".updateButton" ).mouseover(function() {
			$( ".form-horizontal" ).off( "submit", false );
		});
		
</script>
</body>
</html>
