component accessors="true" extends="model.beans.base.bean" {

	property name="beanfactory";
	property name="fw";

	property name="firstName" default="";
	property name="lastName" default="";
	property name="planId" default="0";
	property name="tenantId" default="0";
	property name="roles" default="";
	property name="groups" default="";
	property name="shadow" default="0";

	property name="tenantConfig" default="";
	property name="userConfig" default="";

	property name="securityService";

	public any function init(fw){
		variables.fw = arguments.fw;
		return this;
	}

	public boolean function isSuperAdmin(){
		return getSecurityService().isSuperAdmin();
	}

	public boolean function isAdmin(){
		return getSecurityService().isAdmin();
	}

	public boolean function isShadowing(){
		return getShadow();
	}

	public void function loadFromSession(){
		if( structKeyExists( session, "user") ){
			getBeanFactory().injectProperties(this,session.user);
		}
	}
}