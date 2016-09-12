component accessors="true" {

	property name="calendarService";
	property name="utilityService";

	public function init( fw ){
		variables.fw = arguments.fw;
	}


	public function default( rc ){
		param name="rc.selectedDay" default="#day(now())#";
		param name="rc.selectedMonth" default="#month(now())#";
		param name="rc.selectedYear" default="#year(now())#";
		param name="rc.selectedView" default="monthly";
		param name="rc.selecteditemtypes" default="all";
		rc.itemTypes = getCalendarService().getItemTypes();
	}


	public function edit( rc ){
		param name="rc.type" default="";
		param name="rc.id" default="0";
		rc.item = getCalendarService().getItem( type=rc.type, id=rc.id );
		variables.fw.setLayout('none');
	}


	public function monthly( rc ){
		param name="rc.selectedMonth" default="#month(now())#";
		param name="rc.selectedYear" default="#year(now())#";
		param name="rc.selectedView" default="monthly";
		param name="rc.selectedType" default="all";

		var prevNextMonthYear = getUtilityService().findNextPrevMonthYear(rc.selectedMonth,rc.selectedYear);

		rc.prevMonth = prevNextMonthYear.prevMonth;
		rc.nextMonth = prevNextMonthYear.nextMonth;
		rc.prevYear = prevNextMonthYear.prevYear;
		rc.nextYear = prevNextMonthYear.nextYear;

		rc.calMonth = getCalendarService().getCalendarMonth( rc.selectedMonth, rc.selectedYear, rc.selectedType );

		variables.fw.setLayout('none');
	}

	public function save( rc ){
		param name="rc.id" default="0";
		param name="rc.type" default="";
		param name="rc.label" default="";
		param name="rc.startdate" default="";
		param name="rc.starttime" default="";
		param name="rc.enddate" default="";
		param name="rc.endtime" default="";
		param name="rc.description" default="";

		var item = getCalendarService().getItem( type=rc.type, id=rc.id );
		var success = item.updateData( rc );
		if(!isAjaxRequest()){
			variables.fw.redirect(variables.fw.getSection());
		} else {
			variables.fw.renderData('json', success);
		}
	}


	private function isAjaxRequest(){
		var headers = getHTTPRequestData().headers;
		if(structKeyExists(headers,'X-Requested-With') && headers['X-Requested-With'] == "XMLHttpRequest"){
			return true;
		} else {
			return false;
		}
	}

}