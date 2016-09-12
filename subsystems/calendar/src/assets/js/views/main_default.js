ss_calendar.main_default = (function(){
	function init(){
		return {
			loadModal: loadModal,
			loadMonth: loadMonth,
			refresh: refresh,
			saveModal: saveModal
		};
	}
	
	function loadMonth( month, year, type ){
		$.ajax({
			url: jsrequest.monthly,
			dataType: 'html',
			method: 'post',
			data: {
				selectedMonth: month,
				selectedYear: year,
				selectedType: type
			},
			success: function(data) {
				$('#calendarContainer').html(data);
				setFilters( month, year, type );
			}
		});
	}
	
	function refresh(){
		var month = $('#calendarFilters [name="filterMonth"]').val();
		var year = $('#calendarFilters [name="filterYear"]').val();
		var type = $('#calendarFilters [name="filterType"]').val();
		if( year.length === 4){
			loadMonth( month, year, type );
		}
	}
	
	function setFilters( month, year, type ){
		$('#calendarFilters [name="filterMonth"]').val(month);
		$('#calendarFilters [name="filterYear"]').val(year);
		$('#calendarFilters [name="filterType"]').val(type);
	}
	
	function loadModal( $linkref ){
		var data = $linkref.data();
		
		$.ajax({
			url: jsrequest.edit,
			dataType: 'html',
			method: 'post',
			data: {
				id: data.id,
				type: data.type
			},
			success: function(data) {
				$('#itemModal .modal-body').html(data);
				$('#itemModal').modal('show');
				
				$( '#itemModal .datepicker' ).datepicker();
				
				$('#itemModal .timepicker').clockpicker({
				    autoclose: true
				});
			}
		});
	}
	
	function saveModal(){
		$.ajax({
			url: jsrequest.save,
			dataType: 'json',
			method: 'post',
			data: {
				id: $('#itemModal [name="id"]').val(),
				type: $('#itemModal [name="type"]').val(),
				label: $('#itemModal [name="label"]').val(),
				startdate: $('#itemModal [name="startDate"]').val(),
				enddate: $('#itemModal [name="endDate"]').val(),
				starttime: $('#itemModal [name="startTime"]').val(),
				endtime: $('#itemModal [name="endTime"]').val(),
				description: $('#itemModal [name="description"]').val()
			},
			success: function(data) {
				$('#itemModal').modal('hide');
				refresh();
			}
		});
	}
	
	return init();
}());

$(document).ready(function(){
	$('#calendarFilters')
		.on(
			'change',
			'select',
			function(event){
				event.preventDefault();
				ss_calendar.main_default.refresh();
			}
		)
		.on(
			'keyup',
			'input',
			function(event){
				event.preventDefault();
				ss_calendar.main_default.refresh();
			}
		);
	
	$('#calendarContainer')
		.on(
			'click',
			'.prevMonth, .nextMonth',
			function(event){
				event.preventDefault();
				var data = $(this).data();
				var type = $('#calendarFilters [name="filterType"]').val();
				ss_calendar.main_default.loadMonth( data.month, data.year, type );
			}
		)
		.on(
			'click',
			'.calevent .calItem',
			function(event){
				event.preventDefault();
				
				ss_calendar.main_default.loadModal( $(this) );
			}
		)
		;

	$('#dialog-form').on('shown.bs.modal', function () {
		$('#itemModel [name="id"]').focus();
	});
	
	$('#savecalevent').on('click',function(event){
		ss_calendar.main_default.saveModal();
	});
	
	ss_calendar.main_default.refresh();
});