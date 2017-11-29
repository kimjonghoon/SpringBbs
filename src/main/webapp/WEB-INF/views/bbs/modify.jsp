<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<script>
function check() {
    //var form = document.getElementById("modifyForm");
    //TODO Validation 
    return true;
}
function goView() {
    var form = document.getElementById("viewForm");
    form.submit();
}
</script>

<div id="url-navi"><spring:message code="global.bbs" /></div>

<h2>${boardName }</h2>

<h3><spring:message code="global.modify" /></h3>

<sf:form id="modifyForm" action="/bbs/${boardCd}/${articleNo}?${_csrf.parameterName}=${_csrf.token}" method="post" commandName="article" enctype="multipart/form-data" onsubmit="return check()">
<input type="hidden" name="articleNo" value="${articleNo }" />
<input type="hidden" name="boardCd" value="${boardCd }" />
<input type="hidden" name="page" value="${param.page }" />
<input type="hidden" name="searchWord" value="${param.searchWord }" />
<sf:errors path="*" cssClass="error"/>
<table id="write-form" class="bbs-table">
<tr>
    <td><spring:message code="global.title" /></td>
    <td>
    	<sf:input path="title" style="width: 90%" value="${article.title }" /><br />
    	<sf:errors path="title" cssClass="error" />
    </td>
</tr>
<tr>
    <td colspan="2">
        <textarea name="content" rows="17" cols="50">${article.content }</textarea><br />
        <sf:errors path="content" cssClass="error" />
    </td>
</tr>
<tr>
    <td><spring:message code="global.attach.file" /></td>
    <td><input type="file" name="attachFile" /></td>
</tr>
</table>
<div style="text-align: center;padding-bottom: 15px;">
    <input type="submit" value="<spring:message code="global.submit" />" />
    <input type="button" value="<spring:message code="bbs.back.to.article" />" onclick="goView()" />
</div>
</sf:form>
		
<div id="form-group" style="display: none">
    <form id="viewForm" action="/bbs/${boardCd }/${articleNo }" method="get">
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>    
</div>
