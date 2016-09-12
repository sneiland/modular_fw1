<cffunction name="relatedLink" output="false">
	<cfargument name="typeId">
	<cfargument name="typeName">
	<cfargument name="relatedId">
	<cfargument name="relatedName">

	<cfset var relatedurl = "">

	<cfscript>
		switch( arguments.typeId ){
			case 1:
				relatedurl = buildUrl(action=":accounts.view",querystring="accountId=");
			break;
			case 2:
				relatedurl = buildUrl(action=":bugs.view",querystring="bugId=");
			break;
			case 3:
				relatedurl = buildUrl(action=":calls.view",querystring="callId=");
			break;
			case 4:
				relatedurl = buildUrl(action=":campaigns.view",querystring="campaignId=");
			break;
			case 5:
				relatedurl = buildUrl(action=":cases.view",querystring="caseId=");
			break;
			case 6:
				relatedurl = buildUrl(action=":contacts.view",querystring="contactId=");
			break;
			case 7:
				relatedurl = buildUrl(action=":leads.view",querystring="leadId=");
			break;
			case 8:
				relatedurl = buildUrl(action=":meetings.view",querystring="meetingId=");
			break;
			case 9:
				relatedurl = buildUrl(action=":notes.view",querystring="noteId=");
			break;
			case 10:
				relatedurl = buildUrl(action=":opportunities.view",querystring="opportunityId=");
			break;
			case 11:
				relatedurl = buildUrl(action=":projects.view",querystring="projectId=");
			break;
			case 12:
				relatedurl = buildUrl(action=":prospects.view",querystring="prospectId=");
			break;
			case 13:
				relatedurl = buildUrl(action=":tasks.view",querystring="taskId=");
			break;
		}

		relatedurl &= arguments.relatedId;
	</cfscript>

	<cfreturn '<a href="#relatedurl#"> (#arguments.typeName#) #arguments.relatedName#</a>'>
</cffunction>