<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>

<security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
    <security:authentication property="principal.username" var="check" />
</security:authorize>

<h1><spring:message code="user.membership" /></h1>
<ul>
    <c:choose>
        <c:when test="${empty check}">
            <li><a href="/users/login"><spring:message code="user.login" /></a></li>
            <li><a href="/users/signUp"><spring:message code="user.signup" /></a></li>
            <li><a href="#"><spring:message code="user.forgot.id" /></a></li>
            <li><a href="#"><spring:message code="user.forgot.pw" /></a></li>
        </c:when>
        <c:otherwise>
            <li><a href="/users/editAccount"><spring:message code="user.modify.account" /></a></li>
            <li><a href="/users/changePasswd"><spring:message code="user.change.password" /></a></li>
            <li><a href="/users/bye"><spring:message code="user.bye" /></a></li>
        </c:otherwise>
	</c:choose>
</ul>