<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<h1 style="float: left;width: 150px;"><a href="/"><img src="/resources/images/ci.gif" alt="java-school" /></a></h1>

<div id="memberMenu" style="float: right;position: relative;top: 7px;">

<security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
	<security:authentication property="principal.username" var="check" />
</security:authorize>
<c:choose>
	<c:when test="${empty check}">
		<input type="button" value="<spring:message code="user.login" />" onclick="location.href='/users/login'" />
		<input type="button" value="<spring:message code="user.signup" />" onclick="location.href='/users/signUp'" />
	</c:when>
	<c:otherwise>
		<input type="button" value="<spring:message code="user.logout" />" id="logout" />
		<input type="button" value="<spring:message code="user.modify.account" />" onclick="location.href='/users/editAccount'" />
	</c:otherwise>
</c:choose>
</div>

<%
String url = "";
String english = "";
String korean = "";
String qs = request.getQueryString();
if (qs != null) {
	if (qs.indexOf("&lang=") != -1) {
		qs = qs.substring(0, qs.indexOf("&lang="));
	}
	if (qs.indexOf("lang=") != -1) {
		qs = qs.substring(0, qs.indexOf("lang="));
	}
	if (!qs.equals("")) {
	    String decodedQueryString = java.net.URLDecoder.decode(request.getQueryString(), "UTF-8");
	    url = "?" + decodedQueryString;
	    if (url.indexOf("&lang=") != -1) {
	        url = url.substring(0, url.indexOf("&lang="));
	    } 
	    english = url + "&lang=en";
	    korean = url + "&lang=ko";
	} else {
	    english = url + "?lang=en";
	    korean = url = "?lang=ko";
	}
} else {
    english = url + "?lang=en";
    korean = url = "?lang=ko";
}

pageContext.setAttribute("english", english);
pageContext.setAttribute("korean", korean);
%>

<div id="localeChangeMenu" style="float: right;position: relative;top: 7px;margin-right: 10px;">
    <input type="button" value="English" onclick="location.href='${english}'" />
    <input type="button" value="Korean" onclick="location.href='${korean }'" />
</div>

<form id="logoutForm" action="/logout" method="post" style="display:none">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
<script type="text/javascript" src="/resources/js/jquery-3.0.0.min.js"></script>

<script>
$(document).ready(function() {
	$('#logout').click(function() {
		$('#logoutForm').submit();
		return false;
  	});
});
</script>