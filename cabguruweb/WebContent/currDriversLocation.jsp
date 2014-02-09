<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ITaxi-DriverLocations</title>
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

<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="http://maps.google.com/maps/api/js?sensor=false"
	type="text/javascript">
	  </script>


<style>
html,body,#map-canvas {
	height: 100%;
	margin: 0px;
	padding: 0px
}
</style>



<style type="text/css">
html {
	height: 100%
}

body {
	height: 100%;
	margin: 0;
	padding: 0
}

#map-canvas {
	height: 100%
}
</style>


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

					<ul class="nav navbar-nav">
						<li><a href="./currDriversLocation.jsp">Current Drivers
								Location</a></li>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">Menu<b class="caret"></b></a>
							<ul class="dropdown-menu">

								<li><a href="./adminMain.jsp">Book Taxi</a></li>
								<li class="divider"></li>
								<li><a href="./addCust.jsp">Add Customer</a></li>
								<li><a href="./searchCust.jsp">Search Customer</a></li>

								<li class="divider"></li>
								<li><a href="./addDriver.jsp">Add Driver</a></li>
								<li><a href="./searchDriver.jsp">Search Driver</a></li>

								<li class="divider"></li>
								<li><a href="./currDriversLocation.jsp">Current Drivers
										Location</a></li>

								<li class="divider"></li>
								<li><a href="./pendingBookings.jsp">Pending Bookings</a></li>
								<li><a href="./adminBookingHistory.jsp">Bookings
										History</a></li>
								<li><a href="/cabguruweb/logout">Log Out</a></li>
							</ul></li>
					</ul>
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

	<div id="map-canvas"></div>


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



	<script type="text/javascript">





	function loadGPSData(){	 

	var locations = <% out.println(com.cabguru.util.DriversCache.getGPSData());  %>

	var map = new google.maps.Map(document.getElementById('map-canvas'), {
	zoom: 13,
	center: new google.maps.LatLng(44.86, -93.26),
	mapTypeId: google.maps.MapTypeId.ROADMAP
	});

	var infowindow = new google.maps.InfoWindow();
	var marker, i;

	for (i = 0; i < locations.length; i++) {
	marker = new google.maps.Marker({
	 position: new google.maps.LatLng(locations[i][1], locations[i][2]),
	 map: map,
	// animation: google.maps.Animation.BOUNCE,
	 icon:'./ico/cabs.png'
	});

	google.maps.event.addListener(marker, 'click', (function(marker, i) {
	 return function() {
	   infowindow.setContent(locations[i][0]);
	   infowindow.open(map, marker);
	 }
	})(marker, i));
	}
	}

	window.onload = loadGPSData;
	
</script>



</body>
</html>