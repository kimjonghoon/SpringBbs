<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="net.java_school.user.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>error 403</title>
<link rel="stylesheet" href="/css/screen.css" type="text/css" />
<script type="text/javascript" src="/js/jquery-3.0.0.min.js"></script>
</head>
<body>
<%
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
%>
<div id="wrap">

    <div id="header">
    	<%@ include file="inc/header.jsp" %>
    </div>
    
    <div id="main-menu">
    	<%@ include file="inc/main-menu.jsp" %>
    </div>
    
	<div id="container">
		<div id="content">
			<div id="url-navi">error-403</div>
			<h1>Error 403</h1>
			Access is Denied.
<%
if (throwable != null) {
    out.write("<h3>Exception Details</h3>");
    out.write("<li>Exception Name:" + throwable.getClass().getName() + "</li>");
    out.write("<li>Exception Message:" + throwable.getMessage() + "</li>");
    out.write("</ul>");
}
%>			
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Error</h1>
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