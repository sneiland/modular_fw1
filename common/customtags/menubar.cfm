<cfsilent>
	<cfparam name="attributes.style" type="string" default="overflow:auto;">

	<cfif NOT IsDefined("thisTag.executionMode")>
		<cfthrow message="Custom tag called as a regular file" detail="The file being executed can only be used as a custom tag">
	</cfif>

	<cfif NOT thisTag.HasEndTag>
		<cfthrow message="End Tag Missing" detail="The menubar custom tag requires a closing end tag">
	</cfif>
</cfsilent>
<cfoutput>
	<cfswitch expression="#thisTag.ExecutionMode#">
		<cfcase value="start">
			<div class="menuBar" style="#attributes.style#">
		</cfcase>

		<cfcase value="end">
				<!--- <div style="clear:both"></div> --->
			</div>
		</cfcase>
	</cfswitch>
</cfoutput>