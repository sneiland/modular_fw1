var dtt;

dtTimerSearch = function(callback) {
	clearTimeout(dtt);
	dtt = setTimeout(function() {
		callback();
	},1500);
};

getDateForFiltering = function(field){
	var value = $(field).val();

	if(validateDate(value)){
		return value;
	} else {
		return '';
	}
};