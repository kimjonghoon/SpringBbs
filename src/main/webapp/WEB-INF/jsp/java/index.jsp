<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="자바 설치" />
<meta name="Description" content="자바 설치" />
<title><spring:message code="java.title" /></title>
<link rel="stylesheet" href="/css/screen.css" type="text/css" />
<script type="text/javascript" src="/js/jquery-3.0.0.min.js"></script>
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
		<div id="content">
			<div id="url-navi">Java</div>
<!-- 본문 시작 -->
<h1>자바 설치</h1>
<!-- 본문 끝 -->
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Java</h1>
	</div>
    
	<div id="extra">
		<%@ include file="../inc/extra.jsp" %>
	</div>
    
    <div id="footer">
		<%@ include file="../inc/footer.jsp" %>
    </div>
        
</div>

</body>
</html>