<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<script src="/resources/js/bbs-view.js"></script>

<div id="url-navi">BBS</div>

<h2>${boardName }</h2>

<div class="view-menu" style="margin-bottom: 5px;">
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
    <th style="width: 37px;text-align: left;vertical-align: top;">TITLE</th>
    <th style="text-align: left;color: #555;">${title }</th>
</tr>
</table>
<div id="detail">
    <span id="date-writer-hit">
    	edited <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${regdate }" />
		by ${name } hit ${hit }</span>
    <p>${content }</p>
    <p id="file-list" style="text-align: right">
    	<c:forEach var="file" items="${attachFileList }" varStatus="status">
    	   <a href="#" title="${file.filename }" class="download">${file.filename }</a>
			<security:authorize access="#email == principal.username or hasRole('ROLE_ADMIN')">
	    	<a href="#" title="${file.attachFileNo }">x</a>
			</security:authorize>
			<br />
		</c:forEach>
    </p>
</div>
<form id="modifyForm" action="/bbs/modify_form" method="get">
<p>
    <input type="hidden" name="articleNo" value="${articleNo }" />
    <input type="hidden" name="boardCd" value="${boardCd }" />
    <input type="hidden" name="curPage" value="${param.curPage }" />
    <input type="hidden" name="searchWord" value="${param.searchWord }" />
</p>
</form>

<form id="addCommentForm" action="/bbs/addComment" method="post" style="margin-bottom: 10px;">
<p style="margin: 0;padding: 0">
	<input type="hidden" name="articleNo" value="${articleNo }" />
	<input type="hidden" name="boardCd" value="${boardCd }" />
	<input type="hidden" name="curPage" value="${param.curPage }" />
	<input type="hidden" name="searchWord" value="${param.searchWord }" />
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}" />
</p>
<div id="addComment">
	<textarea name="memo" rows="7" cols="50"></textarea>
</div>
<div style="text-align: right;">
	<input type="submit" value="<spring:message code="bbs.new.comments" />" />
</div>
</form>

<!--  comments begin -->
<c:forEach var="comment" items="${commentList }" varStatus="status">
<div class="comments">
    <span class="writer">${comment.name }</span>
    <span class="date">${comment.regdate }</span>
	<security:authorize access="#comment.email == principal.username or hasRole('ROLE_ADMIN')">
    <span class="modify-del">
        <a href="#" class="comment-toggle"><spring:message code="global.modify" /></a> | 
        <a href="#" class="comment-delete" title="${comment.commentNo }"><spring:message code="global.delete" /></a>
    </span>
	</security:authorize>
    <p class="view-comment">${comment.htmlMemo }</p>
    <form class="modify-comment" action="/bbs/updateComment" method="post" style="display: none;">
    <p>
        <input type="hidden" name="commentNo" value="${comment.commentNo }" />
        <input type="hidden" name="boardCd" value="${boardCd }" />
        <input type="hidden" name="articleNo" value="${articleNo }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    <div style="text-align: right;">
            <a href="#" class="comments-modify-submit"><spring:message code="global.submit" /></a> | <a href="#" class="comments-modify-cancel"><spring:message code="global.cancel" /></a>
    </div>
    <div>
        <textarea class="modify-comment-ta" name="memo" rows="7" cols="50">${comment.memo }</textarea>
    </div>
    </form>
</div>
</c:forEach>
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
		<img src="/resources/images/attach.png" alt="<spring:message code="global.attach.file" />" />
		</c:if>
		<c:if test="${article.commentNum > 0 }">		
		<span class="bbs-strong">[${article.commentNum }]</span>
		</c:if>		
	</td>
	<td style="text-align: center;"><fmt:formatDate pattern="yyyy.MM.dd" value="${article.regdate }" /></td>
	<td style="text-align: center;">${article.hit }</td>
</tr>
</c:forEach>
</table>
                
<div id="paging">
	<c:if test="${prevPage > 0 }">
		<a href="#" title="${prevPage }">[ <spring:message code="global.prev" /> ]</a>
	</c:if>
	
	<c:forEach var="i" begin="${firstPage }" end="${lastPage }">
		<c:choose>
			<c:when test="${param.curPage == i }">
				<span class="bbs-strong">${i }</span>
			</c:when>	
			<c:otherwise>	
				<a href="#" title="${i }">[ ${i } ]</a>
			</c:otherwise>
		</c:choose>			
	</c:forEach>
	
	<c:if test="${nextPage > 0 }">	
		<a href="#" title="${nextPage }">[ <spring:message code="global.next" /> ]</a>
	</c:if>
</div>

<div id="list-menu">
	<input type="button" value="<spring:message code="bbs.new.article" />" />
</div>

<div id="search">
	<form action="/bbs/${boardCd }/" method="get">
	<div>
		<input type="hidden" name="curPage" value="1" />
		<input type="text" name="searchWord" size="15" maxlength="30" />
		<input type="submit" value="<spring:message code="global.search" />" />
	</div>
	</form>
</div>

<div id="form-group" style="display: none">
    <form id="listForm" action="/bbs/${boardCd }/" method="get">
    <p>
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="viewForm" action="/bbs/${boardCd }/" method="get">
    <p>
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <form id="writeForm" action="/bbs/write_form" method="get">
    <p>
        <input type="hidden" name="articleNo" value="${articleNo }" />
        <input type="hidden" name="boardCd" value="${boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </p>
    </form>
    <sf:form id="delForm" action="/bbs/${boardCd }/${articleNo }" method="delete">
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </sf:form>
    <form id="deleteCommentForm" action="/bbs/deleteComment" method="post">
    <p>
        <input type="hidden" name="commentNo" />
        <input type="hidden" name="articleNo" value="${articleNo }" />
        <input type="hidden" name="boardCd" value="${boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    </form>   
    <form id="deleteAttachFileForm" action="/bbs/deleteAttachFile" method="post">
    <p>
        <input type="hidden" name="attachFileNo" />
        <input type="hidden" name="articleNo" value="${articleNo }" />
        <input type="hidden" name="boardCd" value="${boardCd }" />
        <input type="hidden" name="curPage" value="${param.curPage }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    </form>
    <form id="downForm" action="/file/download" method="post">
    <p>
        <input type="hidden" name="filename" />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </p>
    </form>
   	<div id="delete-confirm" title="<spring:message code="delete.confirm" />"></div>
</div>