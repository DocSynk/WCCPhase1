<!DOCTYPE html>
<html>
	<head>
		<base href="<cfoutput>#iif( CGI.HTTPS eq "on", de("https"), de("http") ) & "://" & CGI.HTTP_HOST & getDirectoryFromPath( CGI.SCRIPT_NAME )#</cfoutput>" />

		<title><cfoutput>#getBeanFactory().getBean("applicationDisplayName")#</cfoutput></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- Bootstrap -->

		<link href="/assets/css/jquery-ui-1.11.2-smoothness.css" rel="stylesheet">
		<link href="/assets/css/bootstrap.min.css" rel="stylesheet">
		<link href="/assets/css/bootstrap-toggle.min.css" rel="stylesheet">
		<link href="/assets/css/app.css" rel="stylesheet">

  		<script src="/assets/js/jquery-2.1.3.min.js"></script>
  		<script src="/assets/js/jquery-ui-1.11.2.min.js"></script>
  		<script src="/assets/js/lodash-3.6.0.min.js"></script>
		<script src="/assets/js/bootstrap.min.js"></script>
		<script src="/assets/js/bootstrap-toggle.min.js"></script>
        <script src="/assets/js/jscolor.js"></script>
        <script src="/assets/js/datable.min.js"></script>

		<!--- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries --->
		<!--- WARNING: Respond.js doesn't work if you view the page via file:// --->
		<!--[if lt IE 9]>
		  <script src="/assets/js/html5shiv-3.7.0.js"></script>
		  <script src="/assets/js/respond-1.3.0.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<cfif cgi.path_info EQ "/main/login">
			<div class="jumbotron">
				<div class="container">
					<img id="wccLogo" src="/assets/img/westClinic_Large.png" />
				</div>
			</div>
		<cfelse>
			<cfinclude template="includes/navbar.cfm" />
		</cfif>
		<div class="container bodyDisplay">
			<cfinclude template="includes/messages.cfm" />
			<cfoutput>#body#</cfoutput>
		</div>


	</body>
	<footer>
		<div class="contactUsSection">
			<a class="contactUsBottomBtn" href="tel:9015555555">
				<span class="glyphicon glyphicon-earphone glyph-background gi-big"></span>
				<p class="contactUsTextBtn">Contact Us</p>
			</a>
		</div>
		<script src="/assets/js/default.js"></script>
	</footer>
</html>
<cfset session.messenger.clear() />