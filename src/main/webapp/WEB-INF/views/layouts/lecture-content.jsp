<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="main-article" title="<tiles:insertAttribute name="article" />"></div>
<div id="next-prev">
    <ul>
        <li>
            <spring:message code="global.next" /> : 
            <a href="<tiles:insertAttribute name="next-article" defaultValue="" defaultValueType="string" />"><tiles:insertAttribute name="next-article-title" defaultValue="" /></a>
        </li>
        <li>
            <spring:message code="global.prev" /> : 
            <a href="<tiles:insertAttribute name="prev-article" defaultValue="" defaultValueType="string" />"><tiles:insertAttribute name="prev-article-title" defaultValue="" /></a>
        </li>
    </ul>
</div>