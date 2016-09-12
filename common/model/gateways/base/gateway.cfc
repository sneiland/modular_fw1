component {

	public function init(dsn){
		variables.dsn = arguments.dsn;
		return this;
	}


	public function getDSN(){
		return variables.dsn;
	}


	/**
	 * @hint takes an array of sorting rules and generates a sql order by string
	 * @permittedcolumns limits the string to only those that exactly match the expected values (prevents sql injection)
	 **/
	private string function generateSortString(required array sortArray,required string permittedcolumns){
		var col = "";
		var dir = "";
		var returnString = "";
		var sortLength = arrayLen(arguments.sortArray);

		if(sortLength){
			for(var i=1; i<=sortLength; i++){
				col = sortArray[i].col;
				dir = sortArray[i].dir;

				if(listfindnocase(arguments.permittedcolumns,col) && (dir == "asc" || dir == "desc")){
					if(len(returnString) != 0){
						returnString = returnString & ", ";
					}

					returnString = returnString & col & " " & dir;
				}
			}
		}

		return returnString;
	}

}