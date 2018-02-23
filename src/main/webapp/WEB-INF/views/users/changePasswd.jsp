<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<script>
    $(document).ready(function () {
        $('#changePasswordForm').submit(function() {
            var currentPasswd = $('#changePasswordForm input[name*=currentPasswd]').val();
            currentPasswd = $.trim(currentPasswd);
            if (currentPasswd.length === 0) {
                alert('<spring:message code="passwd.validation.error" />');
                $('#changePasswordForm input[name*=currentPasswd]').val('');
                return false;
            }
            var newPasswd = $('#changePasswordForm input[name*=newPasswd]').val();
            newPasswd = $.trim(newPasswd);
            if (newPasswd.length === 0) {
                alert('<spring:message code="passwd.validation.error" />');
                $('#changePasswordForm input[name*=newPasswd]').val('');
                return false;
            }
            var confirmPasswd = $('#changePasswordForm input[name*=confirm]').val();
            confirmPasswd = $.trim(confirmPasswd);
            if (confirmPasswd.length === 0) {
                alert('<spring:message code="passwd.validation.error" />');
                $('#changePasswordForm input[name*=confirm]').val('');
                return false;
            }
            if (newPasswd !== confirmPasswd) {
                alert('<spring:message code="user.changePasswd.passwd.validation" />');
                return false;
            }
            
            $('#changePasswordForm input[name*=currentPasswd]').val(currentPasswd);
            $('#changePasswordForm input[name*=newPasswd]').val(newPasswd);
            $('#changePasswordForm input[name*=confirm]').val(confirmPasswd);

        });
    });
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.changePasswd.heading" /></h2>
<div>
    ${user.name }<br />
    ${user.mobile }<br />
</div>
<sf:form id="changePasswordForm" action="changePasswd" method="post" modelAttribute="password">
    <table>
        <tr>
            <td><spring:message code="user.changePasswd.current.passwd" /></td>
            <td>
                <sf:password path="currentPasswd" /><br />
                <sf:errors path="currentPasswd" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td><spring:message code="user.changePasswd.new.passwd" /></td>
            <td>
                <sf:password path="newPasswd" /><br />
                <sf:errors path="newPasswd" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td><spring:message code="user.changePasswd.new.passwd.confirm" /></td>
            <td><input type="password" name="confirm" /></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
        </tr>
    </table>
</sf:form>