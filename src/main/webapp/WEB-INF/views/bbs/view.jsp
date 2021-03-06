<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<link rel="stylesheet" href="/resources/css/prettify.css" type="text/css" />
<script src="/resources/js/prettify.js"></script>
<script>
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
        $('#file-list a.download').click(function (e) {
            e.preventDefault();
            var filename = this.title;
            $('#downForm input[name*=filename]').val(filename);
            $('#downForm').submit();
        });
        $('#file-list a:not(.download)').click(function (e) {
            e.preventDefault();
            var chk = confirm('<spring:message code="delete.confirm" />');
            if (chk === true) {
                var attachFileNo = this.title;
                $('#deleteAttachFileForm input[name*=attachFileNo]').val(attachFileNo);
                $('#deleteAttachFileForm').submit();
            }
        });
        $('.next-prev a').click(function (e) {
            e.preventDefault();
            var articleNo = this.title;
            var action = $('#viewForm').attr('action');
            action += articleNo;
            $('#viewForm').attr('action', action);
            $('#viewForm').submit();
        });
        //Modify Button
        $('.goModify').click(function () {
            $('#modifyForm').submit();
        });
        //Del Button
        $('.goDelete').click(function () {
            var chk = confirm('<spring:message code="delete.confirm" />');
            if (chk === true) {
                $('#delForm').submit();
            }
        });
        //Next Article Button
        $('.next-article').click(function () {
            var articleNo = this.title;
            var action = $('#viewForm').attr('action');
            action += articleNo;
            $('#viewForm').attr('action', action);
            $('#viewForm').submit();
        });
        //Prev Article Button
        $('.prev-article').click(function () {
            var articleNo = this.title;
            var action = $('#viewForm').attr('action');
            action += articleNo;
            $('#viewForm').attr('action', action);
            $('#viewForm').submit();
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
        $('#list-table a').click(function (e) {
            e.preventDefault();
            var articleNo = this.title;
            var action = $('#viewForm').attr('action');
            action += articleNo;
            $('#viewForm').attr('action', action);
            $('#viewForm').submit();
        });
        //Paging
        $('#paging a').click(function (e) {
            e.preventDefault();
            var page = this.title;
            $('#listForm input[name*=page]').val(page);
            $('#listForm').submit();
        });
        //Write Button on Search Button
        $('#list-menu > input').click(function () {
            $('#writeForm').submit();
        });
        $('#searchForm').submit(function() {
            var $searchWord = $('#searchForm input[name*=searchWord]').val();
            $searchWord = $.trim($searchWord);
            $('#searchForm input[name*=searchWord]').val($searchWord);
            $('#searchForm').submit();
        });        
    });
    
    function displayComments() {
        var url = '/comments/' + ${articleNo};
        $.getJSON(url, function (data) {
            $('#all-comments').empty();
            $.each(data, function (i, item) {
                var creation = new Date(item.regdate);
                var comments = '<div class="comments">'
                        + '<span class="writer">' + item.name + '</span>'
                        + '<span class="date">' + creation.toLocaleString() + '</span>';
                if (item.editable === true) {
                    comments = comments
                            + '<span class="modify-del">'
                            + '<a href="#" class="comment-modify-link">' + '<spring:message code="global.modify" />' + '</a> | '
                            + '<a href="#" class="comment-delete-link" title="' + item.commentNo + '">' + '<spring:message code="global.delete" />' + '</a>'
                            + '</span>';
                }
                comments = comments
                        + '<div class="comment-memo">' + item.memo + '</div>'
                        + '<form class="comment-form" action="/comments/' + ${articleNo } + '/' + item.commentNo + '" method="put" style="display: none;">'
                        + '<div style="text-align: right;">'
                        + '<a href="#" class="comment-modify-submit-link">' + '<spring:message code="global.submit" />' + '</a> | <a href="#" class="comment-modify-cancel-link">' + '<spring:message code="global.cancel" />' + '</a>'
                        + '</div>'
                        + '<div>'
                        + '<textarea class="comment-textarea" name="memo" rows="7" cols="50">' + item.memo + '</textarea>'
                        + '</div>'
                        + '</form>'
                        + '</div>';
                $('#all-comments').append(comments);
                //console.log(item);
            });
        }).done(function() {
            runAfterLoadArticle();
        });
    }

    $(document).ready(function () {
        displayComments();
        //new comment
        $("#addCommentForm").submit(function (event) {
            event.preventDefault();
            var $form = $(this);
            var memo = $('#addComment-ta').val();
            memo = $.trim(memo);
            if (memo.length === 0) {
                $('#addComment-ta').val('');
                return false;
            }
            var dataToBeSent = $form.serialize();
            var url = $form.attr("action");
            var posting = $.post(url, dataToBeSent);
            posting.done(function () {
                displayComments();
                $('#addComment-ta').val('');
            });
        });
        $('title').empty();
        var title = $('#bbs-title').html();
        $('title').append(title);
    });

    $('body').on('click', '#all-comments', function (e) {
        if ($(e.target).is('.comment-modify-link')) {
            e.preventDefault();
            var $form = $(e.target).parent().parent().find('.comment-form');
            var $div = $(e.target).parent().parent().find('.comment-memo');

            if ($form.is(':hidden') === true) {
                $form.show();
                $div.hide();
            } else {
                $form.hide();
                $div.show();
            }
        } else if ($(e.target).is('.comment-modify-cancel-link')) {
            e.preventDefault();
            var $form = $(e.target).parent().parent().parent().find('.comment-form');
            var $div = $(e.target).parent().parent().parent().find('.comment-memo');

            if ($form.is(':hidden') === true) {
                $form.show();
                $div.hide();
            } else {
                $form.hide();
                $div.show();
            }
        } else if ($(e.target).is('.comment-modify-submit-link')) {
            e.preventDefault();
            var $form = $(e.target).parent().parent().parent().find('.comment-form');
            var $textarea = $(e.target).parent().parent().find('.comment-textarea');
            var memo = $textarea.val();
            $('#modifyCommentForm input[name*=memo]').val(memo);
            var dataToBeSent = $('#modifyCommentForm').serialize();
            var url = $form.attr("action");
            $.ajax({
                url: url,
                type: 'POST',
                data: dataToBeSent,
                success: function () {
                    displayComments();
                },
                error: function () {
                    alert('error!');
                }
            });
        } else if ($(e.target).is('.comment-delete-link')) {
            e.preventDefault();
            var chk = confirm('<spring:message code="delete.confirm" />');
            if (chk === false) {
                return;
            }
            var $commentNo = $(e.target).attr('title');
            var url = $('#deleteCommentForm').attr('action');
            url += $commentNo;
            var dataToBeSent = $('#deleteCommentForm').serialize();
            $.ajax({
                url: url,
                type: 'POST',
                data: dataToBeSent,
                success: function () {
                    displayComments();
                },
                error: function () {
                    alert('error!');
                }
            });
        }
    });

    $(document).ready(function () {
        var originWidth = $('#article-content > iframe').width();
        var originHeight = $('#article-content > iframe').height();

        var width = $('#detail').width();
        var height = originHeight * width / originWidth;

        $('#article-content > iframe').attr('width', width);
        $('#article-content > iframe').attr('height', height);

        $('#article-content > iframe').attr('allowFullScreen', '');
    });
</script>


<div id="content-categories">${boardName }</div>

<div class="view-menu" style="margin-top: 15px;margin-bottom: 5px;">
    <security:authorize access="#email == principal.username or hasAuthority('ROLE_ADMIN')">
        <div class="fl">
            <input type="button" value="<spring:message code="global.modify" />" class="goModify" />
            <input type="button" value="<spring:message code="global.delete" />" class="goDelete" />
        </div>
    </security:authorize>        
    <div class="fr">
        <c:if test="${nextArticle != null }">    
            <input type="button" value="<spring:message code="bbs.next.article" />" title="${nextArticle.articleNo }" class="next-article" />
        </c:if>
        <c:if test="${prevArticle != null }">        
            <input type="button" value="<spring:message code="bbs.prev.article" />" title="${prevArticle.articleNo}" class="prev-article" />
        </c:if>        
        <input type="button" value="<spring:message code="global.list" />" class="goList" />
        <input type="button" value="<spring:message code="bbs.new.article" />" class="goWrite" />
    </div>
</div>

<table class="bbs-table">
    <tr>
        <th style="width: 47px;text-align: left;vertical-align: top;font-size: 1em;">TITLE</th>
        <th style="text-align: left;color: #555;font-size: 1em;" id="bbs-title">${title }</th>
    </tr>
</table>
<div id="detail">
    <div id="date-writer-hit">edited <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${regdate }" /> by ${name } hit ${hit }</div>
    <div id="article-content">${content }</div>
    <div id="file-list" style="text-align: right">
        <c:forEach var="file" items="${attachFileList }" varStatus="status">
            <div id="attachfile${file.attachFileNo }" class="attach-file">
                <a href="#" title="${file.filename }" class="download">${file.filename }</a>
                <security:authorize access="#email == principal.username or hasRole('ROLE_ADMIN')">
                    <a href="#" title="${file.attachFileNo }"><spring:message code="global.delete" /></a>
                </security:authorize>
            </div>
        </c:forEach>
    </div>
</div>

<sf:form id="addCommentForm" action="/comments/${articleNo }" method="post" style="margin: 10px 0;">
    <div id="addComment">
        <textarea id="addComment-ta" name="memo" rows="7" cols="50"></textarea>
    </div>
    <div style="text-align: right;">
        <input type="submit" value="<spring:message code="bbs.new.comments" />" />
    </div>
</sf:form>

<!--  comments begin -->
<div id="all-comments">
</div>
<!--  comments end -->

<div class="next-prev">
    <c:if test="${nextArticle != null }">
        <p><spring:message code="bbs.next.article" /> : <a href="#" title="${nextArticle.articleNo }">${nextArticle.title }</a></p>
    </c:if>
    <c:if test="${prevArticle != null }">
        <p><spring:message code="bbs.prev.article" /> : <a href="#" title="${prevArticle.articleNo }">${prevArticle.title }</a></p>
    </c:if>
</div>

<div class="view-menu" style="margin-bottom: 47px;">
    <security:authorize access="#email == principal.username or hasRole('ROLE_ADMIN')">
        <div class="fl">
            <input type="button" value="<spring:message code="global.modify" />" class="goModify" />
            <input type="button" value="<spring:message code="global.delete" />" class="goDelete" />
        </div>
    </security:authorize>        
    <div class="fr">
        <c:if test="${nextArticle != null }">    
            <input type="button" value="<spring:message code="bbs.next.article" />" title="${nextArticle.articleNo }" class="next-article" />
        </c:if>
        <c:if test="${prevArticle != null }">        
            <input type="button" value="<spring:message code="bbs.prev.article" />" title="${prevArticle.articleNo}" class="prev-article" />
        </c:if>        
        <input type="button" value="<spring:message code="global.list" />" class="goList" />
        <input type="button" value="<spring:message code="bbs.new.article" />" class="goWrite" />
    </div>
</div>

<!--  BBS list in detailed Article -->
<table id="list-table" class="bbs-table">
    <tr>
        <th style="width: 60px;">NO</th>
        <th>TITLE</th>
        <th style="width: 84px;">DATE</th>
        <th style="width: 60px;">HIT</th>
    </tr>

    <c:forEach var="article" items="${list }" varStatus="status">        
        <tr>
            <td style="text-align: center;">
                <c:choose>
                    <c:when test="${articleNo == article.articleNo }">	
                        <img src="/resources/images/arrow.gif" alt="<spring:message code="global.here" />" />
                    </c:when>
                    <c:otherwise>
                        ${listItemNo - status.index }
                    </c:otherwise>
                </c:choose>	
            </td>
            <td>
                <a href="#" title="${article.articleNo }">${article.title }</a>
                <c:if test="${article.attachFileNum > 0 }">		
                    <img src="/resources/images/attach.png" alt="<spring:message code="global.attach.file" />" style="vertical-align: middle;" />
                </c:if>
                <c:if test="${article.commentNum > 0 }">		
                    <span class="bbs-strong">[${article.commentNum }]</span>
                </c:if>		
            </td>
            <td style="text-align: center;"><fmt:formatDate pattern="yy.MM.dd" value="${article.regdate }" /></td>
            <td style="text-align: center;">${article.hit }</td>
        </tr>
    </c:forEach>
</table>

<div id="paging">
    <c:if test="${prevPage > 0 }">
        <a href="#" title="1">[<spring:message code="global.first" />]</a>
        <a href="#" title="${prevPage }">[<spring:message code="global.prev" />]</a>
    </c:if>

    <c:forEach var="i" begin="${firstPage }" end="${lastPage }">
        <c:choose>
            <c:when test="${param.page == i }">
                <span class="bbs-strong">${i }</span>
            </c:when>	
            <c:otherwise>	
                <a href="#" title="${i }">[ ${i } ]</a>
            </c:otherwise>
        </c:choose>			
    </c:forEach>

    <c:if test="${nextPage > 0 }">	
        <a href="#" title="${nextPage }">[<spring:message code="global.next" />]</a>
        <a href="#" title="${totalPage }">[<spring:message code="global.last" />]</a>
    </c:if>
</div>

<div id="list-menu">
    <input type="button" value="<spring:message code="bbs.new.article" />" />
</div>

<form id="searchForm" action="/bbs/${boardCd }/" method="get">
    <input type="hidden" name="page" value="1" />
    <div id="search">
        <input type="text" name="searchWord" size="15" maxlength="30" />
    <input type="submit" value="<spring:message code="global.search" />" />
    </div>
</form>

<div id="form-group" style="display: none">
    <form id="listForm" action="/bbs/${boardCd }" method="get">
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="viewForm" action="/bbs/${boardCd }/" method="get">
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <form id="writeForm" action="/bbs/${boardCd}/new" method="get">
        <input type="hidden" name="articleNo" value="${articleNo }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <sf:form id="delForm" action="/bbs/${boardCd }/${articleNo }" method="delete">
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </sf:form>
    <form id="modifyForm" action="/bbs/${boardCd }/${articleNo }/edit" method="get">
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
    <sf:form id="deleteCommentForm" action="/comments/${articleNo }/" method="delete">
        <input type="hidden" name="_method" value="DELETE" />
    </sf:form>
    <form id="deleteAttachFileForm" action="/bbs/deleteAttachFile" method="post">
        <input type="hidden" name="attachFileNo" />
        <input type="hidden" name="articleNo" value="${articleNo }" />
        <input type="hidden" name="boardCd" value="${boardCd }" />
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <form id="downForm" action="/data" method="post">
        <input type="hidden" name="filename" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <sf:form id="modifyCommentForm" method="put">
        <input type="hidden" name="_method" value="PUT" />
        <input type="hidden" name="memo" />
    </sf:form>
</div>
