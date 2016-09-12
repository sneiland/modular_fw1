var jsrequest = {};

function dollarFormat(val) {
	return '$' + val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}