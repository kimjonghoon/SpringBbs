<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h1><spring:message code="user.welcome.heading" /></h1>

<spring:message code="user.welcome.message" /><br />
<input type="button" value="<spring:message code="user.login" />" onclick="javascript:location.href='login'" />