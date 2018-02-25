<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>    
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<script type="text/javascript">
    $(document).ready(function() {
        $('#signUpForm').submit(function() {
            var name = $('#signUpForm input[name*=name]').val();
            name = $.trim(name);
            if (name.length === 0) {
                alert('<spring:message code="fullname.validation.error" />');
                $('#signUpForm input[name*=name]').val('');
                return false;
            }
            var passwd = $('#signUpForm input[name*=passwd]').val();
            passwd = $.trim(passwd);
            if (passwd.length === 0) {
                alert('<spring:message code="passwd.validation.error" />');
                $('#signUpForm input[name*=passwd]').val('');
                return false;
            }
            var confirm = $('#signUpForm input[name*=confirm]').val();
            confirm = $.trim(confirm);
            if (confirm.length === 0) {
                alert('<spring:message code="passwd.validation.error" />');
                $('#signUpForm input[name*=confirm]').val('');
                return false;
            }
            if (passwd !== confirm) {
                alert('<spring:message code="passwd.confirm.not.same" />');
                return false;
            }
            var email = $('#signUpForm input[name*=email]').val();
            email = $.trim(email);
            if (email.length === 0) {
                alert('<spring:message code="email.validation.error" />');
                $('#signUpForm input[name*=email]').val('');
                return false;
            }
            var mobile = $('#signUpForm input[name*=mobile]').val();
            mobile = $.trim(mobile);
            if (mobile.length === 0) {
                alert('<spring:message code="mobile.validation.error" />');
                $('#signUpForm input[name*=mobile]').val('');
                return false;
            }
            $('#signUpForm input[name*=name]').val(name);
            $('#signUpForm input[name*=passwd]').val(passwd);
            $('#signUpForm input[name*=confirm]').val(confirm);
            $('#signUpForm input[name*=email]').val(email);
            $('#signUpForm input[name*=mobile]').val(mobile);
        });
        
    });
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.signup.heading" /></h2>

<sf:form id="signUpForm" action="signUp" method="post" modelAttribute="user">
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