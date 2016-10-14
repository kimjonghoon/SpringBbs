<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<a href="https://cloud.google.com"><img src="/resources/images/gcp-logo.png" alt="Google Cloud Platform"></a>
<a href="https://drive.google.com/drive/my-drive"><img src="/resources/images/google-drive.png" alt="Google Drive"></a>
<a href="http://www.youtube.com"><img src="/resources/images/youtube.png" alt="youtube.com" /></a>
<a href="http://www.gmail.com"><img src="/resources/images/gmail.gif" alt="gmail.com" /></a>
<a href="http://www.java-school.net"><img src="/resources/images/ci.gif" alt="java-school.net" /></a>
<security:authorize access="hasRole('ROLE_ADMIN')">
<a href="/admin?page=1"><img alt="go to console" src="/resources/images/admin.png"></a>
</security:authorize>