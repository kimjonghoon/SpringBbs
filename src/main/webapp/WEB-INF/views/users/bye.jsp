<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
    $(document).ready(function() {
        $('#byeForm').submit(function(){
            var email = $('#byeForm input[name*=email]').val();
            email = $.trim(email);
            if (email.length === 0) {
                alert('<spring:message code="email.validation.error" />');
                $('#byeForm input[name*=email]').val('');
                return false;
            }
            var passwd = $('#byeForm input[name*=passwd]').val();
            passwd = $.trim(passwd);
            if (passwd.length === 0) {
                alert('<spring:message code="passwd.validation.error" />');
                $('#byeForm input[name*=passwd]').val('');
                return false;                
            }
            $('#byeForm input[name*=email]').val(email);
            $('#byeForm input[name*=passwd]').val(passwd);
        });
    });
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.bye.heading" /></h2>

<form id="byeForm" action="bye" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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