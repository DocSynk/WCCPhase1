component accessors="true" {

	property securityService;
	property beanFactory;
	property validationService;
	property defaultOrganizationID;
	property formatterService;
	property util;
	property accountService;
	property appointmentService;
	property twilioService;
	property auditLogService;
	property addressService;
	property importService;


	function init (fw) {
		variables.fw = arguments.fw;
	}

	function error (rc) {
		for (var line in request.exception.cause.tagcontext) {
			writeoutput(line.raw_trace);
			writeoutput("<br />");
		}
		writedump(request.exception);
		abort;
	}

	function before (rc) {
		rc.xeh.logout = 'main.logout';
		rc.authPassword = 'w35tschedul3';

		rc.jsonResponse = {
			"success": false
		  , "errorType": {}
		  , "patientAppts": {}
		  , "availableAppts": {}
		}

		rc.controllerName = "main";
	}

	function after (rc) {

	}

	function checkAuthorization (rc) {
		if (isNull(session.user) || isNull(session.messenger) || isNull(session.flash)) {
			setupSession();
		}

		var isSecuredEvent = securityService.isSecuredEvent(fw.getSection(), fw.getItem());
		if ( isSecuredEvent && (isNull(session.user) || !session.user.isLoggedIn())) {
			if (len(cgi.path_info)) {
				session.login_requestedPage = cgi.path_info;
			} else if (findNoCase("index.cfm", cgi.request_url)) {
				var requestURLList = replaceNoCase(cgi.request_url, "index.cfm", "|");
				if (listLen(requestURLList,"|") > 1) {
					session.login_requestedPage = listLast(requestURLList, "|");
				} else {
					session.login_requestedPage = "/";
				}
			} else {
				session.login_requestedPage = "/";
			}
			fw.redirect(securityService.getLoginFormItem());
		}
	}

	function setupSession (rc) {
		session.user = accountService.load(0);
		session.messenger = beanFactory.getBean("Messenger");
		session.flash = beanFactory.getBean("FlashStorage");
	}
	
	function index (rc) {
		if (session.user.isLoggedIn()) {
			fw.redirect('main.patientView');
		} else {
			fw.redirect('main.login');
		}
	}

	function login (rc) {
		appointmentService.addFakeAppointments();
		
		if (session.user.isLoggedIn()) {
			fw.redirect("main.index");
		}

		rc.xeh.loginSubmit = "main.loginSubmit";
		rc.xeh.forgotPasswordForm = "main.forgotPassword";
	}

	function loginSubmit (rc) {
		if (isNull(rc.lastName) || isNull(rc.dob)) {
			fw.redirect('main.index');
		}

		if (!isValid('string', rc.lastName) || !len(trim(rc.lastName))) {
			session.messenger.addAlert(
				messageType="WARNING"
				, message="Unrecognized Last Name"
				, messageDetail=""
				, field="lastName");
		}

		if (!isValid('date', rc.dob) || !len(trim(rc.dob))) {
			session.messenger.addAlert(
				messageType="WARNING"
				, message="Invalid format for Date of Birth. Try using mm-dd-yyyy"
				, messageDetail=""
				, field="dob");
		}
		
		if (session.messenger.hasAlerts()) {
			fw.redirect(action=securityService.getLoginFormItem(), queryString="##authenticationError");
		}

		var authenticatedUser = accountService.authenticateLogin(
			lastName=rc.lastName
			, dob=rc.dob
			, ipAddress=util.getRemoteIP()
			, httpHost=cgi.http_host
			, userAgent=cgi.http_user_agent
		);

		if ( authenticatedUser.getIntAccountID() && authenticatedUser.isLoggedIn() ) {
			session.user = authenticatedUser;

			if (!isNull(rc.latitude) && len(rc.latitude)) {
				var geoData = '{"Latitude":' & rc.latitude &'"Longitude":' & rc.longitude & '"Address":' & rc.fullAddress & '}';
				var addresses = addressService.loadByAccountID(session.user.getIntAccountID());
				var currentAddress = replace(replace(rc.fullAddress, " ", "", "ALL"), ",", "", "ALL");

				for (var address in addresses) {
					var possibleAddress = replace(replace(address.getVcAddress1() & address.getVcCity() & address.getVcState() & address.getVcPostalCode() & address.getVcCountry(), " ", "", "ALL"), ",", "", "ALL");
					
					if (!compareNoCase(currentAddress, possibleAddress)) {
						session.addressID = address.getIntAddressID();
					}
				}
			} else {
				var geoData = '';
			}

			auditLogService.logAction(
			    action = 'LOGIN'
			  , category = 'SUCCESS'
			  , subcategory = ''
			  , data = geoData
			  , latitude = rc.latitude
			  , longitude = rc.longitude
			  , addressID = (structKeyExists(session, "addressID") ? session.addressID : 0)
			  , accountID = authenticatedUser.getIntAccountID()
			);


			if ( structKeyExists(session, "login_requestedPage") && len(session.login_requestedPage) ) {
				var redirectTo = session.login_requestedPage;
				structDelete(session, "login_requestedPage");
				fw.redirectCustomURL(redirectTo);
			} else {
				fw.redirect(action='main.index');
			}
		} else {
			//bad authentication
			session.messenger.addAlert(
				messageType="WARNING"
				, message="No account was found with that Last Name and Date of Birth"
				, messageDetail=""
				, field="login");

			fw.redirect(action=securityService.getLoginFormItem(), queryString="##authenticationError");
		}
	}

	function logout (rc) {
		var accountID = session.user.getIntAccountID();
		session.user = accountService.load(0);

		auditLogService.logAction(
			action = 'LOGOUT'
			, category = 'SUCCESS'
			, subcategory = ''
			, accountID = accountID
			, addressID = (structKeyExists(session, "addressID") ? session.addressID : 0)
		);

		fw.redirect(action=securityService.getLoginFormItem());
	}

	function patientView (rc) {
		rc.account = accountService.load(session.user.getIntAccountID());

		rc.xeh.appointmentView = "main.appointmentView";
		rc.xeh.ajaxGetPatientAppts = "main.ajaxGetPatientAppts";
		rc.xeh.ajaxGetAvailableAppts = "main.ajaxGetAvailableAppts";
	}

	function appointmentView(rc) {
		param rc.availableAppts = [];
		rc.accountID = session.user.getIntAccountID();

		if (isNull(rc.apptDay) || isNull(session.availableAppts)) {
			fw.redirect('main.index');
		}

		if (structKeyExists(session, 'availableAppts')) {
			rc.allAvailableAppts = session.availableAppts;
		}

		var today = dateformat(now(), "yyyy-mm-dd");
		for (var appt in rc.allAvailableAppts) {
			if (rc.apptDay == 'Today' && today == appt.getDtApptDate() || rc.apptDay == 'Tomorrow' && today != appt.getDtApptDate()) {
				arrayAppend(rc.availableAppts, appt);
			}
		}

		// Directed to dropoff at WCC in Germantown; generated deeplink https://developer.uber.com/products/ride-requests-deeplink
		rc.uberLink = 'https://m.uber.com/ul/?action=setPickup&client_id=LI6NksDQrxpXJ3k2WVfws_aKx0KpBu3P&pickup=my_location&dropoff[formatted_address]=7945%20Wolf%20River%20Blvd%2C%20Germantown%2C%20TN%2038138%2C%20United%20States&dropoff[latitude]=35.110830&dropoff[longitude]=-89.798521';

		rc.xeh.ajaxUpdateAppt = "main.ajaxUpdateAppt";
		rc.xeh.ajaxLogUberRequest = "main.ajaxLogUberRequest";
	}

	function ajaxGetPatientAppts (rc) {
		if (!isNull(rc.accountID)) {
			var patientAppts = appointmentService.getUpcomingPatientAppts(intAccountID = val(rc.accountID));
			rc.jsonResponse.patientAppts = patientAppts;
			rc.jsonResponse.success = true;
		}

		fw.renderData("json", rc.jsonResponse);
		return;
	}

	function ajaxGetAvailableAppts (rc) {
		var availableAppts = appointmentService.getAvailableAppts();
		rc.jsonResponse.availableAppts = availableAppts;
		rc.jsonResponse.success = true;

		session.availableAppts = availableAppts;

		fw.renderData("json", rc.jsonResponse);
		return;
	}

	function ajaxUpdateAppt (rc) {
		if (!isNull(rc.accountID) && !isNull(rc.appointmentID) && !isNull(rc.oldApptIDList)) {
			var patient = accountService.load(rc.accountID);

			transaction {
				try {
					//update new appt to add account information
					var newAppt = appointmentService.load(rc.appointmentID);

					newAppt.setIntAccountID(rc.accountID);
					newAppt.setBtIsAvailable(0);
					newAppt.setIntPatientID(patient.getIntPatientID());
					newAppt.setDtModifiedOn(now());
					newAppt.setIntModifiedBy(rc.accountID);

					newAppt = appointmentService.save(newAppt);

					auditLogService.logAction(
						action = 'UPDATE'
						, category = 'APPOINTMENT'
						, subcategory = 'ASSIGN'
						, data = newAppt.toJSON()
						, accountID = rc.accountID
						, appointmentID = rc.appointmentID
						, addressID = (structKeyExists(session, "addressID") ? session.addressID : 0)
					);

					for (oldApptID in rc.oldApptIDList) {
						//update old appt to remove account information
						var oldAppt = appointmentService.load(oldApptID);

						oldAppt.setIntAccountID(0);
						oldAppt.setBtIsAvailable(1);
						oldAppt.setIntPatientID(0);
						oldAppt.setDtModifiedOn(now());
						oldAppt.setIntModifiedBy(rc.accountID);

						oldAppt = appointmentService.save(oldAppt);

						auditLogService.logAction(
							action = 'UPDATE'
							, category = 'APPOINTMENT'
							, subcategory = 'REMOVE'
							, data = oldAppt.toJSON()
							, accountID = rc.accountID
							, appointmentID = oldApptID
							, addressID = (structKeyExists(session, "addressID") ? session.addressID : 0)
						);
					}

					//send confirmation message via twilio
					twilioService.sendConfirmation(cellPhone = patient.getVcCellPhone());
					auditLogService.logAction(
						action = 'MESSAGE'
						, category = 'APPOINTMENT'
						, subcategory = 'CONFIRMATION'
						, data = '{"accountCellPhone":' & patient.getVcCellPhone() & '}'
						, appointmentID = rc.appointmentID
						, accountID = rc.accountID
						, addressID = (structKeyExists(session, "addressID") ? session.addressID : 0)
					);

					rc.jsonResponse.success = true;
					structDelete(session, 'availableAppts');

					transaction action="commit";
				}
				catch (any e) {
					transaction action="rollback";
				}
			}
		}
		
		fw.renderData("json", rc.jsonResponse);
		return;
	}

	function ajaxLogUberRequest (rc) {
		if (!isNull(rc.accountID)) {
			auditLogService.logAction(
				action = 'REQUEST'
				, category = 'TRANSPORTATION'
				, subcategory = 'UBER'
				, accountID = rc.accountID
				, transportArranged = 1
			);

			rc.jsonResponse.success = true;
		}

		fw.renderData("json", rc.jsonResponse);
		return;
	}

	function importPatientData (rc) {
		var providedPassword = '';

		if (structKeyExists(url, 'password')) {
			var providedPassword = url['password'];
		}

		if (structKeyExists(rc, "authPassword") && hash(providedPassword) == hash(rc.authPassword)) {
			importService.importPatientData();
			writedump('Import successful.');abort;
		} else {
			fw.redirect('main.login');
		}
	}

	function addFakeAppointments (rc) {
		var providedPassword = '';

		if (structKeyExists(url, 'password')) {
			var providedPassword = url['password'];
		}

		if (structKeyExists(rc, "authPassword") && hash(providedPassword) == hash(rc.authPassword)) {
			appointmentService.addFakeAppointments();
			writedump('Appointments processed.');abort;
		} else {
			fw.redirect('main.login');
		}
	}
}