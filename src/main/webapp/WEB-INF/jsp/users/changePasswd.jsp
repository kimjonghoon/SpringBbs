<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="비밀번호 변경" />
<meta name="Description" content="비밀번호 변경" />
<title>비밀번호 변경</title>
<link rel="stylesheet" href="../css/screen.css" type="text/css" />
<script type="text/javascript">
//<![CDATA[ 

function check() {
    var form = document.getElementById("changePassworddForm");
    if (form.passwd.value == form.confirm.value) {
    	return true;
    } else {
    	alert("[변경 비밀번호]와 [변경 비밀번호 확인]값이 같지 않습니다.");
    	return false;
    }
}

//]]> 
</script>
</head>
<body>

<div id="wrap">

    <div id="header">
		<%@ include file="../inc/header.jsp" %>
    </div>
    
    <div id="main-menu">
 		<%@ include file="../inc/main-menu.jsp" %>
    </div>
    
	<div id="container">
		<div id="content" style="min-height: 800px;">
		
<!-- 본문 시작 -->
<div id="url-navi">회원</div>
<h1>비밀번호 변경</h1>
${user.name }<br />
${user.mobile }<br />
<form id="changePassworddForm" action="changePasswd" method="post" onsubmit="return check()">
<table>
<tr>
	<td>현재 비밀번호</td>
	<td><input type="password" name="currentPasswd" /></td>
</tr>
<tr>
	<td>변경 비밀번호</td>
	<td><input type="password" name="newPasswd" /></td>
</tr>
<tr>
	<td>변경 비밀번호 확인</td>
	<td><input type="password" name="confirm" /></td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="확인" /></td>
</tr>
</table>
</form>
<!-- 본문 끝 -->
		
		</div>
    </div>
    
    <div id="sidebar">
		<%@ include file="loginUsers-menu.jsp" %>
    </div>
    
    <div id="extra">
		<%@ include file="../inc/extra.jsp" %>
    </div>
    
    <div id="footer">
		<%@ include file="../inc/footer.jsp" %>
    </div>
        
</div>

</body>
</html>