component accessors="true" {

	property name="serversService";

	public function init( fw ){
		variables.fw = arguments.fw;
	}


	public function default( rc ){
		rc.filters = getServersService().getFilters();
	}

	public function server( rc ){
		rc.server = getServersService().getServerById( rc.serverId );
		rc.optionsTotal = 10;
		var data = getServersService().getServerOptions( rc.serverId );
		rc.options = data.data;
	}

	public function grid( rc ){
		param name="rc.draw" default="1";
		param name="rc.start" default="0";
		param name="rc.length" default="10";
		param name="rc.sortCol" default="";
		param name="rc.sortDir" default="asc";
		param name="rc.textSearch" default="";

		try{
			var orderColIndex = form["order[0][column]"];
			rc.sortDir = form["order[0][dir]"];
			rc.sortCol = form["columns[#orderColIndex#][data]"];
		} catch(any e ){}

		var data = getServersService().getServersForGrid(
			  draw 			= rc.draw
			, start 		= rc.start
			, length 		= rc.length
			, sortcol 		= rc.sortcol
			, sortdir 		= rc.sortdir
			, textSearch	= rc.textSearch
		);

		variables.fw.renderData('json', data);
	}


}