component name="auditLogService" accessors="true" extends="baseService" {

	property any auditLogGateway;
	property any util;
	property any beanFactory;

	public void function logAction (
	    required String action
	  , required String category
	  , required String subcategory
	  , String data = ""
	  , String IPaddress = util.getRemoteIP()
	  , String userAgent = cgi.http_user_agent
	  , String latitude = ""
	  , String longitude = ""
	  , Numeric appointmentID = 0
	  , Numeric accountID = 0
	  , Numeric dashboardLoginID = 0
	  , Numeric addressID = 0
	  , Numeric missedAppointmentTypeID = 0
	  , Boolean transportArranged = 0) {

		var a = arguments;

		auditLogGateway.logAction(argumentCollection = a);
	}

	private any function create (required any auditLog) {

		var intAuditLogID = auditLogGateway.create(auditLog);

		return load(intAuditLogID);
	}

	private any function update (required any auditLog) {

		auditLogGateway.update(arguments.auditLog);

		return load(auditLog.getIntAuditLogID());
	}

	public any function save (required any auditLog) {

		if (auditLog.getIntAuditLogID()) {
			return update(arguments.auditLog);
		} else {
			return create(arguments.auditLog);
		}
	}

	public any function getEmptyDomain () {

		return beanFactory.getBean("AuditLog");
	}

	public any function populate (required any auditLog, required struct data ) {

		auditLog.setIntAuditLogID(data.intAuditLogID);
		auditLog.setDtTS(data.dtTS);
		auditLog.setVcAction(data.vcAction);
		auditLog.setVcCategory(data.vcCategory);
		auditLog.setVcSubcategory(data.vcSubcategory);
		auditLog.setVcData(data.vcData);
		auditLog.setVcIPAddress(data.vcIPAddress);
		auditLog.setVcUserAgent(data.vcUserAgent);
		auditLog.setVcLatitude(data.vcLatitude);
		auditLog.setVcLongitude(data.vcLongitude);
		auditLog.setIntAppointmentID(data.intAppointmentID);
		auditLog.setIntAccountID(data.intAccountID);
		auditLog.setIntDashboardLoginID(data.intDashboardLoginID);
		auditLog.setIntAddressID(data.intAddressID);
		auditLog.setIntMissedAppointmentTypeID(data.setIntMissedAppointmentTypeID);
		auditLog.setBtTransportArranged(data.btTransportArranged);
		auditLog.setDtCreatedOn(data.dtCreatedOn);
		auditLog.setIntCreatedBy(data.intCreatedBy);

		return auditLog;
	}

	public any function load (required numeric intAuditLogID ) {

		var auditLog = getEmptyDomain();

		if (intAuditLogID == 0) {
			return auditLog;
		}

		var qLoad = auditLogGateway.load(intAuditLogID);

		if (qLoad.recordCount) {
			return populate(auditLog, queryRowData(qLoad, 1));
		}

		return local.auditLog;
	}

	public array function loadAll () {

		var output = [];

		var qLoadAll = auditLogGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

}