$(document).ready(function () {

    prettyPrint();
    $('pre.prettyprint').html(function () {
        return this.innerHTML.replace(/\t/g, '&nbsp;&nbsp;&nbsp;&nbsp;');
    });
    $('pre.prettyprint').dblclick(function () {
        selectRange(this);
    });
    $('pre.script-result-display').each(function () {
        var $result = "";
        function println(str) {
            $result += str + "\n";
        }
        var $convert = $(this).text().replace(/alert/g, "println");
        eval($convert);
        $(this).after('<pre class="result">' + $result + '</pre>');
    });

    $('#file-list a.download').click(function () {
        var $filename = this.title;
        $('#downForm input[name*=filename]').val($filename);
        $('#downForm').submit();
        return false;
    });

    $('#file-list a:not(.download)').click(function () {
        var msg = $('#delete-confirm').attr('title');
        var chk = confirm(msg);

        if (chk === true) {
            var $attachFileNo = this.title;
            $('#deleteAttachFileForm input[name*=attachFileNo]').val($attachFileNo);
            $('#deleteAttachFileForm').submit();
        }

        return false;
    });

    $('.next-prev a').click(function () {
        var $articleNo = this.title;
        goView($articleNo);
        return false;
    });

    //Modify Button
    $('.goModify').click(function () {
        $('#modifyForm').submit();
    });

    //Del Button
    $('.goDelete').click(function () {
        var msg = $('#delete-confirm').attr('title');
        var chk = confirm(msg);
        if (chk === true) {
            $('#delForm').submit();
        }
    });

    //Next Article Button
    $('.next-article').click(function () {
        var $articleNo = this.title;
        goView($articleNo);
    });

    //Prev Article Button
    $('.prev-article').click(function () {
        var $articleNo = this.title;
        goView($articleNo);
    });

    //List Button
    $('.goList').click(function () {
        $('#listForm').submit();
    });

    //Write Button
    $('.goWrite').click(function () {
        $('#writeForm').submit();
    });

    //Title Link in view.jsp
    $('#list-table a').click(function () {
        var $articleNo = this.title;
        goView($articleNo);
        return false;
    });

    //Paging
    $('#paging a').click(function () {
        var $page = this.title;
        goList($page);
        return false;
    });

    //Write Button on Search Button
    $('#list-menu input').click(function () {
        $('#writeForm').submit();
    });

});

function goView(articleNo) {
    var form = document.getElementById("viewForm");
    form.action += articleNo;
    form.submit();
}

function goList(page) {
    $('#listForm input[name*=page]').val(page);
    $('#listForm').submit();
}