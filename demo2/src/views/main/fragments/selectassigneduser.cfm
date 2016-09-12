<cfoutput>
	<label for="assignedName" class="col-md-2 form-control-label">Assigned To:</label>
	<div class="col-sm-11 col-md-9">
		<input class="typeahead form-control" type="text" value="#rc.common.getAssignedName()#" name="assignedName" id="assignedName" required>
		<input type="hidden" value="#rc.common.getAssignedUserId()#" name="assignedUserId" id="assignedUserId">
	</div>
	<div class="col-sm-1 col-md-1" style="padding-left:0;margin-top:2px;">
		<button id="removeAssignedUser" class="btn btn-danger btn-sm"><i class="fa fa-times"></i></button>
	</div>

	<script>
		jsrequest.assigneelookupurl = '#buildUrl( action="tenants:users.lookup" )#';
	</script>
	<script src="/assets/js/views/assignee_select.js"></script>
</cfoutput>
