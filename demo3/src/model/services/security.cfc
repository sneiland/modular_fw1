component accessors="true" {

	property name="fw";

	public function init(){
		return this;
	}

	public any function onMissingMethod(missingMethodName,missingMethodArguments){
		var service = getFw().getSubsystemBeanFactory('security').getBean('securityService');
		return invoke(service,missingMethodName,missingMethodArguments);
	}

	public any function getUsersTimezone(){
		return 'US/Eastern';
	}

	public boolean function hasEditPermission(){
		return true;
	}

}