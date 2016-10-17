<div id="last-modified">Last Modified : 2014.7.31</div>

<h1>목록</h1>

먼저 게시판뿐 아니라 웹사이트에 전체에 적용될 스타일을 설정한다.<br />
아래 강조된 코드를 /*** The Essential Code ***/ 가장 위에 추가한다.

<pre class="prettyprint">
/* 공통 */
html, body {
	margin: 0;
	padding: 0;<strong>
	font-family: "돋움", dotum, sans-serif;</strong>
}
<strong>
div, input, select, textarea, td {
	color: #646464;
	font-family: "돋움", dotum, sans-serif;
	font-size: 12px;
}

table {
	border-collapse: collapse;
}

img {
	border: 0;
}

form {
	margin: 0;
	padding: 0;
}</strong>
/* 공통 끝 */
</pre>

지금까지 예제를 따라 하면서 작성한 index.html을 열고 
'다른 이름으로 저장하기' 메뉴를 이용해서 list.html 파일을 만든다.<br />
/*** Just for Looks ***/에서 #content 부분은 삭제한다.<br />
index.html의 #content에 다음을 붙여넣는다.<br />

<pre class="prettyprint">
&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Eclipse &amp;gt; Eclipse Tutorial&lt;/div&gt;
&lt;h1&gt;Eclipse 설치&lt;/h1&gt;

&lt;div id="bbs"&gt;
	&lt;table&gt;
	&lt;!--  게시판 목록 머리말 --&gt;
	&lt;tr&gt;
		&lt;th&gt;NO&lt;/th&gt;
		&lt;th&gt;TITLE&lt;/th&gt;
		&lt;th&gt;DATE&lt;/th&gt;
		&lt;th&gt;HIT&lt;/th&gt;
	&lt;/tr&gt;
	
	&lt;!--  반복 구간 시작 --&gt;
	&lt;tr&gt;
		&lt;td&gt;11&lt;/td&gt; &lt;!--번호--&gt;
		&lt;td&gt;
			&lt;a href="#"&gt;제목&lt;/a&gt;
			&lt;!--첨부 파일이 있으면 표시--&gt;
			&lt;img src="images/attach.png" alt="첨부 파일" /&gt;
			&lt;!--댓글 개수표시--&gt;
			[5]
			&lt;/td&gt;
			&lt;td&gt;2011.11.15&lt;/td&gt; &lt;!--등록일--&gt;
			&lt;td&gt;4555&lt;/td&gt; &lt;!--조회 수--&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td&gt;11&lt;/td&gt; &lt;!--번호--&gt;
		&lt;td&gt;
			&lt;a href="#"&gt;제목&lt;/a&gt;
			&lt;!--첨부 파일이 있으면 표시--&gt;
			&lt;img src="images/attach.png" alt="첨부 파일" /&gt;
			&lt;!--댓글 개수표시--&gt;
			[5]
			&lt;/td&gt;
			&lt;td&gt;2011.11.15&lt;/td&gt; &lt;!--등록일--&gt;
			&lt;td&gt;4555&lt;/td&gt; &lt;!--조회 수--&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td&gt;11&lt;/td&gt; &lt;!--번호--&gt;
		&lt;td&gt;
			&lt;a href="#"&gt;제목&lt;/a&gt;
			&lt;!--첨부 파일이 있으면 표시--&gt;
			&lt;img src="images/attach.png" alt="첨부 파일" /&gt;
			&lt;!--댓글 개수표시--&gt;
			[5]
			&lt;/td&gt;
			&lt;td&gt;2011.11.15&lt;/td&gt; &lt;!--등록일--&gt;
			&lt;td&gt;4555&lt;/td&gt; &lt;!--조회 수--&gt;
	&lt;/tr&gt;
	&lt;tr&gt;
		&lt;td&gt;11&lt;/td&gt; &lt;!--번호--&gt;
		&lt;td&gt;
			&lt;a href="#"&gt;제목&lt;/a&gt;
			&lt;!--첨부 파일이 있으면 표시--&gt;
			&lt;img src="images/attach.png" alt="첨부 파일" /&gt;
			&lt;!--댓글 개수표시--&gt;
			[5]
			&lt;/td&gt;
			&lt;td&gt;2011.11.15&lt;/td&gt; &lt;!--등록일--&gt;
			&lt;td&gt;4555&lt;/td&gt; &lt;!--조회 수--&gt;
	&lt;/tr&gt;
	&lt;!--  반복 구간 끝 --&gt;             
	&lt;/table&gt;
                
	&lt;div id="paging"&gt;
		1
		&lt;a href="#"&gt;[2]&lt;/a&gt;
		&lt;a href="#"&gt;[3]&lt;/a&gt;
		&lt;a href="#"&gt;[4]&lt;/a&gt;
		&lt;a href="#"&gt;[5]&lt;/a&gt;
	&lt;/div&gt;

	&lt;div id="list-menu"&gt;
		&lt;input type="button" value="새 글쓰기" /&gt;
	&lt;/div&gt;

	&lt;div id="search"&gt;
		&lt;form action="list.jsp" method="get"&gt;
		&lt;p style="margin: 0;padding: 0;" &gt;
			&lt;input type="hidden" name="boardCd" value="free" /&gt;
			&lt;input type="hidden" name="curPage" value="1" /&gt;                               
			&lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
			&lt;input type="submit" value="검색" /&gt;
		&lt;/p&gt;
		&lt;/form&gt;
	&lt;/div&gt;

&lt;/div&gt;
&lt;!--  본문 끝 --&gt;
</pre>

<img alt="게시판 디자인 1" src="https://lh3.googleusercontent.com/-O6uvKRmmCbE/VYLFqU8MyLI/AAAAAAAACdI/cOzIxPn1cVs/s1036/bbs-list-01.png" /><br />

<h3>#content 패딩, 폰트 크기, 줄 간격 설정</h3>

<pre class="prettyprint">
#content {
	margin-left: 180px;
	margin-right: 210px;
	<strong>padding-left: 9px;</strong>
	<strong>padding-right: 9px;</strong>
	border-left: 1px solid #DAEAAA;
	border-right: 1px solid #DAEAAA;
	<strong>font-size: 13px;</strong>
	<strong>line-height: 19px;</strong>
}
</pre>

<img alt="게시판 디자인 2" src="https://lh3.googleusercontent.com/-GlYv3s8McTw/VYLFqUq5BbI/AAAAAAAACdc/9bOWjKBqzBw/s1031/bbs-list-02.png" /><br />

<h3>#url-navi 추가</h3>
<em class="path">Eclipse &gt; Eclipse Tutorial</em> 부분의 스타일을 지정한다.

<pre class="prettyprint">
<strong>#url-navi {
	margin: 0;
	padding-top: 10px;
	padding-bottom: 8px;
	font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
	font-size: 11px;
	color: #666;
	border-bottom: 1px solid #DAEAAA;</strong>
}
</pre>

<img alt="게시판 디자인 3" src="https://lh3.googleusercontent.com/-Bo-rpGzAJJo/VYLFqWtvvWI/AAAAAAAACdM/KBcnQZJPXsM/s1034/bbs-list-03.png" /><br />

<h3>게시판 제목 스타일</h3>
게시판 제목에 해당하는 #content h1을 추가한다.<br />

<pre class="prettyprint">
<strong>#content h1 {
	margin: 9px 0;
	padding: 7px 0x;
	font-size: 15px;</strong>
}
</pre>

<img alt="게시판 디자인 4" src="https://lh3.googleusercontent.com/-3PxH2IIHliY/VYLFrOMMZQI/AAAAAAAACdY/564yq1o3jkE/s1027/bbs-list-04.png" /><br />

<h3>목록 머릿글 스타일</h3>
사실 여기까지는 게시판 디자인이 아니라 일반적인 content 디자인이다.<br />
bbs 엘리먼트가 감싸고 있는 부분이 게시판 부분이다.<br />
게시판 목록 머릿글에 해당하는 th 스타일을 지정한다.<br />

<pre class="prettyprint">
<strong>#bbs table {
	width: 100%;
}

#bbs table th {
	color: #92B91C;
	border-top: 1px solid #92B91C;
	border-bottom: 1px solid #92B91C;
}</strong>
</pre>

<img alt="게시판 디자인 5" src="https://lh3.googleusercontent.com/-cEVUzFpbsdU/VYLFrXNIKvI/AAAAAAAACd4/PkyBlw5pBcs/s1039/bbs-list-05.png" /><br />

<h3>게시판 목록 아이템 디자인</h3>
번호, 제목, 등록일, 조회 수 부분에 대한 스타일을 지정한다.

<pre class="prettyprint">
#bbs td {
	padding-top: 3px;
	padding-bottom: 3px;
	border-bottom: 1px solid silver;
}

#bbs td a {
	color: #555;
	text-decoration: none;
}

#bbs td a:hover {
	color:#555;
	text-decoration: underline;
}
</pre>

<img alt="게시판 디자인 6" src="https://lh3.googleusercontent.com/-inQBJriLy5o/VYLFrc6PXVI/AAAAAAAACdg/Y---V-TvFAE/s1029/bbs-list-06.png" /><br />

목록 머릿말의 넓이를 조절한다.<br />

<pre class="prettyprint">&lt;!--  게시판 목록 머리말 --&gt;
&lt;tr&gt;
    &lt;th <b>style="width: 60px;"</b>&gt;NO&lt;/th&gt;
    &lt;th&gt;TITLE&lt;/th&gt;
    &lt;th <b>style="width: 84px;"</b>&gt;DATE&lt;/th&gt;
    &lt;th <b>style="width: 60px;"</b>&gt;HIT&lt;/th&gt;
&lt;/tr&gt;
</pre>

<img alt="게시판 디자인 7" src="https://lh3.googleusercontent.com/-D4emmLucNsw/VYLFruuOJEI/AAAAAAAACdw/HG6T44YWMfA/s1039/bbs-list-07.png" /><br />

목록 아이템 중 제목을 제외하고 text-align: center;로 설정한다.<br />

<pre class="prettyprint">
&lt;tr&gt;
	&lt;td <strong>style="text-align: center;"</strong>&gt;11&lt;/td&gt;
	&lt;td&gt;
		&lt;a href="#"&gt;제목&lt;/a&gt;
		&lt;img src="images/attach.png" alt="첨부 파일" /&gt;
		[5]
	&lt;/td&gt;
	&lt;td <strong>style="text-align: center;"</strong>&gt;2011.11.15&lt;/td&gt;
	&lt;td <strong>style="text-align: center;"</strong>&gt;4555&lt;/td&gt;
&lt;/tr&gt;
</pre>


<img alt="게시판 디자인 8" src="https://lh3.googleusercontent.com/-XxjTX59J-pQ/VYLFsXhjucI/AAAAAAAACd8/sahK93njaVk/s1036/bbs-list-08.png" /><br />

<h3>페이지 이동 링크 스타일 지정</h3>

<pre class="prettyprint"><b>#paging {
    text-align: center;
}

#paging a {
    color: #555;
    text-decoration: none;
    font-weight: bold;
}

#paging a:hover {
    color: #555;
    text-decoration: underline;
}</b>
</pre>

<img alt="게시판 디자인 9" src="https://lh3.googleusercontent.com/-HJhSKPdy648/VYLFsmBKvqI/AAAAAAAACeM/9mk6zcfX_Mo/s1026/bbs-list-09.png" />


댓글 개수, 현재 페이지 번호와 같이 게시판에서 글자를 강조하기 위한 스타일을 추가한다.

<pre class="prettyprint">
<strong>.bbs-strong {
	color: #FFA500;
	font-weight: bold;
}</strong>
</pre>

bbs-string 스타일을 댓글 개수와 현재 페이지 번호에 적용한다.<br />
 
<pre class="prettyprint">
&lt;tr&gt;
	&lt;td style="text-align: center;"&gt;11&lt;/td&gt; &lt;!--번호--&gt;
	&lt;td&gt;
		&lt;a href="#"&gt;제목&lt;/a&gt;
		&lt;!--첨부 파일이 있으면 표시--&gt;
		&lt;img src="images/attach.png" alt="첨부 파일" /&gt;
		&lt;!--댓글 개수표시--&gt;<strong>
		&lt;span class="bbs-strong"&gt;[5]&lt;/span&gt;</strong>
	&lt;/td&gt;
	&lt;td style="text-align: center;"&gt;2011.11.15&lt;/td&gt; &lt;!--등록일--&gt;
	&lt;td style="text-align: center;"&gt;4555&lt;/td&gt; &lt;!--조회 수--&gt;
&lt;/tr&gt;
&lt;/table&gt;

&lt;div id="paging"&gt;<strong>
&lt;span class="bbs-strong"&gt;1&lt;/span&gt;</strong>
&lt;a href="#"&gt;[2]&lt;/a&gt;
&lt;a href="#"&gt;[3]&lt;/a&gt;
&lt;a href="#"&gt;[4]&lt;/a&gt;
&lt;a href="#"&gt;[5]&lt;/a&gt;
&lt;/div&gt;
</pre>

<img alt="게시판 디자인 10" src="https://lh3.googleusercontent.com/-v0E_e_JDtak/VYLFtOpuREI/AAAAAAAACeE/TfdfXoeT-BE/s1036/bbs-list-10.png" />

<h3>새 글쓰기 버튼 위치 조정</h3>
새 글쓰기 버튼이 화면 오른쪽에 있도록 스타일을 지정한다.<br />

<pre class="prettyprint"><strong>#list-menu {
    text-align: right;
}</strong>
</pre>

<img alt="게시판 디자인 11" src="https://lh3.googleusercontent.com/-TVEzMSPCsoE/VYLFtZ3vH2I/AAAAAAAACec/DVoKJoCmjhE/s1035/bbs-list-11.png" />

<h3>검색을 중앙으로</h3>
검색을 화면 중앙으로 이동시킨다.<br />

<pre class="prettyprint"><strong>#search {
	text-align: center;
}</strong>
</pre>

<img alt="게시판 디자인 12" src="https://lh3.googleusercontent.com/-iPXtwDabEUA/VYLFtZ0VLBI/AAAAAAAACeY/j6d37Rs7KUg/s1030/bbs-list-12.png" />

<h3>화면 간격 조정</h3>
목록 테이블과 페이지 이동 링크 사이에 간격을 준다.<br />
기존 #bbs table에 다음 강조된 부분을 추가한다.<br />

<pre class="prettyprint">
#bbs table {
	width: 100%;
	<strong>margin: 0 0 7px 0;</strong>
}
</pre>

#search와 #footer의 간격도 조정한다.<br />
기존 #search에 다음 강조된 부분을 추가한다.<br />

<pre class="prettyprint">
#search {
	text-align: center;
	<strong>padding-bottom: 15px;</strong>
}
</pre>

<img alt="게시판 디자인 13" src="https://lh3.googleusercontent.com/-G6pgpPH3rWk/VYLFtyTQJDI/AAAAAAAACeU/MOlCFxsJVKs/s1032/bbs-list-13.png" />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://phrogz.net/css/vertical-align/index.html">http://phrogz.net/css/vertical-align/index.html</a></li>
	<li><a href="http://www.homejjang.com/09/border_collapse.php">http://www.homejjang.com/09/border_collapse.php</a></li>
	<li><a href="http://www.w3schools.com/cssref/pr_tab_border-collapse.asp">http://www.w3schools.com/cssref/pr_tab_border-collapse.asp</a></li>
</ul>