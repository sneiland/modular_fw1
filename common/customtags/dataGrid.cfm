<cfsilent>
	<cfparam name="attributes.columns" type="array" default="#arrayNew(1)#">
	<cfparam name="attributes.query" type="query">
	<cfparam name="attributes.ajaxUrl" default="">
	<!--- <cfparam name="attributes.id" default=""> --->
	
	<cfif NOT IsDefined("thisTag.executionMode")>
		<cfthrow message="Custom tag called as a regular file" detail="The file being executed can only be used as a custom tag">
	</cfif>
	
	<cfif thisTag.executionMode EQ "end">
		<!--- 
			This custom tag is not required to be closed so 
			don't execute a second time if the tag is closed 
			as per valid xml format
		 --->
	    <cfexit>
	</cfif>
	
	<cfif NOT ArrayLen(attributes.columns)>
		<cfthrow message="Column definition array empty" detail="The column definition array for the datagrid customtag is empty">
	</cfif>
	
	<!--- 
		Enable the use of FW/1's buildUrl function inside the custom tag by getting a reference to the caller this scope
		To use do #fw.buildUrl('action')#
		Source: Adam Tuttle, http://fusiongrokker.com/post/using-the-fw-1-buildurl-helper-method-inside-custom-tags
	 --->
	<cfset variables.fw = caller.this>
	
	
</cfsilent>
<cfoutput>
	
	<cffunction name="buildCell">
		<cfargument name="columnDefinition">
		<cfargument name="query">
		<cfargument name="rowNumber">
		
		<cfset var returnString = "hello">
		<cfset var dataPoints = columnDefinition[1]>
		<cfset var dataPoint = "">
		<cfset var counter = 0>
		
		<cfloop list="#dataPoints#" index="dataPoint" delimiters=" ">
			<cfset counter = counter + 1>
			
			<cfif counter EQ 1>
				<cfset returnString = arguments.query[dataPoint][arguments.rowNumber]>
			<cfelse>
				<cfset returnString = returnString & " " & arguments.query[dataPoint][arguments.rowNumber]>
			</cfif>
		</cfloop>
		
		<cfreturn returnString>
	</cffunction>
	
	<table class="pretty">
	<thead>
	<cfloop from="1" to="#arrayLen(attributes.columns)#" index="i">
		<th>#attributes.columns[i][2]#</th>
	</cfloop>
	</thead>
	<tbody>
	<cfloop query="attributes.query">
		<tr <cfif attributes.query.currentRow mod 2>class="odd"</cfif>>
		<cfloop from="1" to="#arrayLen(attributes.columns)#" index="j">
			<cfif j EQ 1><th><cfelse><td></cfif><!--- Make the first column the row header --->
			
			<cfif arrayLen(attributes.columns[j]) EQ 3><a href="#fw.buildUrl(attributes.columns[j][3][1])#&#attributes.columns[j][3][2]#=#attributes.query[attributes.columns[j][3][2]][attributes.query.currentRow]#"></cfif>
						
			#buildCell(
				columnDefinition = attributes.columns[j]
				, query = attributes.query
				, rowNumber = attributes.query.currentRow
			)#
			
			<cfif arrayLen(attributes.columns[j]) EQ 3></a></cfif>
			<cfif j EQ 1></th><cfelse></td></cfif><!--- Make the first column the row header --->
		</cfloop>
		</tr>
	</cfloop>
	</tbody>	
	</table>
	
	<!--- <cfdump var="#caller.rc.action#"> --->
</cfoutput>