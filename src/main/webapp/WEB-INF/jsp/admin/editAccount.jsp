<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
function delRole(role) {
	var form = document.getElementById("deleteRoleForm");
	form.role.value = role;
	form.submit();
}
</script>
<h2><spring:message code="user.modify" /></h2>

<sf:form id="editAccountForm" action="editAccount" method="post" commandName="user">
<sf:hidden path="email" value="${user.email }" />
<input type="hidden" name="page" value="${param.page }" />
<input type="hidden" name="search" value="${param.search }" />
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td><spring:message code="user.full.name" /></td>
	<td>
		<sf:input path="name" value="${user.name }" /><br />
		<sf:errors path="name" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.mobile" /></td>
	<td>
		<sf:input path="mobile" value="${users.mobile }" /><br />
		<sf:errors path="mobile" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</sf:form>

<hr />

<sf:form id="changePasswdForm" action="changePasswd" method="post" commandName="user">
<sf:hidden path="email" value="${user.email }" />
<input type="hidden" name="page" value="${param.page }" />
<input type="hidden" name="search" value="${param.search }" />
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td><spring:message code="user.password" /></td>
	<td>
		<sf:password path="passwd" /><br />
		<sf:errors path="passwd" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</sf:form>

<hr />

<sf:form id="editAuthorityForm" action="changeAuthority" method="post" commandName="user">
<sf:hidden path="email" value="${user.email }" />
<input type="hidden" name="page" value="${param.page }" />
<input type="hidden" name="search" value="${param.search }" />
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td>현재 권한</td>
	<td>
	<c:forEach var="role" items="${roles }" varStatus="status">
			${role } <a href="javascript:delRole('${role }')">x</a>
	</c:forEach>
	</td>
</tr>
<tr>
	<td>권한 추가</td>
	<td>
		<sf:select path="authority">
			<sf:option value="ROLE_USER" selected="selected">ROLE_USER</sf:option>
			<sf:option value="ROLE_ADMIN">ROLE_ADMIN</sf:option>
		</sf:select>
		<sf:errors path="authority" cssClass="error" />
		<input type="submit" value="<spring:message code="global.submit" />" />
	</td>
</tr>
</table>
</sf:form>

<div style="text-align: right;">
<form action="/admin">
	<input type="hidden" name="page" value="${param.page }" />
	<input type="hidden" name="search" value="${param.search }" />
	<input type="submit" value="<spring:message code="user.list" />" />
</form>
</div>

<div style="display: none;">
<form id="deleteRoleForm" action="delRole" method="get">
	<input type="hidden" name="email" value="${user.email }" />
	<input type="hidden" name="page" value="${param.page }" />
	<input type="hidden" name="search" value="${param.search }" />
	<input type="text" name="role" />
</form>
</div>