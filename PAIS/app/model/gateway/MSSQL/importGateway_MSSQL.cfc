<cfcomponent name="importGateway" extends="app.model.gateway.baseGateway">

	<cffunction name="getPatientData" access="public" returntype="query" output="false">
		<cfquery name="local.qGetPatientData" datasource="PAISWS">
			SELECT
				  wc_hum_schedules.profile_key
				, wc_hum_schedules.first_name
				, wc_hum_schedules.last_name
				, wc_hum_schedules.mrn
				, wc_hum_schedules.address1
				, wc_hum_schedules.address2
				, wc_hum_schedules.city
				, wc_hum_schedules.state
				, wc_hum_schedules.postal_code
				, wc_hum_schedules.date_of_birth
				, wc_hum_schedules.status_abrv
				, wc_hum_schedules.status_desc
				, wc_hum_schedules.institution_abrv
				, wc_hum_schedules.institution_name
				, wc_hum_schedules.app_datetime
				, wc_hum_schedules.diags
			FROM wc_hum_schedules
			WHERE
				wc_hum_schedules.status_abrv IS NULL
		</cfquery>
	<cfreturn local.qGetPatientData />	
	</cffunction>

</cfcomponent> 