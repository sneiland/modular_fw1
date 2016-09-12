<cfsilent>
	<cfparam name="rc.alertMessage" default="">
	<cfparam name="rc.heading" default="Login">
	<cfparam name="rc.title" default="Windlass CRM">
	<cfparam name="rc.pageclass" default="">

	<!--- Block layout bubbling --->
	<cfset request.layout = false>
</cfsilent><cfoutput><!DOCTYPE html>
<html>
<head>
	<title>#rc.title#</title>
	<link rel="stylesheet" type="text/css" href="/common/assets/css/reset.css" />
	<link rel="stylesheet" type="text/css" href="/subsystems/#getSubsystem()#/assets/css/public.css" />
	<cfloop array="#rc.css#" index="local.i" item="local.cssfilepath">
		<cfoutput><link rel="stylesheet" type="text/css" href="#local.cssfilepath#" /></cfoutput>
	</cfloop>
	<script src="/common/assets/libs/jquery/jquery-2.1.4.min.js"></script>
	<script src="/common/assets/libs/jquery-validation-1.14.0/dist/jquery.validate.js"></script>
	<script>
		var ss_tenants = {};
	</script>
</head>
<body>
	<div class="pageWrapper #rc.pageclass# subsystempagewrapper">
		<header>
			<h1>#rc.heading#</h1>
		</header>
		<div class="pageContent" id="pageContent">
			#body#
		</div>
	</div>

	<cfif rc.alertMessage NEQ "">
		<script type="text/javascript">alert('#rc.alertMessage#');</script>
	</cfif>
</body>
</html>
</cfoutput>