<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div id="content-categories">Error</div>
<h2>Error Page</h2>
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