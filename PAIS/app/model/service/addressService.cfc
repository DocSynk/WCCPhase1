component name="addressService" accessors="true" extends="baseService" {

	property any addressGateway;

	property any beanFactory;

	private any function create (required any address) {

		var intAddressID = addressGateway.create(address);

		return load(intAddressID);
	}

	private any function update (required any address) {

		addressGateway.update(arguments.address);

		return load(address.getIntAddressID());
	}

	public any function save (required any address) {

		if (address.getIntAddressID()) {
			return update(arguments.address);
		} else {
			return create(arguments.address);
		}
	}

	public any function getEmptyDomain () {

		return beanFactory.getBean("Address");
	}

	public any function populate (required any address, required struct data ) {

		address.setIntAddressID(data.intAddressID);
		address.setIntAccountID(data.intAccountID);
		address.setVcAddressType(data.vcAddressType);
		address.setVcAddress1(data.vcAddress1);
		address.setVcAddress2(data.vcAddress2);
		address.setVcCity(data.vcCity);
		address.setVcState(data.vcState);
		address.setVcPostalCode(data.vcPostalCode);
		address.setVcCountry(data.vcCountry);
		address.setDtCreatedOn(data.dtCreatedOn);
		address.setIntCreatedBy(data.intCreatedBy);
		address.setDtModifiedOn(data.dtModifiedOn);
		address.setIntModifiedBy(data.intModifiedBy);

		return address;
	}

	public any function load (required numeric intAddressID ) {

		var address = getEmptyDomain();

		if (intAddressID == 0) {
			return address;
		}

		var qLoad = addressGateway.load(intAddressID);

		if (qLoad.recordCount) {
			return populate(address, queryRowData(qLoad, 1));
		}

		return local.address;
	}

	public array function loadAll () {

		var output = [];

		var qLoadAll = addressGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public array function loadByAccountID (required numeric accountID) {
		var output = [];

		var qLoadByAccountID = addressGateway.loadByAccountID(accountID);

		for (var row in qLoadByAccountID) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public any function importLoadByAccountID (required numeric accountID) {
		var output = 0;

		var qLoadByAccountID = addressGateway.loadByAccountID(accountID);

		if (qLoadByAccountID.recordCount) {
			output = 1;
		}

		return output;
	}

	public any function insertImportAddress (
		required numeric intAccountID
	  , required string vcAddress1
	  , required string vcAddress2
	  , required string vcCity
	  , required string vcState
	  , required string vcPostalCode) {

		addressGateway.insertImportAddress(intAccountID, vcAddress1, vcAddress2, vcCity, vcState, vcPostalCode);

		return;
	}

}