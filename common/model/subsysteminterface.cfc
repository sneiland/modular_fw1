component accessors="true" {

	property fw;
	property name="beanFactory";

	public function init(fw){
		variables.fw = arguments.fw;
		return this;
	}

	/**
	* @hint Returns a reference to the corresponding subsystems bean factory
	*/
	private function getOwnBeanFactory(){
		var subsystem = listLast(GetMetaData().name,".");
		return getfw().getSubsystemBeanFactory(subsystem);
	}


	private function getCoreBeanFactory(){
		return variables.fw.getDefaultBeanFactory();
	}

}