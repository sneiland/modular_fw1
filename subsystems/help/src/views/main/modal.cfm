<cfoutput>
	<a href="#buildUrl(getSubsystem() & ":main.default")#" class="button pull-right">Help Index</a>
	<h1>#rc.getHelpPage.Title#</h1>

	<div style="padding:10px;">
		<cfif rc.getHelpPage.recordcount>
			#rc.getHelpPage.pageContent#
		<cfelse>
			This topic currently has no content.
		</cfif>
	</div>

</cfoutput>