<cfoutput>
	<cf_card title="Emails">
		<p class="card-text">
			<cfif arrayLen(rc.common.getEmails())>
				<cfloop array="#rc.common.getEmails()#" item="local.emailAddress" index="local.i">
					<a href="mailto:#local.emailAddress.getEmail()#">#local.emailAddress.getEmail()#</a>
					<cfif local.emailAddress.isPrimary()>
						<span class="label label-pill label-default">Primary</span>
					</cfif>
					<cfif local.emailAddress.hasOptedOut()>
						<span class="label label-pill label-warning">Opted out</span>
					</cfif>
					<cfif !local.emailAddress.valid()>
						<span class="label label-pill label-warning">Invalid</span>
					</cfif>

					<cfif local.i LT arrayLen(rc.common.getEmails())><br/></cfif>
				</cfloop>
			<cfelse>
				<span class="text-muted">N/A</span>
			</cfif>
		</p>
	</cf_card>
</cfoutput>