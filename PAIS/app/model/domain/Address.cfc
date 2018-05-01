component name="Addres" accessors="true" extends="BaseDomain" {

	property Numeric intAddressID;
	property Numeric intAccountID;
	property String vcAddressType;
	property String vcAddress1;
	property String vcAddress2;
	property String vcCity;
	property String vcState;
	property String vcPostalCode;
	property String vcCountry;
	property date dtCreatedOn;
	property Numeric intCreatedBy;
	property date dtModifiedOn;
	property Numeric intModifiedBy;

	public any function init () {

		setIDField("intAddressID");

		setIntAddressID(0);
		setIntAccountID(0);
		setVcAddressType("");
		setVcAddress1("");
		setVcAddress2("");
		setVcCity("");
		setVcState("");
		setVcPostalCode("");
		setVcCountry("");
		setDtCreatedOn(variables.instance.never);
		setIntCreatedBy(0);
		setDtModifiedOn(variables.instance.never);
		setIntModifiedBy(0);

		return this;
	}

	public string function toJSON() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAddressID":' & getIntAddressID());
		sb.append(', "intAccountID":' & getIntAccountID());
		sb.append(', "vcAddressType":' & serializeJSON(getVcAddressType()));
		sb.append(', "vcAddress1":' & serializeJSON(getVcAddress1()));
		sb.append(', "vcAddress2":' & serializeJSON(getVcAddress2()));
		sb.append(', "vcCity":' & serializeJSON(getVcCity()));
		sb.append(', "vcState":' & serializeJSON(getVcState()));
		sb.append(', "vcPostalCode":' & serializeJSON(getVcPostalCode()));
		sb.append(', "vcCountry":' & serializeJSON(getVcCountry()));
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "intModifiedBy":' & getIntModifiedBy());
		sb.append("}");
		return sb.toString();
	}

	public string function toJSONSimple() {
		var sb = createObject("java","java.lang.StringBuffer").init("{");
		sb.append('"intAddressID":' & getIntAddressID());
		sb.append(', "intAccountID":' & getIntAccountID());
		sb.append(', "vcAddressType":' & serializeJSON(getVcAddressType()));
		sb.append(', "vcAddress1":' & serializeJSON(getVcAddress1()));
		sb.append(', "vcAddress2":' & serializeJSON(getVcAddress2()));
		sb.append(', "vcCity":' & serializeJSON(getVcCity()));
		sb.append(', "vcState":' & serializeJSON(getVcState()));
		sb.append(', "vcPostalCode":' & serializeJSON(getVcPostalCode()));
		sb.append(', "vcCountry":' & serializeJSON(getVcCountry()));
		sb.append(', "dtCreatedOn":"' & formatterService.formatDateTime(getDtCreatedOn()) & '"');
		sb.append(', "intCreatedBy":' & getIntCreatedBy());
		sb.append(', "dtModifiedOn":"' & formatterService.formatDateTime(getDtModifiedOn()) & '"');
		sb.append(', "intModifiedBy":' & getIntModifiedBy());
		sb.append("}");
		return sb.toString();
	}

}

