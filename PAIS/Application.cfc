component extends="./lib/framework/one" {

	this.name = 'pais' & hash(getCurrentTemplatePath());

	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,6,0,0);
	this.applicationTimeout = createTimeSpan(2,0,0,0);
	this.compression = true; //Enable compression (GZip) for the Railo Response stream for text-based responses when supported by the browser

	this.mappings["/base"] = getBasePath();
	this.mappings["/app"] = this.mappings["/base"] & "app\";
	this.mappings["/lib"] = this.mappings["/base"] & "lib\";
	this.mappings["/domain"] = this.mappings["/app"] & "model\domain\";

	this.defaultDatasource = "PAIS";

	/*this.javaSettings = {
		LoadPaths = ["/lib/jar"]
	};*/

	function getBasePath () {
		return reverse(reverse(replaceNoCase(getDirectoryFromPath(getCurrentTemplatePath()),"\","/","all")));
	}

	//todo: see if we can limit the number of times we have to repeat the application name
	variables.defaultAppConfig = {
		  dbVendor = "MSSQL"                          //MSSQL, PGSQL, etc...
		, defaultOrganizationID = 1
		, applicationDisplayName = "West Clinic TextBot"
		, never = createDateTime(1970,1,1,0,0,0)
		, dateFormatMask = "yyyy-mm-dd"
		, timeFormatMask = "h:mm tt"
		, forgotPasswordEmailFrom = "donotreply@mind-over-data.com"
		, passwordRotation = 0 //you cannot use any of your last 5 passwords
		, loginInstructionsEmailFrom = "donotreply@mind-over-data.com"
		, loginURL = "http://pais.mod-llc.com/main/login"
		, security_nonSecuredSections = []
		, security_nonSecuredItems = ["main.robots", "main.ajaxGetPatientAppts", "main.ajaxUpdateAppt", "main.ajaxLogUberRequest", "main.importPatientData", "main.addFakeAppointments"] //the loginFormItem, loginSubmitItem and logoutSubmitItem will be automatically added ot this list
		, security_loginFormItem = "main.login"
		, security_loginSubmitItem = "main.loginSubmit"
		, security_logoutSubmitItem = "main.logout"
		, security_resetPasswordFormItem = "main.changePassword"
		//datasources
	};

	function getAppConfig() {

		//var appConfig = duplicate(variables.defaultAppConfig);

		if (isNull(variables.defaultAppConfig.dbVendor)) {
			throw(message="You must set dbVendor in variables.defaultAppConfig in application.cfc");
		}

		appConfig.env = getEnvironment();

		switch (appConfig.env) {
			case "dev" :

				break;
			default:
				break;
		}

		return appConfig;
	}

	variables.framework = {
		applicationKey = 'fw1base',                     //A unique value for each FW/1 application that shares a common ColdFusion application name.
		base = "/app",                                  //getDirectoryFromPath( CGI.SCRIPT_NAME ).replace( getContextRoot(), '' )
		action = 'actn',
		//usingSubsystems = false,
		//defaultSubsystem = 'home',
		//defaultSection = 'main',
		defaultItem = 'index',
		//subsystemDelimiter = ':',
		//siteWideLayoutSubsystem = 'common',
		home = 'main.index',                            // defaultSection & '.' & defaultItem
														// or: defaultSubsystem & subsystemDelimiter & defaultSection & '.' & defaultItem
		error = 'main.error',                           // defaultSection & '.error'
														// or: defaultSubsystem & subsystemDelimiter & defaultSection & '.error'
		reload = 'fwreinit',
		password = 'true',
		reloadApplicationOnEveryRequest = false,
		generateSES = true,
		SESOmitIndex = true,                            // ==true needs appropriate rewrite rules in apache httpd/iis
		//baseURL = 'useCgiScriptName',
		cfcbase = 'app',
		diEngine = 'di1',
		diComponent = 'lib.framework.ioc',
		diLocations = "/app/model",
		diConfig = {constants=variables.defaultAppConfig, transients=["domain"], initMethod="configure"},
		//suppressImplicitService = true,
		//unhandledExtensions = 'cfc',
		unhandledPaths = '/flex2gateway,/mxunit,/remote',
		//unhandledErrorCaught = false,
		preserveKeyURLKey = 'fw1pk',
		//maxNumContextsPreserved = 10,
		//cacheFileExists = false,                    //If you are running on a system where disk access is slow – or you simply want to avoid several calls to fileExists() during requests for performance – you can set this to true and FW/1 will cache all its calls to fileExists(). Be aware that if the result of fileExists() is cached and you add a new layout or a new view, it won’t be noticed until you reload the framework.
		trace = false                                  //If true, FW/1 will print out debugging / tracing information at the bottom of each page. This can be very useful for debugging your application! Note that you must enable session management in your application if you use this feature
	};

	variables.framework.routes = [
		{ "/userManagement/userDetail/userID/:userID" = "302:/userManagement/userDetail/:userID"},
		{ "/userManagement/userDetail/:userID" = "/userManagement/userDetail/userID/:userID"},
		{ "/userManagement/userUpdate/userID/:userID" = "302:/userManagement/userUpdate/:userID"},
		{ "/userManagement/userUpdate/:userID" = "/userManagement/userUpdate/userID/:userID"},
		{ "/userManagement/groupDetail/:groupID" = "/userManagement/groupDetail/groupID/:groupID"},
		{ "/userManagement/groupUpdate/groupID/:groupID" = "302:/userManagement/groupUpdate/:groupID"},
		{ "/userManagement/groupUpdate/:groupID" = "/userManagement/groupUpdate/groupID/:groupID"},

	];

	function setupApplication() {

		application.beanFactory = getBeanFactory();

		var config = getAppConfig();
		for (var c in config) {
			application.beanFactory.addBean(c, config[c]);
		}

		switch (variables.defaultAppConfig.dbVendor) {
			case "MSSQL" :
				setupGatewaysForDBVendor(application.beanFactory, 'MSSQL');
				break;
			default :
				throw(type="InvalidConfigException", message="DBVendor #variables.defaultAppConfig.dbVendor# is not currently supported.");
			break;
		}

	}

	private function setupGatewaysForDBVendor (beanfactory, DBVendorPrefix) {
		var gatewayDir = expandPath('/app/model/gateway/' & DBVendorPrefix & '/');
		var gateways = directoryList(gatewayDir);
		for (var filename in gateways) {
			filename = filename.replace(gatewayDir, '', 'all').replaceNoCase('.cfc', '');

			if (filename.findNoCase('Gateway') && filename.findNoCase('_' & DBVendorPrefix)) {
				beanfactory.addAlias(replaceNoCase(filename, '_' & DBVendorPrefix, ''), filename);
			}
		}
	}

	function setupSession() {
		controller('main.setupSession');
	}


	function setupRequest() {
		//variables scope data will be accessible inside views and layouts but not controllers or services
		if ((!isNull(url.clearLogin) && url.clearLogin == true)
				|| (!isNull(url.clearSession) && url.clearSession == true)) {
			setupSession();
		}
		controller('main.checkAuthorization');
	}

	function getEnvironment() {

		//you can also use getHostname() to return env based on server's hostname

		if ( reFindNoCase("^localhost*.", CGI.SERVER_NAME) ) return "dev";
		if ( reFindNoCase("^stage.*", CGI.SERVER_NAME) ) return "stage";
		if ( reFindNoCase("^stagecf10.*", CGI.SERVER_NAME) ) return "stage";

		return "prod";
	}

	variables.framework.environments = {
		"dev" = {},
		"stage" = {},
		"prod" = {
			reloadApplicationOnEveryRequest = false,
			cacheFileExists = true,
			trace = false
		}
	};

	function setupEnvironment( required String env ) {
		//NOTE: this code runs on every request!
		if (env == "prod") {
			//this.typeChecking = false;
		}
	}

	function onMissingView (rc) {
		if (findNoCase("ajax", request.missingView)) {
			return false;
		}
		//location("/");
		dump(request);
		dump(rc);
	}

}