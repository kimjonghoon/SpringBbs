<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1><spring:message code="user.membership" /></h1>
<ul>
    <li>
        <ul>
            <li><a href="${pageContext.request.contextPath}/users/editAccount"><spring:message code="user.modify.account" /></a></li>
            <li><a href="${pageContext.request.contextPath}/users/changePasswd"><spring:message code="user.change.password" /></a></li>
            <li><a href="${pageContext.request.contextPath}/users/bye"><spring:message code="user.bye" /></a></li>
        </ul>
    </li>
</ul>