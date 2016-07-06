<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="<spring:message code="user.changepasswd.confirm.keywords" />" />
<meta name="Description" content="<spring:message code="user.changepasswd.confirm.description" />" />
<title><spring:message code="user.changepasswd.confirm.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.0.0.min.js"></script>
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
		
<!-- contents begin -->
<div id="url-navi"><spring:message code="user.membership" /></div>
<h1><spring:message code="user.changepasswd.confirm.heading" /></h1>
<spring:message code="user.changepasswd.confirm.login.again" />
<input type="button" value="<spring:message code="user.login" />" onclick="javascript:location.href='login'" />
<!-- contents end -->
		
		</div>
    </div>
    
    <div id="sidebar">
		<%@ include file="loginUsers-menu.jsp" %>
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