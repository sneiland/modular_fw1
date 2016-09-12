component accessors="true" extends="common.model.subsysteminterface" implements="subsystems.help.model.interface" {

	public boolean function hasEditPermission(){
		var securityService = getFw().getSubsystemBeanFactory('security').getBean('securityService');
		//var securityService = getBeanFactory().getBean("securityCoreInterface");
		return securityService.hasEditPermission();
	}

}