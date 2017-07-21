component accessors="true" implements="subsystems.calendar.model.beans.item" {

	property name="type" default="";
	property name="itemObject";
	property name="fw";

	public component function init( fw ){
		variables.fw = arguments.fw;
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

	public string function getEndDate(){
		var enddate = "";
		if( getType() == "call"){
			enddate = getItemObject().getEndDate();
		}
		return enddate;
	}

	public string function getEndTime(){
		var endtime = "";
		if( getType() == "call"){
			endtime = getItemObject().getEndTime();
		}
		return endtime;
	}

	public function setId( id ){
		if( getType() == "call"){
			getItemObject().setId( arguments.id );
		}
	}

	public function getId(){
		if( getType() == "call"){
			return getItemObject().getId();
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

	public string function getStartDate(){
		var returnval = "";
		if( getType() == "call"){
			returnval = getItemObject().getStartDate();
		}
		return returnval;
	}

	public string function getStartDateFormatted(){
		var returnval = "";
		if( getType() == "call"){
			returnval = getItemObject().getStartDateFormatted();
		}
		return returnval;
	}

	public string function getEndDateFormatted(){
		var returnval = "";
		if( getType() == "call"){
			returnval = getItemObject().getEndDateFormatted();
		}
		return returnval;
	}


	public string function getStartTime(){
		var startTime = "";

		if( getType() == "call"){
			startTime = getItemObject().getStartTime();
		}

		return startTime;
	}

	public string function getType(){
		return variables.type;
	}


	public void function setStartDatetime( startdatetime ){
		if( getType() == "call"){
			getItemObject().setStartDatetime(startdatetime);
		}
	}

	public void function setEndDatetime( enddatetime ){
		if( getType() == "call"){
			getItemObject().setEndDatetime(enddatetime);
		}
	}

	public void function setDescription( description ){
		if( getType() == "call"){
			getItemObject().setDescription(description);
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

		if( getType() == "call" ){
			getItemObject().save( vars );
		}
		return true;
	}

}