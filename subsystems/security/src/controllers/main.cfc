component accessors="true" output="false" hint="Security Controller" {

	property name="beanFactory";
	property name="securityService";

	public void function init(fw){
		variables.fw = arguments.fw;
	}


	public function before(rc){
		rc.secUser = getBeanFactory().getBean("secUser");
		rc.secUser.loadFromSession();
	}


	public void function default(rc){
		rc.title = "Login";
		rc.heading = "Login";
		rc.rememberme = getSecurityService().remembermeEnabled();
		rc.enableregister = getSecurityService().registerEnabled();

		// If the remember me feature is enabled and user not already logged in try to auto login
		if( !getSecurityService().isLoggedIn() && rc.rememberme ){
			getSecurityService().autologin();
		}

		// If user is logged in then redirect to home
		if( getSecurityService().isLoggedIn() ){
			variables.fw.redirect(':main.default');
		}

		variables.fw.setLayout("public");
	}


	public void function changepassword(rc){
		rc.heading = "Change Password";
		rc.title = "Change Password";

		param name="rc.newpassword" default="";
		param name="rc.confirmpassword" default="";
		param name="rc.errors" default="#arrayNew(1)#";

		if( structKeyExists(form, "returnaction") ){
			var result = getSecurityService().changePassword(
				  newpassword = rc.newpassword
				, confirmpassword = rc.confirmpassword
				, requireCurrentPassword = false
			);

			if( result.success ){
				session.user.passwordChangeRequired = false;
				variables.fw.redirect(action=":main");
			}
		}

		variables.fw.setLayout("public");
	}


	public void function checkAuthorization(rc){
		param name="session.user.passwordChangeRequired" default="0";

		if(
			getSecurityService().isLoggedIn()
			&& session.user.passwordChangeRequired
			&& variables.fw.getSection() != 'security'
			&& !listfindnocase( 'changepassword,dopasswordchange', variables.fw.getItem() )
		){
			variables.fw.redirect(action="security:main.changepassword");

		} else if( getSecurityService().isLoggedIn() ) {
			// Load the users nav array
			rc.navArray = getNavigationService().getUsersNavArray();

		} else if( !isPublicArea() ){
			// If not a public section and not logged in redirect to login form
			variables.fw.redirect('security:main');
		}
	}


	public void function doautologin(rc){
		param name="rc.email" default="";
		param name="rc.password" default="";
		param name="rc.rememberme" default="0";

		var loginResult = getSecurityService().login(email=rc.email,password=rc.password,rememberme=rc.rememberme);

		if( loginResult.success && session.user.passwordChangeRequired){
			variables.fw.redirect(action="main.changepassword");
		} else if( loginResult.success ){
			variables.fw.redirect(":main");
		} else {
			variables.fw.redirect("main.default");
		}
	}


	public void function dologin(rc){
		param name="rc.email" default="";
		param name="rc.password" default="";
		param name="rc.rememberme" default="0";

		var loginResult = getSecurityService().login(email=rc.email,password=rc.password,rememberme=rc.rememberme);

		if( loginResult.success && session.user.passwordChangeRequired){
			variables.fw.redirect(action="main.changepassword");
		} else if( loginResult.success ){
			variables.fw.redirect(":main");
		} else {
			variables.fw.redirect("main.default");
		}
	}


	public void function dologout(rc){
		getSecurityService().logout();
		variables.fw.redirect("main.default");
	}


	public void function dopasswordreset(rc){
		param name="rc.resetCode" default="";
		param name="rc.newpassword" default="";
		param name="rc.confirmpassword" default="";

		var	result = getSecurityService().resetPassword(
			resetCode = resetCode
			, password = password
			, confirmpassword = confirmpassword
		);

		if( result.success ){
			variables.fw.redirect(action="main.default",querystring="reset=complete");
		} else if( arrayLen(result.errors) ){
			variables.fw.redirect(action="main.resetpassword",querystring="resetCode=#resetCode#&errormsg=#result.errors[1]#");
		}
	}


	public void function forgotpassword(rc){
		rc.heading = "Forgot Password";
		rc.title = "Reset Password";
		variables.fw.setLayout("public");
	}


	public void function logout(rc){
		rc.title = "Logout";
		rc.heading = "Logout";
		variables.fw.setLayout("public");
	}


	public void function resetpassword(rc){
		rc.heading = "Reset Password";
		rc.title = "Reset Password";
		variables.fw.setLayout("public");
	}


	public void function sendpasswordreset(rc){
		param name="rc.email" default="";

		rc.resetResult = getSecurityService().sendPasswordReset(email=rc.email);

		variables.fw.setLayout("public");
	}





	public void function checkAuthorization(rc){
		param name="session.user.passwordChangeRequired" default="0";

		if(	!getSecurityService().isLoggedIn() && variables.fw.getSubsystem() != "security" ){
			variables.fw.redirect('security:main');
		}
	}

}