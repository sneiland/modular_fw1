<cffunction name="countryOptions" output="false">
	<cfargument name="countries" required="true" type="query">
	<cfargument name="selectedCountryId" required="false" default="">
	<cfargument name="defaultCountryId" required="false" default="">

	<cfset var returnString = "">
	<cfset var lastPriority = 0>
	<cfset var selectedId = arguments.selectedCountryId>

	<cfif (!len(trim(arguments.selectedCountryId)) OR arguments.selectedCountryId EQ 0) AND arguments.defaultCountryId GT 0>
		<cfset selectedId = defaultCountryId>
	</cfif>

	<cfsavecontent variable="returnString">
	<cfoutput>
		<cfloop query="arguments.countries">
			<cfif arguments.countries.currentRow EQ 1>
				<optgroup>
					<option value="">Select</option>
			<cfelseif lastPriority NEQ arguments.countries.priority>
				</optgroup>
				<optgroup>
			</cfif>
			<cfset lastPriority = arguments.countries.priority>
			<option value="#arguments.countries.countryId#"
				<cfif arguments.countries.countryId EQ selectedId>selected="selected"</cfif>
			>#arguments.countries.name#</option>
			<cfif arguments.countries.currentRow EQ arguments.countries.recordCount>
				</optgroup>
			</cfif>
		</cfloop>
	</cfoutput>
	</cfsavecontent>

	<cfreturn returnString>
</cffunction>