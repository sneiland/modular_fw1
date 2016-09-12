component accessors="true"{

	property name="serversGateway";

	// *** Initialization ***

	public any function init(){
		return this;
	}

	// *** Private Functions ***

	private array function queryToArray( q ){
		var Columns = listToArray(arguments.q.getColumnList(false));
		var QueryArray = [];
		for (local.RowIndex = 1; local.RowIndex <= arguments.q.RecordCount; local.RowIndex++){
			local.Row = {};
			local.numCols = ArrayLen( local.Columns );
			for (local.ColumnIndex = 1; local.ColumnIndex <= local.numCols; local.ColumnIndex++){
				local.ColumnName = local.Columns[ local.ColumnIndex ];
				local.Row[ local.ColumnName ] = arguments.q[ local.ColumnName ][ local.RowIndex ];
			}
			ArrayAppend( QueryArray, local.Row );
		}

		return( QueryArray );
	}


	private string function serializeJsonNoPrefix( data ){
		var jsonString = "";
		var ctx = getPageContext().getFusionContext();
		var isSecure = ctx.isSecureJSON();

		ctx.setSecureJSON(false);
		jsonString = serializeJson(data);
		ctx.setSecureJSON(isSecure);

		return jsonString;
	}

	// *** Public Functions ***

	public function getFilters(){
		param name="session.servers.filters.textSearch" default="";
		return session.servers.filters;
	}


	public function getServerById( serverId ){
		return getServersGateway().getServerById( serverId=arguments.serverId );
	}


	public struct function getServerOptions( serverId ){
		var data = getServersGateway().getServerOptions( serverId=arguments.serverId);

		var unitPrice = 0;

		var returnStruct = {
			total: 0,
			data: ""
		};

		queryAddColumn(data, "subTotal", ArrayNew(1)) ;
		queryAddColumn(data, "unitPrice", ArrayNew(1)) ;

		// Generate computed columns
		for( var row in data ){
			var subTotal = row.optionPrice * row.quantity;

			querySetCell(
				row
				,"subTotal"
				,subTotal
				,row.CurrentRow
			);

			returnStruct.total = returnStruct.total + subTotal;
		}

		returnStruct.data = data;

		return returnStruct;
	}

	/**
	* @hint Returns a json string for return to the datatables grid
	*/
	public struct function getServersForGrid(draw,start,length,sortcol,sortdir,textsearch){
		var results = getServersGateway().getPaged(
			  start			= arguments.start
			, length		= arguments.length
			, sortCol		= arguments.sortCol
			, sortDir		= arguments.sortDir
			, textSearch	= arguments.textSearch
		);

		// Update filters session
		session.servers.filters.textSearch = arguments.textsearch;

		var returnStruct = {
			"draw":arguments.draw
			, "recordsTotal" : results.total
			, "recordsFiltered" : results.totalfiltered
			, "data" : queryToArray(results.data)
		};

		return returnStruct;
	}

}