<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<h1 style="float: left;width: 150px;"><a href="../"><img src="${pageContext.request.contextPath}/images/ci.gif" alt="java-school" /></a></h1>
<div id="memberMenu" style="float: right;position: relative;top: 7px;">
<security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
	<security:authentication property="principal.username" var="check" />
</security:authorize>
<c:choose>
	<c:when test="${empty check}">
		<input type="button" value="<spring:message code="user.login" />" onclick="location.href='${pageContext.request.contextPath}/users/login'" />
		<input type="button" value="<spring:message code="user.signup" />" onclick="location.href='${pageContext.request.contextPath}/users/signUp'" />
	</c:when>
	<c:otherwise>
		<input type="button" value="<spring:message code="user.logout" />" onclick="location.href='${pageContext.request.contextPath}/j_spring_security_logout'" />
		<input type="button" value="<spring:message code="user.modify.account" />" onclick="location.href='${pageContext.request.contextPath}/users/editAccount'" />
	</c:otherwise>
</c:choose>
</div>