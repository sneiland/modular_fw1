component {

	/**
	 * @hint Utility function that takes a list of fieldnames and if it finds them
	 * 		 in the supplied collection with a non emptystring value copies them over into a return
	 **/
	public struct function populateFilters( required struct varsCollection, required string fieldlist ) {
		var result = {};
		var fieldsArray = listToArray(arguments.fieldlist);

		for(var field in fieldsArray){
			if(structKeyExists(varsCollection,field) && len(trim(varsCollection[field]))){
				result[field]  = varsCollection[field];
			}
		}

		return result;
	}

	/**
	 * @hint Utility function that takes datatables sorting vars and converts them to an array
	 * @pairedsort if passed a list of fields to sort by in the form 'first(second)'
	 * 			the second sort column is appended to the sort array if the first sort column is found
	 * 			This is userful for sorting by firstname lastname pairings
	 **/
	public array function populateSortArray( required struct urlvars, string pairedsorts="") {
		// Since we dont know how many of the variables passed relate to sorting set the limit equal to the total count
		var loopmax = structCount(arguments.urlvars);
		var orderColIndex = 0;
		var resultArray = [];
		var sort = {};
		var pairs = buildPairsArray(pairedsorts);

		// Loop starts at 0 for datatables zero based index
		for(var i=0; i<loopmax; i++){
			if(structKeyExists(arguments.urlvars,"order[#i#][column]")){
				orderColIndex = arguments.urlvars["order[#i#][column]"];

				sort.dir = arguments.urlvars["order[#i#][dir]"];
				sort.col = arguments.urlvars["columns[#orderColIndex#][data]"];

				ArrayAppend(resultArray, duplicate(sort));

				var pairindex = indexOfFirstKeyValue(pairs,sort.col);
				if(pairindex){
					sort.col = pairs[pairindex].second;
					ArrayAppend(resultArray, duplicate(sort));
				}
			} else {
				// End the loop once we can no longer find any sorting related variables
				break;
			}
		}


		return resultArray;
	}

	/**
	 * @hint converts a list if pairs written in the format 'first(second),first(second)' into a struct array
	 */
	private array function buildPairsArray(string pairedsorts){
		var unsplitarray = listToArray(arguments.pairedsorts);
		var pair = {};
		var pos = 0;
		var strlen = 0;
		var returnArray = [];

		if(arrayLen(unsplitarray)){
			for(var pairstr in unsplitarray){
				pos = find("(",pairstr);
				strlen = len(pairstr);
				midlen = (strlen - pos) - 1;
				if(pos){
					pair = {
						first = left(pairstr,pos-1)
						, second = mid(pairstr,pos+1,(strlen - pos) - 1)
					};

					arrayAppend(returnArray,pair);
				}
			}
		}

		return returnArray;
	}


	/**
	 * @hint Finds the array position of the first struct where the key "first" contains the given value
	 */
	private numeric function indexOfFirstKeyValue(searcharray,value){
		var searchLen = arrayLen(arguments.searcharray);
		var index = 0;

		if(searchLen){
			for(var i=1; i <= searchLen; i++){
				if(arguments.searcharray[i].first == arguments.value){
					index = i;
					break;
				}
			}
		}

		return index;
	}

}
