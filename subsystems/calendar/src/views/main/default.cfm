<cfoutput>
	<cf_card title="Filter">
		<form action="#buildUrl(rc.action)#" method="POST" id="calendarFilters" autocomplete="off">
			<div class="row">
				<!--- <div class="col-xs-12 col-lg-3">
					<div class="form-group">
						<label for="filterView">View :</label>
						<select name="filterView" id="filterView" class="form-control c-select">
							<option value="month"> Month </option>
							<option value="week"> Week </option>
							<option value="day"> Day </option>
						</select>
					</div>
				</div> --->

				<div class="col-xs-12 col-lg-3">
					<div class="form-group">
						<label for="filterMonth">Month :</label>
						<select name="filterMonth" id="filterMonth" class="form-control c-select">

							<cfloop from="1" to="12" index="local.monthNumber">
								<option value="#local.monthNumber#" <cfif local.monthNumber EQ rc.selectedMonth>selected="true"</cfif>>#monthAsString(local.monthNumber)#</option>
							</cfloop>
						</select>
					</div>
				</div>

				<div class="col-xs-12 col-lg-3">
					<div class="form-group">
						<label for="filterYear">Year :</label>
						<input type="text" name="filterYear" id="filterYear"class="form-control" value="#rc.selectedYear#">
					</div>
				</div>

				<div class="col-xs-12 col-lg-3">
					<div class="form-group">
						<label for="filterType">Type :</label>
						<select name="filterType" id="filterType" class="form-control c-select">
							<option value=""> -All- </option>
							<cfloop array="#rc.itemTypes#" index="local.i" item="local.itemType">
								<option value="#local.itemType.value#">#local.itemType.name#</option>
							</cfloop>
						</select>
					</div>
				</div>
			</div>
		</form>
	</cf_card>

	#view("/main/default/modal")#

	<div id="calendarContainer">
	</div>

	<script>
		jsrequest.monthly = '#buildUrl( action="main.monthly" )#';
		jsrequest.edit = '#buildUrl( action="main.edit" )#';
		jsrequest.save = '#buildUrl( action="main.save" )#';
	</script>
	<script src="/subsystems/#getSubsystem()#/assets/js/views/main_default.js?refresh=#application.refreshTimestamp#"></script>
</cfoutput>