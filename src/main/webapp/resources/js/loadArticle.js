$(document).ready(function () {
    var url = $('#main-article').attr('class');
    $('#main-article').load('/resources/articles/' + url + '.html', function () {
        runAfterLoadArticle();
        displayJavaScriptResult();
    });
});