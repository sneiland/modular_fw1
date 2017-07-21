component accessors="true" extends="common.model.services.subsystem" {

	property name="helpGateway";
	property name="applicationId" default="0";

	private function getApplicationId(){
		if( !variables.applicationId ){
			variables.applicationId = getHelpGateway().getApplicationId( application.applicationname );
		}

		return variables.applicationId;

	}

	public function getHelpPageByAction( string helpaction="" ){
		return getHelpGateway().getHelpPageByAction( helpaction=arguments.helpaction, applicationId=getApplicationId() );
	}


	public function getHelpPagesForList(string search=""){
		return getHelpGateway().getHelpPagesForList(
			search = arguments.search
			, userId = 1
			, isAdmin = 1
			, applicationId = getApplicationId()
		);
	}


	public boolean function hasEditPermission(){
		return getCoreService().hasEditPermission();
	}


	public function updateHelpPage( Id, title, pageContent, helpAction ){
		return getHelpGateway().updateHelpPage(
			Id = arguments.Id
			, title = arguments.title
			, pageContent = arguments.pageContent
			, helpAction = arguments.helpAction
			, applicationId = getApplicationId()
		);
	}

}