
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>ITaxi-ForgotPassword &middot;</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

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
							<li><a href="./index.jsp">Home</a></li>
							<li><a href="./services.jsp">Services</a></li>
							<li><a href="./fare.jsp">FareInformation</a></li>
							<li><a href="./offers.jsp">Offers</a></li>
							<li><a href="./contactUs.jsp">ContactUs</a></li>
							<li><a href="./aboutUs.jsp">AboutUs</a></li>
							<li class="active"><a href="./signup.jsp">SignUp</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- /.navbar -->
		</div>



		<div class="row">


			<div class="row-fluid">
				<div class="span12">
					<div class="span6">
						<div class="area">
							<form class="form-horizontal" accept-charset="UTF-8" role="form"
								method="POST" action="/cabguruweb/fps">
								<div class="heading">
									<h4 class="form-heading">Forgot Password</h4>
								</div>

								<%
							String msg = (String) request.getAttribute("msg");
							if (msg != null) {

								out.println("<div class=\"alert alert-error\">"
										+ "<button class=\"close\" data-dismiss=\"alert\" "
										+ "type=\"button\">×</button>" + "<strong>"
										+ msg + "</strong>" + "</div>");

							} else {

							}
						%>

								<div class="control-group">
									<label class="control-label" for="inputUsername">Mobile
										Number</label>

									<div class="controls">
										<input id="inputUsername" placeholder="E.g. 9525647320"
											type="text" name="phone">
									</div>
								</div>

								<div class="control-group">
									<div class="controls">

										<button class="btn btn-success" type="submit">Send
											Password Via Mail</button>
									</div>
								</div>



							</form>
						</div>
					</div>

					<div class="span6">
						<div class="area">
							<form class="form-horizontal" accept-charset="UTF-8" role="form"
								method="POST" action="/cabguruweb/sus">
								<div class="heading">
									<h4 class="form-heading">Sign Up</h4>
								</div>

								<%
							String signupMsg = (String) request.getAttribute("signupMsg");
							if (signupMsg != null) {

								out.println("<div class=\"alert alert-error\">"
										+ "<button class=\"close\" data-dismiss=\"alert\" "
										+ "type=\"button\">×</button>" + "<strong>"
										+ signupMsg + "</strong>" + "</div>");

							} else {

							}
						%>

								<input type="hidden" id="callerPage" name="callerPage"
									value="forgotPassword.jsp" />

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
										<input id="inputUser" placeholder="E.g. 9525647320"
											type="text" name="phone">
									</div>
								</div>



								<div class="control-group">
									<label class="control-label" for="inputFirst">First
										Name</label>

									<div class="controls">
										<input id="inputFirst" placeholder="E.g. Shankar" type="text"
											name="firstName">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label" for="inputLast">Last Name</label>

									<div class="controls">
										<input id="inputLast" placeholder="E.g. Mohanty" type="text"
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
										<input id="inputEmail" placeholder="E.g. nousonwork@gmail.com"
											type="text" name="mailId">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label" for="textarea">Address</label>
									<div class="controls">
										<textarea id="textarea"
											placeholder="7300 Gallagher Drive, Minneapolis, MN 55435, USA"
											name="address"></textarea>
									</div>
								</div>



								<div class="control-group">
									<label class="control-label" for="inputPassword">Password</label>

									<div class="controls">
										<input id="inputPassword" placeholder="Min. 8 Characters"
											type="password" name="password">
									</div>
								</div>

								<div class="control-group">
									<label class="control-label" for="inputPassword">Confirm
										Password</label>

									<div class="controls">
										<input id="inputPassword" placeholder="Min. 8 Characters"
											type="password" name="confirmPassword">
									</div>
								</div>


								<div class="control-group">
									<div class="controls">
										<label class="checkbox"><input type="checkbox"
											name="termsandconds"> I agree all your <a href="#">Terms
												of Services</a></label>
										<button class="btn btn-success" type="submit">Sign Up</button>
									</div>
								</div>




							</form>
						</div>
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