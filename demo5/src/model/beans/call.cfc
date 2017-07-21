component accessors="true" extends="base.primary" {

	property name="Id" default="0";
	property name="tenantId";
	property name="subject" default="";
	property name="directionId";
	property name="directionName" default="";
	property name="statusId";
	property name="statusName" default="";
	property name="description" default="";
	property name="datetimeStart" default="";
	property name="durationMinutes" default="0";

	property name="relatedEntityTypeId";
	property name="relatedToTypeName";
	property name="relatedId" default="0";
	property name="relatedname" default="";

	property name="callsService";
	property name="timezonesLibrary";

	// derived fields
	property name="reminders";
	property name="users"; // Users attending the call
	property name="contacts";

	property name="durationHours";
	property name="startDate";
	property name="startTime";

	public boolean function load( required numeric Id ){
		var success = true;

		if( arguments.Id ){
			var data = getCallsService().getCallById(arguments.Id);

			if(data.recordCount){
				getBeanFactory().injectProperties(this,getFormatterLibrary().queryToStruct(data));
			} else {
				success = false;
			}
		}

		return success;
	}


	public array function getContacts(){
		if( !structkeyExists(variables,"contacts") || !isArray(variables.contacts) ){
			variables.contacts = [];

			// now get emails from the gateway
			if( getId() ){
				var data = getCallsService().getContacts( callId=getId() );

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


	public string function getDatetimeEnd(){
		return dateadd( "n", getDurationMinutes(), getDatetimeStart() );
	}


	public string function getDatetimeEndLocalized(){
		var timezone = getSecurityService().getUsersTimezone();
		return getTimeZonesLibrary().utcToTimezone(getDatetimeEnd(),timezone);
	}


	public string function getDatetimeStart(){
		if( isNull(variables.datetimeStart) || !len(trim(variables.datetimeStart))){
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


	public string function getEndDate(){
		if( len(trim( getDatetimeEndLocalized() )) ){
			return DateFormat( getDatetimeEndLocalized(),"mm/dd/yyyy" );
		} else {
			return '';
		}
	}


	public string function getEndTime(){
		if( len(trim( getDatetimeEndLocalized() )) ){
			return TimeFormat(getDatetimeEndLocalized(),"HH:mm");
		} else {
			return '';
		}
	}


	public array function getLeads(){
		if( !structkeyExists(variables,"leads") || !isArray(variables.leads) ){
			variables.leads = [];

			if( getId() ){
				var data = getCallsService().getLeads( callId=getId() );

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

			if( getId() ){
				var data = getCallsService().getReminders( callId=getId() );

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
			if( getId() ){
				var data = getCallsService().getUsers( callId=getId() );

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


	public void function populate( data ){
		super.populate( data );

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
	}


	public void function populateReminders( data ){
		variables.reminders = [];

		for(var i=1; i<=data.reminderCount; i++){
			if( structKeyExists(arguments.data,"reminderMinutes_#i#") && len(trim(arguments.data["reminderMinutes_#i#"])) ){
				var reminderData = {
					Id = getId()
					, minutesBefore = arguments.data["reminderMinutes_#i#"]
					, typeId = arguments.data["reminderType_#i#"]
					, sent = arguments.data["reminderSent_#i#"]
				};
				var bean = getBeanFactory().injectProperties("reminder",reminderData);

				arrayAppend(variables.reminders,bean);
			}
		}
	}


	public struct function save(){
		var result = {
			Id : getId()
			, success : false
			, errors : validate()
		};

		if( !arrayLen(result.errors) ){
			result.Id = getCallsService().save( this );

			if( result.Id ){
				setId( result.Id );
				result.success = true;
			}
		}

		return result;
	}


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