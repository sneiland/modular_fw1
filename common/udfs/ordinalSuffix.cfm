<cffunction name="ordinalSuffix" access="public" output="false" returntype="string">
	<cfargument name="theNumber" type="numeric" required="true">
	
	<cfset var suffix = "">
	
	<cfif theNumber GTE 10 AND mid(theNumber,len(theNumber)-1,1) EQ "1">
		<cfset suffix = "th">
	<cfelseif theNumber GT 0>
		<cfswitch expression="#right(theNumber,1)#">
			<cfcase value="1">
				<cfset suffix = "st">
			</cfcase>
			<cfcase value="2">
				<cfset suffix = "nd">
			</cfcase>
			<cfcase value="3">
				<cfset suffix = "rd">
			</cfcase>
			<cfdefaultcase>
				<cfset suffix = "th">
			</cfdefaultcase>
		</cfswitch>
	</cfif>
	
	<cfreturn suffix>
</cffunction>