component accessors="true" extends="framework.one" {

	this.name = "demo1";
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
	this.mappings["/subsystems"] = expandPath("../subsystems");

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

	public function setupRequest(){
		include template="/common/udfs/countryOptions.cfm";
		include template="/common/udfs/ordinalSuffix.cfm";
	}


	public function before(rc){
		param name="rc.css" default=[];
		// Test for the X-Requested-With header and disabled debug output if value of XMLHttpRequest
		var headers = getHTTPRequestData().headers;
		if(structKeyExists(headers,'X-Requested-With') && headers['X-Requested-With'] == "XMLHttpRequest"){
			setting showdebugoutput="false";
			disableFrameworkTrace();
		}
	}


	public function onMissingView(rc){
		return view( 'main/pagenotfound' );// Set view to the missing page message
	}


	public function getEnvironment() {
		return 'local';
	}
}