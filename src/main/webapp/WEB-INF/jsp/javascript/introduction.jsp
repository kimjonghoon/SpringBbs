<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div id="last-modified">Last Modified : 2016.4.17</div>

<h1>자바스크립트 소개</h1>

자바스크립트는 <em>주로</em> 웹 브라우저에서 실행되는 스크립트다.
웹 브라우저에는 <a href="http://en.wikipedia.org/wiki/JavaScript_engine">자바스크립트 엔진</a>이 탑재되어 있는데,
브라우저 벤더마다 엔진을 만들기에, 대표적인 브라우저에서 똑같이 동작하도록 자바스크립트를 코딩하기가 쉽지 않다.  
자바스크립트의 권고안은 <a href="http://www.ecma-international.org">Ecma International</a>에서 만든다.

<h3>자바스크립트의 쓰임새</h3>
<ol>
	<li>서버로 전송되기 전에 입력값이 유효한지 검사한다.</li>
	<li>HTML 엘리먼트에서 이벤트가 발생하면 동작하는 이벤트 핸들러를 작성한다.</li> 
	<li>드롭 다운 메뉴와 같은 동적인 메뉴 생성한다.</li>
	<li>엘리먼트의 CSS 속성을 동적으로 변경한다.</li>
	<li>웹페이지 내용을 추가한다.</li>
</ol>

<h3>1. 사용자가 입력한 값이 유효한지 검사</h3>
signUp.html은 회원가입을 위한 페이지다.
signUp.html은 입력양식을 서버로 전송하기 전에 사용자가 입력한 값이 유효한지를 검사한다.
예제에서는 이메일과 모바일 입력란의 값에 집중하기 위해서 그 외 입력란에는 기본값을 주었다.

<em class="filename">signUp.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 예제&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function check() {
	var form = document.getElementById("signUpForm");
	var id = form.id.value;
	id = trim(id);
	if (id.length == 0) {
		alert("유효하지 않는 ID입니다.");
		return false;
	}
	var pass = form.passwd.value;
	pass = trim(pass);
	if (pass.length == 0) {
		alert("유효하지 않는 패스워드입니다.");
		return false;
	}
	var name = form.name.value;
	name = trim(name);
	if (name.length == 0) {
		alert("유효하지 않는 이름입니다.");
		return false;
	}
	var email = form.email.value;
	var chk = emailCheck(email);
	if (chk == false) {
		alert("유효하지 않는 이메일입니다.");
		return false;
	}
	var mobile = form.mobile.value;
	mobile = trim(mobile);
	if (mobile.length == 0) {
		alert("유효하지 않는 모바일 번호입니다.");
		return false;
	}
	chk = beAllowStr(mobile,"0123456789-");
	if (chk == false) {
		alert("유효하지 않는 모바일 번호입니다.");
		return false;
	}
	
	return true;
}

/*******************************************
입력 :  문자열
리턴값 : 입력문자열의 양 사이드의 공백을 제거한 문자열
********************************************/
function <strong>trim(str)</strong> {
	//문자열 끝에 있는 공백문자를 제거한다.
	for (var i = str.length - 1; i &gt;= 0; i--) {
		if (str[i] == " ") {
			str = str.substring(0, i);
		} else {
			break;
		}
	}
	//문자열 앞에 있는 공백을 제거한다.
	for (var i = 0; i &lt; str.length; i++) {
		if (str[i] == " ") {
			str = str.substring(i+1, str.length);
		}	
	}
	return str;
}

/*******************************************
입력 : 검사대상 문자열, 허용되는 문자열
리턴값 : 검사대상 문자열이 허용되는 문자열로 구성되었다면 true,아니면 false
********************************************/
function beAllowStr(str, allowStr) {
	for (var i = 0;i &lt; str.length; i++) {
		var ch = str.charAt(i);
		if (allowStr.indexOf(ch) &lt; 0) {
			return false;
		}
	}
	return true;
}

/**************************************
입력 : 문자열
리턴값 : 유효한 이메일이면 true 아니면 false
***************************************/
function <strong>emailCheck(email)</strong> {
	var allowStr = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@.-_";
	if (beAllowStr(email, allowStr) == false) {
		return false;
	}
	var golbang = 0; // @ 문자의 갯수를 저장하기 위한 변수
	var dot = 0;     // . 문자의 갯수를 저장하기 위한 변수
	if (email.length &lt; 5) {
		return false;
	}
	if (email.indexOf("@") == -1) {
		return false;
	}
	if (email.indexOf(".") == -1) {
		return false;
	}
	if (email.indexOf(" ") != -1) {
		return false;
	}
	for (var i = 0;i &lt; email.length; i++) {
		if (email.charAt(i) == "@") {
			golbang++;
		}
		if (email.charAt(i) == ".") {
			dot++;
		}
	}
	if (golbang != 1 || dot &gt; 3) {
		return false;
	}
	if (email.indexOf("@") &gt; email.indexOf(".")) {
		return false;
	}
	if (email.indexOf("@") == 0  || email.indexOf(".") == email.length - 1) {
		return false;
	}
	return true;
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;회원가입&lt;/h1&gt;
&lt;form id="signUpForm" action="signUp_proc.jsp" method="post" onsubmit="return check();"&gt;
ID: &lt;input type="text" name="id" value="heist" /&gt;&lt;br /&gt;
패스워드: &lt;input type="password" name="passwd" value="1440" /&gt;&lt;br /&gt;
이름: &lt;input type="text" name="name" value="홍길동" /&gt;&lt;br /&gt;
이메일: &lt;input type="text" name="email" /&gt;&lt;br /&gt;
모바일: &lt;input type="text" name="mobile" /&gt;&lt;br /&gt;
&lt;input type="submit" value="가입" /&gt;
&lt;input type="reset" value="리셋" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/signUp.html">signUp.html 예제 실행</a><br />

위 코드는 옛 방식의 코드다.
emailCheck(), trim(), mobileCheck() 함수를 정규 표현식을 사용하는 것으로 바꾸어 보겠다.
(정규 표현식은 <a href="RegExp">정규 표현식</a> 절에서 곧 다룬다)
 
<pre class="prettyprint" style="white-space: pre-wrap">
function emailCheck(email) { 
	var re = /^(([^&lt;&gt;()[\]\\.,;:\s@\"]+(\.[^&lt;&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
	return re.test(email);
}

function trim(str) {
	return str.replace(/(^\s*)|(\s*$)/gi, "");
}

function mobileCheck(mobile) {
	var re = /\d+-\d+-\d+/;
	return re.test(mobile);
}
</pre>

다음 signUp2.html은 새로 작성한 3개의 함수를 이용하여 유효성 검사를 수행한다.<br />

<a href="/resources/examples/javascript/signUp2.html">signUp2.html 예제 실행</a><br />

이메일 정규 표현식은 정규 표현식을 제공하는 사이트에서 참조했다.
signUp.html과 signUp2.html에서 모바일란의 유효성 검사 기준에는 차이가 있다.
signUp.html에서는 숫자와 -(대시)만으로 이루어진 문자열을 유효한 모바일 번호라고 판단한다.
signUp2.html의 mobileCheck() 함수는 <strong>하나 이상의 숫자-하나 이상의 숫자-하나 이상의 숫자</strong>
형식을 유효한 모바일 번호라고 판단한다.

<h3>2. 이벤트 핸들러(엘리먼트에서 이벤트가 발생하면 동작하는 함수) 작성</h3>

<input type="button" value="버튼" onclick="alert('버튼클릭!');" /> 이 버튼은 다음 코드로 만들 수 있다.<br />

<pre class="prettyprint">
&lt;input type="button" value="버튼" <strong>onclick="alert('버튼클릭!');"</strong> /&gt;
</pre>

버튼을 클릭하면 alert() 함수가 실행된다.
alert() 자리에 사용자가 정의한 함수를 둘 수 있는데, 그때 사용자 정의 함수를 <strong>이벤트 핸들러</strong>라 부른다.
버튼의 경우에는 이벤트 핸들러를 연결하지 않으면 어떤 동작도 하지 않는다.
반면에, 링크나 서밋 버튼이나 리셋 버튼은 이벤트에 대해 기본 동작이 있다.
링크나 서밋 버튼이나 리셋 버튼은 자바스크립트 없어도 동작하기에 특별한 경우가 아니면 이벤트 핸들러가 필요 없다.
하지만, signUp.html이나 signUp2.html에서는 서밋 버튼의 기본 동작을 수행하기 전에 check() 함수가 동작하도록 구현했다.<br />
<em class="path">&lt;form .. onsubmit="return check();"&gt;</em><br />
이때 check() 함수는 불린 값을 리턴해야 한다.
true를 리턴하면 서버로 파라미터를 전송하는 기본 동작을 할 것이고, 
false를 리턴하면 기본 동작을 못하게 되어, 결국 check() 함수 실행 후 서밋 버튼은 아무런 동작도 하지 않게 된다.<br />

<h3>3. 드롭 다운 메뉴와 같은 동적인 메뉴 생성</h3>

아래 사이트를 방문하면 페이지 하단 Example에서 dTree 자바스크립트 메뉴를 체험할 수 있다.<br />

<a href="http://destroydrop.com/javascripts/tree/default.html">dTree</a><br />

여기서 동적이라 함은 사용자에 반응하여 움직임을 뜻한다.
(드림위버의 MM_으로 시작하는 함수가 자바스크립트로 동적 메뉴를 만들 때 사용하는 함수다)

<h3>4. 엘리먼트에 적용된 CSS 속성을 동적으로 변경</h3>
자바스크립트를 이용하면 이벤트가 발생할 때 엘리먼트의 CSS 속성을 변경할 수 있다.
signUp2.html에서
<em class="path">&lt;script type="text/javascript"&gt;</em> 다음에 다음 함수를 추가하고,

<pre class="prettyprint">
function testCss() {
	var inputs = document.getElementsByTagName("input");
	for (var i = 0; i &lt; inputs.length; i++) {
		inputs[i].style.background="yellow";
	}
}
</pre>

body 엘리먼트에 onload 이벤트를 추가하면 웹 페이지가 로딩이 완료될 때 input 엘리먼트의 배경이 노랑으로 바뀐다.  
(body 엘리먼트의 onload 이벤트는 문서의 모든 요소가 다운로드되고 사용 가능할 때 발생한다)

<pre class="prettyprint">
&lt;body onload="testCss()"&gt;
</pre>

<a href="/resources/examples/javascript/signUp3.html">예제 실행</a><br />


<h3>5. 웹 페이지 내용을 추가</h3>

페이스북 댓글이 웹 페이지의 내용을 추가하는 자바스크립트의 좋은 예다.<br />

<img src="https://lh3.googleusercontent.com/-DgDUW8mTzpo/VxSeUsGHQBI/AAAAAAAACu8/8EcrNLXCUoMJweJuASm-Ogo_G2XDv7nvgCCo/s636-Ic42/facebook-comments-examples.png" alt="facebook comments"><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://stackoverflow.com/questions/46155/validate-email-address-in-javascript">http://stackoverflow.com/questions/46155/validate-email-address-in-javascript</a></li>
</ul>