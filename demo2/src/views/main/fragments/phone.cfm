<cfoutput>
	<cf_card title="Phone Numbers">
		<p class="card-text">
			<cfif rc.common.getDoNotCall()>
				<span class="label label-pill label-danger pull-right">Do not call</span>
			</cfif>
			<span class="label label-default">Phone Home : </span> #rc.common.getPhoneHomeFormatted()#<br/>
			<span class="label label-default">Phone Mobile : </span> #rc.common.getPhoneMobileFormatted()#<br/>
			<span class="label label-default">Phone Work : </span> #rc.common.getPhoneWorkFormatted()#<br/>
			<span class="label label-default">Phone Other : </span> #rc.common.getPhoneOtherFormatted()#
		</p>
	</cf_card>
</cfoutput>