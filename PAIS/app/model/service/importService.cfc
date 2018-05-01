component name="importService" accessors="true" extends="baseService" {

	property any importGateway;
	property any accountService;
	property any addressService;
	property any appointmentService;

	property any beanFactory;

	public any function importPatientData () {
		setting requestTimeout=600;

		var data = importGateway.getPatientData();

		for (datum in data) {
			patientHasAccount = accountService.loadByMRN(datum.mrn);

			if (!patientHasAccount.getIntAccountID()) {
				// insert patient record, address & appt data
				var newAccountID = accountService.insertImportAccount(
					intPatientID = datum.profile_key
				  , vcMRN = datum.mrn
				  , vcFirstName = datum.first_name
				  , vcLastName = datum.last_name
				  , dtDOB = datum.date_of_birth
				);

				addressService.insertImportAddress(
					intAccountID = newAccountID
				  , vcAddress1 = datum.address1
				  , vcAddress2 = datum.address2
				  , vcCity = datum.city
				  , vcState = datum.state
				  , vcPostalCode = datum.postal_code
				);

				appointmentService.insertImportAppointment(
					intAccountID = newAccountID
				  , dtApptDate = mid(datum.app_datetime, 6, 10)
				  , dtApptTime = mid(datum.app_datetime, 16, 9)
				  , intPatientID = datum.profile_key
				);
				
			} else {
				var accountID = patientHasAccount.getIntAccountID();

				// check for address
				var hasAddress = addressService.importLoadByAccountID(accountID);

				if (!hasAddress) {
					addressService.insertImportAddress(
						  intAccountID = accountID
						, vcAddress1 = datum.address1
						, vcAddress2 = datum.address2
						, vcCity = datum.city
						, vcState = datum.state
						, vcPostalCode = datum.postal_code
					);
				}

				// check for appt
				var hasAppt = appointmentService.checkImportAppointment(
					  intAccountID = accountID
					, apptDate = mid(datum.app_datetime, 6, 10)
					, apptTime = mid(datum.app_datetime, 16, 9)
				);

				if (!hasAppt) {
					appointmentService.insertImportAppointment(
						  intAccountID = accountID
						, dtApptDate = mid(datum.app_datetime, 6, 10)
						, dtApptTime = mid(datum.app_datetime, 16, 9)
						, intPatientID = datum.profile_key
					);
				}
			}
		}

		return; 
	}
}