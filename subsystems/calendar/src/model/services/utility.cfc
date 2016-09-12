component accessors="true" extends="common.model.services.subsystem" {

	public function init(){
		return this;
	}

	public struct function findNextPrevMonthYear(currentMonth,currentYear){
		var  = {};

		returnStruct.prevmonth = month(dateAdd("m",-1,createdate(arguments.currentYear,arguments.currentMonth,1)));
		returnStruct.nextmonth = month(dateAdd("m",1,createdate(arguments.currentYear,arguments.currentMonth,1)));

		if (returnStruct.prevmonth == 12){
			returnStruct.prevyear = arguments.currentYear - 1;
		} else {
			returnStruct.prevyear = arguments.currentYear;
		}

		if (returnStruct.nextmonth EQ 1){
			returnStruct.nextyear = arguments.currentYear + 1;
		} else {
			returnStruct.nextyear = arguments.currentYear;
		}

		return returnStruct;
	}
}