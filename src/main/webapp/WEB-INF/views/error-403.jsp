<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
%>
<div id="url-navi">Error</div>
<h2>Error 403</h2>
<p>
Access is Denied.
</p>
<%
if (throwable != null) {
    out.write("<h3>Exception Details</h3>");
    out.write("<li>Exception Name:" + throwable.getClass().getName() + "</li>");
    out.write("<li>Exception Message:" + throwable.getMessage() + "</li>");
    out.write("</ul>");
}
%>