$(document).ready(function() {
	var url = $('#main-article').attr('title');
	$('#main-article').load('/resources/articles/' + url + '.html', function() {
		runAfterLoadArticle();
		if (isJavaScriptArticle) {
			displayJavaScriptResult();
		}
	});
});