<cfoutput>
	<div class="row">
		<div class="col-md-offset-2 col-md-8 header">
			<fieldset>
				<legend>Welcome, #session.user.getVcFirstName()# #session.user.getVcLastname()#</legend>
			</fieldset>
		</div>
		<div class=" col-md-12 full">	
			<div class="container btnContainer btnChangeContainer">
				<div class="row">
					<div class="col-md-12 buttonSpace">
						<button id="changeApptButton" class="btn btn-primary btnDisplay">Change Appointment</button>
					</div>
				</div>
			</div>
			<div class="container btnContainer btnReschedule">
				<div class="row">
					<div class="col-md-12 buttonSpace">
						<p><h3>For which day would you like to reschedule an appointment?</h3></p>
						<form class="apptDay apptToday" method="POST" action="#buildURL(rc.xeh.appointmentView)#" style="display:none;">
							<input id="todayButton" class="btn btn-primary btnDisplay btnDay" type="submit" name="apptDay" value="Today"/>
							<input class="apptList" type="hidden" name="apptList" value="" />
						</form>
						<form class="apptDay apptTomorrow" method="POST" action="#buildURL(rc.xeh.appointmentView)#" style="display:none;">
							<input id="tomorrowButton" class="btn btn-primary btnDisplay btnDay" type="submit" name="apptDay" value="Tomorrow"/>
							<input class="apptList" type="hidden" name="apptList" value="" />
						</form>
					</div>
				</div>
			</div>	
		</div>
	</div>
	<script>
		PAGE = {
			accountID: #rc.account.getIntAccountID()#,
			xeh: {
			    ajaxGetPatientAppts: '#buildURL(rc.xeh.ajaxGetPatientAppts)#'
			  , ajaxGetAvailableAppts: '#buildURL(rc.xeh.ajaxGetAvailableAppts)#'
			}
		};
	</script>

	<script src="assets/js/views/patientView.js"></script>
</cfoutput>