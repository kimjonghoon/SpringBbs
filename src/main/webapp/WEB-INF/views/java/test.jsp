<!DOCTYPE html>
<html lang="ko">
<? require('../inc/common_start.php'); ?>
<head>
<meta charset="UTF-8" />
<title>Test - www.java-school.net</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="Keywords" content="자바 기초 테스트" />
<meta name="Description" content="자바 기초 테스트" />
<link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/css/print.css" type="text/css" media="print" />
<link rel="stylesheet" href="/css/prettify.css" type="text/css" />
<script src="/js/prettify.js"></script>
<script src="/js/jquery-1.10.2.min.js"></script>
<script src="/js/commons.js"></script>
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
<body>

<div id="wrap">
	
	<header>
		<? require('../inc/header.php'); ?>
	</header>
	
	<nav id="mainNav">
		<? require('../inc/main_menu.php'); ?>
	</nav>

	<div id="login">
		<form id="frm_login" action="../inc/login.php" method="post">
			<? require('../inc/membership.php'); ?>
		</form>
	</div>

	<div id="content-wrap">
		<article>
			<div id="navigator">Java - Java 기초</div>
			<div id="last-modified" class="floatstop">Last Modified : 2013.10.4</div>

<!-- 본문 시작 -->
<h1>테스트</h1>

<h2>문제 1</h2>
로또 번호를 생성하는 코드를 아래 제시한 코드를 보고 작성한다.<br />
메인 메소드는 변경하지 않는다.<br />
generateLotto() 메소드의 //TODO 부분만을 완성한다.<br />
로또번호는 중복되지 않아야 한다.<br />
<pre class="prettyprint">
public class Test3 {
	public static int[] generateLotto() {
		int[] lotto = new int[6];
		//TODO
		return lotto;
	}
	public static void main(String[] args) {
		int[] lotto = generateLotto();
		System.out.println("이번주 로또 번호 추측");
		for (int i = 0; i &lt; lotto.length; i++) {
			System.out.print(lotto[i] + "\t");
		}
		System.out.println();
	}
}
</pre>
Math 클래스의 random() 메소드를 이용한다.<br />
Math의 random() 메소드는 0을 포함하고 1은 포함되지 않는 임의의 double 값을 반환한다.<br />
다음은 1에서 45까지의 임의의 수를 발생시키는 코드다.<br />
<br />
int su = (int)(Math.random() * 45) + 1;
<br />

<h3>문제 1 풀이</h3>
아래와 같이 알고리즘을 작성해 본다.<br />
<ol>
	<li>반복문을  시작한다.</li>
	<li>1~45 중의 난수를 발생한다.</li>
	<li>배열에 발생한 난수가 존재하는지 검사한다.</li>
	<li>존재하지 않으면 난수를 배열에 추가하고 존재한다면 반복문의 조건문으로 분기한다.</li>
	<li>배열에 수를 6개가 다 채우면 반복문을 빠져나온다.</li>
</ol>
<pre class="prettyprint">
public static int[] generateLotto() {
	int[] lotto = new int[6];
	int idx = 0;
	while (true) {
		int su = (int) (Math.random() * 45) + 1;
		for (int i = 0; i &lt; idx; i++) {
			if (su == lotto[i]) {
				continue;
			}
		}
		lotto[idx++] = su;
		if (idx &gt; 5) {
			break;
		}
	}

	return lotto;
}
</pre>
위와 같이 작업하면 우리가 작성한 알고리즘대로 작성한 것 같다.<br />
하지만 continue; 문장은 자신을 감싸고 있는 가장 가까운 반복문의 조건문으로로 분기한다.<br />
그 조건절은 while 문의 조건문이 아닌 for문의 조건문으로 분기하므로 원하는 결과를 얻지 못한다.<br />
while 문의 조건문으로 분기하도록 고치려면 다음과 같이 레이블을 이용하는 것으로 변경한다.<br />

<pre class="prettyprint">
public static int[] generateLotto() {
	int[] lotto = new int[6];
	int idx = 0;
	WHILE: while (true) {
		int su = (int) (Math.random() * 45) + 1;
		for (int i = 0; i &lt; idx; i++) {
			if (su == lotto[i]) {
				continue WHILE;
			}
		}
		lotto[idx++] = su;
		if (idx &gt; 5) {
			break;
		}
	}
	
	return lotto;
}
</pre>
continue 다음에 WHILE 이란 레이블명을 사용하여 while문의 조건절로 분기하도록 소스를 고치면 알고리즘대로 작성한 것이 된다.<br />
레이블을 사용하지 않으려면 다음과 같이 고칠 수도 있다.<br />
boolean check = true; 이라는 변수로 발생한 난수를 배열에 넣을것인지 여부를 판단하도록 한다.<br /> 

<pre class="prettyprint">
public static int[] generateLotto() {
	int[] lotto = new int[6];
	int idx = 0;
	while (true) {
		boolean check = true;
		int su = (int) (Math.random() * 45) + 1;
		for (int i = 0; i &lt; lotto.length; i++) {
			if (su == lotto[i]) {
				check = false;
				break;
			}
		}
		if (check) {
			lotto[idx++] = su;
		}
		if (idx &gt; 5) {
			break;
		}
	}
	
	return lotto;
}
</pre>
아래는 다른 방법으로 푼 예이다.<br />
로또 볼을 상자에서 하나씩 꺼낸다고 가정하자.<br />
로또 볼 상자를 나타내는 것이 아래에서 balls 란 int형 1차원 배열변수이다.<br />
balls 에서 값을 꺼낸 후에는 해당하는 위치의 배열값을 -1로 바꾼다.<br />
만약 로또 볼 상자에서 꺼낸 값이 -1이 아니면 lotto 배열에 추가한다.<br />

<pre class="prettyprint">
public static int[] generateLotto() {
	int[] lotto = new int[6];
	
	// 로또 상자 초기화
	int[] balls = new int[45];
	for (int i = 0,ball = 0; i &lt; balls.length; i++) {
		balls[i] = ++ball; 
	}
	
	int idx = 0; // lotto 배열의 인덱스,lotto 배열에 순서대로 값을 넣기 위해서
	while (idx &lt; 6) {
		int ballsIdx = (int) (Math.random() * 45);//balls 배열 인덱스 값
		int su = balls[ballsIdx];
		if (su != -1) {
			balls[ballsIdx] = -1;
			lotto[idx++] = su;
		}
	}
	
	return lotto;
}
</pre>
<h2>문제 2</h2>
다음 예제를 보고 StringTokenizer 와 String 의 split() 메소드의 차이를 구별한다.<br />

<pre class="prettyprint">
package net.java_school.string;

import java.util.StringTokenizer;

public class Test {
	
	private static void usingStringTokenizer(String addr) {
		StringTokenizer st = new StringTokenizer(addr, ",");
		System.out.println("StringTokenizer");
		int size = st.countTokens();
		for (int i = 0; i &lt; size; i++) {
			System.out.print(st.nextToken() + ",");
		}
	}
	
	private static void usingStringSplit(String addr) {
		String[] addrArray = addr.split(",", -1);
		System.out.println("String's split() method");
		int size = addrArray.length;
		for (int i = 0; i &lt; size; i++) {
			System.out.print(addrArray[i] + ",");
		}
	}
	
	public static void main(String[] args) {
		//Google Address 
		//Name,Mobile Phone,E-mail Address,Company
		String addr = "Michael Jordan,,mj23@gmail.org,Charlotte Bobcats";//Mobile Phone missing!
		usingStringTokenizer(addr);
		System.out.println();
		System.out.println();
		usingStringSplit(addr);
	}

}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
StringTokenizer
Michael Jordan,mj23@gmail.org,Charlotte Bobcats,

String's split() method
Michael Jordan,,mj23@gmail.org,Charlotte Bobcats,
</pre>
<!--  본문 끝  -->						
<div class="fb-comments" data-href="http://www.java-school.net/java/test.php" data-width="592" data-num-posts="10"></div>
		</article>
	</div>
		
	<div id="sidebar">
		<nav id="secondaryNav">
			<? require('java_menu.php'); ?>
		</nav>
	</div>
	
	<aside>
		<? require('../inc/showAds.php'); ?>
	</aside>
	
	<footer class="floatstop">
		<? require('../inc/footer.php'); ?>
	</footer>

</div>

<div id="form_grp">
	<? require('../inc/forms.php'); ?>
</div>

</body>
</html>
