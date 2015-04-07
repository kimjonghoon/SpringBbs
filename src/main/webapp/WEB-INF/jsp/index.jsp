<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.java_school.user.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="메인페이지" />
<meta name="Description" content="메인페이지" />
<title>메인 페이지</title>
<link rel="stylesheet" href="css/screen.css" type="text/css" />
</head>
<body>

<div id="wrap">

    <div id="header">
    	<h1 style="float: left; width:150px;"><a href="./"><img src="images/ci.gif" alt="java-school logo" /></a></h1>
    	<div id="memberMenu" style="float: right;position: relative; top: 7px;">
<%
User loginUser = (User) session.getAttribute("user");
if (loginUser == null) {
%>
			<input type="button" value="로그인" onclick="location.href='./users/login'" />
			<input type="button" value="회원가입" onclick="location.href='./users/signUp'" />
<%
} else {
%>
			<input type="button" value="로그아웃" onclick="location.href='./users/logout'" />
			<input type="button" value="내정보수정" onclick="location.href='./users/editAccount'" />
<%
}
%>
    	</div>
    </div>
    
    <div id="main-menu">
        <ul id="nav">
            <li><a href="java/">Java</a></li>
            <li><a href="jdbc/">JDBC</a></li>
            <li><a href="jsp/">JSP</a></li>
            <li><a href="css-layout/">CSS Layout</a></li>
            <li><a href="jsp-project/">JSP Project</a></li>
            <li><a href="spring/">Spring</a></li>
            <li><a href="javascript/">JavaScript</a></li>
            <li><a href="bbs/list?boardCd=free&amp;curPage=1">BBS</a></li>
        </ul>
    </div>
    
	<div id="container">
		<div id="content" style="min-height: 800px;">
			<div id="url-navi">Main</div>

<!-- 본문 시작 -->
<h1>수정</h1>
<h2>JSP Project 전반적인 내용 수정 2014.9.26</h2>
프로토타입을 만든 후에 진행하는 것으로 내용 수정<br />
프로토타입에 로그인 구현<br />

<h2>CSS Layout 수정 2014.9.26</h2>
카테고리 정리<br />
스타일시트 파일 체계적으로 갱신<br />
<!--  본문 끝 -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Main</h1>
	</div>
    
	<div id="extra">
		<a href="http://www.youtube.com"><img src="images/youtube.png" alt="youtube.com" /></a>
		<a href="http://www.twitter.com"><img src="images/twitter.png" alt="twitter.com" /></a>
		<a href="http://www.facebook.com"><img src="images/facebook.png" alt="facebook.com" /></a>
		<a href="http://www.gmail.com"><img src="images/gmail.png" alt="gmail.com" /></a>
		<a href="http://www.java-school.net"><img src="images/java-school.png" alt="java-school.net" /></a>
	</div>
    
    <div id="footer">
		<%@ include file="inc/footer.jsp" %>
    </div>

</div>

</body>
</html>