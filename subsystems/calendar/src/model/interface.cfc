/**
 * @hint Implement this interface in the main applications /model/subsystems directory
 * ensuring that the filename of the cfc matches the directory name of the subsystem
 *
 */
interface {

	/**
	 * @hint Return a single bean for a calendar event
	 **/
	public any function getItem( string type="", required numeric id ){}

	/**
	 * @hint Return an array of item beans for the date range optionally filtered by types
	 */
	public array function getItems(startdate,enddate,types=""){}

	/**
	 * @hint Return a string array of item type names
	 */
	public struct[] function getItemTypes(){}
}