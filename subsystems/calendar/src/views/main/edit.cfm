<cfoutput>
	<form>
		<input type="hidden" name="id" value="#rc.item.getId()#">
		<input type="hidden" name="type" value="#rc.item.getType()#">

		<div class="form-group row">
			<label class="col-md-2 form-control-label" for="modal_itemlabel">Label</label>
			<div class="col-md-10">
				<input type="text" name="label" id="modal_itemlabel" class="form-control" value="#rc.item.getLabel()#">
			</div>
		</div>

		<div class="form-group row">
			<label for="startDate" class="col-md-3 form-control-label">Start Date</label>
			<div class="col-md-3">
				<input type="text" name="startDate" id="startDate" class="form-control datepicker" value="#rc.item.getStartDate()#">
			</div>
			<label for="startTime" class="col-md-3 form-control-label">Start Time</label>
			<div class="col-md-3">
				<input type="text" name="startTime" id="startTime" class="form-control timepicker" value="#rc.item.getStartTime()#">
			</div>
		</div>

		<div class="form-group row">
			<label for="endDate" class="col-md-3 form-control-label">End Date</label>
			<div class="col-md-3">
				<input type="text" name="endDate" id="endDate" class="form-control datepicker" value="#rc.item.getEndDate()#">
			</div>
			<label for="startTime" class="col-md-3 form-control-label">End Time</label>
			<div class="col-md-3">
				<input type="text" name="endTime" id="endTime" class="form-control timepicker" value="#rc.item.getEndTime()#">
			</div>
		</div>

		<div class="form-group row">
			<label for="startDate" class="col-md-2 form-control-label">Description</label>
			<div class="col-md-10">
				<textarea name="description" id="description" class="form-control">#rc.item.getDescription()#</textarea>
			</div>
		</div>
	</form>
</cfoutput>