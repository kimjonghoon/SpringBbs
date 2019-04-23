<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<ul id="nav">
    <li><a href="/java/Features">Java</a></li>
    <li><a href="/jdbc/JDBC-Intro">JDBC</a></li>
    <li><a href="/jsp/How-to-install-Tomcat">JSP</a></li>
    <li><a href="/css-layout/div-element-arrangement">CSS Layout</a></li>
    <li><a href="/jsp-pjt/Dynamic-Web-Project-Set-Up">JSP Project</a></li>
    <li><a href="/spring/building-java-projects-with-maven">Spring</a></li>
    <li><a href="/javascript/introduction">JavaScript</a></li>
    <li><a href="/google-app-engine/building-gae-projects-with-maven">Google Cloud</a></li>
    <li><a href="/blog">Blog</a></li>
    <li><a href="/bbs/chat?page=1">BBS</a></li>
    <security:authorize access="hasRole('ROLE_ADMIN')">
        <li><a href="/admin?page=1">Admin</a></li>
    </security:authorize>
</ul>