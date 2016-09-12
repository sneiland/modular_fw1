<cfoutput>
	<form name="helpForm" id="helpForm">
		<input type="hidden" name="pageId" id="pageId" value="#rc.helpData.pageId#">
		<input type="hidden" name="modal" value="#rc.modal#">
		<input type="text" name="title" id="title" value="#rc.helpData.title#">
		<input type="hidden" name="helpAction" id="helpAction" value="#rc.helpAction#">

		<textarea style="width:98%;" rows="30" name="pageContent" id="pageContent">#rc.helpData.pageContent#</textarea>
	</form>
</cfoutput>

<script type="text/javascript">
	CKEDITOR.replace( 'pageContent' );
</script>