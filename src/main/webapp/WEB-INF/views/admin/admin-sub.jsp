<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<h1><spring:message code="user.admin" /></h1>
<ul>
    <li><a href="/admin?page=1"><spring:message code="user.list" /></a></li>
    <li><a href="/admin/board"><spring:message code="global.bbs" /></a></li>
</ul>