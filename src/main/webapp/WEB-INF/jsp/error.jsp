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
<meta name="Keywords" content="Error" />
<meta name="Description" content="Error" />
<title>Error</title>
<link rel="stylesheet" href="<%=contextPath %>/css/screen.css" type="text/css" />
<script type="text/javascript" src="<%=contextPath %>/js/jquery-3.0.0.min.js"></script>
</head>
<body>
<%
//Analyze the servlet exception
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

if (servletName == null) {
  servletName = "Unknown";
}

String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

if (requestUri == null) {
  requestUri = "Unknown";
}
%>
<div id="wrap">

    <div id="header">
     	<h1 style="float: left; width:150px;"><a href="<%=contextPath %>/"><img src="<%=contextPath %>/images/ci.gif" alt="java-school logo" /></a></h1>
    	<div id="memberMenu" style="float: right;position: relative; top: 7px;">
    	<!-- 뷰 레벨 인증을 에러 페이지에 쓸 수 없다. -->
    	</div>
    </div>
    
    <div id="main-menu">
    	<%@ include file="inc/main-menu.jsp" %>
    </div>
    
	<div id="container">
		<div id="content">
			<div id="url-navi">Error</div>

<!-- contents begin -->
<h1>Error Page</h1>
<%

if(statusCode != null && statusCode != 500){
    out.write("<h3>Error Details</h3>");
    out.write("<strong>Status Code</strong>:" + statusCode + "<br>");
    out.write("<strong>Requested URI</strong>:"+requestUri);
}    
if (throwable != null) {
    out.write("<h3>Exception Details</h3>");
    out.write("<ul><li>Servlet Name:" + servletName + "</li>");
    out.write("<li>Exception Name:" + throwable.getClass().getName() + "</li>");
    out.write("<li>Requested URI:" + requestUri + "</li>");
    out.write("<li>Exception Message:" + throwable.getMessage() + "</li>");
    out.write("</ul>");
}
%>
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
