<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ page import="net.java_school.user.User" %>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>403</title>
<link rel="stylesheet" href="<%=contextPath %>/css/screen.css" type="text/css" />
<script type="text/javascript" src="<%=contextPath %>/js/jquery-3.0.0.min.js"></script>
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
		<div id="content">
			<div id="url-navi">Error</div>
<!-- contents begin -->
<h1>403</h1>
Access is Denied.
<!--  contents end -->
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
