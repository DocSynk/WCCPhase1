component name="appointmentService" accessors="true" extends="baseService" {

	property any appointmentGateway;

	property any beanFactory;

	private any function create (required any appointment) {

		var intAppointmentID = appointmentGateway.create(appointment);

		return load(intAppointmentID);
	}

	private any function update (required any appointment) {

		appointmentGateway.update(arguments.appointment);

		return load(appointment.getIntAppointmentID());
	}

	public any function save (required any appointment) {

		if (appointment.getIntAppointmentID()) {
			return update(arguments.appointment);
		} else {
			return create(arguments.appointment);
		}
	}

	public any function getEmptyDomain () {

		return beanFactory.getBean("Appointment");
	}

	public any function populate (required any appointment, required struct data ) {

		appointment.setIntAppointmentID(data.intAppointmentID);
		appointment.setIntAccountID(data.intAccountID);
		appointment.setIntPracticeID(data.intPracticeID);
		appointment.setDtApptDate(data.dtApptDate);
		appointment.setDtApptTime(data.dtApptTime);
		appointment.setBtIsAvailable(data.btIsAvailable);
		appointment.setIntPatientID(data.intPatientID);
		appointment.setVcFNameDoctor(data.vcFNameDoctor);
		appointment.setVcLNameDoctor(data.vcLNameDoctor);
		appointment.setDtModifiedOn(data.dtModifiedOn);
		appointment.setIntModifiedBy(data.intModifiedBy);

		return appointment;
	}

	public any function load (required numeric intAppointmentID ) {

		var appointment = getEmptyDomain();

		if (intAppointmentID == 0) {
			return appointment;
		}

		var qLoad = appointmentGateway.load(intAppointmentID);

		if (qLoad.recordCount) {
			return populate(appointment, queryRowData(qLoad, 1));
		}

		return local.appointment;
	}

	public array function loadAll () {

		var output = [];

		var qLoadAll = appointmentGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public array function getUpcomingPatientAppts (required numeric intAccountID) {
		var output = [];

		var qLoadPatientAppts = appointmentGateway.loadUpcomingPatientAppts(intAccountID);

		for (var row in qLoadPatientAppts) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public array function getAvailableAppts () {
		var output = []

		var qLoadAvailable = appointmentGateway.loadAvailable();

		for (var row in qLoadAvailable) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public any function checkImportAppointment (required numeric intAccountID, required date apptDate, required string apptTime) {
		var output = 0;

		if (intAccountID == 0) {
			return output;
		}

		var qLoad = appointmentGateway.checkImportAppointment(intAccountID, apptDate, apptTime);

		if (qLoad.recordCount) {
			output = 1;
		}

		return local.output;
	}

	public any function insertImportAppointment (
		required numeric intAccountID
	  , required date dtApptDate
	  , required string dtApptTime
	  , required numeric intPatientID) {

		appointmentGateway.insertImportAppointment(intAccountID, dtApptDate, dtApptTime, intPatientID);

		return;
	}

	public any function addFakeAppointments () {
		var apptTimes = ['10:00:00', '13:30:00', '09:45:00', '15:15:00', '17:00:00'];
		var counter = 0;

		var apptsExist = getAvailableAppts();

		if (!arrayLen(apptsExist)) {
			for (time in apptTimes) {
				counter++;
				var newAppt = getEmptyDomain();

				if (counter > 2) {
					newAppt.setDtApptDate(dateFormat(now(), 'yyyy-mm-dd'));
				} else {
					newAppt.setDtApptDate(dateFormat(dateAdd('d', 1, now()), 'yyyy-mm-dd'));
				}
				newAppt.setDtApptTime(time);
				newAppt.setIntPracticeID(1);
				newAppt.setBtIsAvailable(1);

				save(newAppt);
			}
		}

		return;
	}
}