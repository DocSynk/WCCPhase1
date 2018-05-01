$(function() {
	$('input[data-datable]').datable();
	$('#dob').attr('placeholder', 'Date of Birth - MM/DD/YYYY');

	var latitude = "";
	var longitude = "";
	var address = "";

	function geoFindMe() {
		if (navigator.geolocation){
			function success(position) {
				latitude  = position.coords.latitude;
				longitude = position.coords.longitude;

				getReverseGeocodingData(latitude, longitude);
			}

			function error() { 
				console.log("Unable to retrieve your location");
			}

			navigator.geolocation.getCurrentPosition(success, error);
		}
	}

	function getReverseGeocodingData(lat, lng) {
		var latlng = new google.maps.LatLng(lat, lng);
		var geocoder = new google.maps.Geocoder();
		geocoder.geocode({ 'latLng': latlng }, function (results, status) {
			if (status !== google.maps.GeocoderStatus.OK) {
				console.log(status);
			}
			if (status == google.maps.GeocoderStatus.OK) {
				address = (results[0].formatted_address);
			}
		});
	}

	geoFindMe();

	$('#loginForm').one('submit', function(e) {
		e.preventDefault();
		$('.loginButton').replaceWith('<a class="btn btn-primary loginButton">Loading...</a>');
	
		$('#latitude').val(latitude);
		$('#longitude').val(longitude);
		$('#address').val(address);

		$(this).submit();
	});
});