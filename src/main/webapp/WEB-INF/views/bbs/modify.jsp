<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<script>
$(document).ready(function() {
   $('#modifyForm').submit(function() {
      var title = $('#modifyForm input[name*=title]').val();
      var content = $('#modifyForm-ta').val();
      title = $.trim(title);
      content = $.trim(content);

      if (title.length === 0) {
          alert('<spring:message code="title.empty" />');
          $('#modifyForm input[name*=title]').val('');
          return false;
      }
      
      if (content.length === 0) {
          alert('<spring:message code="content.empty" />');
          $('#modifyForm-ta').val('');
          return false;
      }

      $('#modifyForm input[name*=title]').val(title);
      $('#modifyForm-ta').val(content);
   });
   
   $('#goView').click(function(){
      $('#viewForm').submit(); 
   });
});
</script>

<div id="url-navi">${boardName }</div>

<h3><spring:message code="global.modify" /></h3>

<sf:form id="modifyForm" action="/bbs/${boardCd}/${articleNo}?${_csrf.parameterName}=${_csrf.token}" method="post" modelAttribute="article" enctype="multipart/form-data">
<input type="hidden" name="page" value="${param.page }" />
<input type="hidden" name="searchWord" value="${param.searchWord }" />
<sf:errors path="*" cssClass="error"/>
<table id="write-form" class="bbs-table">
<tr>
    <td><spring:message code="global.title" /></td>
    <td>
    	<sf:input path="title" style="width: 90%" value="${article.title }" /><br />
    	<sf:errors path="title" cssClass="error" />
    </td>
</tr>
<tr>
    <td colspan="2">
        <textarea name="content" rows="17" cols="50" id="modifyForm-ta">${article.content }</textarea><br />
        <sf:errors path="content" cssClass="error" />
    </td>
</tr>
<tr>
    <td><spring:message code="global.attach.file" /></td>
    <td><input type="file" name="attachFile" /></td>
</tr>
</table>
<div style="text-align: center;padding-bottom: 15px;">
    <input type="submit" value="<spring:message code="global.submit" />" />
    <input type="button" value="<spring:message code="bbs.back.to.article" />" id="goView" />
</div>
</sf:form>
		
<div id="form-group" style="display: none">
    <form id="viewForm" action="/bbs/${boardCd }/${articleNo }" method="get">
        <input type="hidden" name="page" value="${param.page }" />
        <input type="hidden" name="searchWord" value="${param.searchWord }" />
    </form>
</div>
