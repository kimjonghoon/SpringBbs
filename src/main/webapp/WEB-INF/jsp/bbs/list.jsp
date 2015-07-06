<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="bbs.list.keywords" />" />
<meta name="Description" content="<spring:message code="bbs.list.description" />" />
<link rel="stylesheet" href="../css/screen.css" type="text/css" />
<title>BBS</title>
<script type="text/javascript">
//<![CDATA[

function goList(curPage) {
	var form = document.getElementById("listForm");
	form.curPage.value = curPage;
	form.submit();
}

function goView(articleNo) {
	var form = document.getElementById("viewForm");
	form.articleNo.value = articleNo;
	form.submit();
}

function goWrite() {
	var form = document.getElementById("writeForm");
	form.submit();
}

//]]>
</script>           
</head>
<body>

<div id="wrap">

	<div id="header">
		<%@ include file="../inc/header.jsp" %>
	</div>

	<div id="main-menu">
		<%@ include file="../inc/main-menu.jsp" %>
	</div>

	<div id="container">
		<div id="content" style="min-height: 800px;">

<!-- contents begin -->			
<div id="url-navi">BBS</div>

<h1><spring:message code="bbs.board.${param.boardCd }" /></h1>
<div id="bbs">
	<!-- BBS Headings -->
	<table>
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
				<img src="../images/attach.png" alt="<spring:message code="global.attach.file" />" />
			</c:if>
			<c:if test="${article.commentNum > 0 }">
				<span class="bbs-strong">[${article.commentNum }]</span>
			</c:if>
		</td>
		<td style="text-align: center;">${article.regdateForList }</td>
		<td style="text-align: center;">${article.hit }</td>
	</tr>
	</c:forEach>
	<!--  bbs list end -->
	</table>
		
	<div id="paging">
		
		<c:if test="${prevPage > 0 }">
			<a href="javascript:goList('${prevPage }')">[<spring:message code="global.prev" />]</a>
		</c:if>

		<c:forEach var="i" begin="${firstPage }" end="${lastPage }" varStatus="stat">
			<c:choose>
			<c:when test="${param.curPage == i}">
				<span class="bbs-strong">${i }</span>
			</c:when>
			<c:otherwise>
				<a href="javascript:goList('${i }')">${i }</a>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${nextPage > 0 }">
			<a href="javascript:goList('${nextPage }')">[<spring:message code="global.next" />]</a>
		</c:if>
		
	</div>

	<div id="list-menu">
		<input type="button" value="<spring:message code="bbs.new.article" />" onclick="goWrite()" />
	</div>

	<div id="search">
		<form id="searchForm" action="./list" method="get">
			<p style="margin: 0;padding: 0;">
				<input type="hidden" name="boardCd" value="${param.boardCd }" />
				<input type="hidden" name="curPage" value="1" />
				<input type="text" name="searchWord" size="15" maxlength="30" />
				<input type="submit" value="<spring:message code="global.search" />" />
			</p>	
		</form>
	</div>
	
</div>
<!--  contents end -->

		</div><!-- #content end -->
	</div><!--  #container end -->
	
	<div id="sidebar">
		<%@ include file="bbs-menu.jsp" %>
	</div>
	
	<div id="extra">
		<%@ include file="../inc/extra.jsp" %>
	</div>

	<div id="footer">
		<%@ include file="../inc/footer.jsp" %>
	</div>

</div>

<div id="form-group">
	<form id="listForm" action="list" method="get">
		<p>
			<input type="hidden" name="boardCd" value="${param.boardCd }" />
			<input type="hidden" name="curPage" />
			<input type="hidden" name="searchWord" value="${param.searchWord }" />
		</p>
		</form>
		<form id="viewForm" action="view" method="get">
		<p>
			<input type="hidden" name="articleNo" />
			<input type="hidden" name="boardCd" value="${param.boardCd }" />
			<input type="hidden" name="curPage" value="${param.curPage }" />
			<input type="hidden" name="searchWord" value="${param.searchWord }" />
		</p>
		</form>
		<form id="writeForm" action="write_form" method="get">
		<p>
			<input type="hidden" name="boardCd" value="${param.boardCd }" />
			<input type="hidden" name="curPage" value="${param.curPage }" />
			<input type="hidden" name="searchWord" value="${param.searchWord }" />
		</p>
	</form>
</div>

</body>
</html>
