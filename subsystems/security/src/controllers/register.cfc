component accessors="true" output="false" hint="Register Controller" {

	property name="beanFactory";
	property name="securityService";

	public void function init(fw){
		variables.fw = arguments.fw;
	}


	public void function default(rc){
		rc.title = "Register";
		rc.heading = "Register";

		// If user is logged in then redirect to home
		if( getSecurityService().isLoggedIn() ){
			variables.fw.redirect(':main.default');
		}

		variables.fw.setLayout("public");
	}

}