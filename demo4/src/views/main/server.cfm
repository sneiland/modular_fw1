<cfoutput>
	<a href="#buildUrl(action="main.printServer",queryString="serverId=#rc.serverId#")#" class="btn pdfPrintBtn"><i class="fa fa-file-pdf-o fa-lg"></i> Print</a>

	<h1 class="page-header">Server Information: #rc.server.name#</h1>

	<div id="tabs">
		<ul>
			<li><a href="##fragment-1">General</a></li>
			<li><a href="##fragment-2">Options</a></li>
		</ul>

		<div id="fragment-1">
			<table class="simpleTable">
				<tbody>
					<tr>
						<th>Client: </th>
						<td>#rc.server.client#</td>
					</tr>
					<tr>
						<th>Type: </th>
						<td>#rc.server.type#</td>
					</tr>
					<tr>
						<th>Billable: </th>
						<td>#yesnoformat(rc.server.billable)#</td>
					</tr>
					<tr>
						<th>Base Price: </th>
						<td>#dollarFormat(rc.server.price)#</td>
					</tr>
					<tr>
						<th>Total Price: </th>
						<td>#dollarFormat(rc.server.price + rc.optionsTotal)#</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div id="fragment-2">
			<cfif rc.options.recordcount EQ 0>
				<p>No options are currently set on this server</p>
			<cfelse>
				<table class="table table-striped" style="width:100%; clear:both" width="100%">
				<thead>
					<th>Option</th>
					<th>Quantity</th>
					<th>Unit Price</th>
					<th>Sub Total</th>
				</thead>
				<tfoot>
					<th colspan="3">
						Total:
					</th>
					<th>#dollarFormat(rc.optionsTotal)#</th>
				</tfoot>
				<tbody>
					<cfloop query="rc.options">
						<tr>
							<td>#rc.options.optionName#</td>
							<td>#rc.options.quantity#</td>
							<td>#dollarFormat(rc.options.optionPrice)#</td>
							<td>#dollarFormat(rc.options.subTotal)#</td>
						</tr>
					</cfloop>
				</tbody>
				</table>
			</cfif>
		</div>
	</div>
</cfoutput>

<script>
	$(function() {
		$( "#tabs" ).tabs({
				active:0
		});
	});
</script>