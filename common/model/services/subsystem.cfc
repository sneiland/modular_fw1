component accessors="true" extends="model.services.base.service" {

	property name="beanFactory";
	property name="fw";

	public function init(){
		return this;
	}

	private any function getCoreService(){
		var servicename = getFW().getSubsystem() & "CoreInterface";
		return getBeanFactory().getBean(servicename);
	}

}