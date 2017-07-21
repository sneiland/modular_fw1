component accessors="true" {

	property name="callsGateway";
	property name="beanfactory";

	function getCallById( callId ){
		return getCallsGateway().getCallById( arguments.callId );
	}

	function getCallsBetweenDates( startdate, enddate ){
		var data = getCallsGateway().getCallsBetweenDates( arguments.startdate, arguments.enddate );
		var calls = [];
		for( var record in data ){
			var call = variables.beanfactory.getBean('call');
			call.setDatetimeStart( record.datetimeStart );
			call.setDatetimeEnd( record.datetimeStart );
			call.setSubject( record.subject );
			call.setDescription( record.description );
			call.setId( record.callId );
			arrayAppend(calls, call);
		}

		return calls;
	}

	function save( call ){
		return getCallsGateway().save( arguments.call );
	}

}