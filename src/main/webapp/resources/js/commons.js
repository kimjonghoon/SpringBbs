var isJavaScriptArticle = false;
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
function runAfterLoadArticle() {
	prettyPrint();
	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});
	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});
}
function displayJavaScriptResult() {
	$('pre.script-result-display').each(function(index) {
		var $result = "";
		function println(str) {
			$result += str + "\n";
		}
		var $convert = $(this).text().replace(/alert/g,"println");
		eval($convert);
		$(this).after('<pre class="result">' + $result + '</pre>');
	});	
}
