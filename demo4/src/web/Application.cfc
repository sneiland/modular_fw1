component accessors="true" extends="framework.one" {

	this.name = "demo4";
	this.clientmanagement = FALSE;
	this.Sessionmanagement = TRUE;
	this.Sessiontimeout = createtimespan(0,1,0,1);
	this.applicationtimeout = createtimespan(0,1,0,1);
	this.loginstorage = "session";
	this.scriptProtect = FALSE;

	// Set tag defaults
	this.tag.component.output = false;
	this.tag.function.output = false;

	this.mappings["/controllers"] = expandPath("../controllers");
	this.mappings["/model"] = expandPath("../model");
	this.mappings["/layouts"] = expandPath("../layouts");
	this.mappings["/views"] = expandPath("../views");
	this.mappings["/subsysteminterfaces"] = expandPath("../subsysteminterfaces");

	// Create a direct path to the custom tags
	this.customtagpaths = expandPath("../../../common/customtags");

	variables.framework = {
		reload : "reload"
		, password : "true"
		, defaultSection : "main"
		, diConfig : {
			constants : {
				dsn : "demo"
			}
			, singulars : {
				factories : "factory"
				, libraries : "library"
			}
		}
		, diLocations = "/model,/common/model"
		, environments : {
			local : {
				reloadApplicationOnEveryRequest : true
				, trace : true
				, error : "main.error"
			}
		}
		, useMasterlayoutForSubsystems : true
		, subsystems["help"] : {
			diConfig : {
				constants : {
					dsn : "helpsubsystem"
				}
			}
		}
		, subsystems["security"] : {
			diConfig : {
				constants : {
					enableregister : false
				}
			}
		}
	};

	variables.csschecks = {
		defaultsfound: []
		, defaultsnotfound: []
		, overridesfound: []
		, overridesnotfound: []
	};

	property name="securityService";

	public function setupApplication(){
		application.startTime = now();
		application.appDir = getDirectoryFromPath(getCurrentTemplatePath());
		application.refreshTimestamp = getTickCount();
	}


	public void function setupSession(){
		session.user = {
			userId : 0
			, firstName : ""
			, lastName : ""
			, email : ""
			, tenantId : 0
			, groups : []
		};
	}


	public function setupRequest(){
		// Check if a user is authorized to view the current action
		controller('security:main.checkAuthorization');

		include template="/common/udfs/countryOptions.cfm";
		include template="/common/udfs/ordinalSuffix.cfm";
	}


	public function before(rc){
		param name="rc.css" default=arrayNew(1);

		// Test for the X-Requested-With header and disabled debug output if value of XMLHttpRequest
		var headers = getHTTPRequestData().headers;
		if(structKeyExists(headers,'X-Requested-With') && headers['X-Requested-With'] == "XMLHttpRequest"){
			setting showdebugoutput="false";
			disableFrameworkTrace();
		}

		// Populate rc.css with subsystem specific css files
		if( len(getSubsystem()) ){
			queueSubsystemCSS( getSubsystem(), rc );
		}
	}

	public function after(rc){}

	// Wire up the core interface components of each subsystem
	public void function setupSubsystem(subsystem){
		if(
			arguments.subsystem != ']['
			&& fileExists( expandPath("../subsysteminterfaces/" & arguments.subsystem & ".cfc") )
			&& !getBeanFactory().CONTAINSBEAN(arguments.subsystem & "CoreInterface")
		){
			getBeanFactory().declareBean(arguments.subsystem & "CoreInterface", "subsysteminterfaces." & arguments.subsystem, true);
		}
	}


	public function onMissingView(rc){
		return view( 'main/pagenotfound' );// Set view to the missing page message
	}


	public function getEnvironment() {
		return 'local';
	}


	private function queueSubsystemCSS( subsystem, rc ){
		var defaultwebpath = variables.framework.base & "subsystems/" & arguments.subsystem & "/assets/css/default.css";
		var defaultsystempath = expandpath( "/subsystems/#arguments.subsystem#/web/assets/css/default.css" );

		queueSubsystemCssFile( arguments.subsystem, defaultsystempath, defaultwebpath, variables.csschecks.defaultsfound, variables.csschecks.defaultsnotfound, rc );
	}


	private function queueSubsystemCssFile( required string subsystem, required string filepath, webpath, foundarray=[], notfoundarray=[], rc ){
		if(
			arrayFindNoCase(arguments.foundarray, arguments.subsystem)
			|| ( !arrayFindNoCase(arguments.notfoundarray, arguments.subsystem) && fileExists(arguments.filepath))
		){
			arrayAppend(rc.css,arguments.webpath);
			if( !arrayFindNoCase(arguments.foundarray, arguments.subsystem) ){
				arrayAppend(arguments.foundarray , arguments.subsystem);
			}
		} else if( !arrayFindNoCase(arguments.notfoundarray, arguments.subsystem) ){
			arrayAppend(arguments.notfoundarray , arguments.subsystem);
		}
	}
}