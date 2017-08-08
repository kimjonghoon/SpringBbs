<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
<!--
table {
	width: 100%;
	font-size: 1.3em;
}

th {
	text-align: left;
	border: 1px solid gray;
	padding: 0.3em 0.3em;	
}

td {
	border: 1px solid gray;
	padding: 0.3em 0.3em;
	font-size: 1em;
}
-->
</style>

<script type="text/javascript">
$(document).ready(function() {
	$('#jdk-install a').click(function() {
		var url = '/java/jdk-install';
		$.getJSON(url, function(data) {
			$('title').empty();
			$('title').append(data.title);
			$("meta[name='Keywords']").attr("content", data.keywords);
			$("meta[name='Description']").attr("content", data.description);
			$('article').empty();
			$('article').append(data.contents);
			console.log(data);
			console.log($("meta[name='Keywords']").attr("content"));
			console.log($("meta[name='Description']").attr("content"));
		});
		return false;
	});
});
</script>

<ul>
    <li id="jdk-install"><a href="#">JDK Install</a></li>
</ul>

<article>

<h2>Financial assets</h2>

<table>
<tr>
	<th style="width: 20%;">Bank</th>
	<th>Balance</th>
	<th>Memo</th>
</tr>
<!-- loop start -->
<tr>
	<td>Shinhan</td>
	<td>23712</td>
	<td>D/W</td>
</tr>
<tr>
	<td>KEB</td>
	<td>1572</td>
	<td>D/W</td>
</tr>
<tr>
	<td>SC 1</td>
	<td>913133</td>
	<td>D/W</td>
</tr>
<tr>
	<td>SC 2</td>
	<td>13000000</td>
	<td>2017.09.08</td>
</tr>
<tr>
	<td>SC 3</td>
	<td>39000000</td>
	<td>2018.01.31</td>
</tr>
<tr>
	<td>Meritz</td>
	<td>1618429</td>
	<td>CMA</td>
</tr>
<!-- loop end -->
<tr>
	<td>Total</td>
	<td colspan="2">54556846</td>
</tr>
</table>

<table>
<tr>
	<th style="width: 20%">Total</th>
	<th>54556846</th>
</tr>
</table>

</article>