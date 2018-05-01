<cfoutput>
	<div class="row">
		<div class="col-md-offset-2 col-md-8 header">
			<fieldset>
				<legend>Available Appointment Times</legend>
			</fieldset>
		</div>
		<div class="col-md-12 apptTimesDisplayDiv">	
			<cfif !arrayLen(rc.availableAppts)>
				<h3><p>We're sorry, but there are no available appointment times for this day.</p><br /><p>If you would like to reschedule, please contact us.</p></h3>
			<cfelse>
				<cfloop array="#rc.availableAppts#" index="appt">
					<button class="btn btn-primary btnDisplay btnAppt" data-appointmentid="#appt.getIntAppointmentID()#">
						#timeformat(appt.getDtApptTime(), "short")#
					</button>
				</cfloop>
				<br /><br />
				<button class="btn btn-primary btnDisplay btnCant" data-toggle="modal" data-target="##cantModal" >Can't make these times?</button>
			</cfif>
		</div>
	</div>

	<div class="modal fade" id="cantModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<i class="glyphicon glyphicon-remove fa-lg"></i>
					</button>
					<h4 class="modal-title" id="myModalLabel">Having trouble?</h4>
				</div>
				<div class="modal-body">
					<a id="uberLink" href="#rc.uberLink#">
						<button class="btn btn-primary btnDisplay btnUber"style="margin-bottom: 2vh;">
							<img src="/assets/img/uber_rides_api_icon_1x_44px.png" />&nbsp;
							Ride there with Uber
						</button>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<i class="glyphicon glyphicon-remove fa-lg"></i>
					</button>
					<h4 class="modal-title" id="myModalLabel">Thanks for rescheduling!</h4>
				</div>
				<div class="modal-body">
					<p class="successText">Currently, we are sending your appointment and will text you when the change has been confirmed.</p>
					<p class="successText">You will be returned to the login page.</p>
				</div>
			</div>
		</div>
	</div>
	<script>
		PAGE = {
			accountID: #rc.accountID#,
			oldApptIDList: '#rc.apptList#',
			xeh: {
			    ajaxUpdateAppt: '#buildURL(rc.xeh.ajaxUpdateAppt)#',
				ajaxLogUberRequest: '#buildURL(rc.xeh.ajaxLogUberRequest)#'
			}
		};
	</script>

	<script src="assets/js/views/appointmentView.js"></script>
</cfoutput>