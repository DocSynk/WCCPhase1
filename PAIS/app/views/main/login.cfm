<cfoutput>
	<div class="row">
		<div class="col-md-offset-2 col-md-8">
			<form id="loginForm" class="form-horizontal" method="post" action="#buildURL(rc.xeh.loginSubmit)#">
				<fieldset>
					<legend>Log In</legend>
					<div class="form-group">
						<div class="col-md-6">
							<input type="text" id="lastName" name="lastName" class="form-control" value="" placeholder="Last Name" required/>
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-6">
							<input type="text" id="dob" name="dob" class="form-control" value="" data-datable="mmddyyyy" data-datable-divider="/" required/>
						</div>
					</div>
					<div class="form-group">
						<div class=" col-md-12">
							<input id="latitude" type="hidden" value"" name="latitude" />
							<input id="longitude" type="hidden" value"" name="longitude" />
							<input id="address" type="hidden" value="" name="fullAddress" />
							<input type="submit" value="Login" class="btn btn-primary loginButton" />
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<script type="text/javascript" src="https://maps.google.com/maps/api/js?key=AIzaSyA9boqCsS_O5l9k5kTo6ET6Sot73-O259E"></script>
	<script src="assets/js/views/login.js"></script>
</cfoutput>