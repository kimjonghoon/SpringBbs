<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h1><spring:message code="user.changepasswd.confirm.heading" /></h1>

<spring:message code="user.changepasswd.confirm.login.again" />
<input type="button" value="<spring:message code="user.login" />" onclick="javascript:location.href='login'" />