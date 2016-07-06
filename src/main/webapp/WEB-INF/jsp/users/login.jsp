<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="<spring:message code="user.login.keywords" />" />
<meta name="Description" content="<spring:message code="user.login.description" />" />
<title><spring:message code="user.login.title" /></title>
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

<div id="url-navi"><spring:message code="user.membership" /></div>
<h1><spring:message code="user.login.heading" /></h1>
<c:if test="${param.error != null }">
	<h2>Username Password not corrrent</h2>
</c:if>
<c:url var="loginUrl" value="/login" />
<form action="${loginUrl }" method="post">
<p style="margin:0; padding: 0;">
<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}" />
</p>
<table>
<tr>
    <td style="width: 200px;"><spring:message code="user.email" /></td>
    <td style="width: 390px"><input type="text" name="username" style="width: 99%;" /></td>
</tr>
<tr>
    <td><spring:message code="user.password" /></td>
    <td><input type="password" name="password" style="width: 99%;" /></td>
</tr>
</table>
<div style="text-align: center;padding: 15px 0;">
    <input type="submit" value="<spring:message code="global.submit" />" />
    <input type="button" value="<spring:message code="user.signup" />" onclick="location.href='signUp'" />
</div>
</form>
		
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