<div id="last-modified">Last Modified : 2014.7.31</div>
<h1>서브 메뉴</h1>

왼쪽 sidebar 에 부메뉴를 디자인한다.<br />
먼저 지금까지 디자인한 HTML 문서를 열고 sidebar 에 다음을 복사하여 붙여넣는다.<br />

<pre class="prettyprint">
&lt;div id="sidebar"&gt;
	<strong>&lt;h1&gt;Eclipse&lt;/h1&gt;
	&lt;ul&gt;
		&lt;li&gt;&lt;a href="#"&gt;Eclipse Tutorial&lt;/a&gt;
			&lt;ul&gt;
				&lt;li&gt;&lt;a href="#"&gt;Eclipse 설치&lt;/a&gt;&lt;/li&gt;
				&lt;li&gt;&lt;a href="#"&gt;WTP 설치&lt;/a&gt;&lt;/li&gt;
			&lt;/ul&gt;
		&lt;/li&gt;
	&lt;/ul&gt;</strong>

&lt;/div&gt;
</pre>

/*** Just for Looks ***/에서 #sidebar를 지운다.<br />

<img src="https://lh3.googleusercontent.com/-ZXSg849T0Gs/VYJuJDZgplI/AAAAAAAACbg/xssrQYA8EA0/s332/sub-menu-01.png" alt="예제보기 1" /><br />

<h3>#sidebar border와 font 스타일</h3>

#sidebar 상자의 테두리 색과 두께를 설정한다.<br />
마진과 패딩이 없는 엘리먼트가 실제 차지하는 넓이는 width + 좌우 border 합으로 계산된다.<br />
#sidebar가 175px의 넓이만 차지해야 하므로 #sidebar width를 175px에서 173px로 변경해야 한다.<br />

<pre class="prettyprint">
#sidebar {
	float: left;
	width: <strong>173px;</strong>
	margin-left: -1000px;
	<strong>border: 1px solid #DAEAAA;</strong>
	<strong>font-family: Verdana, sans-serif;</strong>
	<strong>font-size: 12px;</strong>
}
</pre>

<h3>#sidebar h1 스타일</h3>

<pre class="prettyprint">
#sidebar h1 {
	margin: 0;
	padding: 14px;
	background: #92B91C;
	color: #FFF;
	font-size: 16px;
}
</pre>

<img src="https://lh3.googleusercontent.com/-VFFA-Zm6DSY/VYJuJCETf_I/AAAAAAAACbw/EFwxwl7XMBg/s300/sub-menu-02.png" alt="예제보기 2" /><br />

<h3>#sidebar ul</h3>
서브 메뉴에 해당하는 #sidebar ul을 추가하고 스타일을 지정한다.<br />

<pre class="prettyprint">
#sidebar ul {
	margin: 0;
	padding: 0;
	list-style-type: none;
}
</pre>

<img src="https://lh3.googleusercontent.com/-Y70qUqs0gdw/VYJuJKJOS6I/AAAAAAAACbk/fRiI5jD0jcw/s284/submenu-03.png" alt="예제보기 3" /><br />

<h3>#sidebar 링크 스타일</h3>
#sidebar 링크에 스타일을 지정한다.<br />
a는 인라인(inline) 엘리먼트지만 display: block으로 설정하면 상자(box)가 되어 상자 영역
전체에 링크가 걸리게 된다.<br />

<pre class="prettyprint">
#sidebar a {
	display: block;
	padding: 6px 10px 6px 10px;
	color: #64615D;
	background: #DAEAAA;
	text-decoration: none;
	font-weight: bold;
}

#sidebar a:hover {
	background-color: #EDFEBA;
	color: #64615D;
}
</pre>

<img src="https://lh3.googleusercontent.com/-E-OJDZeWjIM/VYJuJ1YbCuI/AAAAAAAACbo/fo9FOxeRMOI/s311/submenu-04.png" alt="예제보기 4" /><br />

<h3>#sidebar li li a 링크 스타일 설정</h3>
#sidebar li li a 링크에 대한 스타일을 지정한다.<br />

<pre class="prettyprint">
#sidebar li li a {
	display: block;
	color: #64615D;
	padding: 5px 3px 4px 17px;
	text-decoration: none;
	border-bottom: 1px solid #FFF;
	font-weight: normal;
	background: #FFF url('../images/circle.gif') no-repeat 5% 50%;
}
</pre>

<img src="https://lh3.googleusercontent.com/-86nh0BS0H48/VYJuJyBVkYI/AAAAAAAACbs/qMW22B2dNfY/s308/submenu-05.png" alt="예제보기 5" /><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.alistapart.com/articles/holygrail/">http://www.alistapart.com/articles/holygrail/</a></li>
</ul>