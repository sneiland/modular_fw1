component accessors="true" extends="common.model.subsysteminterface" implements="subsystems.calendar.model.interface" {

	property name="beanFactory";
	property name="callsService";

	public struct function getConfig(){
		return {
			foo : "bar"
		};
	}

	/**
	 * @hint Return an array of item beans for the date range optionally filtered by types
	 * @bf Reference to the subsystems bean factory which I would ideally like to remove
	 */
	public array function getItems(startdate,enddate,types=""){
		var bf = getOwnBeanFactory();
		var data = fakeData();
		var returnArray = [];

		if( !(len(trim(arguments.types))) || arguments.types contains "call" ){
			var calls = getCallsService().getCallsBetweenDates( startdate=startdate, enddate=enddate );

			for( var call in calls ){
				var item = getCoreBeanFactory().getBean('calendaritem');
				item.setType( 'call' );
				item.setitemObject( call );
				returnArray.append(item);
			}
		}

		return returnArray;
	}


	public any function getItem( string type="", required numeric id ){
		var item = "";

		if( type == "call" ){
			var item = getCoreBeanFactory().getBean('calendaritem');
			item.setType("call");

			var call = getBeanFactory().getBean('call');
			call.load( arguments.id );

			item.setItemObject(call);
		} else {
			item = getOwnBeanFactory().getBean("item");
		}

		return item;
	}


	public struct[] function getItemTypes(){
		var itemTypes = [
			{
				value: "call"
				, name: "Call"
				, viewaction: ":call.default"
			}
			,{
				value:"meeting"
				, name: "Meeting"
			}
			,{
				value:"reminder"
				, name:"Reminder"
			}
		];
		return itemTypes;
	}


	private query function fakeData(){
		//var data = getCallsService().getCallsBetweenDates();

		var returnQuery = queryNew("startDate,enddate,label,id,type");
		returnQuery.addrow(5);

		returnQuery.setCell("startdate",now(),1);
		returnQuery.setCell("enddate",dateAdd("d",7,now()),1);
		returnQuery.setCell("label","First",1);
		returnQuery.setCell("id","1",1);
		returnQuery.setCell("type","call",1);

		returnQuery.setCell("startdate",dateAdd("d",1,now()),2);
		returnQuery.setCell("enddate",dateAdd("d",8,now()),2);
		returnQuery.setCell("label","Second",2);
		returnQuery.setCell("id","1",2);
		returnQuery.setCell("type","call",2);

		returnQuery.setCell("startdate",dateAdd("d",2,now()),3);
		returnQuery.setCell("enddate",dateAdd("d",9,now()),3);
		returnQuery.setCell("label","Third",3);
		returnQuery.setCell("id","1",3);
		returnQuery.setCell("type","call",3);

		returnQuery.setCell("startdate",dateAdd("d",3,now()),4);
		returnQuery.setCell("enddate",dateAdd("d",10,now()),4);
		returnQuery.setCell("label","Fourth",4);
		returnQuery.setCell("id","1",4);
		returnQuery.setCell("type","call",4);

		returnQuery.setCell("startdate",dateAdd("d",4,now()),5);
		returnQuery.setCell("enddate",dateAdd("d",11,now()),5);
		returnQuery.setCell("label","Fifth",5);
		returnQuery.setCell("id","1",5);
		returnQuery.setCell("type","call",5);

		return returnQuery;
	}
}