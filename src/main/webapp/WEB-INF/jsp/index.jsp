<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="home.keywords" />" />
<meta name="Description" content="<spring:message code="home.description" />" />
<title><spring:message code="home.title" /></title>
<link rel="stylesheet" href="css/screen.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
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
		<div id="content" style="min-height: 800px;">

<!-- contents begin -->
<div id="url-navi">HomePage</div>
<!--  contents end -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<h1>HomePage</h1>
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