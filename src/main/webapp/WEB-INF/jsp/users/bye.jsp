<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
function check() {
    //var form = document.getElementById("byeForm");
    //TODO Validation
    return true;
}
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h1><spring:message code="user.bye.heading" /></h1>

<form id="byeForm" action="bye" method="post" onsubmit="return check()">
<p style="margin: 0;padding: 0;">
<input type="hidden"	name="${_csrf.parameterName}" value="${_csrf.token}" />
</p>
<table>
<tr>
	<td><spring:message code="user.email" /></td>
	<td><input type="text" name="email" /></td>
</tr>
<tr>
	<td><spring:message code="user.password" /></td>
	<td><input type="password" name="passwd" /></td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</form>