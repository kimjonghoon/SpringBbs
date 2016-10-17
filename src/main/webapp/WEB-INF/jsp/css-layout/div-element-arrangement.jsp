<div id="last-modified">Last Modified : 2014.7.31</div>
<h1>주요 엘리먼트 배치</h1>

<p style="margin: 17px; font-weight: bold; font-size: 15px;">
이번에 소개할 글은 CSS 포지셔닝에 관한 내용이다. 
CSS 포지셔닝이란 CSS 를 이용하여 웹페이지 화면를 배치하는 기법을 말한다.
먼저 HTML 과 CSS 에 대한 이해가 바탕이 되어야 한다.
</p>
CSS로 화면구성을 할 때 중요하게 쓰이는 CSS 속성은 float 과 margin 이다.<br />
여기서 소개하는 방법에서 특별한 점이 있다면 margin 값에 음수를 쓴다는 데 있다.<br />
이제부터 margin 에 음수값으로 두는 것을 <strong>음수 마진</strong>이라 하겠다.<br />
음수 마진은 화면구성를 위해 필요한 엘리먼트의 수를 최소화 할 수 있다.<br />  
표준을 따른다고 하더라도 브라우저마다 다르게 보일 수 있기 때문에 결과물을 파이어폭스, 구글 크롬, 
인터넷 익스플로러 등 대표적인 웹브라우저에서 테스트를 하면서 진행하도록 한다.<br />
먼저 다음 기본 사항을 이해한다.<br />
 
<h2>float 과 음수 마진 기법 정리</h2>

<h3>float 이 적용된 엘리먼트 다음에 나오는 엘리먼트의 행동</h3>
float 이 적용된 엘리먼트 다음에 나오는 정상적인 엘리먼트는 float 이 적용된 엘리먼트의 존재를 인식하지 못하고
자신의 상자 영역을 확보한다.<br />
하지만 float 이 적용된 엘리먼트의 영역은 침범하지 않는다.<br />

<pre class="prettyprint">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		background-color: #66f;
	}
	#B {
		background-color: #ddd;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-GBiNZVxG4K0/VYIyh1EqcJI/AAAAAAAACXc/uGg9ENEr320/s789/A-float%25253Aleft-B.png" alt="A float:left" /><br />

<h3 style="clear: both;">clear 프로퍼티</h3>
clear 프로퍼티의 값은 left, right, both 가 있다.<br />
정확한 의미는 예제로 확인한다.<br />

<em class="filename">A에 float: left, B에 float: right 프로퍼티가 적용된 경우</em>
<pre class="prettyprint">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		background-color: #66f;
	}
	#B {
		float: right;
		width: 100px;
		background-color: #ddd;
	}
	#C {
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-JwgR1omC9cM/VYIykC0huYI/AAAAAAAACYQ/4FgkuPnTW00/s789/a-float-left-b-float-right.png" alt="A float:left,B float:right" /><br />


<em class="filename" style="clear: both;">C에 clear: left;</em>
<pre class="prettyprint">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		background-color: #66f;
	}
	#B {
		float: right;
		width: 100px;
		background-color: #ddd;
	}
	#C {
		<strong>clear: left;</strong>
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-El9vX54a-po/VYIyjeyMSkI/AAAAAAAACX4/5wuSIN7BFRM/s789/a-float-left-b-float-right-c-clear-left.png" alt="A float:left,B float:right,C clear:left" /><br />


<em class="filename" style="clear: both;">clear: right;</em>
<pre class="prettyprint">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		background-color: #66f;
	}
	#B {
		float: right;
		width: 100px;
		background-color: #ddd;
	}
	#C {
		<strong>clear: right;</strong>
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-3dIp3C9coOM/VYIykEsPWWI/AAAAAAAACYM/ObzhAYQ7yns/s789/a-float-left-b-float-right-c-clear-right.png" alt="A float:left,B float:right,C clear:right" /><br />


<em class="filename" style="clear: both;">clear: both;</em>
<pre class="prettyprint">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		background-color: #66f;
	}
	#B {
		float: right;
		width: 100px;
		background-color: #ddd;
	}
	#C {
		<strong>clear: both;</strong>
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-TVJbd4acXvE/VYIyjCCYaPI/AAAAAAAACXw/n_JPIsP5oJI/s790/a-float-left-b-float-right-c-clear-both.png" alt="A float:left,B float:right,C clear:both" /><br />


<h3 style="clear: both;">음수마진</h3>

<em class="filename">음수마진 적용전</em>
<pre class="prettyprint">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		background-color: #ddd;
	}
&lt;/style&gt;
</pre>

<div style="margin: 0 auto;width: 268px;border-left: 4px red dotted;border-right: 4px red dotted;">
<img src="https://lh3.googleusercontent.com/-cewqRIDShsE/VYIyhgdKhKI/AAAAAAAACXI/OfaLfR_ODc8/s268/A-B.png" alt="A float:left,B float:left" /><br />
</div>

<h4  style="clear: both;">A 왼쪽에 음수 마진 적용</h4>
A의 margin-left 에 음수값을 적용하면 그 값만큼 A가 왼쪽으로 움직인다.<br />
이때 B도 따라 움직인다.<br />

<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		<strong>margin-left: -50px;</strong>
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		background-color: #ddd;
	}
&lt;/style&gt;
</pre>

<!-- 왼쪽으로 50px -->
<div style="margin: 0 auto;width: 265px;height: 100px;border-left: 4px red dotted;border-right: 4px red dotted;">
<img src="https://lh3.googleusercontent.com/-xn-gY2INVBI/VYIyieX75lI/AAAAAAAACXY/mBZY8t0e6UM/s265/A-margin-left%25253A-50px-B.png" alt="A float:left;margin-left: -50px;,B float:left" style="display: block;float: left;margin-left: -50px;opacity: 0.6;"/><br />
</div>

<h4 style="clear: both;">A 오른쪽에 음수 마진 적용</h4>
A의 margin-right 에 음수값을 적용하면 그 값만큼 B를 끌어당긴다.<br />
이때 B의 컨텐츠가 위로 해서 겹친다.<br />

<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100px;
		<strong>margin-right: -50px;</strong>
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		background-color: #ddd;
	}
&lt;/style&gt;
</pre>

<div style="margin: 0 auto;width: 265px;border-left: 4px red dotted;border-right: 4px red dotted">
<img src="https://lh3.googleusercontent.com/-LsOwnQ044vM/VYIyjOiq3hI/AAAAAAAACX0/NQ6jLC2BR6E/s202/A-margin-right%25253A-50px-B.png" alt="A float:left;margin-right: -50px;,B float:left" /><br />
</div>

<h3 style="clear: both">포지셔닝 연습</h3>
A,B,C 모두는 float: left;이다. 음수 마진이 적용되지 않는 한 서로간의 영역을 침범하지 않는다.<br />

<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		<strong>float: left;</strong>
		width: 100px;
		background-color: #66f;
	}
	#B {
		<strong>float: left;</strong>
		width: 100px;
		background-color: #ddd;
	}
	#C {
		<strong>float: left;</strong>
		width: 100px;
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-7uanSRHPQHI/VYIyhnbJZkI/AAAAAAAACXg/-Pwjw7wtUhs/s399/A-B-C-all-float-left.png" alt="A float:left;B float:left,C float:left" /><br />




<em class="filename" style="clear: both;">A에 width: 100%; 적용</em>
<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		<strong>width: 100%;</strong>
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		background-color: #ddd;
	}
	#C {
		float: left;
		width: 100px;
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-yPcb_VPnrSg/VYIyhGdkjRI/AAAAAAAACW4/6d-fBbwojl8/s790/A-100%252525width-B-C-all-float-left.png" alt="A float:left;width:100%,B float:left,C float:left" /><br />


<p style="clear: both;">
A아래 B와 C가 있는 듯 하지만 A,B,C는 나란히 있다고 봐야 한다.<br />
</p>

<em class="filename">A에 margin-right: -100%; 적용</em>
<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100%;
		<strong>margin-right: -100%;</strong>
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		background-color: #ddd;
	}
	#C {
		float: left;
		width: 100px;
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-T6ZyBKMa2ps/VYIyhGLHKXI/AAAAAAAACXE/lsK4ae5g58I/s790/A-100%252525width%25253Bmargin-right%25253A%252520-100%252525-B-C-all-float-left.png" alt="A float:left;width:100%;margin-right:-100%;,B float:left,C float:left" /><br />


<p style="clear: both;">
A의 width 가 100% 이고, 여기에 margin-right: -100% 추가하면 B, C는 A의 왼쪽에 겹치게 된다.<br />
</p>



<em class="filename">A의 margin-right: -100%; 삭제하고, B에 margin-left: -100%; 추가</em>
<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100%;
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		<strong>margin-left: -100%;</strong>
		background-color: #ddd;
	}
	#C {
		float: left;
		width: 100px;
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-0tUdI0oI3yc/VYJKqoLCR1I/AAAAAAAACYg/FXINmUkV720/s790/A-B%25253Amargin-left%25253A-100%252525-C-all-float%25253Aleft.png" alt="A float:left;width:100%;margin-right:-100%;,B float:left,C float:left" /><br />


<p style="clear: both">
A의 margin-right: -100%; 를 지우고 B에 margin-left: -100%;를 준다.<br />
그러면 B는 A의 왼쪽에 겹치고 C는 원래 B자리로 이동한다.<br />
</p>


<em class="filename">C에 margin-left: -100px; 적용</em>
<pre class="prettyprint" style="clear: both;">
&lt;style type="text/css"&gt;
	#A {
		float: left;
		width: 100%;
		background-color: #66f;
	}
	#B {
		float: left;
		width: 100px;
		margin-left: -100%;	
		background-color: #ddd;
	}
	#C {
		float: left;
		width: 100px;
		<strong>margin-left: -100px;</strong>
		background-color: #f66;
	}
&lt;/style&gt;
</pre>

<img src="https://lh3.googleusercontent.com/-FkqZtWbtXxA/VYIykWeB9uI/AAAAAAAACYI/oH68R5L31og/s789/a-float-left.png" alt="A float:left;width:100%;margin-right:-100%;,B float:left,C float:left" /><br />


<p style="clear: both;">
원래 C의 넓이만큼 C에 margin-left: -100px; 를 주면 C는 A의 오른쪽에 겹쳐 위치하게 된다.<br />
위를 이해했다면 CSS를 사용하여 웹사이트의 화면을 완성해 보자.<br />
</p>

<h3>고정크기를 가지는 3열(Column) 레이아웃</h3>
실습할 레이아웃은 고정넓이를 가진 3열로 된 것을 선택했다.<br />
실습 화면은 header, man-menu, sidebar, content, extra, footer 로 구성된다.<br />
<ul>
	<li><strong>header</strong><br />가장 위에 있으며 대부분 회사 로고 이미지가 위치한다. </li>
	<li><strong>main-menu</strong><br />header 바로 밑에서 메인 메뉴를 보이는 부분이다.</li>
	<li><strong>sidebar</strong><br />왼쪽에 배치할 것이고, 메인 메뉴에 대한 서브 메뉴가 위치하는 부분이다.</li>
	<li><strong>content</strong><br />중앙에 배치할 것하고, 페이지의 주요 내용을 위치하는 부분이다.</li>
	<li><strong>extra</strong><br />오른쪽에 배치할 것이고, 광고나 새로운 아이디어를 구현하는 부분이다.</li>
	<li><strong>footer</strong><br />가장 아래쪽에 있으며 Copyright, 연락처, 찾아오시는 길 등의 글로벌 메뉴를 보이는 부분이다.</li>
</ul>
주요 부분에 대한 크기를 지정한다.<br />
<h4>header</h4>
<p style="padding-left: 20px;">
넓이: 1000px<br />
높이: 48px<br />
</p>
<h4>main-menu</h4>
<p style="padding-left: 20px;">
넓이: 1000px<br />
높이: 35px<br />
</p>
<h4>sidebar</h4>
<p style="padding-left: 20px;">
넓이: 175px<br />
높이: 내용에 따라 변함<br />
</p>
<h4>Content</h4>
<p style="padding-left: 20px;">
넓이: 720px<br />
높이: 내용에 따라 변함<br />
</p>
<h4>extra</h4>
<p style="padding-left: 20px;">
넓이: 205px<br />
높이: 내용에 따라 변함<br />
</p>
<h4>footer</h4>
<p style="padding-left: 20px;">
넓이: 1000px<br />
높이: 56px<br />
</p>

<h3>디폴트 HTML 문서 템플릿 작성</h3>
아래를 복사하여 사용하고 있는 에디터에 붙여넣는다.<br />

<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="<em>keywords</em>" /&gt;
&lt;meta name="Description" content="<em>description</em>" /&gt;
&lt;title&gt;<em>title</em>&lt;/title&gt;
&lt;link rel="stylesheet" href="css/screen.css" type="text/css" /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

붙여넣기 해서 작성한 파일을 index.html 이름으로 웹사이트의 최상위 디렉토리에 저장한다.<br />
이클립스를 사용한다면 DocType(Document Type)별로 제공되는 HTML 문서 템플릿을 선택하여 작성할 수 있다.
이클립스가 제공하는 디폴트 문서 템플릿이 마음에 들지 않는다면 템플릿을 수정할 수도 있다.<br />
<br />
이제 페이지의 주요 구성요소를 입력할 차례이다.<br />
index.html 파일의 body 엘리먼트 사이에 다음 내용을 붙여넣는다.<br />

<pre class="prettyprint">
&lt;div id="wrap"&gt;

	&lt;div id="header"&gt;&lt;/div&gt;
	
	&lt;div id="main-menu"&gt;&lt;/div&gt;
	
	&lt;div id="container"&gt;
		&lt;div id="content"&gt;&lt;/div&gt;
	&lt;/div&gt;
	
	&lt;div id="sidebar"&gt;&lt;/div&gt;
	
	&lt;div id="extra"&gt;&lt;/div&gt;
	
	
	&lt;div id="footer"&gt;&lt;/div&gt;
	
&lt;/div&gt;
</pre>

위에서 wrap 과 container 는 설명하지 않은 엘리먼트이다.<br />
이 엘리먼트는 견고한 포지셔닝을 위해서 필요한 여분의 엘리먼트이다.<br />
wrap 은 문서의 모든 div 를 포함한다.<br />
container 는 여기에서 설명하는 3열을 배치하는 데 필요하다.<br />
되도록이면 이런 여분의 엘리먼트는 그 수를 최소화 해야 한다.<br />
<br />
여기서 소개하는 포지셔닝의 좋은점은, HTML 문서에서 본문을 담는 content가 서브메뉴를 담는 sidebar보다 먼저 나온다는 것이다.<br />
웹페이지에서 본문이 가장 중요하고 내용도 자주 바뀌므로 먼저 나오는 것이 유지보수에 유리하다.<br />
<br />
루트 디렉토리에 css 서브 디렉토리를 만들고 아래 내용으로 screen.css 파일을 만든다.<br />

<pre class="prettyprint">
@CHARSET "UTF-8";
/*** The Essential Code ***/
html, body {
	margin: 0;
	padding: 0;
}

#wrap {
	margin: 0 auto;
	padding: 0;
	width: 1000px;
}

#header {
	width: 1000px;
	height: 48px;
}

#main-menu {
	width: 1000px;
	height: 35px;	
}

#container {
	width: 100%;
}

#content {
        
}

#sidebar {
	width: 175px;
}

#extra {
	width: 205px; 
}

#footer {
	width: 1000px;
	height: 70px;
}

/*** Just for Looks ***/
#header, #footer {
	font-size: large;
	text-align: center;
	background: #999;
}

#main-menu {
	font-size: large;
	text-align: center;
	background: #DAEAAA;
}
#content {
	font-size: large;
	text-align: center;
	background: #DDD;
	height: 100px;
}

#sidebar {
	font-size: large;
	text-align: center;
	background: #66F;
	height: 100px;
}

#extra {
	font-size: large;
	text-align: center;
	background: #F66;
	height: 100px;
}
</pre>

먼저 이 문서를 해석하기 위해 CSS 의 파일의 기본 형식부터 알아보자.<br />
CSS 문서의 내용은 다음과 같은 형식의 반복이다.<br />

<pre class="prettyprint">
selector {
	Property: value;
	속성: 속성값;
	..
	.
}
</pre>

selector 종류에는 Type, Descendant, Class, id, Child, attribute 가 있다.<br />
다음은 각 셀렉터의 모습이다.<br />

<pre class="prettyprint">
/* Type Selector */
body {

}
/* Descendant Selector */
ul strong {

}
/* Class Selector */
.redwine {

}
/* id Selector */
#header {

}
/* Child Selector */
body &gt; p {

}
/* attribute Selector */
input[type="text"] {

}
</pre>

CSS 파일에서 id 셀렉터(selector)를 정의할 때는 id 앞에 #을 붙인다.<br />
id는 HTML 문서에서 엘리먼트에 유일성을 부여한다.<br />
그러므로 id값은 HTML 문서에서 단 한 번만 나타나야 하는 엘리먼트에 사용한다.<br />
index.html에서 wrap, header, main-menu, container, content, sidebar, extra, footer가 
그런 엘리먼트이다. 반면, Class 셀렉터를 정의할 때는 클래스 이름앞에 .(도트)를 붙인다.<br />
Class는 id와 달리 HTML 문서에서 반복되어 나타날 수 있다.<br />

<dl class="note">
<dt><em class="path">div.redwine</em>와 <em class="path">div .redwine</em></dt>
<dd><em class="path">div.redwine</em>은 HTML 문서에서 <em class="path">&lt;div class="redwine"&gt;</em>에 적용된다.</dd>
<dd><em class="path">div .redwine</em>은 div 엘리먼트에 포함되어 있는 엘리먼트 중에서 class 속성값이 redwine인 엘리먼트에 적용된다.</dd>
</dl>

지금까지 작성한 페이지를 웹브라우저로 확인한다.<br />
웹서버가 동작하지 않아도 된다. 탐색기에서 작성한 index.html 를 더블클릭하여 화면이 아래와 같이 보이는지 테스트한다.<br />

<img src="https://lh3.googleusercontent.com/-J1syyOdw8e4/VYJLYt-srsI/AAAAAAAACYw/VZKOnWiMXis/s589/layout1-1.png" alt="예제보기 1" /><br />

<h3>screen.css 설명</h3>
아직까지 완성 전 코드이지만 지금까지의 CSS 파일의 내용을 살펴보자.<br />
screen.css 파일이 완성되면 화면 구성도 완성된다.<br />
HTML 문서의 내용은 바뀌지 않는다.<br />

<h4>html, body</h4>
<pre class="prettyprint">
html, body {
	margin: 0;
	padding: 0;
}
</pre>

위 설정은 html 과 body 엘리먼트 모두에 적용된다.<br />
div 와는 달리 html 과 body 엘리먼트는 거의 모든 웹브라우저에서 디폴트 마진과 패딩을 가지고 있다.<br />
정밀하게 설정된 화면은 이 값 때문에 화면이 깨질 수 있다.<br />
그래서 대부분의 웹디자이너는 html 과 body 의 마진과 패딩을 0으로 설정한 후 디자인을 시작한다.<br />

<h4>#wrap</h4>

<pre class="prettyprint">
#wrap {
	margin: 0 <strong>auto</strong>;
	padding: 0;
	width: 1000px;
}
</pre>

margin에는 4개의 값이 있어야 한다.<br />
만약 값이 하나만 있다면 top right bottom left에 모두 그 값으로 설정된다.<br />
값이 2개이면 첫번째 값이 top과 bottom에 대한 값이고 두번째 값이 right와 left에 대한 값이다.<br />
값이 3개라면 순서대로 top right bottom에 대한 값이며 left는 right와 같게 설정된다.<br />
값이 4개라면 순서대로 top right bottom left에 대한 값이다.<br />
<br />
margin 프로퍼티의 두번째 값 auto는 해당 엘리먼트를 중앙에 위치시킨다.<br />
margin: 0 auto;에서 두 번째 값이 auto이므로 wrap는 좌우를 기준으로 중앙으로 이동한다.<br />
속성값 0에는 단위를 생략한다.<br />
div 엘리먼트의 디폴트 margin과 padding 값은 0이다.<br />
wrap은 HTML 문서내의 모든 엘리먼트를 담아야 하니 1000px 안에 모든 화면을 넣어야 한다.<br />
<br />
CSS 파일에서 /*** Essential Code ***/ 부분이 중요하다.<br />
/*** Just for Looks ***/ 부분은 예제를 브라우저로 확인할 때 보기 좋으라고 설정한 것으로, 프로젝트가 진행되면서 없어질 부분이다.<br />

<h4>#container</h4>
<pre class="prettyprint">
#container {
	width: 100%;
}
</pre>

container의 width가 100%로 설정되어 있다.<br />
100%라 함은 container의 콛텐츠가 들어갈 수 있는 최대 넓이이다.<br />
container의 마진과 패딩이 0이고 border 역시 설정되어 있지 않기 때문에
100%는 여기서 wrap과 같은 1000px이다.<br />

<h3>#content을 중앙에 배치</h3>
content의 margin을 다음과 같이 조정한다.<br />

<pre class="prettyprint">
#content {
	margin-left: 175px;
	margin-right: 205px;
}
</pre>

<img src="https://lh3.googleusercontent.com/-mGtrEX57RsY/VYJLYh9gRtI/AAAAAAAACY8/CPd84NhVDf8/s589/layout1-2.png" alt="예제보기 2" /><br />

<h3>#container, #sidebar, #extra에 float: left;</h3>
#content 왼쪽에 #sidebar를, #content 오른쪽에 #extra가 있도록 할 것이다.<br />
CSS 파일을 아래와 같이 고친다.<br />

<pre class="prettyprint">
#container {
	<strong>float: left;</strong>
	width: 100%;
}

#content {
	margin-left: 175px;
	margin-right: 205px;
}

#sidebar {
	<strong>float: left;</strong>
	width: 175px;
}

#extra {
	<strong>float: left;</strong>
	width: 205px; 
}

#footer {
	<strong>clear: both;</strong>
	width: 1000px;
	height: 70px;
}
</pre>

#content를 감싸고 있는 #container에 float 속성을 적용한다.<br />
#container 다음부터 나오는 엘리먼트인 #sidebar, #extra도 역시 float 속성을 적용한다.<br />
#container, #sidebar, #extra 모두 float을 설정했기에 정상적인 흐름 안의 상자처럼 위아래에 있는 것이 아니라 옆으로 인접해 있다고 봐야 한다.<br />
#footer는 clear 프로퍼티를 both로 설정해서 #footer의 위치를 가장 아래에 있도록 한다.<br />

<img src="https://lh3.googleusercontent.com/-syLJrBmGbgc/VYJLYo3K1WI/AAAAAAAACY4/bAtsd53F5tI/s589/layout1-3.png" alt="예제보기 3" /><br />


<h3>#content 왼쪽에 #sidebar 배치</h3>

<pre class="prettyprint">
#sidebar {
	float: left;
	width: 175px;
	<strong>margin-left: -1000px;</strong>
}
</pre>

<img src="https://lh3.googleusercontent.com/-TpKsK3zej5s/VYJLZBRs4aI/AAAAAAAACZE/hEIMU9tlzHk/s589/layout1-4.png" alt="예제보기 4" /><br />


<h3>#content 오른쪽에 #extra 배치</h3>
#extra가 #content의 오른쪽으로 위치하도록 음수 마진을 설정한다.

<pre class="prettyprint">
#extra {
	float: left;
	width: 205px;
	<strong>margin-left: -205px;</strong> 
}
</pre>

<img src="https://lh3.googleusercontent.com/-v3NIkfyD2p8/VYJLZoi5SyI/AAAAAAAACZI/3z3taDI5YhY/s589/layout1-5.png" alt="예제보기 5" /><br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.html.net/tutorials/css/">http://www.html.net/tutorials/css/</a></li>
	<li><a href="http://www.subcide.com/articles/creating-a-css-layout-from-scratch/P1/">http://www.subcide.com/articles/creating-a-css-layout-from-scratch/P1/</a></li>
	<li><a href="http://www.alistapart.com/articles/holygrail/">http://www.alistapart.com/articles/holygrail/</a></li>
	<li><a href="http://coding.smashingmagazine.com/2009/07/27/the-definitive-guide-to-using-negative-margins/">http://coding.smashingmagazine.com/2009/07/27/the-definitive-guide-to-using-negative-margins/</a></li>
	<li><a href="http://www.w3.org/QA/2002/04/valid-dtd-list.html">http://www.w3.org/QA/2002/04/valid-dtd-list.html</a></li>
	<li><a href="http://www.ibm.com/developerworks/kr/library/wa-css/">http://www.ibm.com/developerworks/kr/library/wa-css/</a></li>
	<li><a href="http://www.maxdesign.com.au/articles/css-layouts/">http://www.maxdesign.com.au/articles/css-layouts/</a></li>
</ul>

