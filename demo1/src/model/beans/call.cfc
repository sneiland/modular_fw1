component accessors="true" extends="base.primary" {

	property name="callId" default="0";
	property name="subject";
	property name="description";
	property name="datetimeStart";
	property name="datetimeEnd";

	property name="callsService";
	property name="formatterLibrary";

	// derived fields
	property name="reminders";
	property name="users"; // Users attending the call
	property name="contacts";

	property name="durationHours";
	property name="startDate";
	property name="startTime";

	public numeric function getId(){
		return getCallId();
	}

	public boolean function load( required numeric callId ){
		var success = true;

		if( arguments.callId ){
			var data = getCallsService().getCallById(arguments.callId);

			if(data.recordCount){
				getBeanFactory().injectProperties(this,getFormatterLibrary().queryToStruct(data));
			} else {
				success = false;
			}
		}

		return success;
	}


	public numeric function getCallId(){
		return (variables.callId > 0) ? variables.callId : 0;
	}


	public array function getContacts(){
		if( !structkeyExists(variables,"contacts") || !isArray(variables.contacts) ){
			variables.contacts = [];

			// now get emails from the gateway
			if( getCallId() ){
				var data = getCallsService().getContacts( callId=getCallId() );

				if(data.recordCount){
					for(var row in data){
						var bean = getBeanFactory().injectProperties("callAttendee",row);
						bean.setType('contact');
						arrayAppend(variables.contacts,bean);
					}
				}
			}
		}

		return variables.contacts;
	}


	public string function getDatetimeStart(){
		if( isNull(variables.datetimeStart) ){
			var timezone = getSecurityService().getUsersTimezone();
			variables.datetimeStart = getTimeZonesLibrary().timezoneToUTC(now(),timezone);
		}

		return variables.datetimeStart;
	}


	/**
	 * @hint Returns the datetimestart localized
	 */
	public string function getDatetimeStartLocalized(){
		var timezone = getSecurityService().getUsersTimezone();
		return getTimeZonesLibrary().utcToTimezone(getDatetimeStart(),timezone);
	}


	public string function getDatetimeStartFormatted(){
		return getFormatterLibrary().formatDatetime( getDatetimeStartLocalized() );
	}


	public string function getDescriptionFormatted(){
		return getFormatterLibrary().formatIfBlank( getDescription() );
	}


	public numeric function getDurationHoursPart(){
		return int( getDurationMinutes()/60 );
	}


	public numeric function getDurationMinutesPart(){
		return ( getDurationMinutes() mod 60 );
	}


	public string function getDurationFormatted(){
		return getDurationHoursPart() & " hrs " & getDurationMinutesPart() & " minutes";
	}


	public array function getLeads(){
		if( !structkeyExists(variables,"leads") || !isArray(variables.leads) ){
			variables.leads = [];

			if( getCallId() ){
				var data = getCallsService().getLeads( callId=getCallId() );

				if(data.recordCount){
					for(var row in data){
						var bean = getBeanFactory().injectProperties("callAttendee",row);
						bean.setType('lead');
						arrayAppend(variables.leads,bean);
					}
				}
			}
		}

		return variables.leads;
	}


	public array function getReminders(){
		if( !structkeyExists(variables,"reminders") || !isArray(variables.reminders) ){
			variables.reminders = [];

			if( getCallId() ){
				var data = getCallsService().getReminders( callId=getCallId() );

				if(data.recordCount){
					for(var row in data){
						var bean = getBeanFactory().injectProperties("reminder",row);
						arrayAppend(variables.reminders,bean);
					}
				}
			}
		}

		return variables.reminders;
	}


	public string function getStartDate(){
		if( len(trim( getDatetimeStartLocalized() )) ){
			return DateFormat( getDatetimeStartLocalized(),"mm/dd/yyyy" );
		} else {
			return '';
		}
	}


	public string function getStartTime(){
		if( len(trim( getDatetimeStartLocalized() )) ){
			return TimeFormat(getDatetimeStartLocalized(),"HH:mm");
		} else {
			return '';
		}
	}


	public array function getUsers(){
		if( !structkeyExists(variables,"users") || !isArray(variables.users) ){
			variables.users = [];

			// now get emails from the gateway
			if( getCallId() ){
				var data = getCallsService().getUsers( callId=getCallId() );

				if(data.recordCount){
					for(var row in data){
						var bean = getSubsystemBeanFactory('tenants').injectProperties("callAttendee",row);
						bean.setType('user');
						arrayAppend(variables.users,bean);
					}
				}
			}
		}

		return variables.users;
	}


	public function save(){
		result.callId = getCallsService().save( this );
		return true;
	}

/*

	public struct function save(data){
		getBeanfactory().injectProperties(this,data);

		variables.reminders = [];

		setDurationMinutes( getDurationMinutes() + (getDurationHours() * 60) );

		var localDatetimeStart = createDatetime(
			Year( data.StartDate )
			, Month( data.startDate )
			, Day( data.startDate )
			, Hour( data.startTime )
			, Minute( data.startTime)
			, 0
		);
		var timezone = getSecurityService().getUsersTimezone();
		var utcDatetimeStart = getTimeZonesLibrary().timezoneToUTC(localDatetimeStart,timezone);

		setDatetimeStart( utcDatetimeStart );

		var result = {
			callId : getCallId()
			, success : false
			, errors : validate()
		};

		if( !arrayLen(result.errors) ){
			for(var i=1; i<=data.reminderCount; i++){
				if( structKeyExists(arguments.data,"reminderMinutes_#i#") && len(trim(arguments.data["reminderMinutes_#i#"]))){
					var reminderData = {
						callId = getCallId()
						, minutesBefore = arguments.data["reminderMinutes_#i#"]
						, typeId = arguments.data["reminderType_#i#"]
						, sent = arguments.data["reminderSent_#i#"]
					};
					var bean = getBeanFactory().injectProperties("reminder",reminderData);

					arrayAppend(variables.reminders,bean);
				}
			}

			result.callId = getCallsService().save( this );

			if( result.callId ){
				setCallId( result.callId );
				result.success = true;
			}
		}

		return result;
	}*/


	public struct function sendInvites(){
		var result = {
			success : false
			, errors : []
		};

		if( !arrayLen(result.errors) ){
			result.success = getCallsService().sendInvites( this );
		}

		return result;
	}

}