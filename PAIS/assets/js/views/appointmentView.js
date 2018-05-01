$(function() {
	function bindConfirmEvent(element) {
		$('.btnConfirm').on('click', function() {
			updateAppt(PAGE.accountID, $(this).prev('.btnAppt').data('appointmentid'));
		});
	}

	var confirmButton = '<button class="btn btn-primary btnDisplay btnAppt btnConfirm">Tap here to confirm</button>';

	$('.btnAppt').on('click', function(e) {
		if (!$(this).next('.btnAppt').hasClass('btnConfirm')) {
			if ($('.btnConfirm').length) {
				var newAppt = $(this);
				$('.btnConfirm').slideUp('fast', function() { 
					$(this).prev('.btnAppt').css('margin-bottom', '2vh');
					$(this).remove();
					//add confirm button to new appt after old one has finished animating
					newAppt.css('margin-bottom', 0);
					$(confirmButton).insertAfter(newAppt).hide().slideDown('fast');
				});
			} else {
				$(this).css('margin-bottom', 0);
				$(confirmButton).insertAfter($(this)).hide().slideDown('fast');
			}
			
			bindConfirmEvent($('.btnConfirm'));
		}
	});

	function updateAppt(accountID, appointmentID) {
		$('.btnConfirm').replaceWith('<button class="btn btn-primary btnAppt btnDisplay">Confirming...</button>');

		$.ajax( {
			"dataType": 'json',
			"type": 'POST',
			"url": PAGE.xeh.ajaxUpdateAppt,
			"data": {"accountID": accountID, "appointmentID": appointmentID, "oldApptIDList": PAGE.oldApptIDList},
			"success": function(e) {
				if (e.success) {
					$('#successModal').modal('show');
					setTimeout(function() {window.location.replace('main/logout');}, 10000);
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

	$('.btnUber').on('click', function(e) {
		e.preventDefault();

		$.ajax( {
			"dataType": 'json',
			"type": 'POST',
			"url": PAGE.xeh.ajaxLogUberRequest,
			"data": {"accountID": PAGE.accountID},
			"success": function(e) {
				if (e.success) {
					window.location.href = $('#uberLink').attr('href');
				} else {
					alert("Unfortunately, we cannot process your request. Please try again later.");
				}
			},
			"timeout": 15000,
			"error": function(e) {
				console.error(e);
			}
		});
	});
});