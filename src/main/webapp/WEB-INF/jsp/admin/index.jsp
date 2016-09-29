<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8"/>
<title>Admin</title>
</head>
<body>
Hello, Admin
<%
int a = 1;
if (a < 10) {
	throw new NullPointerException("일부러 내는 익셉션!");
}
%>
</body>
</html>