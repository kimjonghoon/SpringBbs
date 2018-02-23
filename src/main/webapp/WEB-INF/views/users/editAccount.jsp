<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<script>
$(document).ready(function() {
    $('#editAccountForm').submit(function(){
        var name = $('#editAccountForm input[name*=name]').val();
        name = $.trim(name);
        if (name.length === 0) {
            alert('<spring:message code="fullname.validation.error" />');
            $('#editAccountForm input[name*=name]').val('');
            return false;
        }
        var mobile = $('#editAccountForm input[name*=mobile]').val();
        mobile = $.trim(mobile);
        if (mobile.length === 0) {
            alert('<spring:message code="mobile.validation.error" />');
            $('#editAccountForm input[name*=mobile]').val('');
            return false;
        }
        var passwd = $('#editAccountForm input[name*=passwd]').val();
        passwd = $.trim(passwd);
        if (passwd.length === 0) {
            alert('<spring:message code="passwd.validation.error" />');
            $('#editAccountForm input[name*=passwd]').val('');
            return false;            
        }
        $('#editAccountForm input[name*=name]').val(name);
        $('#editAccountForm input[name*=mobile]').val(mobile);
        $('#editAccountForm input[name*=passwd]').val(passwd);
            
    });
   
});
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h2><spring:message code="user.editAccount.heading" /></h2>

<p>
    <spring:message code="user.editAccount.content" />
    <a href="changePasswd"><spring:message code="user.change.password" /></a><br />
</p>

<sf:form id="editAccountForm" action="editAccount" method="post" modelAttribute="user">
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
            <td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
        </tr>
    </table>
</sf:form>