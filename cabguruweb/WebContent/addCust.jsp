
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi-AddCustomer</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">





<meta charset="utf-8">
<style>
html,body,#map-canvas {
	height: 100%;
	margin: 0px;
	padding: 0px
}
</style>
<link type="text/css" rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500">
<script
	src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places"></script>
<script>
// This example displays an address form, using the autocompletefrom feature
// of the Google Places API to help users fill in the information.

var placeSearch, autocompleteto, autocompletefrom;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};

function initializefrom() {
  // Create the autocompletefrom object, restricting the search
  // to geographical location types.
  autocompletefrom = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('autocompletefrom')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompletefrom, 'place_changed', function() {
    fillInAddress();
  });
}

function initializeto() {
  // Create the autocompleteto object, restricting the search
  // to geographical location types.
  autocompleteto = new google.maps.places.Autocomplete(
      /** @type {HTMLInputElement} */(document.getElementById('autocompleteto')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompleteto, 'place_changed', function() {
    fillInAddress();
  });
}

function initFunction(){
	initializeto();
    initializefrom();

}

// [START region_geolocation]
// Bias the autocompletefrom object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocatefrom() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocompletefrom.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}

function geolocateto() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      autocompleteto.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    });
  }
}
// [END region_geolocation]

    </script>

<style>
#locationFieldFrom,#controls1 {
	position: relative;
	width: 209px;
}

#locationFieldTo,#controls2 {
	position: relative;
	width: 500px;
}

#autocompletefrom {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 99%;
}

.label {
	text-align: right;
	font-weight: bold;
	width: 10px;
	color: #303030;
}

#address {
	border: 1px solid #000090;
	background-color: #f0f0ff;
	width: 40px;
	padding-right: 2px;
}

#address td {
	font-size: 10pt;
}

.field {
	width: 99%;
}

.slimField {
	width: 80px;
}

.wideField {
	width: 20px;
}

#locationFieldFrom {
	height: 20px;
	margin-bottom: 2px;
}

#locationFieldTo {
	height: 20px;
	margin-bottom: 2px;
}
</style>











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

<body onload="initFunction()">

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
						<li class="active"><a href="./addCust.jsp">Add Customer</a></li>
						<li><a href="./searchCust.jsp">Search Customer</a></li>
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


			<div class="span9">
				<div class="">
					<legend>Add New Customer</legend>

					</br>


					<%
								String signupMsg = (String) request.getAttribute("signupMsg");
								if (signupMsg != null && signupMsg.length() > 1) {

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
								value="addCust.jsp" /> <input type="hidden" id="termsandconds"
								name="termsandconds" value="on" />
							<!-- <div class="control-group">
							                            <label class="control-label" for=
							                            "inputCompanyName">Company Name</label>

							                            <div class="controls">
							                                <input id="inputCompanyName" placeholder=
							                                "E.g. Some Software Pvt. Ltd." type="text">
							                            </div>
							                        </div> -->

							<div class="control-group">
								<label class="control-label" for="inputUser">Mobile
									Number</label>

								<div class="controls">
									<input id="inputUser" placeholder="" type="text" name="phone">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputUser">Mobile
									Operator</label>

								<div class="controls">

									<select id="selectbasic" name="mobileOperator"
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
									<input id="inputFirst" placeholder="" type="text"
										name="firstName">
								</div>
							</div>

							<div class="control-group">
								<label class="control-label" for="inputLast">Last Name</label>

								<div class="controls">
									<input id="inputLast" placeholder="" type="text"
										name="lastName">
								</div>
							</div>


							<div class="control-group">
								<label class="control-label" for="selectbasic">Gender</label>
								<div class="controls">
									<select id="selectbasic" name="sex" class="input-medium">
										<option>Female</option>
										<option>Male</option>
									</select>
								</div>
							</div>





							<div class="control-group">
								<label class="control-label" for="inputEmail">Email</label>

								<div class="controls">
									<input id="inputEmail" placeholder="" type="text" name="mailId">
								</div>
							</div>

							<!-- <div class="control-group">
								<label class="control-label" for="textarea">Address</label>
								<div class="controls">
									<textarea id="textarea"
										placeholder="7300 Gallagher Drive, Minneapolis, MN 55435, USA"
										name="address"></textarea>
								</div>
							</div> -->

							<div class="control-group">
								<label class="control-label" for="textarea">Address</label>
								<div class="controls" id="locationFieldFrom">
									<input class="form-control" id="autocompletefrom"
										onFocus="geolocatefrom()" placeholder="Address" name="address"
										type="text">
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
									<button class="btn btn-success" type="submit">Add</button>
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
