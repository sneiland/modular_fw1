component accessors="true" {

	public any function init(){
		return this;
	}

	public string function formatDatetime( datetime ){
		if( len(trim(arguments.datetime)) ){
			return datetimeFormat( arguments.datetime, "dd-mmm-yyyy hh:nn:ss tt" );
		} else {
			return '<span class="text-muted">N/A</span>';
		}
	}

	public string function formatIfBlank(string input=""){
		if( len(trim(arguments.input)) ){
			return arguments.input;
		} else {
			return '<span class="text-muted">N/A</span>';
		}
	}


	public string function formatPhone( number, countryCode="+1" ){
		if( len(trim(arguments.number )) == 10 ){
			return '<a href="tel:' & arguments.countryCode & arguments.number & '">' & arguments.countryCode
				& ' (' & left(arguments.number,3) & ') '
				& mid(arguments.number,4,3) & '-'
				& right(arguments.number,4) &'</a>';
		} else if( len(trim(arguments.number )) ){
			return '<a href="tel:' & arguments.countryCode & arguments.number & '">'
				& arguments.countryCode & ' ' & arguments.number &'</a>';
		} else {
			return '<span class="text-muted">N/A</span>';
		}
	}


	public array function queryToArray( required query qry ){
		var result = [];

		for (var row in arguments.qry ) {
		    result.append(row);
		}

		return result;
	}

	public struct function queryToStruct(required query queryObj,numeric row=1){
		var returnStruct = {};
		var colArray = listToArray(arguments.queryObj.columnList);

		for(var col in colArray){
			returnStruct[col] = arguments.queryObj[col][arguments.row];
		}

    	return returnStruct;
	}

	/*

	public array function queryToArray(required query q){
		var local = {};
		if ( structKeyExists(server, "railo") || structKeyExists(server, "lucee") ) {
			local.Columns = listToArray(arguments.q.getColumnList(false));
		}
		else {
			local.Columns = arguments.q.getMetaData().getColumnLabels();
		}
		local.QueryArray = ArrayNew(1);
		for (local.RowIndex = 1; local.RowIndex <= arguments.q.RecordCount; local.RowIndex++){
			local.Row = {};
			local.numCols = ArrayLen( local.Columns );
			for (local.ColumnIndex = 1; local.ColumnIndex <= local.numCols; local.ColumnIndex++){
				local.ColumnName = local.Columns[ local.ColumnIndex ];
				local.Row[ local.ColumnName ] = arguments.q[ local.ColumnName ][ local.RowIndex ];
			}
			ArrayAppend( local.QueryArray, local.Row );
		}

		return( local.QueryArray );
	}
	*/
}