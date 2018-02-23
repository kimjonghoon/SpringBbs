<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<script type="text/javascript">
    function check() {
        //var form = document.getElementById("signUpForm");
        //TODO Validation 
        return true;
    }
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.signup.heading" /></h2>

<sf:form id="signUpForm" action="signUp" method="post" modelAttribute="user" onsubmit="return check();">
    <sf:errors path="*" cssClass="error" />
    <table>
        <tr>
            <td style="width: 200px;"><spring:message code="user.full.name" /></td>
            <td style="width: 390px;">
                <sf:input path="name" /><br />
                <sf:errors path="name" cssClass="error" />
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
            <td colspan="2" style="text-align: center;font-weight: bold;">
                <spring:message code="user.signup.warning" />
            </td>
        </tr>
        <tr>
            <td><spring:message code="global.confirm" /></td>
            <td><input type="password" name="confirm" /></td>
        </tr>
        <tr>
            <td><spring:message code="user.email" /></td>
            <td>
                <sf:input path="email" /><br />
                <sf:errors path="email" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td><spring:message code="user.mobile" /></td>
            <td>
                <sf:input path="mobile" /><br />
                <sf:errors path="mobile" cssClass="error" />
            </td>
        </tr>
    </table>
    <div style="text-align: center;padding-bottom: 15px;">
        <input type="submit" value="<spring:message code="global.submit" />" />
    </div>
</sf:form>