<cfoutput>
	<cfif rc.resetResult.success>
		<h2>Reset email sent</h2>

		<p>An email has been sent to the address on file with a link to set a new password.</p>

		<button class="btn btn-lg btn-primary btn-block" type="button" name="loginBtn" onclick="window.location = '#buildUrl("security.default")#';" >Return To Login</button>
	<cfelseif arrayLen(resetResult.errors) GT 1>
		<cfloop from="1" to="#arrayLen(resetResult.errors)#" index="i">
			<p>#resetResult.errors[i]#</p>
		</cfloop>
	<cfelseif arrayLen(resetResult.errors) EQ 1>
		<cfset newurl = buildUrl(action="security.forgotpassword",querystring="errorMsg=#xmlFormat(resetResult.errors[1])#")>
		<cflocation url="#newurl#" addtoken="false">
	<cfelse>
		<p>Something went wrong resetting your password. The administrators have been notified of this error. Please try again.</p>
	</cfif>
</cfoutput>
