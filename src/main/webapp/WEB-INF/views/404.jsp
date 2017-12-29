<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>404</title>
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" />
<script type="text/javascript" src="/resources/js/jquery-3.2.1.min.js"></script>
</head>
<body>
<div id="wrap">

    <div id="header">
    	<h1 style="float: left;width: 150px;"><a href="/"><img src="/resources/images/ci.gif" alt="java-school" /></a></h1>
    </div>
    
    <div id="main-menu">
    	<%@ include file="inc/main-menu.jsp" %>
    </div>
    
	<div id="container">
		<div id="content">
			<div id="url-navi">Error</div>
			<h2>404</h2>
			그런 페이지가 없습니다.
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Error</h1>
	</div>
    
	<div id="extra">
		<%@ include file="inc/extra.jsp" %>    
	</div>
    
    <div id="footer">
    	<%@ include file="inc/footer.jsp" %>
    </div>
        
</div>

</body>
</html>
