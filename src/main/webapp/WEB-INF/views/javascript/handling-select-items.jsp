<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.11.11</div>

<h1>select 엘리먼트 다루기</h1>

<h3>동적으로 항목 추가</h3>
<pre class="prettyprint no-border">
opts[opts.length] = new Option("옵션 text", "옵션 value");
</pre>

<h3>동적으로 항목 제거</h3>
<pre class="prettyprint no-border">
opts[2] = null;
</pre>

중간에 생긴 빈 공간은 없어지고 자동으로 배열이 정렬된다.<br />

<h3>모든 항목 제거</h3>
<pre class="prettyprint no-border">
opts.length = 0;
</pre>

다음 예제는 첫 번째 선택 상자에서 언어를 선택하면 두 번째 선택 상자에 메뉴가 생성되게 하는 예제이다.<br />
언어를 선택할 때 최상위 메뉴(--언어를 선택하세요)를 선택하면 두 번째 선택 상자는 초기화되도록 구현했다.<br />

<em class="filename">sel.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;자바스크립트 select 엘리먼트 다루기&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function chooseLang() {
	var form = document.getElementById("testForm");
	var lang = form.programLanguage.value;

	switch (lang) {
	case "java":
		form.step.options[0] = new Option("자바과정에대해","javaIntro");
		form.step.options[1] = new Option("객체와 클래스","ClassObject");
		form.step.options[2] = new Option("데이터타입","JavadataType");
		break;
	case "javascript":
		form.step.options[0] = new Option("자바스크립트란","javascriptIntro");
		form.step.options[1] = new Option("데이터타입","JavascriptDataType");
		form.step.options[2] = new Option("자바스크립트객체","JavascriptObjects");
		break;
	default:
		form.step.options.length = 0;
	}
	
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" action="sel.php"&gt;
	&lt;select name="programLanguage" onchange="chooseLang()"&gt;
		&lt;option value=""&gt;--언어를 선택하세요&lt;/option&gt;
		&lt;option value="java"&gt;자바&lt;/option&gt;
		&lt;option value="javascript"&gt;자바스크립트&lt;/option&gt;
	&lt;/select&gt;
	&lt;select name="step"&gt;
	&lt;/select&gt;
	&lt;input type="submit" value="테스트" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<a href="/resources/examples/javascript/sel.html">sel.html 예제 실행</a>