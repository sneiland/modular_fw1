<cfcomponent output="false" extends="base.gateway" displayname="Security Gateway">


	<cffunction name="getUserForLogin" access="public" output="false" returntype="query">
		<cfargument name="email" required="false" type="string" default="">
		<cfargument name="userId" required="false" type="numeric" default="0">

		<cfset var qryGetLoginUser = "">

		<cfif NOT len(trim(arguments.email)) AND NOT arguments.userId GT 0>
			<cfthrow message="getUserForLogin requires an email or userId value">
		</cfif>

		<cfquery name="qryGetLoginUser" datasource="#getDSN()#">
			SELECT
				u1.userId
				, u1.firstName
				, u1.lastName
				, u1.email AS emailAddress
				, u1.passwordHash
				, u1.salt
				, u1.tenantId
				, u1.firstLogin
				, u1.passwordChangeRequired
				, u1.passwordResetCode
				, u1.remembermeGUID
				, u1.remembermeSessionId
				, t1.planId
				, t2.name AS timezone
				, t1.countryId AS tenantCountryId
			FROM
				ss_tenants__users AS u1
			INNER JOIN
				ss_tenants__tenants AS t1 ON
					t1.tenantId = u1.tenantId
			LEFT JOIN
				locations_timezones AS t2 ON
					t2.timezoneId = u1.timezoneId
			WHERE
				<cfif len(trim(arguments.email))>
					u1.email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
				<cfelse>
					u1.userId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#">
				</cfif>
		</cfquery>

		<cfreturn qryGetLoginUser>
	</cffunction>


	<cffunction name="isUserEmailInUse" access="public" output="false" returntype="boolean">
		<cfargument name="email" required="true" type="string">
		<cfargument name="userId" required="false" type="numeric" default="0">

		<cfset var qryIsUserEmailInUse = "">

		<cfquery name="qryIsUserEmailInUse" datasource="#getDSN()#">
			SELECT
				u1.userId
			FROM
				ss_tenants__users AS u1
			WHERE
				u1.email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
				<cfif arguments.userId>
					AND u1.userId != <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#">
				</cfif>
		</cfquery>

		<cfif qryIsUserEmailInUse.recordCount>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>


	<cffunction name="isUserInGroup" access="public" output="false" returntype="boolean">
		<cfargument name="userId" required="true" type="numeric">
		<cfargument name="groupId" required="true" type="numeric">

		<cfset var qryIsUserInGroup = "">

		<cfquery name="qryGetLoginUser" datasource="#getDSN()#">
			SELECT
				g1.groupId
			FROM
				ss_tenants__users_groups_bus AS g1
			WHERE
				g1.userId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#">
				AND g1.groupId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.groupId#">
		</cfquery>

		<cfif qryGetLoginUser.recordCount>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>


	<cffunction name="lookupUserByResetCode" access="public" output="false" returntype="numeric">
		<cfargument name="resetcode" required="true" type="string">

		<cfset var qryLookupUserByResetCode = "">
		<cfset var returnId = 0>

		<cfquery name="qryLookupUserByResetCode" datasource="#getDSN()#">
			SELECT userId
			FROM ss_tenants__users
			WHERE passwordResetCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.resetcode#">
		</cfquery>

		<cfif qryLookupUserByResetCode.recordCount>
			<cfset returnId = qryLookupUserByResetCode.userId>
		</cfif>

		<cfreturn returnId>
	</cffunction>


	<cffunction name="savePasswordHash" access="public" output="false" returntype="boolean">
		<cfargument name="userId" required="true" type="numeric">
		<cfargument name="salt" required="true" type="string">
		<cfargument name="passwordHash" required="true" type="string">
		<cfargument name="passwordChangeOnLogin" required="false" type="boolean" default="0">

		<cfset var qrySavePasswordHash = "">
		<cfset var savePasswordHash_result = "">

		<cfquery name="qrySavePasswordHash" datasource="#getDSN()#" result="savePasswordHash_result">
			UPDATE
				ss_tenants__users
			SET
				  passwordHash = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.passwordHash#">
				, salt = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.salt#">
				  <!--- We always clear the resetUUID after changing the password just in case --->
				, passwordResetCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
				, passwordChangeRequired = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.passwordChangeOnLogin#">
			WHERE
				userId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#">
		</cfquery>

		<cfreturn savePasswordHash_result.recordcount>
	</cffunction>


	<cffunction name="savePasswordResetCode" access="public" output="false" returntype="boolean">
		<cfargument name="userId" required="true" type="numeric">
		<cfargument name="resetCode" required="true" type="string">

		<cfset var qrySavePasswordResetCode = "">

		<cfquery name="qrySavePasswordResetCode" datasource="#getDSN()#" result="savePasswordHash_result">
			UPDATE
				ss_tenants__users
			SET
				passwordResetCode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.resetCode#">
				,datetimeResetCodeRequested = now()
			WHERE
				userId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#">
		</cfquery>

		<cfreturn true>
	</cffunction>


	<cffunction name="updateLastLogin" access="public" output="false" returntype="void"
			hint="Updates the last login field on the user record">

		<cfargument name="userId" required="true" type="numeric">
		<cfargument name="remembermeGUID" required="false" type="string" default="">
		<cfargument name="remembermeSessionId" required="false" type="string" default="">

		<cfset var qryUpdateLastLogin = "">

		<cfquery name="qryUpdateLastLogin" datasource="#getDSN()#">
			UPDATE
				ss_tenants__users
			SET
				datetimeLastLogin = now()
				, firstLogin = <cfqueryparam cfsqltype="cf_sql_bit" value="0">
				, loginCount = loginCount + 1
				, remembermeGUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.remembermeGUID#">
				, remembermeSessionId = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.remembermeSessionId#">
			WHERE
				userId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#">
		</cfquery>
	</cffunction>

</cfcomponent>