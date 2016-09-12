component {

	public component function init(){
		return this;
	}

	/**
	* @hint Converts a timezone specific datetime to utc
	*/
	public string function timezoneToUTC( required datetime, required string timezone){
		var timezoneObject = createObject("java","java.util.TimeZone").getTimeZone(arguments.timezone);
		var offset = timezoneObject.getOffset(javacast("long", dateDiff("s", createDateTime(1970, 1, 1, 0, 0, 0), arguments.datetime)*1000))/1000;
		return dateAdd("s", offset*-1, arguments.datetime);
	}

	public string function utcToTimezone( required utcdatetime, required string timezone){
		var timezoneObject = createObject("java","java.util.TimeZone").getTimeZone(arguments.timezone);
		var offset = timezoneObject.getOffset(javacast("long", dateDiff("s", createDateTime(1970, 1, 1, 0, 0, 0), arguments.utcdatetime)*1000))/1000;
		return dateAdd("s", offset, arguments.utcdatetime);
	}
}