<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="자바 홈" />
<meta name="Description" content="자바 홈" />
<title>자바 설치</title>
<link rel="stylesheet" href="/css/screen.css" type="text/css" />
<script type="text/javascript" src="/js/jquery-3.0.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#jdk-install a').click(function() {
		var url = '/java/jdk-install';
		$.getJSON(url, function(data) {
			$('title').empty();
			$('title').append(data.title);
			//$("meta[property=og:title]").attr("content", result.title);
			$("meta[name='Keywords']").attr("content", data.keywords);
			$("meta[name='Description']").attr("content", data.description);
			$('article').empty();
			$('article').append(data.contents);
			//$( 'meta[name="xxx"]' ).attr( 'content' );
			console.log($("meta[name='Description']").attr("content"));
		});
		return false;
	});
});
</script>
</head>
<body>

	<div id="wrap">

		<div id="header">
			<%@ include file="../inc/header.jsp"%>
		</div>

		<div id="main-menu">
			<%@ include file="../inc/main-menu.jsp"%>
		</div>

		<div id="container">
			<div id="content">
				<div id="url-navi">Java</div>
				<article>이것은 본문이다.</article>
			</div>
		</div>

		<div id="sidebar">
			<%@ include file="java-menu.jsp"%>
		</div>

		<div id="extra">
			<%@ include file="../inc/extra.jsp"%>
		</div>

		<div id="footer">
			<%@ include file="../inc/footer.jsp"%>
		</div>

	</div>

</body>
</html>