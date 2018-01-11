$(document).ready(function () {
    var url = $('#content').attr('title');
    $('#content').load('/resources/articles/' + url + '.html', function () {
        runAfterLoadArticle();
    });
    $('body').on('click', 'article', function (e) {
        if ($(e.target).is('a[href^="/download/"]')) {
            e.preventDefault();
            var $filename = $(e.target).attr('href');
            $filename = $filename.substring(10);
            //alert($filename);
            $('#downForm input[name*=filename]').val($filename);
            $('#downForm').submit();
        }
    });
});

