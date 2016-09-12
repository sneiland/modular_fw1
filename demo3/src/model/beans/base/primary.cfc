/**
* @hint Base bean for primary type records i.e. accounts, leads, contacts, prospects etc.
*/
component accessors="true" extends="bean" {

	property name="datetimeCreated" default="";
	property name="creatorId" default="0";
	property name="datetimeUpdated";
	property name="updatorId" default="0";
	property name="assignedUserId" default="0";

	// dependencies
	property name="securityService";
	property name="timeZonesLibrary";

	// derived fields
	property name="creatorName";
	property name="updatorName";
	property name="assignedName" default="";
	property name="assignedUser";

	public any function getAssignedUser(){
		if( isNull(variables.assignedUser) ){
			variables.assignedUser = getFw().getSubsystemBeanFactory('tenants').getBean('user');
			if( variables.assignedUserId > 0 ){
				variables.assignedUser.load(variables.assignedUserId);
			} else if( !getAccountId() ) {
				variables.assignedUser.load( getSecurityService().getUserId() );
			}
		}

		return variables.assignedUser;
	}

	public string function getAssignedName(){
		if ( !getId() ){
			return session.user.lastName & ', ' & session.user.firstName;
		} else if( !getAssignedUserId() ) {
			return '';
		} else {
			return variables.assignedName;
		}
	}

	public string function getAssignedNameFormatted(){
		if( getAssignedUserId() ){
			return getAssignedName();
		} else {
			return '<span class="text-muted">Unassigned</span>';
		}
	}

	public numeric function getAssignedUserId(){
		if ( !(variables.assignedUserId > 0) && !getId() ){
			return session.user.userId;
		} else {
			return variables.assignedUserId > 0 ? variables.assignedUserId : 0 ;
		}
	}


	public string function getCreatorNameFormatted(){
		return getCreatorName();
	}


	/**
	 * @hint Returns the datetimeCreated localized
	 */
	public string function getDatetimeCreatedLocalized(){
		var timezone = getSecurityService().getUsersTimezone();
		return getTimeZonesLibrary().utcToTimezone(getDatetimeCreated(),timezone);
	}


	public string function getDatetimeCreatedFormatted(){
		return getFormatterLibrary().formatDatetime( getDatetimeCreatedLocalized() );
	}


	/**
	 * @hint Returns the datetimeCreated localized
	 */
	public string function getDatetimeUpdatedLocalized(){
		var timezone = getSecurityService().getUsersTimezone();
		return getTimeZonesLibrary().utcToTimezone(getDatetimeUpdated(),timezone);
	}


	public string function getDatetimeUpdatedFormatted(){
		return getFormatterLibrary().formatDatetime( getDatetimeUpdatedLocalized() );
	}


	public numeric function getUpdatorId(){
		return variables.updatorId > 0 ? variables.updatorId : 0 ;
	}


	public string function getUpdatorNameFormatted(){
		return getUpdatorName();
	}

}