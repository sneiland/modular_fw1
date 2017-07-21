component accessors="true" {

	property name="helpService";

	public void function init(fw){
		variables.fw = arguments.fw;
	}


	public void function before(rc){
		param name="rc.modal" default=false;
		if( rc.modal ){
			variables.fw.setLayout('modal');
		}
	}


	public void function default(rc){
		param name="rc.search" default="";
		rc.helpPagesList = getHelpService().getHelpPagesForList(search=rc.search);
	}


	public void function edit(rc){
		if( !getHelpService().hasEditPermission() ){
			variables.fw.redirect("main.default");
		}

		// Lookup existing data if any
		var helpDataQry = getHelpService().getHelpPageByAction(helpaction=rc.helpaction);

		// Populate struct with existing data if any
		if( helpDataQry.recordcount ){
			rc.helpData = {
				Id:helpDataQry.Id,
				title:helpDataQry.title,
				pageContent:helpDataQry.pageContent
			};
		} else {
			// Populate helpData Struct with new defaults
			rc.helpData = {
				Id:0,
				title:"",
				pageContent:""
			};
		}
	}


	public void function save(rc){
		var saveSuccess = getHelpService().updateHelpPage(
			Id = rc.Id
			,title = rc.title
			,pageContent = rc.pageContent
			,helpAction = rc.helpaction
		);
		variables.fw.renderData('json',saveSuccess);
	}


	public void function modal(rc){
		rc.hasEditPermission = getHelpService().hasEditPermission();
		rc.getHelpPage = getHelpService().getHelpPageByAction(helpAction=rc.helpaction);
		rc.helpaction = listfirst(rc.helpaction,"?");
		variables.fw.setLayout('modal');
	}


	public void function view(rc){
		rc.getHelpPage = getHelpService().getHelpPageById(Id=rc.Id);
	}
}