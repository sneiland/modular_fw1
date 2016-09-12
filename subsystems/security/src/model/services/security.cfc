component accessors="true" extends="common.model.services.subsystem" {

	property name="securityGateway";

	public any function init( boolean enablerememberme=false, boolean enableregister=false ){
		variables.enablerememberme = arguments.enablerememberme;
		variables.enableregister = arguments.enableregister;
		return this;
	}


	public boolean function remembermeEnabled(){
		return variables.enablerememberme;
	}


	public boolean function registerEnabled(){
		return variables.enableregister;
	}


	public numeric function getLoggedinUserId(){
		return getUserId();
	}



	public numeric function getUserId(){
		var returnId = 0;

		if(isDefined("session.user")){
			returnId = session.user.userId;
		}

		return returnId;
	}


	/**
	* @hint Does the current logged in user have a feature through their accounts plan
	*/
	public boolean function hasPermission(required numeric permissionId){
		param name="session.user.permissions" default="#arrayNew(1)#";
		return arrayFind(session.user.permissions,permissionId) ? true : false;
	}


	public boolean function hasEditPermission(){
		return true;
	}


	public boolean function isLoggedIn(){
		param name="session.user.userId" default="0";
		return session.user.userid > 0;
	}



	public struct function login(string email="", string password="", boolean rememberme=false){
		var loginResult = {
			success : false
			, passwordChangeRequired : false
			, firstLogin : false
		};

		// Reset the cookie keys used for the remember me function
		cookie.remembermeGUID = "";
		cookie.remembermesessionid = "";
		cookie.userId = 0;
		cookie.email = "";

		if( len(trim(arguments.email)) AND len(trim(arguments.password)) ){
			// Setup the users session structure
			setupSession();
			var GUID = createGUID();

			// If rememberme checked and a good login then store keys in the cookie
			if( rememberme ){
				// 7 days
				cookie name="remembermeGUID" value=GUID expires="7";
				cookie name="remembermesessionid" value=session.sessionid expires="7";
				cookie name="userId" value=session.user.userId expires="7";
				cookie name="email" value=session.user.email expires="7";
			}

			loginResult  = {
				success : true
				, firstLogin :  0
			};
		}

		return loginResult;
	}


	public void function logout(){
		session.user.userId = 0;

		// Clear the remember me cookie values
		cookie name="remembermeGUID" expires="now";
		cookie name="remembermeSessionId" expires="now";
		cookie name="userId" expires="now";
		cookie name="email" expires="now";
	}




	private void function setupSession( ){
		session.user = {
			userId : 1
			, firstName : "demo"
			, PASSWORDCHANGEREQUIRED : false
		};
	}
}