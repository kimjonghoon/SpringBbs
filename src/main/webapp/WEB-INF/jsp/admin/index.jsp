<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<h1>Member</h1>

<table class="table-in-article">
<tr>
	<th>No</th>
	<th>Full Name</th>
	<th>Email</th>
	<th>Mobile</th>
	<th>ROLE</th>
	<th>Manage</th>
</tr>
<c:forEach var="user" items="${list }" varStatus="status">
<tr>
	<td>${listItemNo - status.index }</td>
	<td><a href="javascript:goDetail('${user.email }')">${user.name }</a></td>
	<td>${user.email }</td>
	<td>${user.mobile }</td>
	<td>${user.authority }</td>
	<td><a href="/admin/modifyUser?user=${user.email }">Modify</a> | <a href="/admin/delUser?user=${user.email }">Del</a></td>
</tr>
</c:forEach>
</table>

<div id="paging">
	<c:if test="${prev > 0 }">
		<a href="javascript:goList('${prev }')">[ <spring:message code="global.prev" /> ]</a>
	</c:if>
	<c:forEach var="i" begin="${firstPage }" end="${lastPage }" varStatus="stat">
		<c:choose>
		<c:when test="${param.page == i}">
			<span class="bbs-strong">${i }</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:goList('${i }')">[ ${i } ]</a>
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${next > 0 }">
		<a href="javascript:goList('${next }')">[ <spring:message code="global.next" /> ]</a>
	</c:if>
</div>

<form>
	<input type="text" name="search" /><input type="submit" value="<spring:message code="global.search" />" />
</form>