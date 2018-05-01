<cfcomponent name="appointmentGateway" extends="app.model.gateway.baseGateway">

	<cffunction name="create" access="public" returntype="numeric" output="false">
		<cfargument name="appointment" type="any" required="true" />

		<cfquery name="local.qCreate" result="local.qCreateResult">
			INSERT INTO dbo.tblAppointment
			(
				  intAccountID		/*	- int*/
				, intPracticeID		/*  - int*/
				, dtApptDate		/*  - datetime*/
				, dtApptTime		/*  - datetime*/
				, btIsAvailable		/*  - bit*/
				, intPatientID		/*  - int*/
				, vcFNameDoctor		/*  - varchar(250)*/
				, vcLNameDoctor		/*  - varchar(250)*/
				, dtModifiedOn		/*  - datetime*/
				, intModifiedBy		/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntAccountID()#"/>	/* intAccountID	- int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntPracticeID()#"/>	/* intPracticeID - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.appointment.getDtApptDate()#"/>	/* dtApptDate - datetime */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.appointment.getDtApptTime()#"/>	/* dtApptTime - datetime */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.appointment.getBtIsAvailable()#"/>	/* btIsAvailable - bit */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntPatientID()#"/>	/* intPatientID - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appointment.getVcFNameDoctor()#"/>	/* vcFNameDoctor - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appointment.getVcLNameDoctor()#"/>	/* vcLNameDoctor - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.appointment.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntModifiedBy()#"/>	/* intModifiedBy - int */
			);
		</cfquery>

	<cfreturn local.qCreateResult.generatedKey />
	</cffunction>

	<cffunction name="update" access="public" returntype="void" output="false">
		<cfargument name="appointment" type="any" required="true" />

		<cfquery name="local.qUpdate">
			UPDATE dbo.tblAppointment
			SET
				  intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntAccountID()#"/>	/* intAccountID	- int */
				, intPracticeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntPracticeID()#"/>	/* intPracticeID - int */
				, dtApptDate = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.appointment.getDtApptDate()#"/>	/* dtApptDate - datetime */
				, dtApptTime = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.appointment.getDtApptTime()#"/>	/* dtApptTime - datetime */
				, btIsAvailable = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.appointment.getBtIsAvailable()#"/>	/* btIsAvailable - bit */
				, intPatientID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntPatientID()#"/>	/* intPatientID - int */
				, vcFNameDoctor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appointment.getVcFNameDoctor()#"/>	/* vcFNameDoctor - varchar (250) */
				, vcLNameDoctor = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.appointment.getVcLNameDoctor()#"/>	/* vcLNameDoctor - varchar (250) */
				, dtModifiedOn = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.appointment.getDtModifiedOn()#"/>	/* dtModifiedOn - datetime */
				, intModifiedBy = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntModifiedBy()#"/>	/* intModifiedBy - int */
			WHERE 
				intAppointmentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.appointment.getIntAppointmentID()#"/>
		</cfquery>

	</cffunction>

	<cffunction name="load" access="public" returntype="query" output="false">
		<cfargument name="intAppointmentID" type="numeric" required="true" />

		<cfquery name="local.qLoad">
			SELECT
				  tblAppointment.intAppointmentID	/*  - int*/
				, tblAppointment.intAccountID		/*	- int*/
				, tblAppointment.intPracticeID		/*  - int*/
				, tblAppointment.dtApptDate		/*  - datetime*/
				, tblAppointment.dtApptTime		/*  - datetime*/
				, tblAppointment.btIsAvailable		/*  - bit*/
				, tblAppointment.intPatientID		/*  - int*/
				, tblAppointment.vcFNameDoctor		/*  - varchar(250)*/
				, tblAppointment.vcLNameDoctor		/*  - varchar(250)*/
				, tblAppointment.dtModifiedOn		/*  - datetime*/
				, tblAppointment.intModifiedBy		/*  - int*/
			FROM dbo.tblAppointment
			WHERE
				tblAppointment.intAppointmentID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAppointmentID#"/>
		</cfquery>

	<cfreturn local.qLoad />
	</cffunction>

	<cffunction name="loadAll" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAll">
			SELECT
				  tblAppointment.intAppointmentID	/*  - int*/
				, tblAppointment.intAccountID		/*	- int*/
				, tblAppointment.intPracticeID		/*  - int*/
				, tblAppointment.dtApptDate		/*  - datetime*/
				, tblAppointment.dtApptTime		/*  - datetime*/
				, tblAppointment.btIsAvailable		/*  - bit*/
				, tblAppointment.intPatientID		/*  - int*/
				, tblAppointment.vcFNameDoctor		/*  - varchar(250)*/
				, tblAppointment.vcLNameDoctor		/*  - varchar(250)*/
				, tblAppointment.dtModifiedOn		/*  - datetime*/
				, tblAppointment.intModifiedBy		/*  - int*/
			FROM dbo.tblAppointment
			ORDER BY 1 ASC
		</cfquery>

	<cfreturn local.qLoadAll />
	</cffunction>

	<cffunction name="loadUpcomingPatientAppts" access="public" returntype="query" output="false">
		<cfargument name="intAccountID" type="numeric" required="true" />

		<cfquery name="local.qLoadUpcoming">
			SELECT 
				  tblAppointment.intAppointmentID	/*  - int*/
				, tblAppointment.intAccountID		/*	- int*/
				, tblAppointment.intPracticeID		/*  - int*/
				, tblAppointment.dtApptDate		/*  - datetime*/
				, tblAppointment.dtApptTime		/*  - datetime*/
				, tblAppointment.btIsAvailable		/*  - bit*/
				, tblAppointment.intPatientID		/*  - int*/
				, tblAppointment.vcFNameDoctor		/*  - varchar(250)*/
				, tblAppointment.vcLNameDoctor		/*  - varchar(250)*/
				, tblAppointment.dtModifiedOn		/*  - datetime*/
				, tblAppointment.intModifiedBy		/*  - int*/
			FROM dbo.tblAppointment
			WHERE
				tblAppointment.intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAccountID#" />
			AND ((
						tblAppointment.dtApptDate = CONVERT(DateTime, DATEDIFF(DAY, 0, GETDATE()))
					AND tblAppointment.dtApptTime > CONVERT(VARCHAR(10), GETDATE(), 108)
				) OR (
						tblAppointment.dtApptDate = CONVERT(DateTime, DATEDIFF(DAY, 0, GETDATE()+1)) 
				)
			)
		</cfquery>

	<cfreturn local.qLoadUpcoming />
	</cffunction>

	<cffunction name="loadAvailable" access="public" returntype="query" output="false">

		<cfquery name="local.qLoadAvailable">
			SELECT
				  tblAppointment.intAppointmentID	/*  - int*/
				, tblAppointment.intAccountID		/*	- int*/
				, tblAppointment.intPracticeID		/*  - int*/
				, tblAppointment.dtApptDate		/*  - datetime*/
				, tblAppointment.dtApptTime		/*  - datetime*/
				, tblAppointment.btIsAvailable		/*  - bit*/
				, tblAppointment.intPatientID		/*  - int*/
				, tblAppointment.vcFNameDoctor		/*  - varchar(250)*/
				, tblAppointment.vcLNameDoctor		/*  - varchar(250)*/
				, tblAppointment.dtModifiedOn		/*  - datetime*/
				, tblAppointment.intModifiedBy		/*  - int*/
			FROM
				dbo.tblAppointment
			WHERE
				tblAppointment.btIsAvailable = 1
			AND ((
						tblAppointment.dtApptDate = CONVERT(DateTime, DATEDIFF(DAY, 0, GETDATE()))
					AND tblAppointment.dtApptTime > CONVERT(VARCHAR(10), GETDATE(), 108)
				) OR (
						tblAppointment.dtApptDate = CONVERT(DateTime, DATEDIFF(DAY, 0, GETDATE()+1)) 
				)
			)
			ORDER BY
				tblAppointment.dtApptTime
		</cfquery>

	<cfreturn local.qLoadAvailable />
	</cffunction>

	<cffunction name="checkImportAppointment" access="public" returntype="query" output="false">
		<cfargument name="intAccountID" type="numeric" required="true" />
		<cfargument name="apptDate" type="date" required="true" />
		<cfargument name="apptTime" type="string" required="true" />

		<cfquery name="local.qCheck">
			SELECT
				  tblAppointment.intAppointmentID	/*  - int*/
				, tblAppointment.intAccountID		/*	- int*/
				, tblAppointment.intPracticeID		/*  - int*/
				, tblAppointment.dtApptDate		/*  - datetime*/
				, tblAppointment.dtApptTime		/*  - datetime*/
				, tblAppointment.btIsAvailable		/*  - bit*/
				, tblAppointment.intPatientID		/*  - int*/
				, tblAppointment.vcFNameDoctor		/*  - varchar(250)*/
				, tblAppointment.vcLNameDoctor		/*  - varchar(250)*/
				, tblAppointment.dtModifiedOn		/*  - datetime*/
				, tblAppointment.intModifiedBy		/*  - int*/
			FROM
				dbo.tblAppointment
			WHERE
				tblAppointment.intAccountID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAccountID#" />
			AND tblAppointment.dtApptDate = <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.apptDate#" />
			AND tblAppointment.dtApptTime = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.apptTime#" />
		</cfquery>

	<cfreturn local.qCheck />
	</cffunction>

	<cffunction name="insertImportAppointment" access="public" returntype="void" output="false">
		<cfargument name="intAccountID" type="numeric" required="true" />
		<cfargument name="dtApptDate" type="date" required="true" />
		<cfargument name="dtApptTime" type="string" required="true" />
		<cfargument name="intPatientID" type="numeric" required="true" />

		<cfquery name="local.qInsert">
			INSERT INTO dbo.tblAppointment
			(
				  intAccountID		/*	- int*/
				, intPracticeID		/*  - int*/
				, dtApptDate		/*  - datetime*/
				, dtApptTime		/*  - datetime*/
				, btIsAvailable		/*  - bit*/
				, intPatientID		/*  - int*/
				, vcFNameDoctor		/*  - varchar(250)*/
				, vcLNameDoctor		/*  - varchar(250)*/
				, dtModifiedOn		/*  - datetime*/
				, intModifiedBy		/*  - int*/
			)
			VALUES
			(
				  <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intAccountID#"/>	/* intAccountID	- int */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="1"/>	/* intPracticeID - int */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.dtApptDate#"/>	/* dtApptDate - datetime */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.dtApptTime#"/>	/* dtApptTime - datetime */
				, <cfqueryparam cfsqltype="cf_sql_bit" value="0"/>	/* btIsAvailable - bit */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.intPatientID#"/>	/* intPatientID - int */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value=""/>	/* vcFNameDoctor - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_varchar" value=""/>	/* vcLNameDoctor - varchar (250) */
				, <cfqueryparam cfsqltype="cf_sql_timestamp" value="1970-01-01 00:00:00.000"/>	/* dtModifiedOn - datetime */
				, <cfqueryparam cfsqltype="cf_sql_integer" value="0"/>	/* intModifiedBy - int */
			);
		</cfquery>
	</cffunction>

</cfcomponent>