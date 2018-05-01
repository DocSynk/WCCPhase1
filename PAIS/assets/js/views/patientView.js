$(function() {

	function getPatientAppts(accountID) {
		$.ajax( {
			"dataType": 'json',
			"type": 'GET',
			"url": PAGE.xeh.ajaxGetPatientAppts,
			"data": {"accountID": accountID},
			"success": function(e) {
				if (e.success) {
					var hasAppt = (e.patientAppts.length ? 1 : 0);
					var today = new Date().setHours(0,0,0,0);

					var itemsProcessed = 0;

					e.patientAppts.forEach(function(appt) {
						itemsProcessed++;
						var date = new Date(appt.dtApptDate).setHours(0,0,0,0);

						if (today == date) {
							$('.apptToday').show();
							var apptListInput = $('.apptToday').children('.apptList');
						} else {
							$('.apptTomorrow').show();
							var apptListInput = $('.apptTomorrow').children('.apptList');
						}
						
						apptListInput.val(apptListInput.val() + appt.intAppointmentID + ',');

						if (itemsProcessed == e.patientAppts.length) {
							if ($('.apptToday').children('.apptList').val().length) {
								$('.apptToday').children('.apptList').val($('.apptToday').children('.apptList').val().slice(0, -1));
							}

							if ($('.apptTomorrow').children('.apptList').val().length) {
								$('.apptTomorrow').children('.apptList').val($('.apptTomorrow').children('.apptList').val().slice(0, -1));
							}
						}
					});

					
					$('#changeApptButton').on('click', function(e) {
						$('.btnChangeContainer').fadeOut('fast', function() {
							$('.btnReschedule').fadeIn('fast');
							if (!hasAppt) {
								$('.buttonSpace').empty();
								var explanationText = "<h3><p>No appointments were found for today or tomorrow.</p><br/><p>Please contact us if you need to set up an appointment.</p></h3>";
								$('.buttonSpace').append(explanationText).hide().fadeIn('fast');
							}
						});
					});
				} else {
					alert("Unfortunately, we're having trouble accessing appointments at this time. Please try again later.");
				}
			},
			"timeout": 15000,
			"error": function(e) {
				console.error(e);
			}
		});
	}

	getPatientAppts(PAGE.accountID);

	function getAvailableAppts() {
		$.ajax( {
			"dataType": 'json',
			"type": 'GET',
			"url": PAGE.xeh.ajaxGetAvailableAppts,
			"data": {},
			"success": function(e) {
				if (e.success) {
					// console.log(e.availableAppts);
				} else {
					alert("Unfortunately, we're having trouble accessing appointments at this time. Please try again later.");
				}
			},
			"timeout": 15000,
			"error": function(e) {
				console.error(e);
			}
		});
	}

	getAvailableAppts();
});