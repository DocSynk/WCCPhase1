<cfcomponent name="accountGateway" extends="app.model.gateway.baseGateway">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="account" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblAccount
			(
				  intPatientID		/*  - int*/
				, intPracticeID		/*  - int*/
				, vcMRN				/*  - varchar(100)*/
				, vcFirstName		/*  - varchar(250)*/
				, vcLastName		/*  - varchar(250)*/
				, vcCellPhone		/*  - varchar(25)*/
				, dtDOB			/*  - datetime*/
				, vcGender		/*  - varchar(100)*/
				, vcInsuranceProvider	/*  - varchar(250)*/
				, dtLastLoggedInOn	/*  - datetime*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account.getIntPatientID()#"/>	/* intPatientID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account.getIntPracticeID()#"/>	/* intPracticeID - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcMRN()#"/>	/* vcMRN - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcFirstName()#"/>	/* vcFirstName - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcLastName()#"/>	/* vcLastName - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcCellPhone()#"/>	/* vcCellPhone - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.account.getDtDOB()#"/>	/* dtDOB - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcGender()#"/>	/* vcGender - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcInsuranceProvider()#"/>	/* vcInsuranceProvider - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.account.getDtLastLoggedInOn()#"/>	/* dtLastLoggedInOn - datetime */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="account" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblAccount
			SET
				  intPatientID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account.getIntPatientID()#"/>	/* intPatientID - int */
				, intPracticeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account.getIntPracticeID()#"/>	/* intPracticeID - int */
				, vcMRN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcMRN()#"/> /* vcMRN - varchar(100) */
				, vcFirstName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcFirstName()#"/>	/* vcFirstName - varchar (250) */
				, vcLastName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcLastName()#"/>	/* vcLastName - varchar (250) */
				, vcCellPhone = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcCellPhone()#"/>	/* vcCellPhone - varchar (25) */
				, dtDOB = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.account.getDtDOB()#"/>	/* dtDOB - datetime */
				, vcGender = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcGender()#"/>	/* vcGender - varchar (100) */
				, vcInsuranceProvider = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.account.getVcInsuranceProvider()#"/>	/* vcInsuranceProvider - varchar (250) */
				, dtLastLoggedInOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.account.getDtLastLoggedInOn()#"/>	/* dtLastLoggedInOn - datetime */
			WHERE 
				intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.account.getIntAccountID()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intAccountID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAccount.intAccountID		/*  - int*/
				, tblAccount.intPatientID		/*  - int*/
				, tblAccount.intPracticeID		/*  - int*/
				, tblAccount.vcMRN				/*  - varchar(100)*/
				, tblAccount.vcFirstName		/*  - varchar(250)*/
				, tblAccount.vcLastName		/*  - varchar(250)*/
				, tblAccount.vcCellPhone		/*  - varchar(25)*/
				, tblAccount.dtDOB			/*  - datetime*/
				, tblAccount.vcGender		/*  - varchar(100)*/
				, tblAccount.vcInsuranceProvider	/*  - varchar(250)*/
				, tblAccount.dtLastLoggedInOn	/*  - datetime*/
			FROM dbo.tblAccount
			WHERE
				tblAccount.intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAccountID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadByMRN" access="public" returntype="query" output="false">
		<cfargument name="mrn" type="string" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAccount.intAccountID		/*  - int*/
				, tblAccount.intPatientID		/*  - int*/
				, tblAccount.intPracticeID		/*  - int*/
				, tblAccount.vcMRN				/*  - varchar(100)*/
				, tblAccount.vcFirstName		/*  - varchar(250)*/
				, tblAccount.vcLastName		/*  - varchar(250)*/
				, tblAccount.vcCellPhone		/*  - varchar(25)*/
				, tblAccount.dtDOB			/*  - datetime*/
				, tblAccount.vcGender		/*  - varchar(100)*/
				, tblAccount.vcInsuranceProvider	/*  - varchar(250)*/
				, tblAccount.dtLastLoggedInOn	/*  - datetime*/
			FROM dbo.tblAccount
			WHERE
				tblAccount.vcMRN = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.mrn#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblAccount.intAccountID		/*  - int*/
				, tblAccount.intPatientID		/*  - int*/
				, tblAccount.intPracticeID		/*  - int*/
				, tblAccount.vcMRN				/*  - varchar(100)*/
				, tblAccount.vcFirstName		/*  - varchar(250)*/
				, tblAccount.vcLastName		/*  - varchar(250)*/
				, tblAccount.vcCellPhone		/*  - varchar(25)*/
				, tblAccount.dtDOB			/*  - datetime*/
				, tblAccount.vcGender		/*  - varchar(100)*/
				, tblAccount.vcInsuranceProvider	/*  - varchar(250)*/
				, tblAccount.dtLastLoggedInOn	/*  - datetime*/
			FROM dbo.tblAccount
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="loadByLoginCredentials" access="public" returntype="query" output="false">
		<cfargument name="lastName" type="string" required="true" />
		<cfargument name="dob" type="date" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAccount.intAccountID	/*  - int*/
				, tblAccount.intPatientID			/*  - int*/
				, tblAccount.intPracticeID			/*  - int*/
				, tblAccount.vcMRN				/*  - varchar(100)*/
				, tblAccount.vcFirstName			/*  - varchar(250)*/
				, tblAccount.vcLastName			/*  - varchar(250)*/
				, tblAccount.vcCellPhone			/*  - varchar(25)*/
				, tblAccount.dtDOB				/*  - datetime*/
				, tblAccount.vcGender			/*  - varchar(100)*/
				, tblAccount.vcInsuranceProvider		/*  - varchar(250)*/
				, tblAccount.dtLastLoggedInOn		/*  - datetime*/
			FROM dbo.tblAccount
			WHERE
				tblAccount.vcLastName = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastName#" />
			AND tblAccount.dtDOB = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.dob#" />

		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="updateLastLoggedIn" access="public" returntype="void" output="false">
		<cfargument name="accountID" type="numeric" required="True" />

		<cfquery name="local.qUpdateLastLoggedIn">
			UPDATE
				tblAccount
			SET dtLastLoggedInOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>
			WHERE
				intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.accountID#"/>
		</cfquery>
	</cffunction>

	<cffunction name="logAuthenticationAttempt" access="public" returntype="void" output="false">
		<cfargument name="httpHost" type="string" required="True" />
		<cfargument name="userAgent" type="string" required="True" />
		<cfargument name="lastName" type="string" required="True" />
		<cfargument name="wasSuccessful" type="boolean" required="True" />
		<cfargument name="ipAddress" type="string" required="True" />
		<cfargument name="accountID" type="numeric" required="True" />

		<cfquery name="local.qLogAuthenticationAttempt">
			INSERT INTO tblAuthenticationAttempts
			(
				  vcHttpHost
				, vcUsername
				, btWasSuccessful
				, intAccountID
				, dtAttemptedOn
				, vcAttemptedIP
				, vcUserAgent
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.httpHost#"/>
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastName#"/>
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.wasSuccessful#"/>
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.accountID#"/>
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ipAddress#"/>
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.userAgent#"/>
			)
		</cfquery>

	</cffunction>

	<cffunction name="insertImportAccount" access="public" returntype="numeric" output="false">
		<cfargument name="intPatientID" type="numeric" required="True" />
		<cfargument name="vcMRN" type="string" required="True" />
		<cfargument name="vcFirstName" type="string" required="True" />
		<cfargument name="vcLastName" type="string" required="True" />
		<cfargument name="dtDOB" type="datetime" required="True" />

		<cfquery name="local.qInsert" result="local.qInsertResult">
			INSERT INTO dbo.tblAccount
			(
				  intPatientID		/*  - int*/
				, intPracticeID		/*  - int*/
				, vcMRN				/*  - varchar(100)*/
				, vcFirstName		/*  - varchar(250)*/
				, vcLastName		/*  - varchar(250)*/
				, vcCellPhone		/*  - varchar(25)*/
				, dtDOB			/*  - datetime*/
				, vcGender		/*  - varchar(100)*/
				, vcInsuranceProvider	/*  - varchar(250)*/
				, dtLastLoggedInOn	/*  - datetime*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intPatientID#"/>	/* intPatientID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="1"/>	/* intPracticeID - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcMRN#"/>	/* vcMRN - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcFirstName#"/>	/* vcFirstName - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcLastName#"/>	/* vcLastName - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value=""/>	/* vcCellPhone - varchar (25) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.dtDOB#"/>	/* dtDOB - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value=""/>	/* vcGender - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value=""/>	/* vcInsuranceProvider - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="1970-01-01 00:00:00.000"/>	/* dtLastLoggedInOn - datetime */
			);
		</cfquery>

	<cfreturn local.qInsertResult.generatedKey />
	</cffunction>

</cfcomponent>