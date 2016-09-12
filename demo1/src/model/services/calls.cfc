component accessors="true" {

	property name="callsGateway";

	function getCallById( callId ){
		return getCallsGateway().getCallById( arguments.callId );
	}

	function getCallsBetweenDates( startdate, enddate ){
		return getCallsGateway().getCallsBetweenDates( arguments.startdate, arguments.enddate );
	}

	function save( call ){
		return getCallsGateway().save( arguments.call );
	}

}