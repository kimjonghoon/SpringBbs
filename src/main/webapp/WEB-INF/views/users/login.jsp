<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.login.heading" /></h2>

<c:if test="${not empty param.error }">
	<h3>${SPRING_SECURITY_LAST_EXCEPTION.message }</h3>
</c:if>
<c:url var="loginUrl" value="/login" />
<form action="${loginUrl }" method="post">
<p style="margin:0; padding: 0;">
<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}" />
</p>
<table>
<tr>
    <td style="width: 200px;"><spring:message code="user.email" /></td>
    <td style="width: 390px"><input type="text" name="username" style="width: 99%;" /></td>
</tr>
<tr>
    <td><spring:message code="user.password" /></td>
    <td><input type="password" name="password" style="width: 99%;" /></td>
</tr>
</table>
<div style="text-align: center;padding: 15px 0;">
    <input type="submit" value="<spring:message code="global.submit" />" />
    <input type="button" value="<spring:message code="user.signup" />" onclick="location.href='signUp'" />
</div>
</form>