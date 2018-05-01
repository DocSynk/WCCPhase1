component name="Account" accessors="true" extends="BaseDomain" {

	property Numeric intAccountID;
	property Numeric intPatientID;
	property Numeric intPracticeID;
	property String vcMRN;
	property String vcFirstName;
	property String vcLastName;
	property String vcCellPhone;
	property date dtDOB;
	property String vcGender;
	property String vcInsuranceProvider;
	property date dtLastLoggedInOn;

	property boolean isLoggedIn;

	public any function init () {

		setIDField("intAccountID");

		setIntAccountID(0);
		setIntPatientID(0);
		setIntPracticeID(0);
		setVcMRN("");
		setVcFirstName("");
		setVcLastName("");
		setVcCellPhone("");
		setDtDOB(variables.instance.never);
		setVcGender("");
		setVcInsuranceProvider("");
		setDtLastLoggedInOn(variables.instance.never);

		setIsLoggedIn(false);

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAccountID":' & getIntAccountID());
		sb.append(', "intPatientID":' & getIntPatientID());
		sb.append(', "intPracticeID":' & getIntPracticeID());
		sb.append(', "vcMRN":' & getVcMRN());
		sb.append(', "vcFirstName":' & serializeJSON(getVcFirstName()));
		sb.append(', "vcLastName":' & serializeJSON(getVcLastName()));
		sb.append(', "vcCellPhone":' & serializeJSON(getVcCellPhone()));
		sb.append(', "dtDOB":"' & formatterService.formatDateTime(getDtDOB()) & '"');
		sb.append(', "vcGender":' & serializeJSON(getVcGender()));
		sb.append(', "vcInsuranceProvider":' & serializeJSON(getVcInsuranceProvider()));
		sb.append(', "dtLastLoggedInOn":"' & formatterService.formatDateTime(getDtLastLoggedInOn()) & '"');
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAccountID":' & getIntAccountID());
		sb.append(', "intPatientID":' & getIntPatientID());
		sb.append(', "intPracticeID":' & getIntPracticeID());
		sb.append(', "vcMRN":' & getVcMRN());
		sb.append(', "vcFirstName":' & serializeJSON(getVcFirstName()));
		sb.append(', "vcLastName":' & serializeJSON(getVcLastName()));
		sb.append(', "vcCellPhone":' & serializeJSON(getVcCellPhone()));
		sb.append(', "dtDOB":"' & formatterService.formatDateTime(getDtDOB()) & '"');
		sb.append(', "vcGender":' & serializeJSON(getVcGender()));
		sb.append(', "vcInsuranceProvider":' & serializeJSON(getVcInsuranceProvider()));
		sb.append(', "dtLastLoggedInOn":"' & formatterService.formatDateTime(getDtLastLoggedInOn()) & '"');
		sb.append("}");
		return sb.toString();
	}

	public boolean function isLoggedIn() {
		return variables.isLoggedIn;
	}
}

