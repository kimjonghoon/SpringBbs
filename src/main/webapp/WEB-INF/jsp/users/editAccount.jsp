<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<script type="text/javascript">
function check() {
    //var form = document.getElementById("editAccountForm");
    //TODO Validation 
    return true;
}
</script>
		
<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.editAccount.heading" /></h2>

<p>
<spring:message code="user.editAccount.content" />
<a href="changePasswd"><spring:message code="user.change.password" /></a><br />
</p>

<sf:form id="editAccountForm" action="editAccount" method="post" commandName="user" onsubmit="return check();">
<sf:hidden path="email" value="abc@def.ghi" />
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
	<td><spring:message code="user.password" /></td>
	<td>
		<sf:password path="passwd" /><br />
		<sf:errors path="passwd" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="전송" /></td>
</tr>
</table>
</sf:form>