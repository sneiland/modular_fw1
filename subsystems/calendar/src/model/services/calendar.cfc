component accessors="true" extends="common.model.services.subsystem" {


	public function getCalendarMonth(
		required numeric calendarmonth
		, required numeric calendaryear
		, itemsTypes=""
	){
		var calarray = monthDayArray(arguments.calendarmonth,arguments.calendaryear);
		var startdate = calarray[1][1].date;
		var enddate = calarray[arrayLen(calarray)][7].date;
		var items = getItems(startdate,enddate,arguments.itemsTypes);

		return mergeCalArrayEvents(calarray,items);
	}


	public boolean function betweendates(
		required checkdate,
		required startdate,
		required enddate,
		boolean inclusive=1
	){
		var returnBool = false;

		if(
			(
				arguments.inclusive
				&& datecompare(arguments.checkdate,startdate,"d") >= 0
				&& datecompare(arguments.enddate,checkdate,"d") >= 0
			) || (
				!arguments.inclusive
				&& datecompare(arguments.checkdate,startdate,"d") == 1
				&& datecompare(arguments.enddate,checkdate,"d") == 1
			)
		){
			returnBool = true;
		}

		return returnBool;
	}

	public any function getItem(type="",id=0){
		return getCoreService().getItem( type=arguments.type, id=arguments.id );
	}

	public array function getItems(startdate,enddate,types=""){
		return getCoreService().getItems(startdate,enddate,types);
	}

	public struct[] function getItemTypes(){
		return getCoreService().getItemTypes();
	}


	public array function monthDayArray(
		required numeric calendarmonth,
		required numeric calendaryear,
		array events=arrayNew(1)
	){
		// Init arrays and structures
		var calarray = [];
		var weekarray = [];
		var daystruct = {};
		var date = "";

		// Setup counters
		var i = 0;
		var j = 0;
		var event = "";

		// Setup basic default values
		var weekCount = 5;
		var monthday = 1;
		var monthMarker = "current";

		// Get the start dates of the previous and current months
		var dtCurrentMonthStart = createDate(arguments.calendaryear,arguments.calendarmonth,1);
		var dtLastMonthStart = dateAdd("m",-1,dtCurrentMonthStart);

		// Number of days in each month
		var numDaysLastMonth = daysinmonth(dtLastMonthStart);
		var numDaysCurrentMonth = daysinmonth(dtCurrentMonthStart);

		// Get the offset of the first day in the current month
		var firstDayOffset = DayOfWeek(dtCurrentMonthStart);

		/*
			If the first day of the requested month does not fall on a sunday
			then we first fill in the days from the end of the previous month
		*/
		if(firstDayOffset != 1){
			monthMarker = "last";
			monthday = numDaysLastMonth - (firstDayOffset-2);
		}

		// Determine the number of weeks to display
		if(numDaysCurrentMonth == 28 && firstDayOffset == 1){
		      weekCount = 4;
		} else if( (numDaysCurrentMonth == 30 && firstDayOffset == 7) OR (numDaysCurrentMonth == 31 && firstDayOffset > 5) ){
		      weekCount = 6;
		}

		for(i=1; i<=weekCount; i++){
			weekarray = [];

			for(j=1; j<=7; j++){
				daystruct = {};

				// Build a date object for the current day
				if( monthMarker == "last" && arguments.calendarmonth == 1 ){
					date = createDate((arguments.calendaryear-1),12,monthday);
				} else if( monthMarker == "last" ){
					date = createDate(arguments.calendaryear,(arguments.calendarmonth-1),monthday);
				} else if( monthmarker == "current" ){
					date = createDate(arguments.calendaryear,arguments.calendarmonth,monthday);
				} else if( monthmarker == "next" && arguments.calendarmonth == 12 ){
					date = createDate((arguments.calendaryear+1),1,monthday);
				} else if( monthmarker == "next" ){
					date = createDate(arguments.calendaryear,arguments.calendarmonth+1,monthday);
				}

				daystruct = {
					dayofmonth = monthday
					,monthmarker = monthMarker
					,date = date
				};

				monthday++;

				// Handle month roll over
				if(monthMarker == "last" && monthday > numDaysLastMonth){
					monthday = 1;
					monthMarker = "current";
				} else if(monthMarker == "current" && monthday > numDaysCurrentMonth){
					monthday = 1;
					monthMarker = "next";
				}

				arrayAppend(weekarray,daystruct);
			}

			arrayAppend(calarray,weekarray);
		}

		return calarray;
	}


	public array function mergeCalArrayEvents(
		required array calarray,
		required array items
	){
		var returnArray = [];

		for(var calweek in arguments.calarray){
			for(var i=1; i<=7; i++){
				var todaysItems = [];

				// Merge in events
				for(var item in arguments.items){
					if(betweendates(calweek[i].date,item.getStartDate(),item.getEndDate())){
						arrayAppend(todaysItems,item);
					}
				}

				calweek[i].items=todaysItems;
			}

			arrayAppend(returnArray,calweek);
		}

		return returnArray;
	}

}