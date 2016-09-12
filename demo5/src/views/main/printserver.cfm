<cfoutput>
	<h1>Server Information: #rc.server.serverName#</h1>

	<table>
		<tbody>
			<tr>
				<th>Client: </th>
				<td>#rc.server.clientName#</td>
			</tr>
			<tr>
				<th>Type: </th>
				<td>#rc.server.serverType#</td>
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

	<cfif rc.options.recordcount GT 0>
		<table border="1" cellspacing="0" cellpadding="5">
		<thead>
			<th align="left">Option</th>
			<th align="left">Quantity</th>
			<th align="left">Unit Price</th>
			<th align="left">Sub Total</th>
		</thead>
		<tfoot>
			<th colspan="3" align="right">
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
</cfoutput>