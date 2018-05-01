<cfcomponent name="auditLogGateway" extends="app.model.gateway.baseGateway">

	<cffunction name="logAction" access="public" returntype="numeric" output="false">
		<cfargument name="action" type="String" required="true" />
		<cfargument name="category" type="String" required="true" />
		<cfargument name="subCategory" type="String" required="true" />
		<cfargument name="data" type="String" required="true" />
		<cfargument name="IPAddress" type="String" required="true" />
		<cfargument name="userAgent" type="String" required="true" />
		<cfargument name="latitude" type="String" required="true" />
		<cfargument name="longitude" type="String" required="true" />
		<cfargument name="appointmentID" type="Numeric" required="true" />
		<cfargument name="accountID" type="Numeric" required="true" />
		<cfargument name="dashboardLoginID" type="Numeric" required="true" />
		<cfargument name="addressID" type="Numeric" required="true" />
		<cfargument name="missedAppointmentTypeID" type="numeric" required="true" />
		<cfargument name="transportArranged" type="Boolean" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblAuditLog
			(
				  dtTS			/*  - datetime*/
				, vcAction		/*  - varchar(250)*/
				, vcCategory		/*  - varchar(250)*/
				, vcSubcategory		/*  - varchar(250)*/
				, vcData		/*  - varchar(-1)*/
				, vcIPAddress		/*  - varchar(50)*/
				, vcUserAgent		/*  - varchar(2000)*/
				, vcLatitude		/*  - varchar(100)*/
				, vcLongitude		/*  - varchar(100)*/
				, intAppointmentID	/*  - int*/
				, intAccountID		/*  - int*/
				, intDashboardLoginID		/*  - int*/
				, intAddressID		/*  - int*/
				, intMissedAppointmentTypeID	/*	- int*/
				, btTransportArranged	/*  - bit*/
				, dtCreatedOn		/*  - datetime*/
				, intCreatedBy		/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>	/* dtTS - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Action#"/>	/* vcAction - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Category#"/>	/* vcCategory - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Subcategory#"/>	/* vcSubcategory - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.Data#"/>	/* vcData - varchar (-1) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.IPAddress#"/>	/* vcPAddress - varchar (50) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.UserAgent#"/>	/* vcUserAgent - varchar (2000) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.latitude#"/>
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.longitude#"/>
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AppointmentID#"/>	/* intAppointmentID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AccountID#"/>	/* intAccountID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.DashboardLoginID#"/>	/* intDashboardLoginID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AddressID#"/>	/* intAddressID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.MissedAppointmentTypeID#"/>	/* intMissedAppointmentTypeID - int */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.TransportArranged#"/>	/* btTransportArranged - bit */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#now()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.AccountID#"/>	/* intCreatedBy - int */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />	
	</cffunction>

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="auditLog" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblAuditLog
			(
				  dtTS			/*  - datetime*/
				, vcAction		/*  - varchar(250)*/
				, vcCategory		/*  - varchar(250)*/
				, vcSubcategory		/*  - varchar(250)*/
				, vcData		/*  - varchar(-1)*/
				, vcIPAddress		/*  - varchar(50)*/
				, vcUserAgent		/*  - varchar(2000)*/
				, vcLatitude		/*  - varchar(100)*/
				, vcLongitude		/*  - varchar(100)*/
				, intAppointmentID	/*  - int*/
				, intAccountID		/*  - int*/
				, intDashboardLoginID		/*  - int*/
				, intAddressID		/*  - int*/
				, intMissedAppointmentTypeID	/*	- int*/
				, btTransportArranged	/*  - bit*/
				, dtCreatedOn		/*  - datetime*/
				, intCreatedBy		/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.auditLog.getDtTS()#"/>	/* dtTS - datetime */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcAction()#"/>	/* vcAction - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcCategory()#"/>	/* vcCategory - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcSubcategory()#"/>	/* vcSubcategory - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcData()#"/>	/* vcData - varchar (-1) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcIPAddress()#"/>	/* vcIPAddress - varchar (50) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcUserAgent()#"/>	/* vcUserAgent - varchar (2000) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcLatitude()#"/>	/* vcLatitude - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcLongitude()#"/>	/* vcLongitude - varchar (100) */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAppointmentID()#"/>	/* intAppointmentID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAccountID()#"/>	/* intAccountID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntDashboardLoginID()#"/>	/* intDashboardLoginID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAddressID()#"/>	/* intAddressID - int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntMissedAppointmentTypeID()#"/>	/* intMissedAppointmentTypeID - int */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.auditLog.getBtTransportArranged()#"/>	/* btTransportArranged - bit */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.auditLog.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntCreatedBy()#"/>	/* intCreatedBy - int */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="auditLog" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblAuditLog
			SET
				  dtTS = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.auditLog.getDtTS()#"/>	/* dtTS - datetime */
				, vcAction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcAction()#"/>	/* vcAction - varchar (250) */
				, vcCategory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcCategory()#"/>	/* vcCategory - varchar (250) */
				, vcSubcategory = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcSubcategory()#"/>	/* vcSubcategory - varchar (250) */
				, vcData = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcData()#"/>	/* vcData - varchar (-1) */
				, vcIPAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcIPAddress()#"/>	/* vcIPAddress - varchar (50) */
				, vcUserAgent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcUserAgent()#"/>	/* vcUserAgent - varchar (2000) */
				, vcLatitude = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcLatitude()#"/>	/* vcLatitude - varchar (100) */
				, vcLongitude = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.auditLog.getVcLongitude()#"/>	/* vcLongitude - varchar (100) */
				, intAppointmentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAppointmentID()#"/>	/* intAppointmentID - int */
				, intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAccountID()#"/>	/* intAccountID - int */
				, intDashboardLoginID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntDashboardLoginID()#"/> /* intDashboardLoginID - int */
				, intAddressID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAddressID()#"/>	/* intAddressID - int */
				, intMissedAppointmentTypeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntMissedAppointmentTypeID()#"/>	/* intMissedAppointmentTypeID - int */
				, btTransportArranged = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.auditLog.getBtTransportArranged()#"/>	/* btTransportArranged - bit */
				, dtCreatedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.auditLog.getDtCreatedOn()#"/>	/* dtCreatedOn - datetime */
				, intCreatedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntCreatedBy()#"/>	/* intCreatedBy - int */
			WHERE 
				intAuditLogID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.auditLog.getIntAuditLogID()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intAuditLogID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAuditLog.intAuditLogID		/*  - int*/
				, tblAuditLog.dtTS			/*  - datetime*/
				, tblAuditLog.vcAction		/*  - varchar(250)*/
				, tblAuditLog.vcCategory		/*  - varchar(250)*/
				, tblAuditLog.vcSubcategory		/*  - varchar(250)*/
				, tblAuditLog.vcData		/*  - varchar(-1)*/
				, tblAuditLog.vcIPAddress		/*  - varchar(50)*/
				, tblAuditLog.vcUserAgent		/*  - varchar(2000)*/
				, tblAuditLog.vcLatitude		/*  - varchar(100)*/
				, tblAuditLog.vcLongitude		/*  - varchar(100)*/
				, tblAuditLog.intAppointmentID	/*  - int*/
				, tblAuditLog.intAccountID		/*  - int*/
				, tblAuditLog.intDashboardLoginID	/*	- int*/				
				, tblAuditLog.intAddressID		/*  - int*/
				, tblAuditLog.intMissedAppointmentTypeID	/*	- int*/
				, tblAuditLog.btTransportArranged	/*  - bit*/
				, tblAuditLog.dtCreatedOn		/*  - datetime*/
				, tblAuditLog.intCreatedBy		/*  - int*/
			FROM dbo.tblAuditLog
			WHERE
				tblAuditLog.intAuditLogID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAuditLogID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblAuditLog.intAuditLogID		/*  - int*/
				, tblAuditLog.dtTS			/*  - datetime*/
				, tblAuditLog.vcAction		/*  - varchar(250)*/
				, tblAuditLog.vcCategory		/*  - varchar(250)*/
				, tblAuditLog.vcSubcategory		/*  - varchar(250)*/
				, tblAuditLog.vcData		/*  - varchar(-1)*/
				, tblAuditLog.vcIPAddress		/*  - varchar(50)*/
				, tblAuditLog.vcUserAgent		/*  - varchar(2000)*/
				, tblAuditLog.vcLatitude		/*  - varchar(100)*/
				, tblAuditLog.vcLongitude		/*  - varchar(100)*/
				, tblAuditLog.intAppointmentID	/*  - int*/
				, tblAuditLog.intAccountID		/*  - int*/
				, tblAuditLog.intDashboardLoginID	/*	- int*/				
				, tblAuditLog.intAddressID		/*  - int*/
				, tblAuditLog.intMissedAppointmentTypeID	/*	- int*/
				, tblAuditLog.btTransportArranged	/*  - bit*/
				, tblAuditLog.dtCreatedOn		/*  - datetime*/
				, tblAuditLog.intCreatedBy		/*  - int*/
			FROM dbo.tblAuditLog
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

</cfcomponent>