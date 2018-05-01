component name="Appointment" accessors="true" extends="BaseDomain" {

	property Numeric intAppointmentID;
	property Numeric intAccountID;
	property Numeric intPracticeID;
	property date dtApptDate;
	property date dtApptTime;
	property boolean btIsAvailable;
	property Numeric intPatientID;
	property String vcFNameDoctor;
	property String vcLNameDoctor;
	property date dtModifiedOn;
	property Numeric intModifiedBy;

	public any function init () {

		setIDField("intAppointmentID");

		setIntAppointmentID(0);
		setIntAccountID(0);
		setIntPracticeID(0);
		setDtApptDate(variables.instance.never);
		setDtApptTime(variables.instance.never);
		setBtIsAvailable(false);
		setIntPatientID(0);
		setVcFNameDoctor("");
		setVcLNameDoctor("");
		setDtModifiedOn(variables.instance.never);
		setIntModifiedBy(0);

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAppointmentID":' & getIntAppointmentID());
		sb.append('"intAccountID":' & getIntAccountID());
		sb.append(', "intPracticeID":' & getIntPracticeID());
		sb.append(', "dtApptDate":"' & formatterService.formatDateTime(getDtApptDate()) & '"');
		sb.append(', "dtApptTime":"' & formatterService.formatDateTime(getDtApptTime()) & '"');
		sb.append(', "btIsAvailable":' & (getBtIsAvailable() ? 'true' : 'false'));
		sb.append(', "intPatientID":' & getIntPatientID());
		sb.append(', "vcFNameDoctor":' & serializeJSON(getVcFNameDoctor()));
		sb.append(', "vcLNameDoctor":' & serializeJSON(getVcLNameDoctor()));
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "intModifiedBy":' & getIntModifiedBy());
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAppointmentID":' & getIntAppointmentID());
		sb.append('"intAccountID":' & getIntAccountID());
		sb.append(', "intPracticeID":' & getIntPracticeID());
		sb.append(', "dtApptDate":"' & formatterService.formatDateTime(getDtApptDate()) & '"');
		sb.append(', "dtApptTime":"' & formatterService.formatDateTime(getDtApptTime()) & '"');
		sb.append(', "btIsAvailable":' & (getBtIsAvailable() ? 'true' : 'false'));
		sb.append(', "intPatientID":' & getIntPatientID());
		sb.append(', "vcFNameDoctor":' & serializeJSON(getVcFNameDoctor()));
		sb.append(', "vcLNameDoctor":' & serializeJSON(getVcLNameDoctor()));
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "intModifiedBy":' & getIntModifiedBy());
		sb.append("}");
		return sb.toString();
	}


	public boolean function btIsAvailable() {
		return variables.btIsAvailable;
	}
}

