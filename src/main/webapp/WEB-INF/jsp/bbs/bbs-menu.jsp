<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1><spring:message code="global.bbs" /></h1>
<ul>
	<li>
		<ul>
			<li><a href="list?boardCd=free&curPage=1"><spring:message code="bbs.board.free" /></a></li>
			<li><a href="list?boardCd=qna&curPage=1"><spring:message code="bbs.board.qna" /></a></li>
			<li><a href="list?boardCd=data&curPage=1"><spring:message code="bbs.board.data" /></a></li>
		</ul>
	</li>
</ul>