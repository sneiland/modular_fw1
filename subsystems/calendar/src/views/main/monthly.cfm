<cfoutput>
	<table class="calendar">
	<thead>
		<tr class="titlerow">
			<th style="border-right:none;">
				<button type="button" class="btn button prevMonth" data-month="#rc.prevmonth#" data-year="#rc.prevYear#">&lt; Prev</button>
				<!--- <a href="#buildUrl(action=rc.action, querystring='selectedMonth=#rc.prevmonth#&selectedYear=#rc.prevYear#&selecteditemtypes=#rc.selecteditemtypes#')#" class="button">&lt; Prev</a> --->
			</th>
			<th colspan="5" style="text-align:center; border-right:none;">
				#monthAsString(rc.selectedMonth)# - #rc.selectedYear#
			</th>
			<th style="text-align:right">
				<button type="button" class="btn button nextMonth" data-month="#rc.nextmonth#" data-year="#rc.nextYear#">Next &gt;</button>
				<!--- <a href="#buildUrl(action=rc.action, querystring='selectedMonth=#rc.nextmonth#&selectedYear=#rc.nextYear#&selecteditemtypes=#rc.selecteditemtypes#')#" class="button">Next &gt;</a> --->
			</th>
		</tr>
		<tr>
			<th>Sunday</th>
			<th>Monday</th>
			<th>Tuesday</th>
			<th>Wednesday</th>
			<th>Thursday</th>
			<th>Friday</th>
			<th>Saturday</th>
		</tr>
	</thead>
	<tbody>
		<cfloop array="#rc.calmonth#" index="week">
			<tr>
			<cfloop array="#week#" index="weekday">
				<td <cfif weekday.monthMarker NEQ "current">class="borderingMonth"</cfif> valign="top">
					#weekday.dayofmonth##ordinalSuffix(weekday.dayofmonth)#<br/>

					 <cfloop array="#weekday.items#" index="local.item">
						<div class="calevent">
							<a <!--- href="#buildUrl('events.view')#" ---> class="calItem" data-type="#local.item.getType()#" data-id="#local.item.getId()#">#local.item.getlabel()#</a>
						</div>
					</cfloop>
				</td>
			</cfloop>
			</tr>
		</cfloop>
	</tbody>
	</table>
</cfoutput>