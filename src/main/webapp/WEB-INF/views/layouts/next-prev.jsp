<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<div id="next-prev">
    <ul>
        <li>
            <spring:message code="global.next" /> : 
            <a href="<tiles:insertAttribute name="next-article" />"><tiles:insertAttribute name="next-article-title" /></a>
        </li>
        <li>
            <spring:message code="global.prev" /> : 
            <a href="<tiles:insertAttribute name="prev-article" />"><tiles:insertAttribute name="prev-article-title" /></a>
        </li>
    </ul>
</div>