<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>	
<div id="last-modified">Last Modified : 2016.3.13</div>
			
<h1>JSP</h1>

<h3>목차</h3>
<ol>
	<li><a href="#JSP">JSP란?</a></li>
	<li><a href="#Directives">지시어(Directives)</a>
		<ol>
			<li><a href="#page_Directives">page 지시어</a></li>
			<li><a href="#include_Directives">include 지시어</a></li>
			<li><a href="#taglib_Directives">taglib 지시어</a></li>
		</ol>
	</li>
	<li><a href="#Scripting">스트립팅(Scripting)</a>
		<ol>
			<li><a href="#Declarations">선언(Declarations)</a></li>
			<li><a href="#Expressions">표현식(Expressions)</a></li>
			<li><a href="#Scriptlets">스크립트렛(Scriptlets)</a></li>
		</ol>
	</li>
	<li><a href="#Actions">액션(Actions)</a>
		<ol>
			<li><a href="#useBean">jsp:useBean</a></li>
			<li><a href="#setProperty">jsp:setProperty</a></li>
			<li><a href="#getProperty">jsp:getProperty</a></li>
			<li><a href="#param">jsp:param</a></li>
			<li><a href="#include">jsp:include</a></li>
			<li><a href="#forward">jsp:forward</a></li>
			<!-- <li><a href="#plugin">jsp:plugin</a></li>-->
		</ol>
	</li>
	<li><a href="#Implicit_Objects">내재 객체(Implicit Objects)</a>
		<ol>
			<li><a href="#out">out</a></li>
			<li><a href="#request">request</a></li>
			<li><a href="#response">response</a></li>
			<li><a href="#pageContext">pageContext</a></li>
			<li><a href="#session">session</a></li>
			<li><a href="#application">application</a></li>
			<li><a href="#config">config</a></li>
			<li><a href="#page">page</a></li>
			<li><a href="#exception">exception</a></li>
		</ol>
	</li>
	<li><a href="#JSP_Confirm">JSP 문법에서 꼭 확인해야 할 사항들</a>
		<ol>
			<li><a href="#include_vs_include">include지시어와 include표준 액션의 차이점</a></li>
			<li><a href="#ServletContext_Web-App">서블릿컨텍스트와 웹 애플리케이션의 관계</a></li>
			<li><a href="#pageDirectives_session-attr">page지시자의 session속성의 의미</a></li>
			<li><a href="#useBean_scope">jsp:useBean 표준 액션의 scope속성의 의미</a></li>
		</ol>
	</li>
	<li><a href="#examples">JSP 예제</a>
		<ol>
			<li><a href="#error-handling-1">JSP 에러 핸들링 예전 방식</a></li>
			<li><a href="#error-handling-2">JSP 에러 핸들링 현재 방식</a></li>
			<li><a href="#cookie-example">쿠키</a></li>
			<li><a href="#include-directive-example">include 지시어를 이용하는 페이지 분리</a></li>
			<li><a href="#login-process">자바 빈즈를 이용한 로그인 처리(세션 이용)</a></li>
			<li><a href="#login-process-2">"자바 빈즈를 이용한 로그인 처리(세션 이용)" 을 표준 액션을 사용하도록 수정</a></li>
			<li><a href="#fileList-example">업로드 파일 확인</a></li>
			<li><a href="#download-example">파일 다운로드</a></li>
			<li><a href="#jsp-file-upload">JSP 파일 업로드</a></li>
		</ol>
	</li>
</ol>

<h2 id="JSP">1. JSP란?</h2>
<strong>아래 나오는 모든 예제는 ROOT 애플리케이션에 작성한다.<br />
<a href="Web-Application-Directory-Structure">웹 애플리케이션 작성 실습</a>에서
DocuementBase 가 C:/www/myapp 인 애플리케이션을 ROOT 애플리케이션으로 변경했었다.<br />
JSP는 C:/www/myapp 아래에, 자바는 C:/www/myapp/WEB-INF/src 아래 자바 팩키지 이름의 서브디렉토리에 생성한다. 
이클립스를 사용하지 않고 일반 에디터를 사용한다.</strong><br />

JSP는 마이크로소프트의 ASP가 인기를 끌자 ASP에 대한 자바측 대응 기술로 등장했다.<br />
JSP는 서블릿 기반 기술이다.<br />
JSP는 톰캣과 같은 서블릿 엔진에 의해 서블릿<sup>1</sup>으로 변환 후에 서비스된다.<br />
서블릿은 동적으로 HTML 페이지를 만들어주는 기술이지만 자바 코드와 HTML 코드의 분리에 어려움이 있었다.<br />
서블릿은 HTML디자인을 자바 문자열로 만들어서 출력스트림의 메소드에 인자로 전달해야만 한다.<br />
이것은 자바코드에 HTML디자인이 삽입된다는 의미이다.<br />
이와 반대로 JSP는 HTML디자인에 자바 코드가 삽입된다.<br />
이로서 JSP는 서블릿의 가지고 있는 디자인과 코드의 분리의 어려움을 어느정도 개선했다고 할 수 있다.<sup>2</sup><br />
JSP는 복잡한 디자인을 가진 동적으로 만들어지는 HTML을 사용자에게 보여줘야 할 때 유용한 기술이다.<br />

<em class="filename">/hello.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;body&gt;
Hello World!
&lt;/body&gt;
&lt;/html&gt;
</pre>

클라이언트가 웹브라우저를 통해 hello.jsp를 요청한다.<br />
만일 이 요청이 첫번째 요청이었다면 톰캣은 hello.jsp로부터 서블릿을 만든다.<br />
hello.jsp가 ROOT애플리케이션의 최상위 디렉토리에 위치한다면<br /> 
<em class="path">{톰캣홈}\work\Catalina\localhost\_\org\apache\jsp\hello_jsp.java</em>
이 변환된 서블릿이다.<br />
톰캣은 이 서블릿을 컴파일한 후 객체를 생성하고 서블릿 객체의 서비스 메소드를 호출한다.<br />
이후 hello.jsp에 대한 요청이 들어오면 서블릿 컨테이너는 일단 hello.jsp파일이 변경되었는지를 
체크한다.<br />
hello.jsp가 변경되지 않았다면 객체가 이미 로딩되어 있는지 확인한다.<br />
만일 객체가 메모리에 있다면 객체의 서비스 메소드를 호출하고 로딩되지 않았다면 먼저 객체를 생성한다.<br />
hello.jsp가 변경되었다면 서블릿 컨테이너는 hello.jsp로부터 서블릿을 만든다.<br />

<h2 id="Directives">2. 지시어</h2>
지시어(Directives)는 JSP 페이지의 전반적인 정보를 서블릿/JSP 엔진에게 제공한다.<br />
지시어는 page, include, taglib 3개가 있다.<br />

<h3 id="page_Directives">page 지시어</h3>
용법 : &lt;%@ page {attribute="value"} %&gt;<br />
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 190px;">attribute="value"</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">language="scriptLanguage"</td>
	<td class="table-in-article-td">페이지를 컴파일할 서버측 언어가 무엇인지 기술(대부분 java)</td>
</tr>
<tr>
	<td class="table-in-article-td">import="importList"</td>
	<td class="table-in-article-td">페이지가 import 하는 자바팩키지 리스트 기술 (,로 구분)</td>
</tr>
<tr>
	<td class="table-in-article-td">session="true | false"</td>
	<td class="table-in-article-td">페이지에 세션 데이터가 이용되는지의 여부(디폴트 true)</td>
</tr>
<!-- 
<tr>
	<td>buffer="none | size in kb"</td>
	<td>출력 스트림의 버퍼크기를 결정(디폴트 8kb)</td>
</tr>
<tr>
	<td>autoFlush="true | false"</td>
	<td>출력버퍼가 자동적으로 비워지는가 또는 버퍼가 차면 익셉션을 발생할것인가 여부를 결정 (디폴트 true)</td>
</tr>
<tr>
	<td>isThreadSafe="true | false"</td>
	<td>서블릿/JSP 엔진에게 이 페이지가 일시에 다중으로 서비스할 수 있는가의 여부를 기술<br />(디폴트 true, 만약 이 값이 false로 셋팅되었다면 SingleThreadModel 로 페이지가 작동)
	</td>
</tr>
<tr>
	<td>info="text"</td>
	<td>JSP페이지에 관한 정보를 나타냅니다.<br />
	Servlet.getServletInfo() 메소드를 이용해 접근가능.
	</td>
</tr>
-->
<tr>
	<td class="table-in-article-td">errorPage="error_uri"</td>
	<td class="table-in-article-td">JSP 익셉션을 다루는 에러 페이지의 상대경로를 나타냄.</td>
</tr>
<tr>
	<td class="table-in-article-td">isErrorPage="true | false"</td>
	<td class="table-in-article-td">페이지가 에러를 핸들링하는 페이지인가의 여부를 기술(디폴트 false)</td>
</tr>
<tr>
	<td class="table-in-article-td">contentType="ctinfo"</td>
	<td class="table-in-article-td">클라이언트로 보내질 응답의 MIME 타입과 캐릭터셋 설정</td>
</tr>
<tr>
	<td class="table-in-article-td">pageEncoding="charset"</td>
	<td class="table-in-article-td">JSP파일의 캐릭터셋을 의미<br />
	contentType에서 지정한 캐릭터셋과 동일하게 지정한다.</td>
</tr>
</table>

생략하면 디폴트 값이 적용되는 속성이 많다.<br />
따라서 모든 속성을 정의해 줄 필요는 없다.<br />
page 지시어는 여러번 쓸 수 있다.<br />
contentType 속성은 단 한번만 정의할 수 있고 대부분 첫번째 나오는 페이지 지시어에서 정의한다.<br />
import 속성은 여러번 지정할 수 있다.<br />
다음 예에서 확인한다.<br />

<pre>
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.HashMap,java.util.ArrayList" %&gt;
</pre>

위에서 page 지시어를 2번 사용했다.<br />
contentType 속성과 import 속성만 주목하자.<br />
contentType 속성으로 웹브라우저가 받을 컨텐츠는 HTML문서이고 문서의 문자셋은 UTF-8이라고 설정했다.<br />
UTF-8은 현재 인터넷에서 가장 인기있는 문자셋이다.<br />
두번째 페이지 지시어는 import 속성을 정의했다.<br />
JSP안의 자바 코드에서는 java.util.HashMap과 java.util.ArrayList가 사용될 것이다.<br />
첫번째 페이지 지지어에서 import 속성을 정의할 수 있지만 그렇게 하는 것은 좋지 않다.<br /> 
위를 다음과 같이 바꿀 수 있다.<br />
 
<pre>
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.HashMap" %&gt;
&lt;%@ page import="java.util.ArrayList" %&gt;
</pre>

보기 편하다는 이유 하나로 이렇게 코딩하는 것을 권장한다.<br />

<h3 id="include_Directives">include 지시어</h3>
inlcude 지시어는 JSP 가 서블릿으로 변환시에 텍스트나 소스를 삽입하기 위해 사용한다.<br />
삽입되는 문서는 웹 애플리케이션내에 존재해야 한다.<br />
예) &lt;%@ include file="header.jsp" %&gt;<br />
include 지시어는 서블릿으로 변환할 때 한번만 사용된다.<br />
모든 JSP페이지가 결합된 후 하나의 서블릿은 변환된다.<br />


<h3 id="taglib_Directives">taglib 지시어</h3>
taglib 지시어는 JSP 페이지가 커스텀 태그 라이브러리를 이용함을 기술한다.<br />
태그 라이브러리란 서블릿으로 변환할 때 자바 코드로 바뀌는 태그를 만드는 기술이다.<br />
대부분 HTML로 구성된 JSP에서 자바코드를 피해, 디자이너에게도 친근할 수 있는 태그를 사용하는 것은
코드와 디자인 관리를 효율적으로 할 수 있는다는 이론적인 이점이 있었으나
너무 많고 다양한 태그 라이브러리가 등장한 결과 이점보다는 부작용이 부각되었다.<br />
<br />
다음은 태그 라이브러리를 사용할 때 taglib 지시어를 사용하는 방법이다.<br />
커스텀 태그 라이브러리는 각각의 커스텀 태그 집합을 구별하는 prefix 와 uri 로 유일하게 구별된다.<br />
&lt;%@ taglib <span class="emphasis">uri</span>="tagLibraryURI" <span class="emphasis">prefix</span>="tagPrefix" %&gt;<br />

<dl class="note">
<dt>태그라이브러리 지시어 속성(url, prefix)</dt>
<dd>
uri : 커스텀태그 라이브러리를 고유하게 이름짓는 URI 참조<br />
prefix : 커스텀 태그 라이브러리를 구별하는데 쓰이는 Prefix 정의<br />
</dd>
</dl>

태그 라이브러리를 만드는 방법은 다루지 않겠다.<br />
대신 JSP 스펙에 포함된 JSTL(JavaServer Pages Standard Tag Library)이라는 
태그라이브러리를 사용법은
<a href="/jsp-pjt">JSP Project</a> 에서 다룬다.<br />  


<h2 id="Scripting">스크립팅(Scripting)</h2>
스크립팅은 HTML페이지에 자바코드 조각을 삽입하기 위해 사용한다.<br />
스크립팅에는 선언(Declarations), 표현식(Expressions), 스크립트렛(Scriptlets) 3가지가 있다.

<h3 id="Declarations">선언(Declarations)</h3>
선언은 자바 변수와 메소드를 JSP 페이지내에서 선언하기 위해선 사용된다.<br />
선언은 JSP 페이지가 첫번째로 로딩될 때 초기화되고 그 후에 같은 페이지내의 다른 선언, 식, 스크립트렛에게 이용된다.<br />
선언은 서블릿으로 변환될때 변수 선언일 경우 서블릿 클래스의 인스턴스 변수로, 메소드 선언일 경우 
서블릿 클래스의 메소드로 변환된다.<br />
<em class="path">&lt;%! String name = new String("gildong"); %&gt;</em><br />
<em class="path">&lt;%! public String getName() {return name;} %&gt;</em><br />

<h3 id="Expressions">표현식(Expressions)</h3>
표현식은 컨테이너에 의해 문자열로 바뀐다.<br />
만약 표현식이 문자열로 변환되지 않는다면 ClassCastException 발생한다.<br />
Hello &lt;%=getName()%&gt;

<h3 id="Scriptlets">스크립트렛(Scriptlets)</h3>
스크립트렛에서는 자바 문장을 자유럽게 기술할 수 있다.<br />
&lt;%...%&gt; 안의 자바 코드는 서블릿으로 변환될때 _jspSevice() 메소드에 포함된다.<br />


<h2 id="Actions">액션(Actions)</h2>
액션은 객체를 변경하거나 생성하기 위해 사용된다.<br />

<h3 id="useBean">&lt;jsp:useBean&gt;</h3>
이 액션은 JSP 빈즈를 생성하거나 생성된 JSP 빈즈를 찾는다.<br />
JSP 문서내에서 &lt;jsp:useBean&gt;부분에 이르면 우선 같은 scope 와 id 를 사용하는 객체를 
찾는다.<br />
만약 객체를 찾지 못하면 주어진 scope 와 id 속성대로 해당 객체를 생성한다.<br />

<pre>
&lt;jsp:useBean id="name" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
</pre>

<strong>&lt;jsp:useBean&gt; 액션 속성</strong><br />
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">속성</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">id</td>
	<td class="table-in-article-td">주어진 scope 에서 객체 인스턴스를 식별하기 위한 키</td>
</tr>
<tr>
	<td class="table-in-article-td">scope</td>
	<td class="table-in-article-td">생성된 빈의 레퍼런스가 유효한 범위, page(기본값), request, session, application</td>
</tr>
<tr>
	<td class="table-in-article-td">class</td>
	<td class="table-in-article-td">객체의 구현을 정의하는 클래스</td>
</tr>
<tr>
	<td class="table-in-article-td">beanName</td>
	<td class="table-in-article-td">java.beans.Beans 클래스의 instantiate() 메소드의 아규먼트로 사용할 빈의 이름을 지정</td>
</tr>
<tr>
	<td class="table-in-article-td">type</td>
	<td class="table-in-article-td">해당 빈의 인스턴스를 타입 캐스팅할 때의 타입으로 class 속성에서 정의된 클래스의 수퍼 클래스 또는 인터페이스</td>
</tr>
</table>

&lt;jsp:useBean id="cart" scope="request" class="example.Cart" /&gt;<br />
이것은 다음의 scriptlet 코드와 같다.<br />

<pre class="prettyprint">
&lt;%
    example.Cart cart;
    cart = (example.Cart) request.getAttribute("cart");
    if (cart == null) {
        cart = new example.Cart();
        request.setAttribute("cart", cart);
    }
%&gt;
</pre>

<h3 id="setProperty">&lt;jsp:setProperty&gt;</h3>
이 액션은 자바빈의 속성값을 셋팅하는 데 쓰인다.

JSP 페이지내에 아래와 같은 코드가 있다면,

<pre>
&lt;jsp:useBean id="login" scope="page" class="example.User" /&gt;
&lt;jsp:setProperty name="login" property="passwd" /&gt;
</pre>

이 코드조각은 아래의 scriptlet 코드를 사용하는 것과 같다.

<pre class="prettyprint">
&lt;%
    example.User user;
    user = (example.User) pageContext.getAttribute("user");
    if (user == null) {
        user = new example.User();
        pageContext.setAttribute("user", user);
    }
    String _jspParam;
    _jspParam = request.getParameter("passwd");
    if (_jspParam != null &amp;&amp; !_jspParam.equals(""))
        user.setPasswd(_jspParam);
%&gt;
</pre>

<strong>&lt;jsp:setProperty&gt; 액션 속성</strong>
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">속성</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">name</td>
	<td class="table-in-article-td">&lt;jsp:useBean&gt;이나 다른 액션에서 정의된 빈 인스턴스의 이름</td>
</tr>
<tr>
	<td class="table-in-article-td">property</td>
	<td class="table-in-article-td">값을 변경하고자 하는 빈 속성<br />
	만약 property="*" 라면 HTTP 요청에 전달된 모든 파라미터의 이름과 동일한 이름을 가진 모든 
	setter 메소드를 호출하여 빈의 속성값을 수정한다.<br />
	이때 파라미터의 value가 공백문자("") 라면 이에 상응하는 빈의 속성은 수정되지 않는다.<br />
	</td>
</tr>
<tr>
	<td class="table-in-article-td">param</td>
	<td class="table-in-article-td">HTTP 요청의 파라미터 이름<br />이 파라미터 value 로 property 속성에 해당하는 빈의 
	속성값을 변경한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">value</td>
	<td class="table-in-article-td">value 에 정의된 문자열로 빈의 속성을 변경한다.</td>
</tr>
</table>


다음과 같이 폼이 작성되었다면,

<pre class="prettyprint">
&lt;form action="register.jsp" method="post"&gt;
    &lt;input type="text" name="id" /&gt;
    &lt;input type="password" name="passwd" /&gt;
&lt;/form&gt;
</pre>

이를 받는 JSP 페이지 register.jsp 내의 다음 액션은 

<pre>
&lt;jsp:setProperty name="user" property="*" /&gt;
</pre>

아래 스크립틀렛과 동일하다.

<pre class="prettyprint">
&lt;%
    String _jspParam;
    _jspParam = request.getParameter("passwd");
    if ( _jspParam != null &amp;&amp; !_jspParam.equals("") )
        user.setPasswd(_jspParam);
    _jspParam = request.getParameter("id");
    if ( _jspParam != null &amp;&amp; !_jspParam.equals("") )
        user.setId(_jspParam);
%&gt;
</pre>

다음과 같이 폼이 있다면,

<pre class="prettyprint">
&lt;form action="register.jsp" method="post"&gt;
    &lt;input type="text" name="member_id" /&gt;
&lt;/form&gt;
</pre>

위의 폼을 이용한 파라미터 전송시 이를 받는 JSP 페이지(register.jsp) 내의 다음 액션은 

<pre>
&lt;jsp:setProperty name="user" property="id" param="member_id" /&gt;
</pre>

아래 스크립틀렛 코드와 동일하다.

<pre class="prettyprint">
&lt;%
    String _jspParam;
    _jspParam = request.getParameter("member_id");
    if (_jspParam != null &amp;&amp; !_jspParam.equals(""))
        user.setId(_jspParam);
%&gt;
</pre>

위의 예제를 보듯이 빈의 멤버 변수명과 폼의 파라미터 명이 서로 일치하지 않을 때 param 속성을 사용한다.
다음은 setProperty 액션 예제이다. 아래 setProperty 액션은,

<pre>
&lt;jsp:setProperty name="user" property="id" value="admin" /&gt;
</pre>

다음의 스크렙틀렛 코드와 동일하다.

<pre class="prettyprint">
&lt;%
    user.setId("admin");
%&gt;
</pre>

위의 예제와 같이 setProperty 액션은 빈의 속성 값을 설정하는데 사용한다.

<h3 id="getProperty">&lt;jsp:getProperty&gt;</h3>
getProperty 액션은 빈의 속성값을 가져와서 이것을 출력 스트림에 넣는다.<br />

<pre>
&lt;jsp:getProperty name="name" property="propertyName" /&gt;
</pre>

<strong>&lt;jsp:getProperty&gt; 액션 속성</strong><br />
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">속성</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">name</td>
	<td class="table-in-article-td">빈 인스턴스의 이름</td>
</tr>
<tr>
	<td class="table-in-article-td">property</td>
	<td class="table-in-article-td">얻고자 하는 빈 인스턴스의 속성값</td>
</tr>
</table>

<h3 id="param">&lt;jsp:param&gt;</h3>
이 액션은 &lt;jsp:include&gt;, &lt;jsp:forward&gt;<!-- , &lt;jsp:plugin&gt;-->에 넘겨줄 파라미터를 정의할 때 사용한다.<br />

<pre>
&lt;jsp:param name="name" value="value" /&gt;
</pre>

<h3 id="include">&lt;jsp:include&gt;</h3>
이 액션은 JSP페이지에 정적(HTML) 또는 다이나믹 웹 컴포넌트(JSP,Servlets)를 추가할때 사용한다.<br />

<pre>
&lt;jsp:include page="urlSpec" flush="true"&gt;
&nbsp;&nbsp;&lt;jsp:param ... /&gt;
&lt;/jsp:include&gt;
</pre>

<strong>&lt;jsp:include&gt; 액션 속성</strong><br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">속성</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">page</td>
	<td class="table-in-article-td">인클루드 되는 소스의 상대경로</td>
</tr>
<tr>
	<td class="table-in-article-td">flush</td>
	<td class="table-in-article-td">버퍼가 비워지는 여부</td>
</tr>
</table>

<h3 id="forward">&lt;jsp:forward&gt;</h3>
이 액션은 클라이언트가 요청한 자원에서 다른 자원으로 프로그램의 제어를 이동할 때 사용된다.<br />
이를 포워딩이라 한다.<br /> 
&lt;jsp:forward&gt; 은 &lt;jsp:param&gt; 를 자식 엘리먼트로 가질 수 있는데, 포워딩할 대상 자원으로 파라미터를 전달하기 위해서이다.<br />
page 속성은 포워딩할 대상 자원의 상대주소이다.<br />

<pre class="prettyprint">
&lt;jsp:forward page="relativeURL"&gt;
&nbsp;&nbsp;&lt;jsp:param .../&gt;
&lt;/jsp:forward&gt;
</pre>
<!--  
자바 애플릿은 과거의 기술이 되었다.
그래서 이 액션 태그 역시 많이 쓰이지 않은 기능이므로 생략한다. 2016.03.13
<h3 id="plugin">&lt;jsp:plugin&gt;</h3>
&lt;jsp:plugin&gt; 은 다운로드나 애플릿,자바빈의 실행을 일으키는 HTML 코드를 생성하는데 사용된다.<br />
이 액션은 한번 해석되어 &lt;object&gt; 나 &lt;embed&gt;로 바뀐다.<br />
속성은 바뀌는 코드에 표현을 위한 설정데이터로 제공된다.<br />

<pre class="prettyprint">
&lt;jsp:plugin type="pluginType" code="classFile" codebase="relativeURL"&gt;
   &lt;jsp:params&gt;..
   &lt;/jsp:params&gt;
&lt;/jsp:plugin&gt;
</pre>

<strong>&lt;jsp:plugin&gt;의 속성</strong><br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 70px;">속성</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">type</td>
	<td class="table-in-article-td">인클루드할 플러그인 타입 예를 들면 applet</td>
</tr>
<tr>
	<td class="table-in-article-td">code</td>
	<td class="table-in-article-td">플러그인이 실행할 클래스의 이름</td>
</tr>
<tr>
	<td class="table-in-article-td">codebase</td>
	<td class="table-in-article-td">클래스의 절대 또는 상대경로</td>
</tr>
</table>
-->

<h2 id="Implicit_Objects">내재 객체(Implicit Objects)</h2>
내재 객체는 JSP 문서내에서 이용되는 객체로 레퍼런스를 얻기 위한 작업없이 바로 
사용할 수 있는 객체를 말한다.

<h3 id="out">out</h3>
javax.servlet.jsp.JspWriter 추상 클래스 타입 인스턴스의 레퍼런스이다.<br />
데이터를 응답 스트림으로 작성하는데 사용한다.<br />
아래와 같이 작성한 후 http://localhost:8989/helloWorld.jsp를 방문한다.

<em class="filename">/helloWorld.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;body&gt;
&lt;%
out.println("&lt;strong&gt;Hello World!&lt;/strong&gt;");
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="request">request</h3>
javax.servlet.http.HttpServletRequest 인터페이스 타입 인스턴스의 레퍼런스이다.<br />
요청 파라미터와 헤더에 있는 사용자가 보낸 정보, 그리고 사용자에 관한 정보에 접근할 수 있다.<br />
아래와 같이 작성하고 http://localhost:8989/request.jsp?user=gildong를 방문한다.

<em class="filename">/request.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;head&gt;
  &lt;title&gt;request&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
out.println("Hello, " + request.getParameter("user"));
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="response">response</h3>
javax.servlet.http.HttpServletResponse 인터페이스 타입 인스턴스의 레퍼런스이다.<br />

<h3 id="pageContext">pageContext</h3>
javax.servlet.jsp.PageContext 타입 인스턴스의 레퍼런스이다.<br />
JSP 내에서 이용 가능한 모든 자원에 대한 접근 방법을 제공해 준다.<br />
이를 이용하면 ServletRequest, ServletResponse, ServletContext, HttpSession, ServletConfig 와 같은 자원에 접근할 수 있다.<br />

<h3 id="session">session</h3>
session 내재 객체는 서블릿의 javax.servlet.http.HttpSession 타입 인스턴스의 레퍼런스이다.<br />
세션 데이타를 읽고 저장하는 데 사용된다.<br />
아래를 작성한 후 http://localhost:8989/session.jsp를 여러번 방문한다.<br />

<em class="filename">/session.jsp</em>
<pre class="prettyprint">
&lt;html&gt;
&lt;head&gt;
  &lt;title&gt;session&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
Integer count = (Integer)session.getAttribute("count");
  
if (count == null) {
	count = new Integer(1);
	session.setAttribute("count", count);
} else {
	count = new Integer(count.intValue() + 1);
	session.setAttribute("count", count);
}

out.println("COUNT: " + count); 
%&gt; 
&lt;/body&gt;
&lt;/html&gt;
</pre>


<h3 id="application">application</h3>
javax.servlet.ServletContext 인터페이스 타입 인스턴스의 레퍼런스이다.<br />

<h3 id="config">config</h3>
config 내재 객체는 ServletConfig 이다.<br />
ServletConfig 는 서블릿 각각의 초기화 파라미터 정보를 담고 있다.<br />

<h3 id="page">page</h3>
page 내재 객체는 페이지 구현 클래스 인스턴스를 참조하는 Object 타입의 레퍼런스이다.<br />
page변수는 단순히 JSP와 구현 서블릿 사이의 연결 역할을 한다고 하는데, 쓰임새가 많지 않다.<br />
JSP 코드에서 page 라는 변수를 사용하지 못하는 이유이다.<br />

<h3 id="exception">exception</h3>
exception 내재 객체는 JSP 페이지에서 발생한 잡히지 않은 익셉션에 대한 접근을 제공한다.<br />
JSP 페이지 내에서 exception 변수는 page 지시어의 isErrorPage 속성이 true 로 설정한 
페이지내에서만 사용할 수 있다.<br />


<h2 id="JSP_Confirm">JSP에서 꼭 확인해야 할 사항들</h2>
<h3 id="include_vs_include">include 지시어와 include 표준 액션의 차이점</h3>
지시어는 서블릿으로 변환될 때 단 한번 해석되지만 표준액션의 경우는 요청시마다 매번 해석된다.<br />
그러므로 포함되는 페이지의 내용이 요청시마다 변하지 않고 일정할 때는 include 지시어를, 
포함되는 페이지의 내용이 요청시마다 변한다면 include 표준 액션을 사용하는 것이 좋을 것이다.
include 지시어는 포함하는 JSP를 중심으로 하나의 서블릿으로 변환되고,
include 표준 액션은 각각의 서블릿이 동작하여 하나의 응답을 만들어낸다.<br />

<h3 id="ServletContext_Web-App">서블릿 컨텍스트와 웹 애플리케이션의 관계</h3>
서블릿 컨텍스트에는 웹 애플리케이션의 서버측 컴포넌트와 서블릿 컨테이너와의 통신을 담당하는 메소드가 있다.<br />
서블릿 스펙에 의해 모든 웹 애플리케이션마다 단 하나의 서블릿컨텍스트가 있다.<br />
그래서 서블릿 컨텍스트는 JSP 와 서블릿과 같은 서버측 컴포넌트의 공동 저장소의 기능을 가진다.<br />
서블릿 컨텍스트에 저장된 자원은 웹 애플리케이션의 일생동안 존재한다.<br />

<h3 id="pageDirectives_session-attr">page 지시어의 session 속성</h3>
&lt;%@ page session="false"&gt; 와 같이 page 지시어의 session 속성이 false라면 
해당 페이지가 session 객체를 생성하지도 못하고 
또한 기존의 session 객체에 대한 레퍼런스도 얻을 수도 없다.<br />
false 로 되어 있는 상태에서 session 객체에 접근하고자 하면 에러가 발생한다.<br />

<h3 id="useBean_scope">jsp:useBean표준 액션의 scope속성의 의미</h3>
scope 속성은 jsp:useBean 속성 중에서 가장 중요한 부분이다.<br />
이 속성은 자바 빈즈를 객체화시킨 후 어느 범위까지 사용을 할 것인지를 결정한다.<br />
scope 속성을 어떻게 지정했는가에 따라서 빈 객체는 여러 페이지에서 소멸하지 않고 참조되기고
한다.<br />
예를 들어 scope 속성이 session 으로 설정되었다면 이 빈 객체는 세션이 종료할 때까지 소멸되지
않고 유지된다.<br />
생성된 빈 객체는 이후 어떤 페이지에서도 참조될 수 없을 때 자동으로 소멸된다.<br />
scope의 기본 값은 page이다.<br />
scope 속성에는 4개의 값을 지정해 줄 수 있는데 각각의 값에 대해서 정리하면 다음과 같다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">scope</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">page</td>
	<td class="table-in-article-td">
	scope속성의 기본 값이므로 특별히 지정하지 않으면 이 옵션이 적용된다.<br />
	page영역으로 생성된 객체는 요청된 페이지 내에서만 유효하다.<br />
	같은 페이지를 요청해도 새로운 빈 객체가 생성된다.<br />
	페이지의 실행 종료와 함께 빈 객체는 소멸된다.<br />
	page 영역은 한 페이지에서만 유효하므로 &lt;jsp:include&gt; 표준 액션으로 
	포함된 페이지에서나 &lt;jsp:forward&gt; 표준 액션으로 
	제어권이 이동한 페이지내에서 &lt;jsp:useBean&gt; 표준 액션 코드가 있다면 이 코드는 
	이미 만들어진 빈 객체를 참조하는 것이 아니라 새로운 객체를 생성한다.
	&lt;jsp:include&gt; 표준 액션으로 포함되는 페이지에서 생성한 빈 객체는 포함하는 
	페이지에서는 참조할 수 없다.<br />
	page 영역의 빈 객체는 빈 객체의 상태가 유지될 필요가 없을 때 적합하다.<br />
	</td>
</tr>
<tr>
	<td class="table-in-article-td">request</td>
	<td class="table-in-article-td">
	이 값으로 범위를 지정하면 현재의 JSP 페이지와 연결되어 있는 모든 JSP 페이지까지 영향을 	미친다.<br />
	즉, &lt;jsp:forward&gt;, &lt;jsp:include&gt; 표준 액션으로 연결되어 있는 JSP 페이지에서도 오리지날 페이지에서 생성한 빈을 참조할 수 있게 된다.<br />
	scope 이 request 로 생성된 빈은 HttpServletRequest 객체에 저장되기 때문이다.<br />
	</td>
</tr>
<tr>
	<td class="table-in-article-td">session</td>
	<td class="table-in-article-td">
	이 값으로 범위를 지정해 놓으면 세션에 유효할 때까지 자바 빈즈의 객체가 유효하다.<br />
	즉, 세션이 유지되는 동안 같은 세션에서 호출되는 모든 페이지에서 빈 객체는 소멸되지 않고 	유지된다.<br />
	이는 session 영역의 빈은 생성 후 session 객체(HttpSession)에 저장되기 때문이다.<br />
	반면, page 영역이나  request 영역으로 생성된 빈은 브라우저의 요청에 대한 응답을 돌려준 다음에는 소멸된다.<br />
	각 사용자에 대하여 독립적으로 생성되는 session 객체는 세션이 종료될 때까지 모든 서버측 컴포넌트에서 참조할 수 있는 값을 유지할 수 있게 해준다.<br />
	한가지 주의할 점은 page 지시어에서 session 속성을 false 로 설정했을 경우에는 session 객체에 저장한 빈 객체를 사용할 수 없다.<br />
	</td>
</tr>
<tr>
	<td class="table-in-article-td">application</td>
	<td class="table-in-article-td">
	scope 이 application 으로 지정하면 해당 빈은 웹 애플리케이션이 언로드될까지 소멸되지 않는다.<br />
	application 영역으로 생성된 빈은 application 내재 객체, 즉 ServletContext 에 저장되기 때문이다.<br />
	따라서 서블릿 컨텍스트를 접근할 수 있는 동일한 웹 애플리케이션내의 JSP, 서블릿은 이 빈을 접근할 수 있다.<br />
	위에서 서블릿 컨텍스트의 공동 저장소 역할을 살펴보았는데, appplication 영역으로 생성된 빈은 웹 애플리케이션의 공동자원이다.<br /> 
	그런 이유로 application 영역의 빈은 신중하게 결정해야 한다.<br />
	</td>
</tr>
</table>


<h2 id="examples">JSP 예제</h2>
<strong>이후 실습하는 모든 예제는 C:/www/myapp 아래에,
이클립스가 아닌 에디트 플러스와 같은 일반 에디터를 사용하여 만들고 테스트한다.</strong>

<h3 id="error-handling-1">JSP 에러 핸들링 예전 방식</h3>
JSP는 오로지 에러만을 다룰 수 있는 JSP 페이지를 제공하므로써 에러를 다룰 수 있는 방법을 제공한다.<br />
에러는 주로 런타임 에러가 대부분인데 이것은 JSP 내에서나 JSP 에서 호출한 객체에서 발생한다.<br />
JSP 내에서 핸들링 할 수 없는 익셉션이 발생한다면 서블릿 컨테이너는 JSP 에러 페이지로 요청을 전달한다.
이때 발생한 익셉션 객체도 함께 전달된다.<br />
JSP 에러 페이지를 만드는 것은 간단하다.<br />
JSP 페이지를 만들고 컨테이너에게 이 페이지가 에러 페이지임을 알리면 된다.<br />
이를 수행하기 위해서 page 지시어의 isErrorPage 속성값을 true 로 설정한다.<br />
다음 errorPage.jsp 파일을 C:/www/myapp 에 만든다.

<em class="filename">/errorPage.jsp</em>
<pre class="prettyprint">
&lt;%@ page <strong>isErrorPage="true"</strong> contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%&gt;
&lt;html&gt;
  &lt;body&gt;
    &lt;p&gt;
    다음과 같은 에러가 발생했습니다.&lt;br /&gt;
    &lt;%=exception.getMessage() %&gt;
    &lt;/p&gt;
  &lt;/body&gt;
&lt;/html&gt;
</pre>

isErrorPage="true" 는 이 페이지가 에러를 전문적으로 다루는 페이지라는 것을 컨테이너에게 알려주는 역할을 한다.

&lt;%=exception.getMessage() %&gt;<br />
에러 페이지로 전달되어 온 익셉션의 에러 메시지를 출력한다.<br />
이때 exception 내재 객체를 사용한다.<br />
exception 내재 객체는 page 지시어에서 isErrorPage 속성이 true 인 JSP 페이지에서만 사용할 수 있다.<br />
에러 페이지가 어떻게 작동하는지 알아보기 위해 잡히지 않는 익셉션을 발생시키는 간단한 JSP 페이지를 아래처럼 작성한다.<br />

<em class="filename">/errorMaker.jsp</em>
<pre class="prettyprint">
&lt;%@ page errorPage="errorPage.jsp" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%&gt;
&lt;%
  if (true) {
    throw new Exception("고의적으로 발생시킨 Exception");
  }
%&gt;
</pre>


<h3 id="error-handling-2">JSP 에러 핸들링 현재 방식</h3>
web.xml 파일에 HTTP 상태코드<sup>3</sup>와 발생한 익셉션 유형별로 각각의 에러 페이지를 지정해 줄 수 있다.<br />
이 방식은 서블릿 2.3에서 추가되었다.<br /> 
아래 설정은 익셉션 유형을 java.lang.Throwable 로 하여 모든 익셉션를 다루로록 예제를 단순하게 했다.<br />

<em class="filename">/WEB-INF/web.xml</em>
<pre class="prettyprint">
&lt;error-page&gt;
	&lt;error-code&gt;404&lt;/error-code&gt;
	&lt;location&gt;/404.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
	&lt;error-code&gt;403&lt;/error-code&gt;
	&lt;location&gt;/403.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
	&lt;error-code&gt;500&lt;/error-code&gt;
	&lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
	&lt;exception-type&gt;<strong>java.lang.Throwable</strong>&lt;/exception-type&gt;
	&lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
</pre>

JSP 에러 핸들링 첫번째 방법과 달리 /error.jsp 페이지에서 예외 객체 exception 은 직접 접근하지 못한다.<br />
대신 새로이 추가된 속성값으로 예외 객체를 불러올 수 있다.<sup>4</sup>

<pre>
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
</pre>

다음은 에러와 관련된 request속성 목록이다.<br />
모두 위와 같은 방법으로 접근할 수 있다.<br />

javax.servlet.error.status_code:
에러 상태 코드로 java.lang.Integer 타입으로 저장<br />
javax.servlet.error.exception_type:
예외타입으로 java.lang.Class 타입으로 저장<br />
javax.servlet.error.message:
오류 메시지를 String 으로 저장<br />
javax.servlet.error.exception:
발생한 예외를 java.lang.Throwable 타입으로 저장<br />
javax.servlet.error.request_uri:
문제를 일으킨 리소스의 URI를 String 으로 저장<br />
javax.servlet.error.servlet_name:
문제을 일으킨 서블릿의 이름을 String 으로 저장<br />

<em class="filename">/error.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;Error&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
//Analyze the servlet exception
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

if (servletName == null) {
    servletName = "Unknown";
}

String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

if (requestUri == null) {
    requestUri = "Unknown";
}
 
if(statusCode != 500){
    out.write("&lt;h3&gt;Error Details&lt;/h3&gt;");
    out.write("&lt;strong&gt;Status Code&lt;/strong&gt;:" + statusCode + "&lt;br&gt;");
    out.write("&lt;strong&gt;Requested URI&lt;/strong&gt;:"+requestUri);
}else{
    out.write("&lt;h3&gt;Exception Details&lt;/h3&gt;");
    out.write("&lt;ul&gt;&lt;li&gt;Servlet Name:" + servletName + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Name:" + throwable.getClass().getName() + "&lt;/li&gt;");
    out.write("&lt;li&gt;Requested URI:" + requestUri + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Message:" + throwable.getMessage() + "&lt;/li&gt;");
    out.write("&lt;/ul&gt;");
}
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

http://localhost:8989/honggildong.jsp를 방문한다.<br />
honggildong.jsp 란 자원이 없으므로 404 에러가 발생하면서 error.jsp 파일이 응답할 것이다.<br />
이 예제는 에러 핸들링의 힌트를 준다.<br />
<strong>하지만 개발 단계에서는 에러 페이지 설정을 하지 않는게 좋다.</strong>
에러 핸들링 설정을 취소하려면 web.xml 에서 error 설정만 주석처리하면 된다.<br /> 
참고로 이 예제는 인터넷 익스플로러에서는 테스트되지 않는다.<br />
익스플로러에서 에러 페이지가 일정 바이트 이하면 에러페이지가 작동하지 않는다.<br />
그 결과 404에러 메시지만을 보게 된다.<sup>3</sup>
중요한 것은 아니다. 따라서  이 예제를 테스트할 때는 인터넷 익스플로러외의 브라우저로 테스트한다.<br />

<h3 id="cookie-example">쿠키</h3>

쿠키는 웹 브라우저에 저장되어 요청을 보낼때 함께 전송되는 간단한 데이터를 말한다.<br />
쿠키는 자바스크립트나 JSP에서 설정될 수 있다.<br />
여기서는 JSP에서 쿠키를 설정하는 예만 살펴볼 것이다.<br />
JSP에서 쿠키가 설정되면 응답데이터에 포함된다.<br />
쿠키의 유효기간을 setMaxAge() 메소드를 사용하여 구체적인 시간을 명시한다면 응답 데이터를 받은 웹브라우저는 응답데이터에서 쿠키를 꺼내 쿠키저장소에 보관한다.<br />
setMaxAge()를 사용하지 않은 쿠키데이터는 웹브라우저가 종료되면 사라진다.<br />
<br />

<strong>쿠키 동작 과정</strong>
<ol>
	<li>웹브라우저가 쿠키를 굽는 코드가 있는 웹 자원 요청</li>
	<li>웹 자원은 HTTP 응답 헤더에 쿠키 값을 설정</li>
	<li>웹 브라우저는 응답 헤더에 담겨져 전달된 쿠키 데이터를 저장</li>
	<li>웹브라우저는 쿠키를 구어준 웹 사이트의 자원을 요청할 때마다 쿠키 데이터도 함께 전송</li>
</ol>

2번 과정에서 응답 헤더에 포함된 쿠키 값은 아래와 같은 문자열이다.<br />

<pre>
<strong>Set-Cookie: name=<em>VALUE</em></strong>; expires=<em>DATE</em>; path=<em>PATH</em>; domain=<em>DOMAIN_NAME</em>; secure
</pre>

위에서 강조된 문자열을 필수 데이터이며,
<em>이탤릭체</em>는 실제 값으로 변경되어야 하는 부분이다.<br />
<br />
4번 과정에서 요청 헤더에 포함된 쿠키 정보는 아래와 같은 문자열이다.<br />
<pre>
Cookie: <em>name1=VALUE1</em>; <em>name2=VALUE2</em>;...
</pre>


<strong>쿠키의 구성</strong>
<ul>
	<li>name : 이름</li>
	<li>value : 값</li>
	<li>expires :유효기간</li>
	<li>domain : 도메인</li>
	<li>path : 경로</li>
	<li>secure : 시큐어 웹 여부(https)</li>
</ul>

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">javax.servlet.http.Cookie 클래스</dt>
	<dd class="api-summary-dd">Cookie(String name, String value)</dd>
	<dd class="api-summary-dd">getName()</dd>
	<dd class="api-summary-dd">setValue(String)</dd>
	<dd class="api-summary-dd">getValue()</dd>
	<dd class="api-summary-dd">setDomain(String)</dd>
	<dd class="api-summary-dd">getDomain()</dd>
	<dd class="api-summary-dd">setPath(String)</dd>
	<dd class="api-summary-dd">getPath()</dd>
	<dd class="api-summary-dd">setMaxAge(int)</dd>
	<dd class="api-summary-dd">getMaxAge()</dd>
	<dd class="api-summary-dd">setSecure(boolean)</dd>
	<dd class="api-summary-dd">getSecure()</dd>
</dl>	

다음 코드조각은 Cookie 클래스의 사용법을 보여주고 있다.<br />
  
<pre class="prettyprint">
/*
* 쿠키 생성
*/
Cookie cookie = new Cookie("user", "gildong");

/*
*  . 으로 시작되는 경우 모든 관련도메인에 전송되는 쿠키
* www.java-school.net, user.java-school.net, blog.java-school.net 등등
*/
cookie.setDomain(".java-school.net");

/*
* 경로를 '/'로 설정하면 웹사이트의 모든 경로에 전송되는 쿠키
* 만일 '/user' 와 같이 특정 경로를 설정하면 '/user' 경로만 전송되는 쿠키
*/
cookie.setPath("/");

/*
* 초단위의 쿠키 유효기간 설정
* 음수값이 설정되면 쿠키는 웹 브라우저가 종료할 때 삭제된다. 
*/
cookie.setMaxAge(60*60*24*30); //30일동안 유효한 쿠키 
</pre>
<br />

쿠키에 대한 간단한 예제를 만들어 보자.<br />
/cookie 디렉토리를 만들고 그 안에 아래 파일을 작성한다.<br />

<em class="filename">/cookie/index.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;쿠키 테스트&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;쿠키 테스트&lt;/h1&gt;
&lt;ul&gt;
	&lt;li&gt;&lt;a href="setCookie.jsp"&gt;쿠키 굽기&lt;/a&gt;&lt;/li&gt;
	&lt;li&gt;&lt;a href="viewCookie.jsp"&gt;쿠키 확인&lt;/a&gt;&lt;/li&gt;
	&lt;li&gt;&lt;a href="editCookie.jsp"&gt;쿠키 변경&lt;/a&gt;&lt;/li&gt;
	&lt;li&gt;&lt;a href="delCookie.jsp"&gt;쿠키 삭제&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/setCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.net.*"  %&gt;
&lt;%
Cookie cookie = new Cookie("name", URLEncoder.encode("홍길동", "UTF-8"));

/*
* setPath()로 사용하지 않으면 setCookie.jsp 가 있는 디렉토리로 경로가 설정된다.
* path=/cookie
*/ 
response.addCookie(cookie);
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;쿠키를 굽는 페이지&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
Set-Cookie: &lt;%=cookie.getName() %&gt;=&lt;%=cookie.getValue() %&gt; 문자열을 응답 헤더에 추가&lt;br /&gt;
&lt;a href="viewCookie.jsp"&gt;쿠키확인&lt;/a&gt; 
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/viewCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.net.*" %&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;요청과 함께 쿠키가 전송되는지 확인&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
Cookie[] cookies = request.getCookies();
if (cookies != null &amp;&amp; cookies.length &gt; 1) {
	int length = cookies.length;
	for (int i = 0; i &lt; length; i++) {
%&gt;
	&lt;%=cookies[i].getName() %&gt;=&lt;%=URLDecoder.decode(cookies[i].getValue(), "UTF-8") %&gt;&lt;br /&gt;
&lt;%			
	}
}
%&gt;
&lt;a href="./"&gt;처음으로&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/editCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.net.*" %&gt;
&lt;%
Cookie[] cookies = request.getCookies();
if (cookies != null &amp;&amp; cookies.length &gt; 1) {
	int length = cookies.length;
	for (int i = 0; i &lt; length; i++) {
		if (cookies[i].getName().equals("name")) {
			Cookie cookie = new Cookie("name", URLEncoder.encode("임꺽정" ,"UTF-8"));
			response.addCookie(cookie);
		}
	}
}
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;쿠키 값 변경&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
쿠키 값을 변경했습니다.&lt;br /&gt;
&lt;a href="viewCookie.jsp"&gt;쿠키확인&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/cookie/delCookie.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
Cookie[] cookies = request.getCookies();
if (cookies != null &amp;&amp; cookies.length &gt; 1) {
	int length = cookies.length;
	for (int i = 0; i &lt; length; i++) {
		if (cookies[i].getName().equals("name")) {
			Cookie cookie = new Cookie("name", "");
			cookie.setMaxAge(0);
			response.addCookie(cookie);
			break;
		}
	}
}
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;쿠키 삭제&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
name 쿠키를 삭제했습니다.&lt;br /&gt;
&lt;a href="viewCookie.jsp"&gt;쿠키확인&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="include-directive-example">include 지시어를 이용하는 페이지 분리</h3>
첨부 파일, <a href="https://drive.google.com/open?id=0B42KXwCfAfp3d2YzWEtyN1AzYm8">example.zip</a>을
다운로드한 후 ROOT 애플리케이션의 최상위 디렉토리에 압축을 푼다.<br />

http://localhost:8989/example/ex1/index.jsp를 방문한다.<br />

/example/ex1/index.jsp 소스에서 include 지시어를 사용하여 subMenu.jsp (왼쪽 서브메뉴)을 인클루드하는 부분을 확인한다.<br />

<pre>
&lt;%@ include file="../inc/subMenu.jsp" %&gt;
</pre>

index.jsp 소스에서 subMenu.jsp 페이지를 인클루드하고 있다.<br />
페이지를 구성하는 부분을 분리한 다음 include 지시어를 사용하여 통합하면 유지 보수가 편리해 진다.<br />
인클루드할 때 주의해야 할 사항은 상대 경로 문제이다.<br />
인클루드 되는 파일인 subMenu.jsp 에서 링크 경로는 인클루드하는 index.jsp 를 기준으로 해서 작성해야 한다.<br />
결국 index.jsp 를 기준으로 하나의 서블릿으로 만들어지기 때문이다.<br />
참고로 css 파일에서의 이미지 링크의 경우는 이와는 달리 css 파일의 위치가 기준이 된다.<br />
다시 말해css 파일을 임포트하는 JSP파일이 기준이 아니다.<br />

<h3 id="login-process">자바 빈즈를 이용한 로그인 처리(세션 이용)</h3>
세션은 쿠키 기반 기술이다.<br />
세션은 쿠키와 달리 쿠키값으로 세션ID 만 전송한다.<br />
서블릿 컨테이너는 전송되어 온 세션ID로 판단하여 웹브라우저에 매핑되는 세션이 동작하는 것을 보장한다.<br />   
이번 예제의 소스 위치는 /example/ex2/ 이다.<br />
http://localhost:8989/example/ex2/index.jsp를 방문한다.<br />
이 화면에서 로그인을 테스트하려 하는데 아직 구현이 덜 되어 있다.<br />
login_proc.jsp 페이지가 로그인을 처리하는 페이지인데, login_proc.jsp 소스를 열어 보면 net.java_school.user.User.java 자바 빈즈를 이용하고 있다.<br />
예제를 실행하기 위해서는 net.java_school.user.User.java 를 아래와 같이 작성하고 WEB-INF/classes 에 바이트코드가 생성되도록 컴파일한다.<br />

<em class="filename">User.java</em>
<pre class="prettyprint">
package net.java_school.user;

public class User {

  private String id;
  private String passwd;
	
  public String getId() {
      return id;
  }
	
  public void setId(String id) {
      this.id = id;
  }
	
  public String getPasswd() {
      return passwd;
  }	
	
  public void setPasswd(String passwd) {
      this.passwd = passwd;
  }

}
</pre>

User.java 작성과 컴파일을 마쳤다면,<br />
http://localhost:8989/example/ex2/index.jsp를 다시 방문하여 로그인을 테스트 한다.<br />
<br />
/example/ex2/index.jsp 파일을 열고 파라미터를 전달하고 파라미터 값을 획득하는 코드를 확인한다.<br />

<pre>
&lt;input type="text" name="<strong>id</strong>" /&gt;
</pre>

id 파라미터가 login_proc.jsp 로 전송된다.<br />
/example/ex2/login_proc.jsp 파일을 열어 아래 코드를 확인한다.

<pre>
String id = request.getParameter("<strong>id</strong>");
</pre>

id 파라미터의 값은 login_proc.jsp 에서 내재 객체 request 의 getParameter() 메소드를 사용해서 구할 수 있다.<br />
<br />

login_proc.jsp 는 User 객체를 생성한 다음, 전달된 파라미터 id, passwd 를 이용해서 생성된 User 의 멤버를 셋팅한다.<br />
사용자의 정보로 셋팅된 이 User 객체를 세션에 담는 것으로 로그인 처리를 완료한다.<br />
예제를 간단하게 하기 위해 데이터베이스 조회와 관련된 코드를 생략했다.<br />
따라서 어떤 아이디와 패스워드에 대해서도 로그인이 성공한다.

<em class="filename">login_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;

&lt;%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");

/* 
* 데이터베이스에 id, passwd 를 가진 회원정보가 있는지 조회하고 로직이 필요.
*/
User user = new User();
user.setId(id);

// 세션 객체 생성 후 User 객체를 user 란 이름으로 저장
session.setAttribute("user", user);
%&gt;

&lt;jsp:forward page="index.jsp" /&gt;
</pre>

<h3 id="login-process-2">login_proc.jsp 에 표준 액션 적용</h3>
이번 예제의 소스 위치는 /example/ex3/ 이다.<br />
바로 전 예제와 기능은 같다.<br />
다른 점이 있다면 코드를 표준 액션을 사용하도록 변경했다는 것이다.<br />
login_proc.jsp 소스를 열어보면 코드가 아래처럼 간단하게 줄어든 것을 확인 할 수 있다.<br />

<em class="filename">login_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;jsp:useBean id="user" scope="session" class="net.java_school.user.User" /&gt;
&lt;jsp:setProperty name="user" property="*"/&gt;
&lt;jsp:forward page="index.jsp" /&gt;
</pre>

jsp:useBean 표준 액션은 다음과 같이 실행한다.<br />
먼저 세션에서 id가 user 인 객체를 찾는다.<br /> 
다시 말하면, 세션에서 키값이 "user" 로 저장된 객체를 찾는다.<br />
만약 그런 객체가 없으면 net.java_school.user.User 클래스로부터 User 객체를 생성하고 이 객체를 jsp:userBean 표준 액션 엘리먼트의 id 속성값을 키값으로 해서 세션에 저장한다.<br />
이제 두번째 표준액션이 실행된다.<br />
jsp:setProperty 표준 액션은 전달된 파라미터 값으로 JSP 빈즈의 setter 메소드를 호출하여 값을 저장한다.<br />
전달받은 파라미터 id, passwd 를 이용해서 User 객체의 멤버를 셋팅을 수행하는 것이다.<br /> 

<pre>
&lt;jsp:setProperty name="user" property="*"/&gt;
</pre>

위 액션 태그는 User 빈의 setId() 메소드와 setPasswd() 메소드를 호출한다.<br />
setter 메소드의 인자값은 메소드의 이름과 매칭되는 파라미터의 값이 전달된다.<br />
좀더 정확한 이해를 위해 다음 표를 확인한다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">JSP/JSP 빈즈</th>
	<th class="table-in-article-th">코드</th>
</tr>
<tr>
	<td class="table-in-article-td">index.jsp</td>
	<td class="table-in-article-td">&lt;input type="text" name="<strong>id</strong>" /&gt;</td>
</tr>
<tr>	
	<td class="table-in-article-td">login_proc.jsp</td>
	<td class="table-in-article-td">&lt;jsp:setProperty name="login" property="<strong>id</strong>" /&gt;</td>
</tr>
<tr>
	<td class="table-in-article-td">User.java</td>
	<td class="table-in-article-td">set <strong>Id </strong>(String id)</td>
</tr>
</table>

여기서 JSP 빈즈의 setId() 메소드에서 I가 대문자이다.<br />
이는 자바에서 권고하는 네이밍 룰이다.<br />
(이에 대해서는 "자바"과정에서 이미 공부했다.)<br />
jsp:setProperty 표준액션을 사용할 때 JSP 빈즈가 자바 네이밍 룰을 따르지 않는다면 작동하지 않는다.<br />
즉, 표준액션과 관련해서는 네이밍 룰이 권고사항이 아니라 문법이 된다.<br />

<h3 id="fileList-example">업로드 파일 확인</h3>
서블릿에서 파일 업로드 예제를 다루었다.<br />
다음 JSP는 upload 폴더에 업로드한 파일의 리스트를 보여준다.<br />

<em class="filename">/fileList.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.io.*" %&gt;
&lt;%@ page import="java.net.*" %&gt;
&lt;%
String upload = application.getRealPath("/upload");

File dir = new File(upload);
File[] files = dir.listFiles();
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;저장된 파일 리스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goDownload(filename) {
	var form = document.getElementById("downForm");
	form.filename.value = filename;
	form.submit();
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
int len = files.length;
for (int i = 0; i &lt; len; i++) {
	File file = files[i];
	String filename = file.getName();
%&gt;
	&lt;a href="javascript:goDownload('&lt;%=filename %&gt;')"&gt;&lt;%=file.getName() %&gt;&lt;/a&gt;&lt;br /&gt;
&lt;%
}
%&gt;
&lt;form id="downForm" action="download.jsp" method="post"&gt;
	&lt;input type="hidden" name="filename" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3 id="download-example">파일 다운로드</h3>
다음은 위의 파일 목록 페이지에서 해당 파일을 클릭하면 다운로드를 하도록 하는 JSP페이지아다.<br />

<em class="filename">/download.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;%@ page import="java.io.File" %&gt;
&lt;%@ page import="java.net.URLEncoder" %&gt;
&lt;%@ page import="java.io.OutputStream" %&gt;
&lt;%@ page import="java.io.FileInputStream" %&gt;
&lt;%@ page import="java.io.IOException" %&gt;
&lt;%@ page import="org.apache.commons.io.FileUtils" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
String filename = request.getParameter("filename");

String path = application.getRealPath("/upload");
File file = new File(path + "/" + filename);

response.setContentLength((int) file.length());

String filetype = filename.substring(filename.indexOf(".") + 1, filename.length());
if (filetype.trim().equalsIgnoreCase("txt")) {
	response.setContentType("text/plain");
} else {
	response.setContentType("application/octet-stream");
}

String userAgent = request.getHeader("user-agent");
boolean ie = userAgent.indexOf("MSIE") != -1;
if (ie) {
	filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
} else {
	filename = new String(filename.getBytes("UTF-8"), "8859_1");
}

response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
/* response.setHeader("Content-Transfer-Encoding", "binary"); */

OutputStream outputStream = response.getOutputStream();

try {
	FileUtils.copyFile(file, outputStream);
} finally {
	outputStream.flush();
}
%&gt;
</pre>

<h3 id="jsp-file-upload">JSP 파일 업로드</h3>
다음은 서블릿 예제에서 다루었던 파일을 업로드하는 서블릿을 JSP로 바꾼 코드이다.<br />

<em class="filename">fileupload_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="
java.util.Iterator,
java.io.File,java.util.List,
javax.servlet.http.HttpServletRequest,
org.apache.commons.fileupload.FileItem,
org.apache.commons.fileupload.FileItemFactory,
org.apache.commons.fileupload.FileUploadException,
org.apache.commons.fileupload.disk.DiskFileItemFactory,
org.apache.commons.fileupload.servlet.ServletFileUpload" %&gt;
&lt;%
//Check that we have a file upload request
boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//Create a factory for disk-based file items
DiskFileItemFactory factory = new DiskFileItemFactory();

//Configure a repository (to ensure a secure temp location is used)
File repository = (File) application.getAttribute("javax.servlet.context.tempdir");
factory.setRepository(repository);

//Create a new file upload handler
ServletFileUpload upload = new ServletFileUpload(factory);
upload.setHeaderEncoding("UTF-8");//한글파일명 처리위해 추가
//Parse the request
List&lt;FileItem&gt; items = upload.parseRequest(request);
//Process a file upload
Iterator&lt;FileItem&gt; iter = items.iterator();
while (iter.hasNext()) {
	FileItem item = iter.next();
	String fileName = null;
	if (!item.isFormField()) {
		String fieldName = item.getFieldName();
		out.println("fieldName : " + fieldName);out.println(",");
		fileName = item.getName();
		out.println("fileName : " + fileName);out.println(",");
		String contentType = item.getContentType();
		out.println("contentType : " + contentType);out.println(",");
		boolean isInMemory = item.isInMemory();
		out.println("isInMemory : " + isInMemory);out.println(",");
		long sizeInBytes = item.getSize();
		out.println("sizeInBytes : " + sizeInBytes);
	}
	// Process a file upload
	String dir = application.getRealPath("/upload");
	File uploadedFile = new File(dir + "/" + fileName);
    item.write(uploadedFile);
}
response.sendRedirect("upload.html");
%&gt;
</pre>

<span id="comments">주석</span>
<ol>
	<li>JSP가 바뀌어서 만들어지는 서블릿은 지난장에서 배운 서블릿과 닮았지만 같지 않다.</li>
	<li>HTML문서 디자인과 자바 코드의 깔끔한 분리는 여전히 숙제로 남아 있다.</li>
	<li>HTTP 상태코드 404는 찾을 수 없음을, 403는 금지됨을, 500은 내부 서버 오류를 의미한다.</li>
	<li>앞으로 배울 JSTL에서는 다음과 같이 접근할 수 있다.<br />
	&lt;c:out value="${requestScope['javax.servlet.error.message']}" /&gt;</li>
</ol>
