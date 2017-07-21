<!--- <cfoutput>
	<cfif server.coldfusion.productName contains "ColdFusion">
		ColdFusion<br/>
		Version: #server.coldfusion.productVersion#<br/>
		<cfif server.coldfusion.appserver Contains "JRun">
			Instance: #createObject("java", "jrunx.kernel.JRun").getServerName()#
		</cfif>
	<cfelseif server.coldfusion.productName contains "Railo">
		Railo
		Version: #server.railo.version#
	</cfif>
</cfoutput> --->

<style>
	.helpList {
		list-style-type:none;
	}

	.helpList p {
		margin-bottom: 10px;
	}

	.helpList a {
		text-decoration: none;
	}

	.helpList h2 a, .helpList h2 a:visited, .helpList a, .helpList a:visited {
		color: #333
	}

	.helpList p a {
		text-decoration: underline;
	}
</style>

<cfoutput>
	<div style="background-color:##FEFEFE;margin:10px;padding:10px 0 10px 0;">
		<ul class="helpList">
			<cfloop query="rc.helpPagesList">
				<li>
					<h2><a href="#buildUrl(action="main.view",querystring="Id=#rc.helpPagesList.Id#")#"">#rc.helpPagesList.title#</a></h2>
					<p>#left(REReplaceNoCase(rc.helpPagesList.pageContent, "<[\/]?[^>]*>","","ALL"),250)# <a href="##" onclick="javascript:showHelpDialog('#rc.helpPagesList.helpAction#')">more...</a></p>
				</li>
			</cfloop>
		</ul>
	</div>

<!---	 <cfdump var="#rc.parent.getBean("helpGateway")#"> --->
</cfoutput>