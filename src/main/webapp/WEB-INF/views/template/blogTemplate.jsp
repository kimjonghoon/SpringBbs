<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="<tiles:insertAttribute name="keywords" />" />
<meta name="Description" content="<tiles:insertAttribute name="description" />" />
<title><tiles:insertAttribute name="title" /></title>
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/prettify.css" type="text/css" />
<style type="text/css">
#sidebar {
	display: none;
}
#content {
	margin-left: 0;
}
</style>
<script src="/resources/js/jquery-3.2.1.min.js"></script>
<script src="/resources/js/prettify.js"></script>
<script src="/resources/js/commons.js"></script>
<script>
$(document).ready(function() {
	var url = $('#content').attr('title');
	$('#content').load('/resources/articles/' + url + '.html', function() {
		runAfterLoadArticle();
	});
});
</script>
</head>
<body>

	<div id="wrap">

		<div id="header">
			<tiles:insertAttribute name="header" />
		</div>

		<div id="main-menu">
			<tiles:insertAttribute name="main-menu" />
		</div>

		<div id="container">
			<div id="content" title="<tiles:insertAttribute name="content" />"></div>
		</div>

		<div id="sidebar">
			<tiles:insertAttribute name="sidebar" />
		</div>

		<div id="extra">
			<tiles:insertAttribute name="extra" />
		</div>

		<div id="footer">
			<tiles:insertAttribute name="footer" />
		</div>

	</div>

<div id="form-group" style="display: none">
 	<form id="downForm" action="/download" method="post">
		<input type="hidden" name="filename" />
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
</div>
	
</body>
</html>