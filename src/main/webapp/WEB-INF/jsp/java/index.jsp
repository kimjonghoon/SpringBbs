<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="Keywords" content="<spring:message code="java.keywords" />" />
<meta name="Description" content="<spring:message code="java.description" />" />
<title><spring:message code="java.title" /></title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/screen.css" type="text/css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.0.0.min.js"></script>
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
		<div id="content">
			<div id="url-navi"><spring:message code="java.title" /></div>

<!-- contents begin -->
<h1>JDK Install</h1>

<pre>
public class Test {
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
}
</pre>

<pre>
C:\&gt;javac Test.java

C:\&gt;java Test
Hello World!
</pre>
<!-- contents end -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Java</h1>
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