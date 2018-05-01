component name="AuditLog" accessors="true" extends="BaseDomain" {

	property Numeric intAuditLogID;
	property date dtTS;
	property String vcAction;
	property String vcCategory;
	property String vcSubcategory;
	property String vcData;
	property String vcIPAddress;
	property String vcUserAgent;
	property String vcLatitude;
	property String vcLongitude;
	property Numeric intAppointmentID;
	property Numeric intAccountID;
	property Numeric intDashboardLoginID;
	property Numeric intAddressID;
	property Numeric intMissedAppointmentTypeID;
	property boolean btTransportArranged;
	property date dtCreatedOn;
	property Numeric intCreatedBy;

	public any function init () {

		setIDField("intAuditLogID");

		setIntAuditLogID(0);
		setDtTS(variables.instance.never);
		setVcAction("");
		setVcCategory("");
		setVcSubcategory("");
		setVcData("");
		setVcIPAddress("");
		setVcUserAgent("");
		setVcLatitude("");
		setVcLongitude("");
		setIntAppointmentID(0);
		setIntAccountID(0);
		setIntDashboardID(0);
		setIntAddressID(0);
		setIntMissedAppointmentTypeID(0);
		setBtTransportArranged(false);
		setDtCreatedOn(variables.instance.never);
		setIntCreatedBy(0);

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAuditLogID":' & getIntAuditLogID());
		sb.append(', "dtTS":"' & formatterService.formatDateTime(getDtTS()) & '"');
		sb.append(', "vcAction":' & serializeJSON(getVcAction()));
		sb.append(', "vcCategory":' & serializeJSON(getVcCategory()));
		sb.append(', "vcSubcategory":' & serializeJSON(getVcSubcategory()));
		sb.append(', "vcData":' & serializeJSON(getVcData()));
		sb.append(', "vcIPAddress":' & serializeJSON(getVcIPAddress()));
		sb.append(', "vcUserAgent":' & serializeJSON(getVcUserAgent()));
		sb.append(', "vcLatitude":' & serializeJSON(getVcLatitude()));
		sb.append(', "vcLongitude":' & serializeJSON(getVcLongitude()));
		sb.append(', "intAppointmentID":' & getIntAppointmentID());
		sb.append(', "intAccountID":' & getIntAccountID());
		sb.append(', "intDashboardLoginID":' & getIntDashboardLoginID());
		sb.append(', "intAddressID":' & getIntAddressID());
		sb.append(', "intMissedAppointmentTypeID":' & serializeJSON(getIntMissedAppointmentTypeID()));
		sb.append(', "btTransportArranged":' & (getBtTransportArranged() ? 'true' : 'false'));
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAuditLogID":' & getIntAuditLogID());
		sb.append(', "dtTS":"' & formatterService.formatDateTime(getDtTS()) & '"');
		sb.append(', "vcAction":' & serializeJSON(getVcAction()));
		sb.append(', "vcCategory":' & serializeJSON(getVcCategory()));
		sb.append(', "vcSubcategory":' & serializeJSON(getVcSubcategory()));
		sb.append(', "vcData":' & serializeJSON(getVcData()));
		sb.append(', "vcIPAddress":' & serializeJSON(getVcIPAddress()));
		sb.append(', "vcUserAgent":' & serializeJSON(getVcUserAgent()));
		sb.append(', "vcLatitude":' & serializeJSON(getVcLatitude()));
		sb.append(', "vcLongitude":' & serializeJSON(getVcLongitude()));
		sb.append(', "intAppointmentID":' & getIntAppointmentID());
		sb.append(', "intAccountID":' & getIntAccountID());
		sb.append(', "intDashboardLoginID":' & getIntDashboardLoginID());
		sb.append(', "intAddressID":' & getIntAddressID());
		sb.append(', "intMissedAppointmentTypeID":' & serializeJSON(getIntMissedAppointmentTypeID()));
		sb.append(', "btTransportArranged":' & (getBtTransportArranged() ? 'true' : 'false'));
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append("}");
		return sb.toString();
	}

	public boolean function btTransportArranged() {
		return variables.btTransportArranged;
	}
}

