<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="<spring:message code="home.keywords" />" />
<meta name="Description" content="<spring:message code="home.description" />" />
<title><spring:message code="home.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.0.0.min.js"></script>
</head>
<body>

<div id="wrap">

    <div id="header">
		<%@ include file="inc/header.jsp" %>
    </div>
    
    <div id="main-menu">
		<%@ include file="inc/main-menu.jsp" %>
    </div>
    
	<div id="container">
		<div id="content">

<!-- contents begin -->
<div id="url-navi">Home</div>
<!--  contents end -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Home</h1>
	</div>
    
	<div id="extra">
		<%@ include file="inc/extra.jsp" %>
	</div>
    
    <div id="footer">
		<%@ include file="inc/footer.jsp" %>
    </div>

</div>

</body>
</html>