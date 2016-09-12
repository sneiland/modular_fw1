component accessors="true" {

	property name="beanFactory";
	property name="datatablesLibrary";
	property name="formatterLibrary";
	property name="securityService";
	property name="fw";

	public function init(){
		return this;
	}


	/**
	 *
	 *
	 * @multitenant Restrict results to current users tenant unless set to true
	 * @tenantId If multitenant is true allow for superadmin to optionally filter by different tenantIds
	 */
	private struct function getPagedResultset(vars,filters,gateway,multitenant=false,tenantId=0){
		var filtersStruct = getDatatablesLibrary().populateFilters(vars,filters);
	  	var sortArray = getDatatablesLibrary().populateSortArray(vars,"lastname(firstName)");

		// Force the tenantId for all non superadmins
		if( !arguments.multitenant || !getSecurityService().isSuperAdmin() ){
			arguments.tenantId = getSecurityService().getTenantId();
		}

		var result = arguments.gateway.getPaged(
			start=vars.start
			, length=vars.length
			, sortArray=sortArray
			, filters=filtersStruct
			, userId=session.user.userId
			, tenantId=arguments.tenantId
		);

		var returnStruct = {
			"draw" = vars.draw
			, "data" = variables.formatterLibrary.queryToArray(result.data)
			, "recordsTotal" = result.recordsTotal
			, "recordsFiltered" = result.recordsFiltered
		};

		return returnStruct;
	}
}