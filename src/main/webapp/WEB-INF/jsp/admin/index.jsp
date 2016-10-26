<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script type="text/javascript">
function goDel(user) {
	var check = confirm('<spring:message code="delete.confirm" />')
	if (check) {
		var form = document.getElementById("delUserForm");
		form.email.value = user;
		form.submit();
	}
}
</script>

<h2><spring:message code="user.list" /></h2>

<table class="table-in-article">
<tr>
	<th>No</th>
	<th><spring:message code="user.full.name" /></th>
	<th><spring:message code="user.email" /></th>
	<th><spring:message code="user.mobile" /></th>
	<th><spring:message code="user.authority" /></th>
	<th>X</th>
</tr>
<c:forEach var="user" items="${list }" varStatus="status">
<tr>
	<td>${listItemNo - status.index }</td>
	<td><a href="/admin/editAccount?email=${user.email }&page=${param.page }&search=${param.search }">${user.name }</a></td>
	<td>${user.email }</td>
	<td>${user.mobile }</td>
	<td>${user.authority }</td>
	<td><a href="javascript:goDel('${user.email }')">X</a></td>
</tr>
</c:forEach>
</table>

<div id="paging">
	<c:if test="${prev > 0 }">
		<a href="/admin?page=${prev }&search=${search }">[ <spring:message code="global.prev" /> ]</a>
	</c:if>
	<c:forEach var="i" begin="${firstPage }" end="${lastPage }" varStatus="stat">
		<c:choose>
		<c:when test="${param.page == i}">
			<span class="bbs-strong">${i }</span>
		</c:when>
		<c:otherwise>
			<a href="/admin?page=${i }&search=${param.search }">[ ${i } ]</a>
		</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:if test="${next > 0 }">
		<a href="/admin?page=${next }&search=${search }">[ <spring:message code="global.next" /> ]</a>
	</c:if>
</div>

<form>
	<input type="hidden" name="page" value="1" />
	<input type="text" name="search" /><input type="submit" value="<spring:message code="global.search" />" />
</form>

<form id="delUserForm" action="/admin/delUser" method="post">
	<input type="hidden" name="page" value="${param.page }" />
	<input type="hidden" name="search" value="${param.search }" />
	<input type="hidden" name="email" />
	<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
