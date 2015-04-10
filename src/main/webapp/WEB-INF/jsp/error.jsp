<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.java_school.user.User" %>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="Error" />
<meta name="Description" content="Error" />
<title>Error</title>
<link rel="stylesheet" href="<%=contextPath %>/css/screen.css" type="text/css" />
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
    	</div>
    </div>
    
    <div id="main-menu">
        <ul id="nav">
            <li><a href="<%=contextPath %>/java/">Java</a></li>
            <li><a href="<%=contextPath %>/jdbc/">JDBC</a></li>
            <li><a href="<%=contextPath %>/jsp/">JSP</a></li>
            <li><a href="<%=contextPath %>/css-layout/">CSS Layout</a></li>
            <li><a href="<%=contextPath %>/jsp-project/">JSP Project</a></li>
            <li><a href="<%=contextPath %>/spring/">Spring</a></li>
            <li><a href="<%=contextPath %>/javascript/">JavaScript</a></li>
            <li><a href="<%=contextPath %>/bbs/list?boardCd=free&amp;curPage=1">BBS</a></li>
        </ul>
    </div>
    
	<div id="container">
		<div id="content" style="min-height: 800px;">
			<div id="url-navi">Error</div>

<!-- 본문 시작 -->
<h1>Error Page</h1>
<%
if(statusCode != 500){
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
<!--  본문 끝 -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Main</h1>
	</div>
    
	<div id="extra">
		<a href="http://www.youtube.com"><img src="<%=contextPath %>/images/youtube.png" alt="youtube.com" /></a>
		<a href="http://www.twitter.com"><img src="<%=contextPath %>/images/twitter.png" alt="twitter.com" /></a>
		<a href="http://www.facebook.com"><img src="<%=contextPath %>/images/facebook.png" alt="facebook.com" /></a>
		<a href="http://www.gmail.com"><img src="<%=contextPath %>/images/gmail.png" alt="gmail.com" /></a>
		<a href="http://www.java-school.net"><img src="<%=contextPath %>/images/java-school.png" alt="java-school.net" /></a>    
	</div>
    
    <div id="footer">
		<%@ include file="inc/footer.jsp" %>
    </div>
        
</div>

</body>
</html>