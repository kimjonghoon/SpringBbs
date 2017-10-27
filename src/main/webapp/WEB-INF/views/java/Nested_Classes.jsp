<!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<? require('../inc/common_start.php'); ?>
<head>
<title>Nested Classes - Java 기초 | Java | 자바스쿨 :: www.java-school.net</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="내부 클래스, Nested Classes, Innner Classes" />
<meta name="Description" content="내부 클래스, Nested Classes, Inner Classes" />
<? if($isMobileDevice == "true") { ?>
<link rel="stylesheet" href="/css/mobile.css" type="text/css" media="screen" />
<? } else { ?>
<link rel="stylesheet" href="/css/screen2.css" type="text/css" media="screen" />
<? } ?>
<link rel="stylesheet" href="/css/print.css" type="text/css" media="print" />
<link rel="stylesheet" href="/css/prettify.css" type="text/css" />
<script src="/js/prettify.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/jquery-1.10.2.min.js"></script>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function() {

	prettyPrint();

	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});
	
	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});

});
//]]>
</script>
</head>
<body onload="prettyPrint()">


<div id="wrap">
	
	<div id="header">
		<? require('../inc/header.php'); ?>	
	</div>
	
	<div id="navcontainer">
		<ul id="nav">
			<? require('../inc/main_menu.php'); ?>
		</ul>
	</div>

	<div id="login">
		<form id="frm_login" action="../inc/login.php" method="post">
			<? require('../inc/membership.php'); ?>
		</form>
	</div>

	<div id="content-wrap">
		<div id="content">
			<div id="navigator">Java - Java 기초</div>
			<div id="last-modified" class="floatstop">Last Modified : 2014.8.27</div>

<!-- 본문 시작 -->
<h1>내부 클래스</h1>

자바는 클래스 안에 클래스를 정의하는 것을 허용한다.
프로젝트가 커질수록 팩키지내에 많은 클래스 수를 줄이는 방법 중 하나가 내부 클래스를 이용하는 것이다.
내부 클래스를 사용하더라도 이 클래스는 외부에서 사용할 필요가 없다는 보증이 있어야 한다.

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/tutorial/java/javaOO/nested.html">http://docs.oracle.com/javase/tutorial/java/javaOO/nested.html</a></li>
</ul>
<!--  본문 끝 -->
			<div id="prev-next">
				<ul>
					<li>다음 : <a href="../jdbc/">JDBC란?</a></li>
					<li>이전 : <a href="socket.php">소켓</a></li>
				</ul>
			</div>
		</div>
	</div>
		
	<div id="sidebar">
		<div id="secondaryNav">
			<? require('java_menu.php'); ?>
			<p>
	    		<a href="http://validator.w3.org/check?uri=referer"><img
	        		src="/images/valid-xhtml10.png"
	        		alt="Valid XHTML 1.0 Strict" height="31" width="88" /></a>
  			</p>
		</div>
	</div>
	
	<div id="extra">
		<? require('../inc/product_menu.php'); ?>
		<? require('../inc/showAds.php'); ?>
	</div>
	
	<div id="footer" class="floatstop">
		<? require('../inc/footer.php'); ?>
	</div>

</div>

<div id="form_grp">
	<? require('../inc/forms.php'); ?>
</div>

</body>
</html>