<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script type="text/javascript">
function goList(page) {
	var form = document.getElementById("listForm");
	form.page.value = page;
	form.submit();
}
function goView(articleNo) {
 	var form = document.getElementById("viewForm");
 	form.action += articleNo;
	form.submit();
}
function goWrite() {
	var form = document.getElementById("writeForm");
	form.submit();
}
</script>

<div id="url-navi"><spring:message code="global.bbs" /></div>

<h2>${boardName }</h2>

<table class="bbs-table">
<tr>
	<th style="width: 60px;">NO</th>
	<th>TITLE</th>
	<th style="width: 84px;">DATE</th>
	<th style="width: 60px;">HIT</th>
</tr>
<!--  bbs list begin-->
<c:forEach var="article" items="${list }" varStatus="status">	
<tr>
	<td style="text-align: center;">${listItemNo - status.index}</td>
	<td>
		<a href="javascript:goView('${article.articleNo }')">${article.title }</a>
		<c:if test="${article.attachFileNum > 0 }">
			<img src="/resources/images/attach.png" alt="<spring:message code="global.attach.file" />" />
		</c:if>
		<c:if test="${article.commentNum > 0 }">
			<span class="bbs-strong">[${article.commentNum }]</span>
		</c:if>
	</td>
	<td style="text-align: center;">
		<fmt:formatDate pattern="yyyy.MM.dd" value="${article.regdate }" />
	</td>
	<td style="text-align: center;">${article.hit }</td>
</tr>
</c:forEach>
<!--  bbs list end -->
</table>
		
<div id="paging">
	
	<c:if test="${prevPage > 0 }">
		<a href="javascript:goList('${prevPage }')">[ <spring:message code="global.prev" /> ]</a>
	</c:if>

	<c:forEach var="i" begin="${firstPage }" end="${lastPage }" varStatus="stat">
		<c:choose>
		<c:when test="${param.page == i}">
			<span class="bbs-strong">${i }</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:goList('${i }')">[ ${i } ]</a>
		</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<c:if test="${nextPage > 0 }">
		<a href="javascript:goList('${nextPage }')">[ <spring:message code="global.next" /> ]</a>
	</c:if>
	
</div>

<div id="list-menu">
	<input type="button" value="<spring:message code="bbs.new.article" />" onclick="goWrite()" />
</div>

<div id="search">
	<form id="searchForm" method="get">
	<div>
		<input type="hidden" name="page" value="1" />
		<input type="text" name="searchWord" size="15" maxlength="30" />
		<input type="submit" value="<spring:message code="global.search" />" />
	</div>	
	</form>
</div>

<div id="form-group">
	<form id="listForm" method="get">
	<p>
		<input type="hidden" name="page" />
		<input type="hidden" name="searchWord" value="${param.searchWord }" />
	</p>
	</form>
	<form id="viewForm" action="/bbs/${boardCd }/" method="get">
	<p>
		<input type="hidden" name="page" value="${param.page }" />
		<input type="hidden" name="searchWord" value="${param.searchWord }" />
	</p>
	</form>
	<form id="writeForm" action="/bbs/write" method="get">
	<p>
		<input type="hidden" name="boardCd" value="${boardCd }" />
		<input type="hidden" name="page" value="${param.page }" />
		<input type="hidden" name="searchWord" value="${param.searchWord }" />
	</p>
	</form>
</div>