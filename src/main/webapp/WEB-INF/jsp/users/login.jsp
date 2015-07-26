<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="user.login.keywords" />" />
<meta name="Description" content="<spring:message code="user.login.description" />" />
<title><spring:message code="user.login.title" /></title>
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
<h1><spring:message code="user.login.heading" /></h1>
<c:if test="${not empty param.msg }">
	<h2>${SPRING_SECURITY_LAST_EXCEPTION.message }</h2>
</c:if>
<form id="loginForm" action="../j_spring_security_check" method="post">
<table>
<tr>
    <td style="width: 200px;"><spring:message code="user.email" /></td>
    <td style="width: 390px"><input type="text" name="j_username" style="width: 99%;" /></td>
</tr>
<tr>
    <td><spring:message code="user.password" /></td>
    <td><input type="password" name="j_password" style="width: 99%;" /></td>
</tr>
</table>
<div style="text-align: center;padding: 15px 0;">
    <input type="submit" value="<spring:message code="global.submit" />" />
    <input type="button" value="<spring:message code="user.signup" />" onclick="location.href='signUp'" />
</div>
</form>
<!-- contents end -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<%@ include file="notLoginUsers-menu.jsp" %>
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