<h1 class="page-header">Servers List</h1>

<div class="table-responsive">
	<div style="float:right;">
		<cfoutput>
			<form onsubmit="return false;">
				<label for="textSearch">Keyword:</label>
				<input type="text" name="textSearch" id="textSearch"
				value="#rc.filters.textSearch#"
				onkeyup="dtTimerSearch();" onmouseup="dtTimerSearch();">

				<button name="goBtn" onclick="dtTimerSearch();">Go</button>
			</form>
		</cfoutput>
	</div>

	<table id="servers_table" class="table table-striped" style="width:100%; clear:both" width="100%">
	<thead>
		<th>Id</th>
		<th>Name</th>
		<th>Client</th>
		<th>Type</th>
		<th>Billable</th>
		<th>Base Price</th>
		<th>Total Price</th>
	</thead>
	<tbody></tbody>
	</table>
</div>

<script>
	var config = {
		"dom": 'T<"clear">lfrtip',
        "tableTools": {
            "aButtons": [],"sRowSelect": "single"
        },
		"order": [[ 0, "asc" ]], // Default sort
		"lengthChange": true,
		"searching": false,
		"processing": true,
        "serverSide": true,
        "stateSave": true,
        "ajax": {
   			"url": <cfoutput>'#buildUrl("main.grid")#'</cfoutput>,
   			"type": "POST",
   			"data": function ( d ) {
		        d.textSearch = $('#textSearch').val();
		    }
 		},
        "columns": [
              { "data": "serverId" }
            , {
            	"data": "name",
				"render": function ( data, type, full, meta ) {
					<cfoutput>return '<a href="#buildUrl(action="main.server")#&serverId=' + full.serverId + '">' + data + '</a>';</cfoutput>
				}
            }
            , { "data": "client" }
            , { "data": "type" }
            , {
            	"data": "billable",
				"render": function ( data, type, full, meta ) {
					if(data){
						return 'Yes';
					} else {
						return 'No';
					}
				}
			}
            , {
            	"data": "basePrice",
            	"render": function ( data, type, full, meta ) {
            		return dollarFormat(data);
            	}
            }
            , {
            	"data": "totalPrice",
            	"render": function ( data, type, full, meta ) {
            		return dollarFormat(data);
            	}
            }
        ]
	};

	var dtt;

	dtTimerSearch = function() {
		clearTimeout(dtt);
		dtt = setTimeout(function() {refreshServersGrid();},500);
	}

	refreshServersGrid = function() {
		var table = $('#servers_table').DataTable();
		table.ajax.reload();
	}

	var dtable = $('#servers_table').dataTable(config);
</script>