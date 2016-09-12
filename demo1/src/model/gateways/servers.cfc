<cfcomponent accessors="true" displayname="Servers Gateway" extends="base.gateway" output="false">

	<cffunction name="getServerById" access="public" output="false" returntype="query" hint="Gets a single server">
		<cfargument name="serverId"	required="true" type="numeric">

		<cfset var qryGetServerById = "">

		<cfquery name="qryGetServerById" datasource="#getDSN()#">
			SELECT
				  s1.serverId
				  , s1.name
				  , s1.client
				  , s1.type
				  , s1.billable
				  , s1.price
			FROM
				servers AS s1
			WHERE
				s1.serverid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.serverId#">
		</cfquery>

		<cfreturn qryGetServerById>
	</cffunction>


	<cffunction name="getServerOptions" access="public" output="false" returntype="query" hint="Gets the currently selected options for a server">
		<cfargument name="serverId"	required="true" type="numeric">

		<cfset var qryGetServerOptions = "">

		<cfquery name="qryGetServerOptions" datasource="#getDSN()#">
			SELECT
				 o1.quantity
				 , o2.name as optionName
				 , o2.price as optionPrice
			FROM
				server_options AS o1
			INNER JOIN
				options AS o2 ON
					o1.optionId = o2.optionId
			WHERE
				o1.serverId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.serverId#">
		</cfquery>

		<cfreturn qryGetServerOptions>
	</cffunction>


	<cffunction name="getPaged" access="public" output="false" returntype="struct" hint="Gets servers in a paged form">
		<cfargument name="start" 		required="false" type="numeric" default="0">
		<cfargument name="length" 			required="false" type="numeric" default="15">
		<cfargument name="sortCol" 			required="false" type="string" default="priority">
		<cfargument name="sortDir" 			required="false" type="string" default="ASC">
		<cfargument name="textSearch" 		required="false" type="string" default="">

		<cfset var qryGetServersPaged = "">
		<cfset var countServers = "">
		<cfset var countServersFiltered = "">
		<cfset var returnStruct = structNew()>

		<cfquery name="countServers" datasource="#getDSN()#">
			SELECT COUNT(*) AS total
			FROM servers AS s1
		</cfquery>

		<cfset returnStruct.total = countServers.total>

		<cfquery name="countServersFiltered" datasource="#getDSN()#">
			SELECT COUNT(*) AS total
			FROM
					servers AS s1
			<cfif len(trim(arguments.textSearch))>
				WHERE
					name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.textSearch#%">
					OR client LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.textSearch#%">
					OR type LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.textSearch#%">
			</cfif>
		</cfquery>

		<cfset returnStruct.totalfiltered = countServersFiltered.total>

		<cfquery name="qryGetServersPaged" datasource="#getDSN()#">
			SELECT
				x0.serverId
				, x0.name
				, x0.client
				, x0.type
				, x0.billable
				, x0.basePrice
				, CASE
					WHEN x0.optionsTotal IS NOT NULL THEN x0.optionsTotal
					ELSE 0
				  END AS optionsTotal
				, CASE
					WHEN x0.optionsTotal IS NOT NULL THEN x0.optionsTotal + x0.basePrice
					ELSE x0.basePrice
				  END AS totalPrice
			FROM (
				SELECT
					  s1.serverId
					  , s1.name
					  , s1.client
					  , s1.type
					  , s1.billable
					  , s1.price AS basePrice
					  ,(
						SELECT
							 sum(o1.quantity * o2.price) as optionsTotal
						FROM
							server_options AS o1
						INNER JOIN
							options AS o2 ON
								o1.optionId = o2.optionId
						WHERE
							o1.serverId = s1.serverId
					)  as optionsTotal

				FROM
					servers AS s1
			) AS x0

			<cfif len(trim(arguments.textSearch))>
				WHERE
					name LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.textSearch#%">
					OR client LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.textSearch#%">
					OR type LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.textSearch#%">
			</cfif>

			ORDER BY
				<cfswitch expression="#arguments.sortCol#">
					<cfcase value="name">name</cfcase>
					<cfcase value="client">client</cfcase>
					<cfcase value="type">type</cfcase>
					<cfcase value="billable">billable</cfcase>
					<cfcase value="basePrice">basePrice</cfcase>
					<cfcase value="totalPrice">totalPrice</cfcase>
					<cfdefaultcase>serverId</cfdefaultcase>
				</cfswitch>

				<cfif arguments.sortDir EQ "DESC">DESC<cfelse>ASC</cfif>
			LIMIT
				#arguments.start#, #arguments.length#
		</cfquery>

		<cfset returnStruct.data = qryGetServersPaged>

		<cfreturn returnStruct>
	</cffunction>

</cfcomponent>