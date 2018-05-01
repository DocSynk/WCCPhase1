<cfcomponent name="addresGateway" extends="app.model.gateway.baseGateway">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="addres" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblAddress
			(
				  intAccountID	/*  - int*/
				, vcAddressType	/*  - varchar(250)*/
				, vcAddress1	/*  - varchar(250)*/
				, vcAddress2	/*  - varchar(250)*/
				, vcCity	/*  - varchar(250)*/
				, vcState	/*  - varchar(100)*/
				, vcPostalCode	/*  - varchar(10)*/
				, vcCountry	/*  - varchar(250)*/
				, dtCreatedOn	/*  - datetime*/
				, intCreatedBy	/*  - int*/
				, dtModifiedOn	/*  - datetime*/
				, intModifiedBy	/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntAccountID()#"/>	/* intAccountID - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcAddressType()#"/>	/* vcAddressType - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcAddress1()#"/>	/* vcAddress1 - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcAddress2()#"/>	/* vcAddress2 - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcCity()#"/>	/* vcCity - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcState()#"/>	/* vcState - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcPostalCode()#"/>	/* vcPostalCode - varchar (10) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcCountry()#"/>	/* vcCountry - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.addres.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.addres.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntModifiedBy()#"/>	/* intModifiedBy - int */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="addres" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblAddress
			SET
				  intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntAccountID()#"/>	/* intAccountID - int */
				, vcAddressType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcAddressType()#"/>	/* vcAddressType - varchar (250) */
				, vcAddress1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcAddress1()#"/>	/* vcAddress1 - varchar (250) */
				, vcAddress2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcAddress2()#"/>	/* vcAddress2 - varchar (250) */
				, vcCity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcCity()#"/>	/* vcCity - varchar (250) */
				, vcState = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcState()#"/>	/* vcState - varchar (100) */
				, vcPostalCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcPostalCode()#"/>	/* vcPostalCode - varchar (10) */
				, vcCountry = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.addres.getVcCountry()#"/>	/* vcCountry - varchar (250) */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.addres.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, intCreatedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntCreatedBy()#"/>	/* intCreatedBy - int */
				, dtModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.addres.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
				, intModifiedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntModifiedBy()#"/>	/* intModifiedBy - int */
			WHERE 
				intAddressID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.addres.getIntAddressID()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intAddressID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAddress.intAddressID	/*  - int*/
				, tblAddress.intAccountID	/*  - int*/
				, tblAddress.vcAddressType	/*  - varchar(250)*/
				, tblAddress.vcAddress1	/*  - varchar(250)*/
				, tblAddress.vcAddress2	/*  - varchar(250)*/
				, tblAddress.vcCity	/*  - varchar(250)*/
				, tblAddress.vcState	/*  - varchar(100)*/
				, tblAddress.vcPostalCode	/*  - varchar(10)*/
				, tblAddress.vcCountry	/*  - varchar(250)*/
				, tblAddress.dtCreatedOn	/*  - datetime*/
				, tblAddress.intCreatedBy	/*  - int*/
				, tblAddress.dtModifiedOn	/*  - datetime*/
				, tblAddress.intModifiedBy	/*  - int*/
			FROM dbo.tblAddress
			WHERE
				tblAddress.intAddressID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAddressID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblAddress.intAddressID	/*  - int*/
				, tblAddress.intAccountID	/*  - int*/
				, tblAddress.vcAddressType	/*  - varchar(250)*/
				, tblAddress.vcAddress1	/*  - varchar(250)*/
				, tblAddress.vcAddress2	/*  - varchar(250)*/
				, tblAddress.vcCity	/*  - varchar(250)*/
				, tblAddress.vcState	/*  - varchar(100)*/
				, tblAddress.vcPostalCode	/*  - varchar(10)*/
				, tblAddress.vcCountry	/*  - varchar(250)*/
				, tblAddress.dtCreatedOn	/*  - datetime*/
				, tblAddress.intCreatedBy	/*  - int*/
				, tblAddress.dtModifiedOn	/*  - datetime*/
				, tblAddress.intModifiedBy	/*  - int*/
			FROM dbo.tblAddress
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="loadByAccountID" access="public" returntype="query" output="false">
		<cfargument name="accountID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAddress.intAddressID	/*  - int*/
				, tblAddress.intAccountID	/*  - int*/
				, tblAddress.vcAddressType	/*  - varchar(250)*/
				, tblAddress.vcAddress1	/*  - varchar(250)*/
				, tblAddress.vcAddress2	/*  - varchar(250)*/
				, tblAddress.vcCity	/*  - varchar(250)*/
				, tblAddress.vcState	/*  - varchar(100)*/
				, tblAddress.vcPostalCode	/*  - varchar(10)*/
				, tblAddress.vcCountry	/*  - varchar(250)*/
				, tblAddress.dtCreatedOn	/*  - datetime*/
				, tblAddress.intCreatedBy	/*  - int*/
				, tblAddress.dtModifiedOn	/*  - datetime*/
				, tblAddress.intModifiedBy	/*  - int*/
			FROM dbo.tblAddress
			WHERE
				tblAddress.intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.accountID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="insertImportAddress" access="public" returntype="void" output="false">
		<cfargument name="intAccountID" type="numeric" required="true" />
		<cfargument name="vcAddress1" type="string" required="true" />
		<cfargument name="vcAddress2" type="string" required="true" />
		<cfargument name="vcCity" type="string" required="true" />
		<cfargument name="vcState" type="string" required="true" />
		<cfargument name="vcPostalCode" type="string" required="true" />

		<cfquery name="local.qInsert">
			INSERT INTO dbo.tblAddress
			(
				  intAccountID	/*  - int*/
				, vcAddressType	/*  - varchar(250)*/
				, vcAddress1	/*  - varchar(250)*/
				, vcAddress2	/*  - varchar(250)*/
				, vcCity	/*  - varchar(250)*/
				, vcState	/*  - varchar(100)*/
				, vcPostalCode	/*  - varchar(10)*/
				, vcCountry	/*  - varchar(250)*/
				, dtCreatedOn	/*  - datetime*/
				, intCreatedBy	/*  - int*/
				, dtModifiedOn	/*  - datetime*/
				, intModifiedBy	/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAccountID#"/>	/* intAccountID - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="HOME"/>	/* vcAddressType - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcAddress1#"/>	/* vcAddress1 - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcAddress2#"/>	/* vcAddress2 - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcCity#"/>	/* vcCity - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcState#"/>	/* vcState - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.vcPostalCode#"/>	/* vcPostalCode - varchar (10) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="US"/>	/* vcCountry - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="0"/>	/* intCreatedBy - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="1970-01-01 00:00:00.000"/>	/* dtModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="0"/>	/* intModifiedBy - int */
			);
		</cfquery>

	</cffunction>

</cfcomponent>