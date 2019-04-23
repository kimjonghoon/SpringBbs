<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<ul>
	<li><a href="#"><spring:message code="global.guide" /></a></li>
	<li><a href="#"><spring:message code="global.privacy" /></a></li>
	<li><a href="#"><spring:message code="global.email.collection.ban" /></a></li>
	<li id="company-info">
		<spring:message code="global.phone" /> : 02-123-5678, 
		<spring:message code="global.fax" /> : 02-123-5678<br />
		people@ggmail.org<br /> Copyright java-school.net All Rights Reserved.</li>
	<li><a href="#"><spring:message code="global.map" /></a></li>
</ul>