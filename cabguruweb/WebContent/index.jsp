
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi-Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="X-UA-Compatible" content="IE=8">

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
      /** @type {HTMLInputElement} */(document.getElementById('locationFieldFromText')),
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
      /** @type {HTMLInputElement} */(document.getElementById('locationFieldToText')),
      { types: ['geocode'] });
  // When the user selects an address from the dropdown,
  // populate the address fields in the form.
  google.maps.event.addListener(autocompleteto, 'place_changed', function() {
    fillInAddress();
  });
}


function enable_from_option()
{
  document.bookForm.locationFieldFrom.hidden = true;
  document.bookForm.fromOption.hidden = false;
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

#locationFieldFromText {
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
	padding-top: 20px;
	padding-bottom: 60px;
}

/* Custom container */
.container {
	margin: 0 auto;
	max-width: 1000px;
}

.container>hr {
	margin: 60px 0;
}

/* Main marketing message and sign up button */
.jumbotron {
	margin: 80px 0;
	text-align: center;
}

.jumbotron h1 {
	font-size: 100px;
	line-height: 1;
}

.jumbotron .lead {
	font-size: 24px;
	line-height: 1.25;
}

.jumbotron .btn {
	font-size: 21px;
	padding: 14px 24px;
}

/* Supporting marketing content */
.marketing {
	margin: 60px 0;
}

.marketing p+h4 {
	margin-top: 28px;
}

/* Customize the navbar links to be fill the entire space of the .navbar */
.navbar .navbar-inner {
	padding: 0;
}

.navbar .nav {
	margin: 0;
	display: table;
	width: 100%;
}

.navbar .nav li {
	display: table-cell;
	width: 1%;
	float: none;
}

.navbar .nav li a {
	font-weight: bold;
	text-align: center;
	border-left: 1px solid rgba(255, 255, 255, .75);
	border-right: 1px solid rgba(0, 0, 0, .1);
}

.navbar .nav li:first-child a {
	border-left: 0;
	border-radius: 3px 0 0 3px;
}

.navbar .nav li:last-child a {
	border-right: 0;
	border-radius: 0 3px 3px 0;
}

.addrtoggle {
	display: inline;
	margin: 10px;
	font-weight: bold;
}

.w100 {
	width: 100%;
}
</style>
<link href="./css/bootstrap-responsive.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="./js/html5shiv.js"></script>
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


	<div class="container">

		<div class="masthead">
			<h3 class="muted">
				<img class="w100 img-responsive text-center"
					src="./ico/taxi_car.png">
			</h3>
			<h2>(952)927-0000 / (612)250-7716 / (952)995-0110</h2>
			<div class="navbar">
				<div class="navbar-inner">
					<div class="container">
						<ul class="nav">
							<li class="active"><a href="./index.jsp">Home</a></li>
							<li><a href="./services.jsp">Services</a></li>
							<li><a href="./fare.jsp">FareInformation</a></li>
							<li><a href="./offers.jsp">Offers</a></li>
							<li><a href="./contactUs.jsp">ContactUs</a></li>
							<li><a href="./aboutUs.jsp">AboutUs</a></li>


							<%
String authid = (String)session.getAttribute("authid");
String authkey = (String)session.getAttribute("authkey");

userName = (String)session.getAttribute("userName");



if((authid != null
   		&& authid.equalsIgnoreCase("admin") 
   		&& authkey != null
   		&& authkey.equals("987654321secure!@#$%"))
   		){
%>

							<li><a href="/cabguruweb/logout">LogOut</a></li>
							<li><a href="/cabguruweb/adminMain.jsp">MyAccount</a></li>

							<%	
}else if(authid != null 
	    && authid.equalsIgnoreCase("user") 
	    && authkey != null 
	    && authkey.equals("usersecret")
	    && userName != null 
	    && userName.length() > 1){
%>
							<li><a href="/cabguruweb/logout">LogOut</a></li>
							<li><a href="/cabguruweb/custMain.jsp">MyAccount</a></li>

							<%
} else{
	 userName = "Guest";
%>

							<li><a href="./signup.jsp">SignUp</a></li>

							<%	
}
%>


							<!-- <li><a href="./custMain.jsp">CustomerSection</a></li>
							<li><a href="./adminMain.jsp">AdminSection</a></li> -->
						</ul>
					</div>
				</div>
			</div>
			<!-- /.navbar -->
		</div>
		</br>

		<h4>Airport Taxi Minneapolis, at our full-service transportation
			company, we provide a number of different services. With 24/7
			dispatch and advanced reservations any time of the day or night, a
			taxi from our huge fleet can take you where you need to go.</h4>

		</br> </br>

		<div class="row">


			<div class="row-fluid">
				<div class="span12">






					<form accept-charset="UTF-8" role="form" name="bookForm"
						method="POST" action="/cabguruweb/bcs">



						<div class="span8">
							<!-- Nav tabs category -->
							<div class="heading">
								<h4 class="form-heading">Book as Guest</h4>
							</div>

							<%
										String bookingMessage = (String) request.getAttribute("bookingMsg");
										if (bookingMessage != null) {

											out.println("<div class=\"alert alert-error\">"
													+ "<button class=\"close\" data-dismiss=\"alert\" "
													+ "type=\"button\">×</button>" + "<strong>"
													+ bookingMessage + "</strong>" + "</div>");

										} else {

										}
							%>

							<!-- Tab panes -->
							<div class="tab-content faq-cat-content">
								<div class="tab-pane active in fade" id="faq-cat-1">
									<fieldset>

										<input type="hidden" id="callerPage" name="callerPage"
											value="index.jsp" />

										<div class="control-group">
											<!-- <input type="checkbox" name="checkboxes" id="checkboxes-0"
													value="1" onclick="disableFromBox()"><label class="control-label" for="checkboxes">Book
												from Favourites</label>	-->
											<input type="radio" checked="checked" name="addrradioFrom"
												id="addrUserTypedFrom" onclick="disableFromBox();">
											<label class="addrtoggle" for="addrUserTypedFrom">Enter
												PickUp Address</label> <input type="radio" name="addrradioFrom"
												onclick="enableFromBox();" id="addrPreConfFrom"> <label
												class="addrtoggle" for="addrPreConfFrom">Select
												PickUp from Favourites</label>

										</div>



										<div class="form-group" id="locationFieldFrom">
											<input class="form-control" id="locationFieldFromText"
												onFocus="geolocatefrom()" placeholder="PickUp Address"
												name="from" type="text">
										</div>
										<br>

										<div class="controls" id="fromOption" style="display: none;">
											<select id="fromOptionSelect" name="fromtemp">
												<option value="MN RST Airport">MN RST Airport</option>
												<option value="MN MSP Terminal 1">MN MSP Terminal 1</option>
												<option value="MN MSP Terminal 2">MN MSP Terminal 2</option>
											</select>
										</div>



										<div class="control-group">
											<!-- <input type="checkbox" name="checkboxes" id="checkboxes-0"
													value="1" onclick="disableFromBox()"><label class="control-label" for="checkboxes">Book
												from Favourites</label>	-->
											<input type="radio" checked="checked" name="addrradioTo"
												id="addrUserTypedTo" onclick="disableToBox();"> <label
												class="addrtoggle" for="addrUserTypedTo">Enter
												DropOff Address</label> <input type="radio" name="addrradioTo"
												onclick="enableToBox();" id="addrPreConfTo"> <label
												class="addrtoggle" for="addrUserTypedTo">Select
												DropOff from Favourites</label>

										</div>


										<div class="form-group" id="locationFieldTo">
											<input class="form-control" id="locationFieldToText"
												onFocus="geolocateto()" placeholder="Drop Address" name="to"
												type="text">
										</div>
										<br>


										<div class="controls" id="toOption" style="display: none;">
											<select id="toOptionSelect" name="totemp">
												<option value="MN RST Airport">MN RST Airport</option>
												<option value="MN MSP Terminal 1">MN MSP Terminal 1</option>
												<option value="MN MSP Terminal 2">MN MSP Terminal 2</option>
											</select>
										</div>



										<div class="form-group">
											<div class="input-group date form_datetime col-md-5"
												data-date-format="dd MM yyyy - HH:ii p"
												data-link-field="dtp_input1">
												<input class="form-control" size="6" type="text"
													placeholder="Date Time" value="" name="datetime" readonly>
												<span class="input-group-addon"><span
													class="glyphicon glyphicon-remove"></span></span> <span
													class="input-group-addon"><span
													class="glyphicon glyphicon-th"></span></span>
											</div>

											<input type="hidden" id="dtp_input1" value="" />


										</div>



										<div class="form-group">
											<input class="form-control" placeholder="Name"
												name="customername" type="text" value="">
										</div>

										<div class="form-group">
											<input class="form-control" placeholder="Mobile Number"
												name="phone" type="text" value=""> <select
												id="selectbasic" name="mobileOperator" class="input-medium">
												<option>Sprint</option>
												<option>ATnT</option>
												<option>Verizon</option>
												<option>TMobile</option>
												<option>VirginMobile</option>
												<option>BoostMobile</option>
											</select>

										</div>

										<div class="form-group">
											<input class="form-control" placeholder="Flight Number"
												name="flightNumber" type="text" value=""> <input
												type="text" name="airline" placeholder="Airline" value="" />

										</div>


										<div class="form-group">
											<label class="addrtoggle" for="selectbasic">No. of
												Passengers</label> <select id="selectbasic" name="noOfPassengers"
												class="input-medium">
												<option>1</option>
												<option>2</option>
												<option>3</option>
												<option>4</option>
												<option>5</option>
											</select>

										</div>



										<div class="form-group">
											<label class="checkbox"><input type="checkbox"
												name="termsandconds"> I agree all your <a href="#">Terms
													of Services</a></label>
											<button class="btn btn-success" type="submit">Book</button>
										</div>


									</fieldset>
								</div>



							</div>
						</div>

					</form>






























					<div class="span4">

						<%
if(userName.equalsIgnoreCase("Guest")){

%>

						<div class="area">
							<form accept-charset="UTF-8" role="form" method="POST"
								action="/cabguruweb/ls">
								<div class="heading">
									<h4 class="form-heading">Please sign in</h4>
								</div>


								<%
												String loginMessage = (String) request.getAttribute("loginMsg");
												if (loginMessage != null) {

													out.println("<div class=\"alert alert-error\">"
															+ "<button class=\"close\" data-dismiss=\"alert\" "
															+"type=\"button\">×</button>"
															+ "<strong>" + loginMessage + "</strong>" + "</div>");

												} else {

												}
											%>

								<div class="panel-body">

									<fieldset>

										<input type="hidden" id="callerPage" name="callerPage"
											value="index.jsp" />

										<div class="form-group">
											<input class="form-control" placeholder="Mobile Number"
												name="phone" type="text">
										</div>

										<div class="form-group">
											<input class="form-control" placeholder="Password"
												name="passwd" type="password" value="">
										</div>



										<div class="form-group">
											<label class="checkbox"><input type="checkbox">
												Keep me signed in <a class="btn btn-link"
												href="./forgotPassword.jsp">Forgot my password</a></label>
											<button class="btn btn-success" type="submit">Sign
												In</button>
										</div>

										</br>







									</fieldset>
							</form>
						</div>
					</div>
					<!-- Close of area div -->
					<%
}
%>

				</div>

			</div>
		</div>



	</div>


	<hr>

	<!-- Example row of columns -->
	<div class="row-fluid">
		<div class="span4">
			<h3>ITaxi Co. No 1</h3>

			<img class="img-circle img-responsive text-center"
				src="./ico/no-1.jpg">
		</div>
		<div class="span4">
			<h3>WE TAKE VISA.</h3>

			<img class="img-circle img-responsive" src="./ico/visa.png">
		</div>
		<div class="span4">
			<h3>WE CARRY CHANGE.</h3>
			<img class="img-circle img-responsive" src="./ico/change.jpg">
		</div>
	</div>

	<hr>

	<div class="footer">
		<p>Copyright &copy; NousOnWork 2013</p>
	</div>

	</div>
	<!-- /container -->

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


	<script type="text/javascript" src="./js/bootstrap.min.js"></script>
	<script type="text/javascript" src="./js/bootstrap-datetimepicker.js"
		charset="UTF-8"></script>
	<script type="text/javascript"
		src="./js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>
	<script type="text/javascript">
		$('.form_datetime').datetimepicker({
			//language:  'fr',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1
		});
		$('.form_date').datetimepicker({
			language : 'fr',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			minView : 2,
			forceParse : 0
		});
		$('.form_time').datetimepicker({
			language : 'fr',
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 1,
			minView : 0,
			maxView : 1,
			forceParse : 0
		});
	</script>

	<script>
		$( document ).ready(function() {
			initFunction();
		});
	</script>

</body>
</html>