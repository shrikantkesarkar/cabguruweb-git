
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi-AddCustomer</title>
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
    		org.json.simple.JSONObject profileMsg = null;
%>

	<%
  userName = (String)session.getAttribute("userName"); 
String userId = (String)session.getAttribute("userId") ;

try {	
	if(userId!=null){
		org.json.simple.JSONObject profileJson = new org.json.simple.JSONObject();
		profileJson.put("userId", userId);
		String profileData = com.cabguru.util.HTTPConnectionManager.sendPost("http://"
				+ com.cabguru.util.Constants.CABGURU_SERVER_IP_PORT
				+ "/cabserver/customers/get",profileJson.toJSONString());
		org.json.simple.parser.JSONParser profileParser = new org.json.simple.parser.JSONParser();
		profileMsg = (org.json.simple.JSONObject) profileParser.parse(profileData);
		System.out.println("profileMsg "+profileMsg);
	}
}catch(Exception e ){
	e.printStackTrace();
}
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
						<li><a href="./custMain.jsp">Book Taxi</a></li>
						<li><a href="./custBookingHistory.jsp">My Bookings</a></li>
						<li class="active"><a href="./myProfile.jsp">My Profile</a></li>
						<li><a href="/cabguruweb/logout">Log Out</a></li>




					</ul>
				</div>
				<!--/.well -->
			</div>
			<!--/span-->


			<div class="span9">
				<div class="">
					<legend>Update Details</legend>

					</br>

					<%
														String signupMsg = (String) request.getAttribute("signupMsg");
														if (signupMsg != null) {
							
															out.println("<div class=\"alert alert-error\">"
																	+ "<button class=\"close\" data-dismiss=\"alert\" "
																	+ "type=\"button\">×</button>" + "<strong>" + signupMsg
																	+ "</strong>" + "</div>");
							
														} else {
							
														}
													%>

					<div class="area">
						<form class="form-horizontal" accept-charset="UTF-8" role="form"
							method="POST" action="/cabguruweb/sus">
							<div class="heading">
								<h4 class="form-heading"></h4>
							</div>

							<input type="hidden" id="callerPage" name="callerPage"
								value="myProfile.jsp" /> <input type="hidden"
								id="termsandconds" name="termsandconds" value="on" /> <input
								type="hidden" id="userId" name="userId"
								value="<%= (String) profileMsg.get("userId") %>" />


							<div class="control-group">
								<label class="control-label" for="inputUser">Mobile
									Number</label>

								<div class="controls">
									<input id="inputUser" type="text" readonly="readonly"
										name="phone" value="<%= (String) profileMsg.get("phone") %>">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputUser">Mobile
									Operator</label>

								<div class="controls">

									<select id="mobileOperator" name="mobileOperator"
										class="input-medium">
										<option>Sprint</option>
										<option>ATnT</option>
										<option>Verizon</option>
										<option>TMobile</option>
										<option>VirginMobile</option>
										<option>BoostMobile</option>
									</select>


								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputFirst">First Name</label>

								<div class="controls">
									<input id="inputFirst" type="text" name="firstName"
										value="<%= (String) profileMsg.get("firstName") %>">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputLast">Last Name</label>

								<div class="controls">
									<input id="inputLast" type="text" name="lastName"
										value="<%= (String) profileMsg.get("lastName") %>">
								</div>
							</div>

							<%
													if( ((String) profileMsg.get("sex")!=null) && ((String) profileMsg.get("sex")).equalsIgnoreCase("Male")){
													
													%>

							<div class="control-group">
								<label class="control-label" for="selectbasic">Gender</label>
								<div class="controls">
									<select id="selectbasic" name="sex" class="input-medium">
										<option>Male</option>
										<option>Female</option>
									</select>
								</div>
							</div>

							<%
													}else{
													
													%>
							<div class="control-group">
								<label class="control-label" for="selectbasic">Gender</label>
								<div class="controls">
									<select id="selectbasic" name="sex" class="input-medium">
										<option>Female</option>
										<option>Male</option>
									</select>
								</div>
							</div>

							<%
														}
													%>




							<div class="control-group">
								<label class="control-label" for="inputEmail">Email</label>

								<div class="controls">
									<input id="inputEmail" type="text" name="mailId"
										value="<%= (String) profileMsg.get("mailId") %>">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="textarea">Address</label>
								<div class="controls">
									<textarea id="textarea" name="address" value=""><%= (String) profileMsg.get("address") %>															
															</textarea>
								</div>
							</div>



							<div class="control-group">
								<label class="control-label" for="inputPassword">Password</label>

								<div class="controls">
									<input id="inputPassword" placeholder="Min. 5 Characters"
										type="password" name="password">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputPassword">Confirm
									Password</label>

								<div class="controls">
									<input id="inputPassword" placeholder="Min. 5 Characters"
										type="password" name="confirmPassword">
								</div>
							</div>


							<div class="control-group">
								<div class="controls">
									<button class="btn btn-success" type="submit">Update</button>
								</div>
							</div>





						</form>
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
	<script>
		$( document ).ready(function() {
			$('#mobileOperator').val("<%=(String) profileMsg.get("mobileOperator")%>");
		});
	</script>

</body>
</html>
