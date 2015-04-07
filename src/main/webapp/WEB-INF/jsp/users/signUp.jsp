<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="회원가입" />
<meta name="Description" content="회원가입" />
<title>회원가입</title>
<link rel="stylesheet" href="../css/screen.css" type="text/css" />
<script type="text/javascript">
//<![CDATA[ 

function check() {
    //var form = document.getElementById("signUpForm");
    //TODO 유효성 검사 
    return true;
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
<h1>회원가입</h1>
<form id="signUpForm" action="signUp_proc.do" method="post" onsubmit="return check()">
<table>
<tr>
	<td style="width: 200px;">이름(Full Name)</td>
	<td style="width: 390px;"><input type="text" name="name" /></td>
</tr>
<tr>
	<td>비밀번호(Password)</td>
	<td><input type="password" name="passwd" /></td>
</tr>
<tr>
	<td colspan="2" style="text-align: center;font-weight: bold;">
		Email이 아이디로 쓰이므로 비밀번호는 Email계정 비밀번호와 같게 하지 마세요.
	</td>
</tr>
<tr>
	<td>비밀번호 확인(Confirm)</td>
	<td><input type="password" name="confirm" /></td>
</tr>
<tr>
	<td>Email</td>
	<td><input type="text" name="email" /></td>
</tr>
<tr>
	<td>손전화(Mobile)</td>
	<td><input type="text" name="mobile" /></td>
</tr>
</table>
<div style="text-align: center;padding-bottom: 15px;">
	<input type="submit" value="확인" />
</div>
</form>
<!-- 본문 끝 -->
		
		</div>
    </div>
    
    <div id="sidebar">
		<%@ include file="notLoginUsers-menu.jsp" %>
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