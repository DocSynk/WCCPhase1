component name="accountService" accessors="true" extends="baseService" {

	property any accountGateway;

	property any beanFactory;

	private any function create (required any account) {

		var intAccountID = accountGateway.create(account);

		return load(intAccountID);
	}

	private any function update (required any account) {

		accountGateway.update(arguments.account);

		return load(account.getIntAccountID());
	}

	public any function save (required any account) {

		if (account.getIntAccountID()) {
			return update(arguments.account);
		} else {
			return create(arguments.account);
		}
	}

	public any function getEmptyDomain () {

		return beanFactory.getBean("Account");
	}

	public any function populate (required any account, required struct data ) {

		account.setIntAccountID(data.intAccountID);
		account.setIntPatientID(data.intPatientID);
		account.setIntPracticeID(data.intPracticeID);
		account.setVcMRN(data.vcMRN);
		account.setVcFirstName(data.vcFirstName);
		account.setVcLastName(data.vcLastName);
		account.setVcCellPhone(data.vcCellPhone);
		account.setDtDOB(data.dtDOB);
		account.setVcGender(data.vcGender);
		account.setVcInsuranceProvider(data.vcInsuranceProvider);
		account.setDtLastLoggedInOn(data.dtLastLoggedInOn);

		return account;
	}

	public any function load (required numeric intAccountID ) {

		var account = getEmptyDomain();

		if (intAccountID == 0) {
			return account;
		}

		var qLoad = accountGateway.load(intAccountID);

		if (qLoad.recordCount) {
			return populate(account, queryRowData(qLoad, 1));
		}

		return local.account;
	}

	public any function loadByMRN (required string MRN) {
		var account = getEmptyDomain();

		if (MRN == "") {
			return account;
		}

		var qLoad = accountGateway.loadByMRN(MRN);

		if (qLoad.recordCount) {
			return populate(account, queryRowData(qLoad, 1));
		}

		return local.account;
	}

	public array function loadAll () {

		var output = [];

		var qLoadAll = accountGateway.loadAll();

		for (var row in qLoadAll) {
			arrayAppend(output, populate(getEmptyDomain(), row));
		}

		return output;
	}

	public any function insertImportAccount (
		required numeric intPatientID
	  , required string vcMRN
	  , required string vcFirstName
	  , required string vcLastName
	  , required date dtDOB) {

		var accountID = accountGateway.insertImportAccount(intPatientID, vcMRN, vcFirstName, vcLastName, dtDOB);

		return accountID;
	}

	public any function authenticateLogin (
		required string lastName
		, required date dob
		, required string ipAddress
		, required string httpHost
		, required string userAgent) {

		var local.qLogin = accountGateway.loadByLoginCredentials(lastName = lastName, dob = dob);
		var local.account = load(0);

		if (local.qLogin.recordCount EQ 1) {
			accountGateway.updateLastLoggedIn(local.qLogin.intAccountID);
			local.account = load(local.qLogin.intAccountID);
			local.account.setIsLoggedIn(true);
		}

		accountGateway.logAuthenticationAttempt(httpHost, userAgent, lastName, local.account.isLoggedIn(), ipAddress, local.account.getIntAccountID());

		return account;
	}

}