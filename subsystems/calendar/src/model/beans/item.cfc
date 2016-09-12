component accessors="true" {

	property name="id";
	property name="startdatetime";
	property name="enddatetime";
	property name="label";
	property name="description";

	property name="type";
	property name="itemObject";

	public function init(){
		return this;
	}

	public function getStartDate(){
		return DateFormat(getStartDatetime(), "yyyy-mm-dd");
	}

	public function getStartTime(){
		return TimeFormat(getStartDatetime(), "H:mm");
	}

	public function getEndDate(){
		return DateFormat(getEndDatetime(), "yyyy-mm-dd");
	}

	public function getEndTime(){
		return TimeFormat(getEndDatetime(), "H:mm");
	}

	public string function getStartDateFormatted(){
		return dateFormat(getStartDate(),"short");
	}

	public string function getEndDateFormatted(){
		return dateFormat(getEndDate(),"short");
	}

	public boolean function updateData( vars ){
		setType( arguments.vars.type );
		return getItemObject().updateData(vars);
	}

}