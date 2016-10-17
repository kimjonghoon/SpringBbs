<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript" src="/resources/js/script-result-display.js"></script>

<div id="last-modified">Last Modified : 2014.8.13</div>

<h1>자바와 다른 점</h1>

자바를 바탕으로 자바와 다른 자바스크립트의 특징을 살펴본다.<br />

<ol>
	<li>변수 선언 시 변수 앞에 var를 붙인다.</li>
	<li>기본 데이터형 중 숫자는 부동 소수이며 나눗셈의 결과는 부동 소수가 된다.</li>
	<li>switch 문에서 switch ()의 괄호 안에 문자열이 올 수 있다. (JDK1.7부터 자바도 된다.)</li>
	<li>배열(인덱스를 사용하여 요소를 접근)은 []을 사용하거나 Array 객체를 사용한다.</li>
	<li>연관 배열은 key:value의 배열이다. 연관 배열은 인덱스로 요소에 접근할 수 없다. 자바에는 연관 배열이 없다.</li>
	<li>for in 반복문</li>
	<li>자바와 달리 자바스크립트는 함수를 함수의 인자로 전달할 수 있다.</li>
</ol>

1,2는 이미 보았다.<br />

<h3>3. switch("문자열")</h3>
<pre class="prettyprint">
var str = "A";

switch (str) {
case "A":
	alert("A");
	break;
case "B":
	alert("B");
	break;
case "C":
	alert("C");
	break;
case "D":
	alert("D");
	break;
default:
	alert("F");
}
</pre>

<h3>4. 배열 만들기</h3>

<h4>[] 사용</h4>
[]을 사용하여 만든 배열은 인덱스를 사용하여 요소에 접근할 수 있다.

<pre class="prettyprint">
var arr = [1, 2, 3, 4, 5];
var sum = 0;
for (var i = 0; i &lt; arr.length; i++) {
	sum = sum + arr[i];
}
alert('배열요소 합:' + sum);
</pre>

<h4>Array 객체 이용</h4>
Array 객체를 이용하여 만든 배열 역시 인덱스를 사용하여 요소에 접근할 수 있다.

<pre class="prettyprint">
var arr = new Array(1, 2, 3, 4, 5);
var sum = 0;
for (var i = 0; i &lt; arr.length; i++) {
	sum = sum + arr[i];
}
alert('배열요소 합:' + sum);
</pre>

<h3>5. 연관 배열</h3>
연관 배열은 key:value의 배열로 {}를 사용하여 만든다.<br />
연관 배열은 인덱스를 사용할 수 없다.<br />

<pre class="prettyprint">
var person = {"name":"홍길동", "job":"의적"};
alert(person.name);
alert(person["name"]);
alert(person.job);
alert(person["job"]);
</pre>

<h3>6. for in 반복문으로 연관 배열의 모든 요소에 접근할 수 있다.</h3>
<pre class="prettyprint">
var person = {"name":"임꺽정", "job":"의적"};
var result = "";
for(var property in person) {
	result += person[property];
}
alert(result);
</pre>

<h3>7. 자바스크립트는 함수를 함수의 인자로 전달할 수 있다.</h3>

<pre class="prettyprint">
function x(a, y) {
	var ret = y(a);
	alert(ret);
}

function z(a) {
    return a * a
}

x(2, z);
</pre>
