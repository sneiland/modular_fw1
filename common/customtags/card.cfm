<cfsilent>
	<cfparam name="attributes.columnDatapoints" type="string" default="">
	<cfparam name="attributes.columnLabels" type="string" default="">
	<cfparam name="attributes.title" type="string" default="">
	<cfparam name="attributes.style" type="string" default="">
	<cfparam name="attributes.draggable" type="boolean" default="false">
	<cfparam name="attributes.collapsable" type="boolean" default="false">

	<cfif NOT IsDefined("thisTag.executionMode")>
		<cfthrow message="Custom tag called as a regular file" detail="The file being executed can only be used as a custom tag">
	</cfif>

	<cfif NOT thisTag.HasEndTag>
		<cfthrow message="End Tag Missing" detail="The pod custom tag requires a closing end tag">
	</cfif>
</cfsilent>
<cfoutput>

	<cfswitch expression="#thisTag.ExecutionMode#">
		<cfcase value="start">
			<div class="card pod <cfif attributes.collapsable>collapsable</cfif>">
				<div class="card-header bg-primary <cfif attributes.draggable>draggable</cfif>">
					<cfif attributes.collapsable>
						<span class="caret" style="float:right;">
							<i class="fa fa-caret-down"></i>
						</span>
					</cfif>
					<cfif attributes.draggable>
						<i class="fa fa-bars"></i>
					</cfif>
					#attributes.title#
				</div>
				<div class="card-block">
		</cfcase>

		<cfcase value="end">
				</div>
			</div>
		</cfcase>
	</cfswitch>

</cfoutput>