function runAfterLoadArticle() {
	prettyPrint();
	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});
	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});
}

function selectRange(obj) {
	if (window.getSelection) {
		var selected = window.getSelection();
		selected.selectAllChildren(obj);
	} else if (document.body.createTextRange) {
		var range = document.body.createTextRange();
		range.moveToElementText(obj);
		range.select();
	}
}