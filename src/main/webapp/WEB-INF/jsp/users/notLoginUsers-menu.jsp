<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<h1><spring:message code="user.membership" /></h1>
<ul>
	<li>
		<ul>
			<li><a href="login"><spring:message code="user.login" /></a></li>
			<li><a href="signUp"><spring:message code="user.signup" /></a></li>
			<li><a href="#"><spring:message code="user.forgot.id" /></a></li>
			<li><a href="#"><spring:message code="user.forgot.pw" /></a></li>
		</ul>
	</li>
</ul>