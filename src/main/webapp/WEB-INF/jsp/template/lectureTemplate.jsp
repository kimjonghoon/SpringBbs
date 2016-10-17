<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="<tiles:insertAttribute name="keywords" />" />
<meta name="Description" content="<tiles:insertAttribute name="description" />" />
<title><tiles:insertAttribute name="title" /></title>
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/prettify.css" type="text/css" />
<script src="/resources/js/jquery-3.0.0.min.js"></script>
<script src="/resources/js/prettify.js"></script>
<script src="/resources/js/commons.js"></script>
<script>
$(document).ready(function() {
	prettyPrint();
	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});
	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});
});
</script>
</head>
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
			<div id="content">
				<tiles:insertAttribute name="content" />
				<div id="next-prev">
					<ul>
						<li>
							<spring:message code="global.next" /> : 
							<a href="<tiles:insertAttribute name="next-link" />"><tiles:insertAttribute name="next-title" /></a>
						</li>
						<li>
							<spring:message code="global.prev" /> : 
							<a href="<tiles:insertAttribute name="prev-link" />"><tiles:insertAttribute name="prev-title" /></a>
						</li>
					</ul>
				</div>
			</div>
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

</body>
</html>