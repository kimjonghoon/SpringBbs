<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="<spring:message code="user.bye.keywords" />" />
<meta name="Description" content="<spring:message code="user.bye.description" />" />
<title><spring:message code="user.bye.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
<script type="text/javascript">
//<![CDATA[ 

function check() {
    //var form = document.getElementById("byeForm");
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
<h1><spring:message code="user.bye.heading" /></h1>
<form id="byeForm" action="bye" method="post" onsubmit="return check()">
<table>
<tr>
	<td><spring:message code="user.email" /></td>
	<td><input type="text" name="email" /></td>
</tr>
<tr>
	<td><spring:message code="user.password" /></td>
	<td><input type="password" name="passwd" /></td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</form>
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