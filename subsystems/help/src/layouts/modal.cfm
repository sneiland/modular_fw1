<cfsilent>
	<cfset request.layout = false>
	<cfsetting showdebugoutput="false">

	<script>
		ss_help.modal = {
			editurl : '#buildUrl( action="help:main.edit" )#'
		};
	</script>
</cfsilent>
<cfoutput>
<html>
<body>
	<div class="popupWindow">#body#</div>
</body>
</html>
</cfoutput>