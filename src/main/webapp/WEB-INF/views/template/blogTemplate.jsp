<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<tiles:importAttribute name="javascripts"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title><tiles:insertAttribute name="title" /></title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="Keywords" content="<tiles:insertAttribute name="keywords" />" />
<meta name="Description" content="<tiles:insertAttribute name="description" />" />
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/resources/css/print.css" type="text/css" media="print" />
<link rel="stylesheet" href="/resources/css/prettify.css" type="text/css" />
<style type="text/css">
#sidebar  {
	display: none;
}
#content  {
	margin-left: 0;
}
</style>
<c:forEach var="script" items="${javascripts}">
	<script src="<c:url value="${script}"/>"></script>
</c:forEach>
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