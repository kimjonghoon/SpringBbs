<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="user.changepasswd.keywords" />" />
<meta name="Description" content="<spring:message code="user.changepasswd.description" />" />
<title><spring:message code="user.changepasswd.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
//<![CDATA[ 

function check() {
    var form = document.getElementById("changePassworddForm");
    if (form.newPasswd.value == form.confirm.value) {
    	return true;
    } else {
    	alert('<spring:message code="user.changepasswd.passwd.validation" />');
    	return false;
    }
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
		<div id="content" style="min-height: 800px;">
		
<!-- contents begin -->
<div id="url-navi"><spring:message code="user.membership" /></div>
<h1><spring:message code="user.changepasswd.heading" /></h1>
${user.name }<br />
${user.mobile }<br />
<sf:form id="changePassworddForm" action="changePasswd" method="post" 
	commandName="password" onsubmit="return check()">
<table>
<tr>
	<td><spring:message code="user.changepasswd.current.passwd" /></td>
	<td>
		<sf:password path="currentPasswd" /><br />
		<sf:errors path="currentPasswd" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.changepasswd.new.passwd" /></td>
	<td>
		<sf:password path="newPasswd" /><br />
		<sf:errors path="newPasswd" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.changepasswd.new.passwd.confirm" /></td>
	<td><input type="password" name="confirm" /></td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="확인" /></td>
</tr>
</table>
</sf:form>
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