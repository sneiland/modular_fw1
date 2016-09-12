component accessors="true" extends="common.model.subsysteminterface" implements="subsystems.help.model.interface" {

	property securityService;

	public boolean function hasEditPermission(){
		return true;
	}

}