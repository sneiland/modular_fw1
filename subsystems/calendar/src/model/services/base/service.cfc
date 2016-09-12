component accessors="true" {

	property name="beanFactory";
	property name="fw";

	public function init(){
		return this;
	}


	private function getPagedResultset(vars,filters,gateway,sessionvar,superAdminView=0){
		var filtersStruct = getDatatablesLibrary().populateFilters(vars,filters);
	  	var sortArray = getDatatablesLibrary().populateSortArray(vars,"lastname(firstName)");
	  	var securityService = getBeanFactory().getBean("securityService");

		// Restrict non super admins to their own tenant
		if(!superAdminView || !securityService.isSuperAdmin()){
			filtersStruct.tenantId = securityService.getLoggedinUsertenantId();
		}

	  	session[arguments.sessionvar].sortArray = sortArray;
	  	session[arguments.sessionvar].filtersStruct = filtersStruct;

		var result = arguments.gateway.getPaged(vars.start, vars.length, sortArray, filtersStruct, session.user.userId);

		var returnStruct = {
			"draw" = vars.draw
			, "data" = variables.datatablesLibrary.queryToArray(result.data)
			, "recordsTotal" = result.recordsTotal
			, "recordsFiltered" = result.recordsFiltered
		};

		return returnStruct;
	}


	private query function getResultsetForDownload(gateway,sessionvar){
		var sortArray = [];
		var filtersStruct = {};

		if(structKeyExists(session,sessionvar)){
			sortArray = session[sessionvar].sortArray;
			filtersStruct = session[sessionvar].filtersStruct;
		}

		return arguments.gateway.getResultsetForDownload(
			sortarray = sortArray
	  		, filtersStruct = filtersStruct
	  		, userId = session.user.userId
		);
	}


	private struct function queryToStruct(required query queryObj,numeric row=1){
		var returnStruct = {};
		var colArray = listToArray(arguments.queryObj.columnList);

		for(var col in colArray){
			returnStruct[col] = arguments.queryObj[col][arguments.row];
		}

    	return returnStruct;
	}

	private any function getCoreService(){
		var servicename = getFW().getSubsystem() & "CoreInterface";
		return getBeanFactory().getBean(servicename);
	}
}