component accessors="true" extends="subsystems.calendar.model.beans.item" {

	property name="type";
	property name="itemObject";

	function init(){
		return this;
	}


	public any function save(){
		getItem().save();
	}

	public function setDescription( description ){
		getItemObject().setDescription( arguments.description );
	}

	public function getDescription(){
		return getItemObject().getDescription();
	}

	public function setId( id ){
		if( getType() == "call"){
			getItemObject().setCallId( arguments.id );
		}
	}

	public function getId(){
		if( getType() == "call"){
			return getItemObject().getCallId();
		}
	}

	public function setLabel( label ){
		if( getType() == "call"){
			getItemObject().setSubject( arguments.label );
		}
	}

	public function getLabel(){
		if( getType() == "call"){
			return getItemObject().getSubject();
		}
	}

	public function setStartDate( startdate ){
		if( getType() == "call"){
			getItemObject().setStartDate( arguments.startdate );
		}
	}

	public function getStartDate(){
		if( getType() == "call"){
			return getItemObject().getStartDate();
		}
	}

	public boolean function updateData( vars ){
		setId( arguments.vars.id );
		setType( arguments.vars.type );
		setLabel( arguments.vars.label );
		setStartDate( arguments.vars.startdate );
		//setStartTime( arguments.vars.starttime );
		//setEndDate( arguments.vars.enddate );
		//setEndTime( arguments.vars.enddate );
		setDescription( arguments.vars.description );
		getItemObject().save();

		return true;
	}


	public function onMissingMethod(missingMethodName,missingMethodArguments){
		var gw = getItemObject();
		return invoke(gw,missingMethodName,missingMethodArguments);
	}

}