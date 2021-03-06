<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<script>
    $(document).ready(function () {
        $('#board-list a').click(function (e) {
            e.preventDefault();
            var boardCd = this.text;
            var boardNm = this.title;
            var boardNm_ko = this.className;
            $('#editBoard input[name*=boardCd]').val(boardCd);
            $('#editBoard input[name*=boardNm]').val(boardNm);
            $('#editBoard input[name*=boardNm_ko]').val(boardNm_ko);
        });
    });
</script>

<h2><spring:message code="board.list" /></h2>

<table class="bbs-table" id="board-list">
    <tr>
        <th style="text-align: left;"><spring:message code="board.code" /></th>
        <th style="text-align: left;"><spring:message code="board.name" /></th>
        <th style="text-align: left;"><spring:message code="board.korean.name" /></th>
    </tr>
    <c:forEach var="board" items="${boards }" varStatus="status">
        <tr>
            <td><a href="#" title="${board.boardNm }" class="${board.boardNm_ko }">${board.boardCd }</a></td>
            <td>${board.boardNm }</td>
            <td>${board.boardNm_ko }</td>
        </tr>
    </c:forEach>
</table>

<h2><spring:message code="board.edit" /></h2>

<form id="editBoard" action="/admin/editBoard" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <table class="bbs-table">
        <tr>
            <td><spring:message code="board.code" /></td>
            <td><input type="text" name="boardCd" readonly=readonly /></td>
        </tr>
        <tr>
            <td><spring:message code="board.name" /></td>
            <td><input type="text" name="boardNm" /></td>
        </tr>
        <tr>
            <td><spring:message code="board.korean.name" /></td>
            <td><input type="text" name="boardNm_ko" /></td>
        </tr>
    </table>
    <div>
        <input type="submit" value="<spring:message code="global.submit" />" />
    </div>
</form>

<h2><spring:message code="board.new" /></h2>

<form id="createBoard" action="/admin/createBoard" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <table class="bbs-table">
        <tr>
            <td><spring:message code="board.code" /></td>
            <td><input type="text" name="boardCd" />
        </tr>
        <tr>
            <td><spring:message code="board.name" /></td>
            <td><input type="text" name="boardNm" />
        </tr>
        <tr>
            <td><spring:message code="board.korean.name" /></td>
            <td><input type="text" name="boardNm_ko" />
        </tr>
    </table>
    <div>
        <input type="submit" value="<spring:message code="global.submit" />" />
    </div>
</form>