<cffunction name="buildNav" output="false" hint="Build the tab navigation based on users toolset">
	<cfargument name="navArray">
	<cfargument name="action" default="">

<cfscript>
	var navList = "";

	if( arguments.action == "" ){
		arguments.action = ":main.default";
	}

	if( arrayLen(navArray) ){
		for( var i=1; i<=arrayLen(navArray); i++ ){
			if( navArray[i].showOnMainNav ){
				var selected = "";
				var currentSubsystem = listFirst(listFirst(arguments.action,"."),":");
				var currentSection = listLast(listFirst(arguments.action,"."),":");
				var navSubsystem = listFirst(listFirst(navArray[i].action,"."),":");
				var navSection = listLast(listFirst(navArray[i].action,"."),":");
				if( currentSubsystem == navSubsystem && currentSection == navSection ){
					selected = "class=""selected""";
				}

				navList &= "<li #selected#><a href=""#buildUrl(action="#navArray[i].action#")#""><span>#navArray[i].label#</span></a></li>";

			}
		}
	}
			</cfscript>

	<cfreturn navList>
</cffunction>