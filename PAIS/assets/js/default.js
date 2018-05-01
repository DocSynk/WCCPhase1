$(function() {
	$('input').attr('autocapitalize', 'off').attr('autocorrect', 'off');

	function addMarginToContactButton() {
		if ($(window).height() > $('body').height() + $('.contactUsSection').outerHeight(true)) {
			var marginToAdd = $(window).height() - $('body').height() - $('.contactUsSection').outerHeight(true);
			$('.contactUsSection').css('margin-top', marginToAdd + 'px');
		} else {
			$('.contactUsSection').css('margin-top', '0em');
		}
	}

	addMarginToContactButton();

	function reposition() {
		var modal = $(this),
			dialog = modal.find('.modal-dialog');
		modal.css('display', 'block');
		dialog.css("margin-top", Math.max(0, ($(window).height() - dialog.height()) / 2));
	}
	// Reposition when a modal is shown
	$('.modal').on('show.bs.modal', reposition);
	// Reposition when the window is resized
	$(window).on('resize', function() {
		$('.modal:visible').each(reposition);
		addMarginToContactButton();
	});
});