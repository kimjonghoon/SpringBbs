<div id="last-modified">Last Modified : 2014.7.31</div>
<h1>#header, #footer, #content 스타일</h1>

index.html 문서를 열고 #header 사이에 아래 코드를 삽입한다.<br /> 

<pre class="prettyprint">
&lt;h1&gt;&lt;a href="#"&gt;&lt;img src="images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
</pre>

/*** Just for Looks ***/에서 #header, #footer의 배경색을 제외한 나머지 스타일을 지운다.<br />

<pre class="prettyprint">
#header, #footer {
	background: #999;
}
</pre>

<img src="https://lh3.googleusercontent.com/-zkaWuyyK0R4/VYJ6erZcR2I/AAAAAAAACcI/1Fg4Wy87ju4/s1000/footer-footer-content-01.png" alt="예제보기 1" /><br />

<h3>#header h1 위치 재지정</h3>
h1 엘리먼트는 디폴트 마진을 가지고 있기 때문에 #header가 
웹 브라우저 화면에서 조금 아래로 떨어진다.<br />
h1의 디폴트 마진과 패딩을 없애고 9px 아래로 이동시킨다.<br />
/*** The Essential Code ***/에 다음을 추가한다.<br />

<pre class="prettyprint">
#header h1 {
	margin: 0;
	padding: 0;
	position: relative;
	top: 9px;
}
</pre>

<img src="https://lh3.googleusercontent.com/-J4qU8KSupGk/VYJ6eo-XExI/AAAAAAAACcQ/kSQfTlWC5ms/s1002/footer-footer-content-02.png" alt="예제보기 2" /><br />

<h2>#footer 스타일</h2>
index.html 문서의 footer 안에 아래 코드를 삽입한다.<br />

<pre class="prettyprint">
&lt;div id="footer"&gt;
	<strong>&lt;ul&gt;
		&lt;li&gt;&lt;a href="#"&gt;이용약관&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;개인정보보호정책&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;이메일무단수집거부&lt;/a&gt;&lt;/li&gt;
		&lt;li id="company-info"&gt;전화 : 02-123-5678, FAX : 02-123-5678&lt;br /&gt;
		people@ggmail.org&lt;br /&gt;
		Copyright java-school.net All Rights Reserved.&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;찾아오시는 길&lt;/a&gt;&lt;/li&gt;
	&lt;/ul&gt;</strong>
&lt;/div&gt;
</pre>

/*** Just for Looks ***/ 부분의 #header, footer는 지운다.<br />
/*** The Essential Code ***/의 #footer에 다음을 추가한다.<br />

<pre class="prettyprint">
#footer {
	clear: both;
	width: 1000px;
	height: 70px;
	<strong>font-size: 11px;
	color: #8d8d8d;
	letter-spacing: -1px;
	border-top: 1px solid #DAEAAA;</strong>	
}
</pre>

<img src="https://lh3.googleusercontent.com/-AfkKpP1pR1M/VYJ6ekeDFqI/AAAAAAAACcM/IrP5L5QgTjU/s1000/footer-footer-content-03.png" alt="예제보기 3" /><br />

<h3>#footer 메뉴를 가로로 보이게 수정</h3>
다음 코드를 /*** The Essential Code ***/에 추가한다.<br />

<pre class="prettyprint">
<strong>#footer ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
}

#footer ul li {
	float: left;
}</strong> 
</pre>

<img src="https://lh3.googleusercontent.com/-64dB4b_CBOs/VYJ6fb9WYgI/AAAAAAAACco/Ee4J9XledEo/s999/footer-footer-content-04.png" alt="예제보기 4" /><br />

<h3>footer 글로벌 메뉴 스타일</h3>
글로벌(global) 메뉴 스타일을 지정한다.<br />


<pre class="prettyprint">
#footer ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
	<strong>position: relative;
	left: 8px;</strong>
}

#footer ul li {
	float: left;
	<strong>padding: 6px 12px 6px 8px;
	background: url('../images/circle.gif') no-repeat 0 50%;</strong>
}
<strong>
#footer a {
	color: #8D8D8D;
	text-decoration: none;
}

#footer a:hover {
	text-decoration: underline;
}

#footer ul li#company-info {
	margin-left: 350px;
	letter-spacing: 0;
	background: none;
}</strong>
</pre>

<img src="https://lh3.googleusercontent.com/-Xw4-LR7LP4s/VYJ6fhSDuUI/AAAAAAAACck/SQIHnqkciT4/s1004/footer-footer-content-05.png" alt="예제보기 5" /><br />

<h2>#content 스타일</h2>
#content 마진을 5px씩 늘려 #sidebar와 #extra 사이에 간격을 두도록 설정한다.
보더를 추가하여 경계를 구분한다.<br />

<pre class="prettyprint">
#content {
	margin-left: <strong>180px;</strong>
	margin-right: <strong>210px;</strong>
	<strong>border-left: 1px solid #DAEAAA;</strong>
	<strong>border-right: 1px solid #DAEAAA;</strong>
}
</pre>

#content 상자의 영역은 1000px이다.<br />
좌우 마진합이 390px(180 + 210)이라면 #content의 width는 610px이 된다.<br />
border를 좌우로 1px 주었다면 width는 608px이 된다.<br />

<dl class="note">
<dt>#content 좌우에 padding 9px를 준다면</dt>
<dd>
608에서 18을 뺀 590px이 #content의 width이다.
</dd>
</dl>

레이아웃을 좀 더 우아하게 보이도록 강조된 부분을 추가한다.<br />

<pre class="prettyprint">
#container {
	float: left;
	width: 100%;
	<strong>border-top: 1px solid #DAEAAA;</strong>
}

#sidebar {
	float: left;
	width: 173px;
	margin-left: -1000px;
	<strong>margin-bottom: 20px;</strong>
	border: 1px solid #DAEAAA;
	font-family: Verdana, sans-serif;
	font-size: 12px;
	<strong>position: relative;</strong>
	<strong>top: 7px;</strong>
}

#extra {
	float: left;
	width: 205px;
	margin-left: -205px;
	<strong>position: relative;</strong>
	<strong>top: 7px;</strong>
}
</pre>

<em class="path">margin-bottom: 20px;</em>은 #sidebar가 #content보다 위아래로 길 때<br />
<em class="path">position: relative;top: 7px;</em> 때문에 #sidebar가 #footer를 침범할 수 있기에 설정한다.<br />
#content가 #sidebar 보다 높이가 낮다면 #content에 min-height 프로퍼티를 #sidebar의 높이보다 큰 값으로 설정한다.
min-height 프로퍼티 값은 페이지마다 달라질 수 있기 때문에 스타일 시트가 아닌 HTML 페이지에서 해당 엘리먼트에 직접 지정한다. <br />
이렇게 페이지마다 #content의 min-height를 신경 써야 하는 것이 이 레이아웃의 약점이다.<br />
아래 참고에서 이 문제에 대해 다루고 있다.<br />
<br />
테스트를 위해서 /*** Just for Looks ***/의 #content의 높이를 100px에서 300px으로 수정한다.<br />

<pre class="prettyprint">
#content {
	font-size: large;
	text-align: center;
	background: #DDD;
	<strong>height: 300px;</strong>
}
</pre>

<img src="https://lh3.googleusercontent.com/-sw1mzCeCSIk/VYJ6fnYEuGI/AAAAAAAACcc/l3vS87BU10o/s1005/footer-footer-content-final.png" alt="예제보기 6" /><br />
#content 부분의 디자인은 게시판 목록 스타일에서 다룬다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.alistapart.com/articles/holygrail/">http://www.alistapart.com/articles/holygrail/</a></li>
</ul>

