component accessors="true" extends="common.model.subsysteminterface" implements="subsystems.security.model.interface" {

	public boolean function hasEditPermission(){
		var securityService = getFw().getSubsystemBeanFactory('security').getBean('securityService');
		//var securityService = getOwnBeanFactory().getBean('securityService');
		return securityService.hasEditPermission();
	}

}