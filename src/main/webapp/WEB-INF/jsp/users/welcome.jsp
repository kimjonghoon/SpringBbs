<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="user.welcome.keywords" />" />
<meta name="Description" content="<spring:message code="user.welcome.description" />" />
<title><spring:message code="user.welcome.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
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
<div id="url-navi"><spring:message code="user.membership" /></div>
<h1><spring:message code="user.welcome.heading" /></h1>
<spring:message code="user.welcome.message" /><br />
<input type="button" value="<spring:message code="user.login" />" onclick="javascript:location.href='login'" />
<!-- contents end -->
		
		</div>
    </div>
    
    <div id="sidebar">
		<h1>Welcome</h1>
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