<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<a href="https://cloud.google.com"><img src="${pageContext.request.contextPath}/images/gcp-logo.png" alt="Google Cloud Platform"></a>
<a href="https://drive.google.com/drive/my-drive"><img src="${pageContext.request.contextPath}/images/google-drive.png" alt="Google Drive"></a>
<a href="http://www.youtube.com"><img src="${pageContext.request.contextPath}/images/youtube.png" alt="youtube.com" /></a>
<a href="http://www.gmail.com"><img src="${pageContext.request.contextPath}/images/gmail.gif" alt="gmail.com" /></a>
<a href="http://www.java-school.net"><img src="${pageContext.request.contextPath}/images/ci.gif" alt="java-school.net" /></a>
<security:authorize access="hasRole('ROLE_ADMIN')">
<a href="${pageContext.request.contextPath}/admin">Admin</a>
</security:authorize>