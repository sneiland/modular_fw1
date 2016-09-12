<cfcomponent accossors="true" output="false">

	<cfproperty name="dsn" default="">

	<cffunction name="init">
		<cfargument name="dsn">

		<cfset variables.dsn = arguments.dsn>

		<cfreturn this>
	</cffunction>

	<cffunction name="getDSN">
		<cfreturn variables.dsn>
	</cffunction>


	<cffunction name="getApplicationId" access="public" output="false" returntype="numeric">
		<cfargument name="applicationname" type="string" required="yes">

		<cfset var qryGetApplicationId = "">
		<cfset var returnId = 0>

		<cfquery name="qryGetApplicationId" datasource="#getDSN()#">
			SELECT
				applicationId
			FROM
				applications
			WHERE
				name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationname#">
		</cfquery>

		<cfif NOT qryGetApplicationId.recordCount>
			<cfset returnId = createNewApplication( arguments.applicationname )>
		<cfelse>
			<cfset returnId = qryGetApplicationId.applicationId>
		</cfif>

    	<cfreturn returnId>
    </cffunction>


	<cffunction name="getHelpPageByAction" access="public" output="false" returntype="query">
		<cfargument name="helpAction" required="yes" type="string">
		<cfargument name="applicationId" required="yes" type="numeric">

		<cfset var qryGetHelpPageByAction = "">

		<cfquery name="qryGetHelpPageByAction" datasource="#getDSN()#">
			SELECT
				pageId
				,title
				,pageContent
			FROM
				pages
			WHERE
				helpAction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.helpAction#">
				AND applicationId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.applicationId#">
		</cfquery>

    	<cfreturn qryGetHelpPageByAction>
    </cffunction>


	<cffunction name="getHelpPagesForList" access="public" output="false" returntype="query">
		<cfargument name="search" required="false" type="string" default="">
		<cfargument name="userId" required="true" type="numeric">
		<cfargument name="isAdmin" required="true" type="boolean">
		<cfargument name="applicationId" required="yes" type="numeric">

		<cfset var qryGetHelpPagesForList = "">

		<cfquery name="qryGetHelpPagesForList" datasource="#getDSN()#">
			SELECT
				  p1.pageId
				, p1.title
				, p1.pageContent
				, p1.helpAction
			FROM
				pages AS p1
			WHERE
				p1.applicationId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.applicationId#">
				<cfif len(trim(arguments.search))>
					AND (
						p1.title LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.search#%">
						OR p1.pageContent LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.search#%">
					)
				</cfif>
		</cfquery>

    	<cfreturn qryGetHelpPagesForList>
    </cffunction>


	<cffunction name="updateHelpPage" access="public" output="false" returntype="numeric">
		<cfargument name="helpAction" type="string" required="true" default="">
		<cfargument name="pageId" type="numeric" required="true" default="0">
		<cfargument name="title" type="string" required="false" default="">
		<cfargument name="pageContent" type="string" required="false" default="">
		<cfargument name="applicationId" required="yes" type="numeric">

		<cfset var qryUpdateHelpPage = "">
		<cfset var qryAddHelpPage = "">

		<cfif arguments.pageId EQ 0>
			<cfquery name="qryAddHelpPage" datasource="#getDSN()#">
				INSERT INTO pages (
					title
					, pageContent
					, helpAction
					, applicationId
				) VALUES (
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pageContent#">
					, <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.helpAction#">
					, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.applicationId#">
				)
			</cfquery>
		<cfelse>
			<cfquery name="qryUpdateHelpPage" datasource="#getDSN()#">
				UPDATE
					pages
				SET
					title = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.title#">
					, pageContent = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.pageContent#">
					, helpAction = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.helpAction#">
				WHERE
					pageId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pageId#">
			</cfquery>
		</cfif>

    	<cfreturn true>
    </cffunction>

	<!--- Private Functions --->

	<cffunction name="createNewApplication" access="private" output="false" returntype="numeric">
		<cfargument name="applicationname" type="string" required="yes">

		<cfset var qryCreateNewApplication = "">
		<cfset var createNewApplicationResult = "">

		<cfquery name="qryCreateNewApplication" result="createNewApplicationResult" datasource="#getDSN()#">
			INSERT INTO	applications (
				name
			) VALUES (
				<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.applicationname#">
			)
		</cfquery>

    	<cfreturn createNewApplicationResult.generated_key>
    </cffunction>

</cfcomponent>