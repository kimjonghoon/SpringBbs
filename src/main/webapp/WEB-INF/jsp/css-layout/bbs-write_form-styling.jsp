<div id="last-modified">Last Modified : 2014.7.31</div>
<h1>글쓰기, 회원가입</h1>

<h3>새 글쓰기 폼 디자인</h3>
view.html 파일을 에디터에서 다른 이름으로 저장하기 메뉴를 사용하여 write_form.html 파일을 만든다.<br />
write_form.html 파일에서 #content 엘리먼트의 내용을 아래 내용으로 바꾼다.

<pre class="prettyprint">&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Eclipse &amp;gt; Eclipse Tutorial&lt;/div&gt;
&lt;h1&gt;Eclipse 설치&lt;/h1&gt;

&lt;div id="bbs"&gt;
&lt;h2&gt;글쓰기&lt;/h2&gt;
&lt;form id="writeForm" action="write_proc.jsp" method="post" 
	enctype="multipart/form-data"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="boardCd" value="free" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="17" cols="50"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;첨부 파일&lt;/td&gt;
	&lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
	&lt;input type="submit" value="전송" /&gt;
	&lt;input type="button" value="취소" /&gt;
	&lt;input type="button" value="목록" /&gt;
&lt;/div&gt;
&lt;/form&gt;
&lt;/div&gt;
&lt;!-- 본문 끝 --&gt;
</pre>

CSS 파일에 다음을 추가한다.

<pre class="prettyprint"><strong>#content h2 {
	margin: 9px 0 0 0;
	padding: 0;
	font-size: 13px;
	border-bottom: 1px solid #ebebeb;
}

#write-form td {
	border: none;
}

#write-form textarea {
	width: 99%;
}</strong>
</pre>

[결과 화면]<br />
<img alt="게시판 글쓰기 디자인 결과" src="https://lh3.googleusercontent.com/-TvdRJpx3EZU/VYTPjr_3SqI/AAAAAAAAChA/1Y8kXnwBXg4/s598/bbs-write-form-result.png" /><br />

전송, 취소, 목록 버튼 부분은 테이블이 아닌 div를 사용했다.<br />
<br />
#extra 부분은 웹사이트 기획자가 상상력을 발휘하는 곳이다.<br />
여기서는 단순히 이미지에 외부 사이트를 링크 걸었다.<br />
링크 이미지를 아래 링크에서 내려받아 압축을 풀고 images 폴더에 저장한다.<br />
<a href="https://goo.gl/enRjQc"><em class="path">https://goo.gl/enRjQc</em></a><br />
이미지는 #extra 박스의 테두리(border) 두께를 고려해서 넓이를 203px로 만들었다.<br />
write_from.html 문서의 #extra에 아래 코드를 입력한다.

<pre class="prettyprint">&lt;div id="extra"&gt;
	<strong>&lt;a href="http://www.youtube.com"&gt;&lt;img src="images/youtube.png" alt="youtube.com" /&gt;&lt;/a&gt;
	&lt;a href="http://www.twitter.com"&gt;&lt;img src="images/twitter.png" alt="twitter.com" /&gt;&lt;/a&gt;
	&lt;a href="http://www.facebook.com"&gt;&lt;img src="images/facebook.png" alt="facebook.com" /&gt;&lt;/a&gt;
	&lt;a href="http://www.gmail.com"&gt;&lt;img src="images/gmail.png" alt="gmail.com" /&gt;&lt;/a&gt;
	&lt;a href="http://www.java-school.net"&gt;&lt;img src="images/java-school.png" alt="java-school.net" /&gt;&lt;/a&gt;</strong>
&lt;/div&gt;
</pre>

/*** Just for Looks ***/ 부분은 모두 지운다.
CSS 파일에 다음을 추가한다.

<pre class="prettyprint"><strong>#extra a {
	display: block;
	margin-bottom: 20px;
	border: 1px solid #DAEAAA;
}

#extra a:hover {
	border: 1px solid red;
}</strong>
</pre>

#extra의 높이가 #content보다 크기 때문에 #content에 적용된 테두리가 #footer까지 내려오지 않는다.<br />
해결책으로 #content의 style 속성에 min-height: 800px;를 설정한다.

<pre class="prettyprint">&lt;div id="container"&gt;
	&lt;div id="content" style="<strong>min-height: 800px;</strong>"&gt;        
</pre>

[결과 화면]<br />
<img alt="게시판 글쓰기 최종본 디자인 결과" src="https://lh3.googleusercontent.com/-LYICsBjoLZE/VYTPjz8pfYI/AAAAAAAAChI/rLeeDwyFIqY/s640/bbs-write-form-result2.png" />

<h3>회원가입 폼 디자인</h3>

write_form.html 파일을 에디터에서 다른 이름으로 저장하기 메뉴를 이용하여 signUp.html 파일을 만든다.<br />
signUp.html에서 #content안 코드를 아래 코드로 바꾼다.

<pre class="prettyprint"><strong>&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;회원 가입&lt;/h1&gt;
&lt;form id="signUpForm" action="signUp_proc.jsp" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td style="width: 200px;"&gt;이름(Full Name)&lt;/td&gt;
	&lt;td style="width: 390px;"&gt;&lt;input type="text" name="name" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;비밀번호(Password)&lt;/td&gt;
	&lt;td&gt;&lt;input type="password" name="passwd" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2" style="text-align: center;font-weight: bold;"&gt;
	Email이 아이디로 쓰이므로 비밀번호는 Email 계정 비밀번호와 같게 하지 마세요.
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;비밀번호 확인(Confirm)&lt;/td&gt;
	&lt;td&gt;&lt;input type="password" name="confirm" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;Email&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="email" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;이동전화(Mobile)&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="mobile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;

&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
	&lt;input type="submit" value="확인" /&gt;
&lt;/div&gt;
&lt;/form&gt;</strong>
</pre>

[결과 화면]<br />
<img alt="회원 가입 페이지 디자인" src="https://lh3.googleusercontent.com/-RcvH5ExyJWo/VYTPjtXwWSI/AAAAAAAAChE/L_DSJPgOYR4/s640/signUpForm.png" /><br />
지금까지 게시판 디자인을 작업했다.<br />
다음 장 'JSP 프로젝트'는 여기서 만든 최종 디자인을 가지고 진행한다.