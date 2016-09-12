<cfheader name="Content-Disposition" value="attachment; filename=myDoc.pdf">
<cfcontent type="application/pdf">
<cfdocument format="pdf"><cfoutput>#body#</cfoutput></cfdocument><cfset request.layout = false>