<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.11.19</div>

<h1>유효성 검사</h1>

<h3>폼에 접근</h3>
&lt;form id="someform"&gt; 폼 태그가 있다면 폼의 참조를 얻는 방법이다.<br />

<pre class="prettyprint">
var form = document.getElementsTagName("form")[0];
var form = document.getElementById("someform");
</pre>

<h3>폼에 이벤트를 추가하는 방법</h3>
폼 엘리먼트 내에 submit 버튼이 클릭 이벤트에 핸들러 함수를 매핑하는 방법은 다음과 같다.<br />

<pre class="prettyprint">
&lt;form id="someform" onsubmit="return 핸들러함수() "&gt;
</pre>

이때 핸들러 함수는 불린을 리턴해야 한다.<br />
유효성 검사를 통과하여 폼을 전송하려면 return true;로<br />
유효성 검사를 통과 못 해서 폼 전송을 취소하려면 return false;로 구현한다.<br />

<h3>라디오 버튼과 체크 박스</h3>
라디오 버튼을 비활성화 시키는 방법은 아래와 같다.<br />

<pre class="prettyprint">
document.someform.radiogroup[i].disabled = true;
</pre>

비활성화하면 이 파라미터는 서버에 전송되지 않는다.<br />

<em class="filename">send1.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function check() {
	var form = document.getElementById("testForm");
	<strong>form.condition[4].disabled = true;</strong>
	return true;
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" method="get" onsubmit="return check()"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;
	&lt;input type="submit" value="확인" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/send1.html">예제 실행</a><br />
이름을 입력하고 W를 선택한 후 서밋 버튼을 클릭하여 전송되는 파라미터와 값을 확인한다.<br />
W 외에 다른 값을 선택한 후 서밋 버튼을 클릭하여 전송되는 파라미터와 값을 확인한다.<br />

<h3>라디오 버튼이나 체크 박스를 선택하면 실행되는 이벤트 핸들러 등록 예제</h3>

<em class="filename">send2.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function agree() {
	var form = document.getElementById("testForm");
	var submit = document.getElementById("submit");
	if (form.agreement.checked == true) {
		submit.disabled = false;	
	} else {
		submit.disabled = true;
	}
	
}
function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	var chk = form.confirm[0].value

	return true;
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" method="get" onsubmit="return check()"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;&lt;br /&gt;
	서버로 정보를 전달하는 것에 동의합니다.
	&lt;input type="radio" name="agreement" value="y" onchange="agree()" /&gt;
	&lt;input type="submit" id="submit" value="확인" disabled="disabled" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/send2.html">예제 실행</a><br />
입력 후 서밋 버튼을 클릭하여 전송되는 파라미터와 값을 확인한다.<br />

<h3>그 밖의 참고사항</h3>
<ul>
	<li>라디오 버튼이나 체크박스의 경우 옵션을 동적으로 추가 또는 삭제할 수 없다.</li>
	<li>input 엘리먼트의 type 속성은 text, password, hidden 이 있다.</li>
	<li>textarea는 여러 줄을 입력할 수 있게 한다.</li>
	<li>input 과 textarea에서 사용자가 입력한 값은 value 속성으로 접근할 수 있다.</li>
	<li>click 이외에도 change, focus, blur 이벤트를 이용하여 폼 유효성 검사를 수행할 수 있다.</li>
	<li>이벤트 핸들러를 등록하는 방법은 아래와 같다.
		<ul>
			<li>onclick="핸들러 함수()"</li>
			<li>onchange="핸들러 함수()"</li>
			<li>onfocus="핸들러 함수()"</li>
			<li>onblur="핸들러 함수()"</li>
		</ul>
	</li>
</ul>

<h3>자바스크립트 코드와 디자인의 분리</h3>
엘리먼트의 onclick 속성을 이용하여 이벤트를 등록하는 방법은 디자인과의 결합도가 높은 코드다.<br />
<em class="path">&lt;form id="testForm" method="get" onsubmit="return check()"&gt;</em>
부분이 결합도가 높다. send1.html 파일을 아래처럼 바꾸어서 테스트한다.

<em class="filename">send1-1.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
<strong>
window.onload = initPage;

function initPage() {
	var form = document.getElementById("testForm");
	form.onsubmit = check;
}

function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	return true;
}
</strong>
//]]&gt;
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" method="get"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;
	&lt;input type="submit" value="확인" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/send1-1.html">예제 실행</a><br />

더 좋은 코드는 자바스크립트 코드를 외부 파일로 만드는 것이다.<br />

<em class="filename">send1-2.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
<strong>&lt;script type="text/javascript" src="send1.js"&gt;&lt;/script&gt;</strong>
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" method="get"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;
	&lt;input type="submit" value="확인" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/send1-2.html">예제 실행</a><br />

<em class="filename">send1.js</em>
<pre class="prettyprint">
window.onload = initPage;

function initPage() {
	var form = document.getElementById("testForm");
	form.onsubmit = check;
}

function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	return true;
}
</pre>

<em class="filename">send2-1.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
window.onload = initPage;

function initPage() {
	var submit = document.getElementById("submit");
	submit.disabled = true;
	var form = document.getElementById("testForm");
	form.onsubmit = check;
	form.agreement.onchange = agree;
}

function agree() {
	var form = document.getElementById("testForm");
	var submit = document.getElementById("submit");
	if (form.agreement.checked == true) {
		submit.disabled = false;	
	} else {
		submit.disabled = true;
	}
}
function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	return true;
}
//]]&gt;
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" method="get"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;&lt;br /&gt;
	서버로 정보를 전달하는 것에 동의합니다.
	&lt;input type="radio" name="agreement" value="y"/&gt;
	&lt;input type="submit" id="submit" value="확인" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/send2-1.html">예제 실행</a><br />

위 예제 역시 자바스크립트 코드를 분리하는 것이 더 좋은 코드다.<br />

<a href="/resources/examples/javascript/send2-2.html">예제 실행</a><br />
