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

