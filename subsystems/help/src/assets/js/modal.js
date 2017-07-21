ss_help.modal = (function(){
	
	var hasEditPermission = false;
	
	function init(){
		return {
			setEditPermission: setEditPermission,
			showHelpDialog: showHelpDialog
		};
	}
	
	function loadEditHelpDialog( helpaction ){
		//var url = '/index.cfm?action=help:main.edit';
		$('#dialog-help').dialog('close');
	
		$.ajax({
			type: 'POST',
			url: ss_help.modal.editurl,
			data: {
				helpaction: helpaction
				, modal: true
			},
			success: function(data) {
				showEditHelpDialog( helpaction, data );
			}
		});
	}
	
	function setEditPermission( val ){
		hasEditPermission = val;
	}
	
	function showEditHelpDialog( helpaction, data ){
		$('#dialog-edithelp').dialog({
			height: '600',
			width: '650',
			modal:true,
			buttons: [
				{
					text: 'Close',
					click: function() {
						$( this ).dialog( 'close' );
						showHelpDialog( helpaction );
					}
				},
				{
					text: 'Save and Close',
					click: function() {
						for (instance in CKEDITOR.instances) {
					         CKEDITOR.instances[instance].updateElement();
					    }
						$.post(
							'/index.cfm?action=help:main.save',
							$( '#helpForm' ).serialize()
						).done(
							function(data){
								$('#dialog-edithelp').dialog('close');
								showHelpDialog(helpaction);
							}
						);
					}
				}
			],
			open: function (){
				$(this).html(data);
			},
			title: 'Edit Help Page'
		})
		.dialog('open');
	}
		
	
	function showHelpDialog( helpaction ){
		var buttons = [];
		
		if( hasEditPermission ){
			buttons = [
				{
					text: 'Close',
	            	click: function(){
	            		$(this).dialog('close');
	            	}
				},
				{
	            	text: 'Edit',
	            	click: function(){
	            		loadEditHelpDialog(helpaction);
	            	}
				}
        	];
		} else {
			buttons = [
				{
					text: 'Close',
	            	click: function(){
	            		$(this).dialog('close');
	            	}
				}
        	];
		}
		
		$.ajax({
			type: 'POST',
			url: '/index.cfm?action=help:main.modal',
			data: {helpaction: helpaction},
			success: function(data) {
				$('#dialog-help').dialog({
					height: '600',
					width: '650',
					modal:true,
					buttons: buttons,
		        	open: function (){
			            $(this).html(data);
			        },
		        	title: 'Help'
				}).dialog('open');
			}
		});
	}
	
	return init();
}());