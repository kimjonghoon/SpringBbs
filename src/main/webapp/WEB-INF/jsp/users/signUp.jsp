<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="user.signup.keywords" />" />
<meta name="Description" content="<spring:message code="user.signup.description" />" />
<title><spring:message code="user.signup.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
//<![CDATA[ 

function check() {
    //var form = document.getElementById("signUpForm");
    //TODO Validation 
    return true;
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
<h1><spring:message code="user.signup.heading" /></h1>
<sf:form id="signUpForm" action="signUp" method="post" commandName="user" onsubmit="return check();">
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td style="width: 200px;"><spring:message code="user.full.name" /></td>
	<td style="width: 390px;">
		<sf:input path="name" /><br />
		<sf:errors path="name" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.password" /></td>
	<td>
		<sf:password path="passwd" /><br />
		<sf:errors path="passwd" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2" style="text-align: center;font-weight: bold;">
		<spring:message code="user.signup.warning" />
	</td>
</tr>
<tr>
	<td><spring:message code="global.confirm" /></td>
	<td><input type="password" name="confirm" /></td>
</tr>
<tr>
	<td><spring:message code="user.email" /></td>
	<td>
		<sf:input path="email" /><br />
		<sf:errors path="email" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.mobile" /></td>
	<td>
		<sf:input path="mobile" /><br />
		<sf:errors path="mobile" cssClass="error" />
	</td>
</tr>
</table>
<div style="text-align: center;padding-bottom: 15px;">
	<input type="submit" value="<spring:message code="global.submit" />" />
</div>
</sf:form>
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