<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page isELIgnored="false" %> --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="게시판 목록" />
<meta name="Description" content="게시판 목록" />
<link rel="stylesheet" href="../css/screen.css" type="text/css" media="screen" />
<title>${boardNm }</title>
<script type="text/javascript">
//<![CDATA[
	function goList(page) {
		var form = document.getElementById("listForm");
		form.curPage.value = page;
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

	function search() {
		var form = document.getElementById("searchForm");
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
		<div id="content" style="height: 800px;">
			<div id="url-navi">BBS</div>

<!-- 본문 시작 -->			
<h1>${boardNm }</h1>
<div id="bbs">
	<table>
	<tr>
		<th style="width: 60px;">NO</th>
		<th>TITLE</th>
		<th style="width: 84px;">DATE</th>
		<th style="width: 60px;">HIT</th>
	</tr>
	<!--  반복 구간 시작 -->
	<c:forEach var="article" items="${list }" varStatus="status">	
	<tr>
		<td style="text-align: center;">${no - status.index}</td>
		<td>
			<a href="javascript:goView('${article.articleNo }')">${article.title }</a>
			<c:if test="${article.attachFileNum > 0 }">
				<img src="../images/attach.png" alt="첨부파일" />
			</c:if>
			<c:if test="${article.commentNum > 0 }">
				<span class="bbs-strong">[${article.commentNum }]</span>
			</c:if>
		</td>
		<td style="text-align: center;">${article.writeDate }</td>
		<td style="text-align: center;">${article.hit }</td>
	</tr>
	</c:forEach>
	<!--  반복 구간 끝 -->
	</table>
		
	<div id="paging" style="text-align: center;">
		
		<c:if test="${prevLink > 0 }">
			<a href="javascript:goList('${prevPage }')">[이전]</a>
		</c:if>

		<c:forEach var="i" items="${pageLinks }" varStatus="stat">
			<c:choose>
			<c:when test="${curPage == i}">
				<span class="bbs-strong">${i }</span>
			</c:when>
			<c:otherwise>
				<a href="javascript:goList('${i }')">${i }</a>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${nextLink > 0 }">
			<a href="javascript:goList('${nextPage }')">[다음]</a>
		</c:if>
		
	</div>

	<div id="list-menu" style="text-align:  right;">
		<input type="button" value="새글쓰기" onclick="goWrite()" />
	</div>

	<div id="search" style="text-align: center;">
		<form id="searchForm" action="./list" method="get" style="margin: 0;padding: 0;">
			<p style="margin: 0;padding: 0;">
				<input type="hidden" name="boardCd" value="${boardCd }" />
				<input type="text" name="searchWord" size="15" maxlength="30" />
				<input type="submit" value="검색" style="height: 25px;line-height: 25px;" />
			</p>	
		</form>
	</div>
	
</div>
<!--  본문 끝 -->

		</div><!-- content 끝 -->
	</div><!--  container 끝 -->
	
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
	<form id="listForm" action="./list" method="get">
		<p>
			<input type="hidden" name="boardCd" value="${boardCd }" />
			<input type="hidden" name="curPage" />
			<input type="hidden" name="searchWord" value="${param.searchWord }" />
		</p>
		</form>
		<form id="viewForm" action="./view" method="get">
		<p>
			<input type="hidden" name="articleNo" />
			<input type="hidden" name="boardCd" value="${boardCd }" />
			<input type="hidden" name="curPage" value="${curPage }" />
			<input type="hidden" name="searchWord" value="${param.searchWord }" />
		</p>
		</form>
		<form id="writeForm" action="./write" method="get">
		<p>
			<input type="hidden" name="boardCd" value="${boardCd }" />
			<input type="hidden" name="curPage" value="${curPage }" />
			<input type="hidden" name="searchWord" value="${param.searchWord }" />
		</p>
	</form>
</div>

</body>
</html>
