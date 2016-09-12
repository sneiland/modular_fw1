<cffile action="uploadall" destination="#application.uploads_purgatory#" nameconflict="overwrite">
<cffile action="move" source="#application.uploads_purgatory##cffile.SERVERFILE#" destination="#url.destination##cffile.SERVERFILE#">

<!--- <cfset localPath="/spassets/#Replace(url.destination, application.spassetsDir, "")##cffile.SERVERFILE#"> --->
<cfset localPath="https://www.sterlingpayment.com#url.destination##cffile.SERVERFILE#">
<cfset localPath=replace(localPath, "\", "/", "ALL")>
<cfset localPath=replaceNoCase(localPath,"//TPA1PWWEB04/spassets/","/spassets/")>
<cfoutput><script>window.parent.CKEDITOR.tools.callFunction(#url.CKEditorFuncNum#,"#localPath#", "Upload Successful");</script></cfoutput>