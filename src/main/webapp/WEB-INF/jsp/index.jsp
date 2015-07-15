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
</head>
<body>

<div id="wrap">

    <div id="header">
    	<h1 style="float: left; width:150px;"><a href="./"><img src="images/ci.gif" alt="java-school" /></a></h1>
    	<div id="memberMenu" style="float: right;position: relative; top: 7px;">
		<security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
			<security:authentication property="principal.username" var="check" />
		</security:authorize>
		<c:choose>
			<c:when test="${empty check}">
				<input type="button" value="<spring:message code="user.login" />" onclick="location.href='./users/login'" />
				<input type="button" value="<spring:message code="user.signup" />" onclick="location.href='./users/signUp'" />
			</c:when>
			<c:otherwise>
				<input type="button" value="<spring:message code="user.logout" />" onclick="location.href='./j_spring_security_logout'" />
				<input type="button" value="<spring:message code="user.modify.account" />" onclick="location.href='./users/editAccount'" />
			</c:otherwise>
		</c:choose>	
    	</div>
    </div>
    
    <div id="main-menu">
        <ul id="nav">
            <li><a href="java/">Java</a></li>
            <li><a href="jdbc/">JDBC</a></li>
            <li><a href="jsp/">JSP</a></li>
            <li><a href="css-layout/">CSS Layout</a></li>
            <li><a href="jsp-project/">JSP Project</a></li>
            <li><a href="spring/">Spring</a></li>
            <li><a href="javascript/">JavaScript</a></li>
            <li><a href="bbs/list?boardCd=free&amp;curPage=1">BBS</a></li>
        </ul>
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
		<a href="http://www.youtube.com"><img src="images/youtube.png" alt="youtube.com" /></a>
		<a href="http://www.twitter.com"><img src="images/twitter.png" alt="twitter.com" /></a>
		<a href="http://www.facebook.com"><img src="images/facebook.png" alt="facebook.com" /></a>
		<a href="http://www.gmail.com"><img src="images/gmail.png" alt="gmail.com" /></a>
		<a href="http://www.java-school.net"><img src="images/java-school.png" alt="java-school.net" /></a>
	</div>
    
    <div id="footer">
		<%@ include file="inc/footer.jsp" %>
    </div>

</div>

</body>
</html>