<div id="last-modified">Last Modified : 2014.7.31</div>
<h1>메인 메뉴</h1>

다음 링크에서 이미지를 내려받는다. 
<a href="https://goo.gl/h0FujX">https://goo.gl/h0FujX</a><br />
아니면 아래 이미지를 저장한다.<br />

<div style="background: #ebebeb;">
<img src="https://lh3.googleusercontent.com/-sQJqA2Xy4lA/VYJgApAGzmI/AAAAAAAACak/QoRi8LP0HEA/s4/bull_circle.gif" alt="bull_circle.gif" style="width:120px;" />
<img src="https://lh3.googleusercontent.com/-m7AxsWEEYkI/VYJgAlTWMsI/AAAAAAAACag/ZwSK80SF3yI/s11/attach.png" alt="attach.png" style="width:120px;" />
<img src="https://lh3.googleusercontent.com/-CLWzjmg1nE0/VYJgBW3wZ2I/AAAAAAAACao/3fAtEYhiSps/s117/ci.gif" alt="ci.gif" style="width:120px;" />
<img src="https://lh3.googleusercontent.com/-HRhH9HImJr0/VYJgB_tbr-I/AAAAAAAACa4/r0w7FPaHy6w/s3/circle.gif" alt="circle.gif" style="width:120px;" />
<img src="https://lh3.googleusercontent.com/-oNgNdic_nwk/VYJgApt8m8I/AAAAAAAACa0/BbLVtFw5Ayk/s9/arrow.gif" alt="arrow.gif" style="width:120px;" />
</div>

최상위 디렉토리 바로 아래 images 폴더를 만들고 이미지를 넣는다.<br />

<h3>HTML 코드 추가</h3>
main-menu 안에 아래와 같이 메인 메뉴를 추가한다.<br />
ul 에 id 속성을 준 것은 main-menu 안의 ul 에만 적용되는 스타일을 지정하기 위해서다.<br />
content 안에도 ul 을 쓸 일이 있기 때문이다.<br />
<pre class="prettyprint">
&lt;div id="main-menu"&gt;

	&lt;ul id="nav"&gt;
		&lt;li&gt;&lt;a href="#"&gt;Java&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;JDBC&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;JSP&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;Eclipse&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;Struts2&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;Ajax&lt;/a&gt;&lt;/li&gt;
		&lt;li&gt;&lt;a href="#"&gt;Android&lt;/a&gt;&lt;/li&gt;
	&lt;/ul&gt;
	
&lt;/div&gt;	
</pre>


<h3>#main-menu 폰트 설정</h3>
대메뉴에 글자의 폰트에 대한 설정을 한다.<br />
/*** The Essential Code ***/ 부분에 #main-menu 에 다음에 다음을 추가한다.<br /> 
/*** Just for Looks ***/ 부분에 있는 #main-menu 는 이제 필요없으니 지운다.<br />

<pre class="prettyprint">
#main-menu {
	width: 1000px;
	height: 35px;
	<strong>font-family: Verdana, sans-serif;</strong>
	<strong>font-weight: bold;</strong>
	<strong>font-size: 12px;</strong>	
}
</pre>

<img src="https://lh3.googleusercontent.com/-ScIYFUn40gE/VYJfewTGNHI/AAAAAAAACZ8/V629ccAxfKc/s1002/main-menu-01.png" alt="예제보기 1" /><br />

<h3>ul#nav</h3>
li의 디폴트 리스트 스타일를 제거한다.<br />
ul과 li가 가진 디폴트 마진과 패딩도 제거한다.<br />
/*** The Essential Code ***/ 부분에 다음을 추가한다.<br />

<pre class="prettyprint">
ul#nav {
	margin: 0;
	padding: 0;
	list-style-type: none;
}	
</pre>

<img src="https://lh3.googleusercontent.com/-k3YjIyfXNpA/VYJfew_30xI/AAAAAAAACZ4/h1orzH137eQ/s1002/main-menu-02.png" alt="예제보기 2" /><br />

<h3>ul#nav li</h3>
메뉴가 가로로 보이도록 설정한다.<br />
/*** The Essential Code ***/에 다음을 추가한다.<br />

<pre class="prettyprint">
ul#nav li {
	float: left;
}
</pre>

<img src="https://lh3.googleusercontent.com/-FIGnHDBVqzY/VYJfe46KQCI/AAAAAAAACZk/reCCXdbwvt8/s1001/main-menu-03.png" alt="예제보기 3" /><br />

메뉴 항목이 붙어 있다.<br />
항목 좌우에 적당한 패딩을 준다.<br />

<pre class="prettyprint">
ul#nav li {
	float: left;
	<strong>padding: 0 17px 0 8px;</strong>
}
</pre>

<img src="https://lh3.googleusercontent.com/-lE_DJHJdnS4/VYJffUvVymI/AAAAAAAACZo/Mf7yDGDHhAU/s1002/main-menu-04.png" alt="예제보기 4" /><br />

<h3>ul#nav 위치 조절</h3>
메뉴가 있는 ul이 main-menu의 위쪽에 치우쳐 있다.<br />
main-menu의 높이에 변화를 주지 않으면서 ul의 위치를 중앙으로 이동시킨다.<br />

<pre class="prettyprint">
ul#nav {
	margin: 0;
	padding: 0;
	<strong>position: relative;</strong>
	<strong>top: 9px;</strong>
	<strong>left: 17px;</strong>
}
</pre>

<img src="https://lh3.googleusercontent.com/-DMfBbYWa_5U/VYJffkIW81I/AAAAAAAACaI/P2RSUomT3uk/s999/main-menu-05.png" alt="예제보기 5" /><br />

<h3>메인 메뉴 링크 스타일</h3>

#main-menu 배경색을 지정한다.<br />

<pre class="prettyprint">
#main-menu {
	width: 1000px;
	height: 35px;
	font-family: Verdana, sans-serif;
	font-weight: bold;
	font-size: 12px;
	<strong>background: #92B91C;</strong>
}
</pre>

링크의 글자색은 흰색으로,
링크 밑줄은 없애고,
마우스를 올릴때는 밑줄이 보이도록 한다.<br />
다음을 /*** The Essential Code ***/에 추가한다.<br />

<pre class="prettyprint">
ul#nav li a {
	text-decoration: none;
	color: #FFF;
}

ul#nav li a:hover {
	text-decoration: underline;
	background: none;
	color: #FFF;
}
</pre>

<img src="https://lh3.googleusercontent.com/-dlvWJ3Z86TU/VYJffwAhvBI/AAAAAAAACaM/PZVGiMptb2M/s999/main-menu-06.png" alt="예제보기 6" /><br />

<h3>메인 메뉴의 목록 앞에 이미지</h3>
list-style-type: none;으로 설정하면 리스트 아이템의 왼쪽 옆에 나오는 디폴트 리스트 스타일인 동그라미가 없어진다.<br />
디폴트 리스트 스타일 대신 배경 이미지를 이용하면 리스트를 좀 더 세련되게 표현할 수 있다.<br />
아래 코드를 ul#nav li 에 추가한다.<br />
url 다음의 이미지 경로는 CSS 파일의 위치를 기준으로 이미지가 있는 위치를 상대경로로 표시한다.<br />

<pre class="prettyprint">
ul#nav li {
	float: left;
	list-style-type: none;
	margin: 0;
	padding: 0 17px 0 8px;
	<strong>background: url('../images/bull_circle.gif') no-repeat 0 50%;</strong>
}
</pre>

<img src="https://lh3.googleusercontent.com/-KpORGDfW3HA/VYJfgPAy47I/AAAAAAAACaA/2dF8Wi9oFd0/s1001/main-menu-07.png" alt="예제보기 7" /><br />

<h3>둥근 상자 모서리(CSS 3)</h3>

CSS 3에서는 상자의 모서리를 둥글게 설정할 수 있다.<br />
아래 강조된 부분을 #main-menu에 추가한다.<br />

<pre class="prettyprint">
#main-menu {
	<strong>margin-top: 15px;
	margin-bottom: 15px;</strong>
	width: 1000px;
	height: 35px;
	font-family: Verdana, sans-serif;
	font-weight: bold;
	font-size: 12px;	
	background: #92B91C;	
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	border-radius: 3px;	
}
</pre>

<img src="https://lh3.googleusercontent.com/-vFFBr4Ttz5g/VYJfhTmyueI/AAAAAAAACaQ/r5LKKEQRao8/s1000/main-menu-08.png" alt="예제보기 8" /><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.css3.info/preview/rounded-border/">http://www.css3.info/preview/rounded-border/</a></li>
	<li><a href="http://border-radius.com/">http://border-radius.com/</a></li>
	<li><a href="http://www.the-art-of-web.com/css/border-radius/">http://www.the-art-of-web.com/css/border-radius/</a></li>
	<li><a href="http://www.alistapart.com/articles/holygrail/">http://www.alistapart.com/articles/holygrail/</a></li>
</ul>