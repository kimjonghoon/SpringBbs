<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.07.03</div>

<h1>자바스크립트 DOM</h1>

<h2>문서 객체 모델</h2>

DOM 은 언어에 중립적인 인터페이스이다.<br /> 
돔을 이용하면 문서의 내용,구조, 스타일을 동적으로 변경할 수 있다.<br />
웹브라우저는 도큐먼트 객체 모델로 웹 페이지를 관리한다.<br />
아래 내용으로 dom.html 문서를 작성한다.<br />

<em class="filename">dom.html</em>
<pre class="code">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스쿨 TODO&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;오늘의 할일&lt;/h1&gt;
&lt;div id="div1"&gt;
	&lt;p id="p1"&gt;
	DOM 관련하여 기사를 작성한다.
	&lt;/p&gt;
	&lt;p id="p2"&gt;
	2013년 7월 3일 밤 &lt;strong id="strong"&gt;12&lt;/strong&gt;시까지 
	&lt;/p&gt;
&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

이 문서를 DOM 구조로 그려보자.<br />
DOM 은 이러한 트리에 접근할 수 있는 표준을 제공한다.<br />
트리에 접근하기 위해선 문서의 최상위 레벨에 해당하는 document 객체가 쓰인다.<br />
document 객체의 주요 메소드는 getElementById() 와 getElementsByTagName() 이다.<br />
dom.html 문서를 열고 head 엘리먼트 아래 다음과 같이 자바스크립트를 추가한 후 차례로 테스트한다.<br />

<pre class="code">
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

window.onload=domTest;

function domTest() {
	var div = document.getElementById("div1");
	var p = div.getElementsByTagName("P")[0];
	div.removeChild(p);
}

//]]&gt;
&lt;/script&gt;
</pre>

<pre class="code">
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

window.onload=domTest;

function domTest() {
	var strong = document.getElementById("strong");
	var p = document.getElementById("p2");
	var txt = document.createTextNode("11");
	p.replaceChild(txt,strong);
}

//]]&gt;
&lt;/script&gt;
</pre>

<pre class="code">
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

window.onload=domTest;

function domTest() {
	var p = document.createElement("P");
	p.innerHTML="다음 기사는 ...";
	var div = document.getElementById("div1");
	div.appendChild(p);
}

//]]&gt;
&lt;/script&gt;
</pre>

<pre class="code">
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

window.onload=domTest;

function domTest() {
	var div = document.getElementById("div1");
	div.style.display="none";
}

//]]&gt;
&lt;/script&gt;
</pre>