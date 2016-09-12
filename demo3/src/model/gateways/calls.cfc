<cfcomponent displayname="Calls Gateway" extends="base.gateway" output="false">

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="callId" required="true" type="numeric">
		<cfargument name="tenantId" required="true" type="numeric">

	 	<cfset var qryDeleteCall = "">

	 	<cfquery name="qryDeleteCall" datasource="#getDSN()#">
			DELETE FROM calls
			WHERE
				callId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.callId#">
	 	</cfquery>

	 	<cfreturn true>
	</cffunction>


	<cffunction name="getCallsBetweenDates" access="public" output="false" returntype="query">
		<cfargument name="startdate" required="true" type="string">
		<cfargument name="enddate" required="true" type="string">

	 	<cfset var qryGetCallBetweenDates = "">

	 	<cfquery name="qryGetCallBetweenDates" datasource="#getDSN()#">
			SELECT
				c1.callId
				, c1.subject
				, c1.description
				, c1.datetimeStart
			FROM
				calls AS c1
			WHERE
				c1.datetimeStart >= <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.startdate#">
				AND c1.datetimeStart <= <cfqueryparam cfsqltype="cf_sql_date" value="#arguments.enddate#">
	 	</cfquery>

	 	<cfreturn qryGetCallBetweenDates>
	</cffunction>


	<cffunction name="getCallById" access="public" output="false" returntype="query">
		<cfargument name="callId" required="true" type="numeric">

	 	<cfset var qryGetCallById = "">

	 	<cfquery name="qryGetCallById" datasource="#getDSN()#">
			SELECT
				c1.callId
				, c1.subject
				, c1.description
				, c1.datetimeStart
				, c1.datetimeEnd
			FROM
				calls AS c1
			WHERE
				c1.callId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.callId#">
	 	</cfquery>

	 	<cfreturn qryGetCallById>
	</cffunction>


	<cffunction name="save" access="public" output="false" returntype="numeric">
		<cfargument name="call">

		<cfset var returnId = 0>
		<cfset var qryCreateCall = "">
		<cfset var createCallResult = "">
		<cfset var qryUpdateCall = "">
		<cfset var updateCallResult = "">

	 	<cfif NOT arguments.call.getCallId()>

		 	<cfquery name="qryCreateCall" result="createCallResult" datasource="#getDSN()#">
		 		INSERT INTO calls (
		 			subject
		 			, description
		 			, datetimeStart
		 			, datetimeEnd
		 		) VALUES (
		 			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.call.getSubject()#">
		 			, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.call.getDescription()#">
		 			, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.call.getDatetimeStart()#">
		 			, <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.call.getDatetimeEnd()#">
		 		)
			</cfquery>

			<cfset returnId = createCallResult.generated_key>
		<cfelse>

		 	<cfquery name="qryUpdateCall" result="updateCallResult" datasource="#getDSN()#">
		 		UPDATE
		 			calls
		 		SET
		 			subject = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.call.getSubject()#">
		 			, description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.call.getDescription()#">
		 			, datetimeStart = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.call.getDatetimeStart()#">
		 			, datetimeEnd = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#arguments.call.getDatetimeEnd()#">
		 		WHERE
		 			callId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.call.getCallId()#">
			</cfquery>

			<cfset returnId = arguments.call.getCallId()>
		</cfif>

	 	<cfreturn returnId>
	</cffunction>

</cfcomponent>