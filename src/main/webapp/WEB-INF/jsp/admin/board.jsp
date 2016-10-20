<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
function goEdit(boardCd, boardNm, boardNm_ko) {
	var form = document.getElementById("editBoard");
	form.boardCd.value = boardCd;
	form.boardNm.value = boardNm;
	form.boardNm_ko.value = boardNm_ko;
	return false;
}
</script>

<h2>Board List</h2>

<table class="bbs-table">
<tr>
	<th style="text-align: left;">Board Code</th>
	<th style="text-align: left;">Board Name</th>
	<th style="text-align: left;">Board Korean Name</th>
</tr>
<c:forEach var="board" items="${boards }" varStatus="status">
<tr>
	<td><a href="javascript:goEdit('${board.boardCd }','${board.boardNm }','${board.boardNm_ko }')">${board.boardCd }</a></td>
	<td>${board.boardNm }</td>
	<td>${board.boardNm_ko }</td>
</tr>
</c:forEach>
</table>

<h2>New Board</h2>

<form id="createBoard" action="/admin/createBoard" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<table class="bbs-table">
<tr>
	<td>Board Code</td>
	<td><input type="text" name="boardCd" />
</tr>
<tr>
	<td>Board Name</td>
	<td><input type="text" name="boardNm" />
</tr>
<tr>
	<td>Board Korean Name</td>
	<td><input type="text" name="boardNm_ko" />
</tr>
</table>
<div>
	<input type="submit" value="Submit" />
</div>
</form>

<h2>Edit Board</h2>

<form id="editBoard" action="/admin/editBoard" method="post">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<table class="bbs-table">
<tr>
	<td>Board Code</td>
	<td><input type="text" name="boardCd" readonly=readonly />
</tr>
<tr>
	<td>Board Name</td>
	<td><input type="text" name="boardNm" />
</tr>
<tr>
	<td>Board Korean Name</td>
	<td><input type="text" name="boardNm_ko" />
</tr>
</table>
<div>
	<input type="submit" value="Submit" />
</div>
</form>
</html>