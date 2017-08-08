<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="Account Book" />
<meta name="Description" content="Account Book" />
<title>Account Book</title>
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" />
<script src="/resources/js/jquery-3.0.0.min.js"></script>
<script>
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
			<div id="content">
				<tiles:insertAttribute name="content" />
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