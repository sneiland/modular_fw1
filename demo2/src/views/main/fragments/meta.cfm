<cfoutput>
	<cf_card title="Meta Data">
		<p class="card-text">
			<span class="label label-default">Assigned To : </span>
				<cfif rc.common.getAssignedUserId()>
					<a href="#buildUrl(action="tenants:users.view",querystring="userId=#rc.common.getAssignedUserId()#")#">
						#rc.common.getAssignedNameFormatted()#
					</a>
				<cfelse>
					#rc.common.getAssignedNameFormatted()#
				</cfif>

			<br/>
			<span class="label label-default">Created : </span> #rc.common.getDatetimeCreatedFormatted()#<br/>
			<span class="label label-default">Created by : </span> <a href="#buildUrl(action="tenants:users.view",querystring="userId=#rc.common.getCreatorId()#")#">#rc.common.getCreatorNameFormatted()#</a>
			<cfif rc.common.getUpdatorId()>
				<br/>
				<span class="label label-default">Updated : </span> #rc.common.getDatetimeUpdatedFormatted()#<br/>
				<span class="label label-default">Updated by : </span> <a href="#buildUrl(action="tenants:users.view",querystring="userId=#rc.common.getUpdatorId()#")#">#rc.common.getUpdatorNameFormatted()#</a>
			</cfif>
		</p>
	</cf_card>
</cfoutput>