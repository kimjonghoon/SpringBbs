$(document).ready(function() {

	prettyPrint();

	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});
	
	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});

});