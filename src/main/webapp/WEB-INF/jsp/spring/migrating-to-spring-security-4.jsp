<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.8.2</div>

<h1>스프링 시큐리티 4 적용</h1>

<h3>pom.xml에서 스프링 시큐리티 버전 변경</h3>

<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;properties&gt;
	&lt;spring.version&gt;4.1.7.RELEASE&lt;/spring.version&gt;
	&lt;spring.security.version&gt;<strong>4.0.2.RELEASE</strong>&lt;/spring.security.version&gt;
	&lt;jdk.version&gt;1.7&lt;/jdk.version&gt;
&lt;/properties&gt;
</pre>

<pre class="prettyprint">
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
	&lt;artifactId&gt;spring-security-web&lt;/artifactId&gt;
	&lt;version&gt;<strong>${spring.security.version}</strong>&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
	&lt;artifactId&gt;spring-security-taglibs&lt;/artifactId&gt;
	&lt;version&gt;<strong>${spring.security.version}</strong>&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
	&lt;artifactId&gt;spring-security-config&lt;/artifactId&gt;
	&lt;version&gt;<strong>${spring.security.version}</strong>&lt;/version&gt;
&lt;/dependency&gt;
</pre>

src/main/webapp/WEB-INF/lib에 있는 라이브러리를 모두 지운다.<br />
pom.xml 파일이 있는 루트 디렉터리로 이동해 다음을 수행한다.<br />

<pre class="shell-prompt">
mvn clean compile war:inplace
</pre>

톰캣을 재실행한다.<br />
로그인 화면으로 이동하여 로그인을 시도하면 빈 화면을 만나게 된다.<br />
에러 메시지도 로그에 없다.<br />
원인은 스프링 시큐리티 4의 CSRF 방지 기능이 작동하고 있기 때문이다.<br />
스프링 시큐리티 4부터는 이 기능이 디폴트로 작동한다.<br />
따라서 PATCH, POST, PUT, DELETE 요청에 CSRF 토큰을 포함해야 한다.<br />
/users/login.jsp 파일을 열고 폼에 다음을 추가한다.<br />

<pre class="prettyprint">
<strong>&lt;input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /&gt;</strong>
</pre>

스프링 폼 태그를 사용하는 폼(일반적으로 &lt;form:form&gt;, 우리의 프로젝트에서는 &lt;sf:form&gt;의 모양이다)
은 자동으로 토큰 파라미터가 추가되므로 위 코드가 필요없다.<br />

다시 로그인을 시도한다.<br />
이번에는 /j_spring_security_check를 찾을 수 없다는 404 에러를 만나게 된다.<br />

<h3>스프링 시큐리티 4에서는 http 자식요소 form-login의 속성 중 기본값이 변경된 속성</h3>
&lt;form-login&gt;에서 login-processing-url 속성의 기본값은 /j_spring_security_check에서 POST /login으로,<br />
username-parameter 속성의 기본값은 j_username에서 username으로,<br />
password-parameter 속성의 기본값은 J_password에서 password로,<br />
authentication-failure-url 속성의 기본값은 /login?error=1으로 변경되었다.<br />
<br />
스프링 시큐리티 설정 파일을 열고 강조된 부분을 참고하여 수정한다.<br />

<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;form-login 
	login-page="/users/login"
	authentication-failure-url="/users/login?<strong>error=1</strong>"  
	default-target-url="/bbs/list?boardCd=free&amp;page=1" /&gt;
</pre>

login-page 속성의 기본값은 /login, authentication-failure-url 속성의 기본값은 /login?error=1이다.<br />
설정 파일에서 속성을 생략한다면 이 값이 적용된다.<br />
사용자 로그인 페이지(/users/login)를 사용하고 로그인 실패시 다시 로그인 페이지로 이동하게 하려면, login-page 속성 뿐만 아니라 authentication-failure-url 속성을 명시해야 하며
아래와 같은 추가적인 설정이 필요하다.(이미 되어 있다.)<br />

<pre class="prettyprint">
&lt;http use-expressions="true"&gt;
    &lt;intercept-url pattern="/users/login" access="permitAll" /&gt;
</pre>

http의 use-expressions의 속성 기본값이 false에서 true로 변경되었으므로 생략할 수 있다.<br />

<pre class="prettyprint">
&lt;http&gt;
    &lt;intercept-url pattern="/users/login" access="permitAll" /&gt;
</pre>

<h3>로그인 페이지 수정</h3>
명시하지 않은 설정은 디폴트 값이 적용됨을 고려하면서 /users/login.jsp를 수정한다.<br />

<em class="filename">/users/login.jsp</em>
<pre class="prettyprint">
&lt;c:if test="${param.error != null }"&gt;
        &lt;h2&gt;Username/Password not corrrect&lt;/h2&gt;
&lt;/c:if&gt;
&lt;c:url var="loginUrl" value="<strong>/login</strong>" /&gt;
&lt;form action="<strong>${loginUrl }</strong>" method="post"&gt;
&lt;p style="margin:0; padding: 0;"&gt;
<strong>&lt;input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /&gt;</strong>
&lt;/p&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td style="width: 200px;"&gt;&lt;spring:message code="user.email" /&gt;&lt;/td&gt;
    &lt;td style="width: 390px"&gt;&lt;input type="text" name="<strong>username</strong>" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;&lt;spring:message code="user.password" /&gt;&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="<strong>password</strong>" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre>
 
설정 파일일 변경되었으니 톰캣을 재실행하고 로그인을 테스트한다.<br />
로그인이 성공했다면 로그아웃을 실행한다.<br />
다시 빈 화면을 만나게 될 것이다.<br />
이는 logout의 logout-url 속성의 기본값이 /j_spring_security_logout에서 POST /logout으로 변경되었기 때문이다.<br />
POST /logout 요청을 해야하기에 모든 화면이 포함하는 header.jsp를 수정하여 로그아웃을 수정해 보자.<br />
/inc/header.jsp파일을 열고 &lt;head&gt;와 &lt;/head&gt;사이에 다음을 추가한다.<br />

<pre class="prettyprint">
<strong>&lt;input type="button" value="&lt;spring:message code="user.logout" /&gt;" id="logout" /&gt;</strong>
</pre>

header.jsp 가장 아래에 다음을 추가한다.<br />

<pre class="prettyprint">
&lt;form id="logoutForm" action="<%="$" %>{pageContext.request.contextPath}/logout" method="post" style="display:none"&gt;
	&lt;input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /&gt;
&lt;/form&gt;

&lt;script&gt;
$(document).ready(function() {
        $('#logout').click(function() {
                $('#logoutForm').submit();
                return false;
        });
});
&lt;/script&gt;
</pre>

다시 로그아웃을 테스트한다.<br />
header.jsp에 jQuery를 사용하고 있으므로 화면을 보여주는 페이지는 모두 jQuery를 임포트하도록 다음 코드를 추가한다.<br />

<pre class="prettyprint">
&lt;script type="text/javascript"
	src="<%="$" %>{pageContext.request.contextPath}/js/jquery-1.11.3.min.js"&gt;&lt;/script&gt;
</pre>

로그아웃까지 테스트했다면 다시 로그인하고 새글 쓰기를 시도한다.<br />
새글 쓰기 처리에서 다시 빈 화면을 만나게 된다.<br />
첨부 파일의 경우 <em class="path">&lt;input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /&gt;</em>이 아닌 쿼리 스프링으로 CSRF 토큰을 전달해야 한다.<br />
이는 스프링 폼 태그를 사용하고 있다 하더라도 마찬가지다.<br />
write_form.jsp와 modify_form.jsp 파일을 열고 <em class="path">&lt;input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /&gt;</em>이 있다면 지우고, 
아래와 같이 폼의 action 속성을 수정한다.<br />
 
<em class="filename">write_form.jsp의 action 속성</em>
<pre class="prettyprint">
&lt;sf:form action="write?<strong>${_csrf.parameterName}=${_csrf.token}</strong>" method="post" ...
</pre>

<em class="filename">modify_form.jsp action 속성</em>
<pre class="prettyprint">
&lt;sf:form action="modify?<strong>${_csrf.parameterName}=${_csrf.token}</strong>" method="post" ...
</pre>

하지만 이 방법은 쿼리 파라미터가 노출될 수 있다.<br />
민감한 데이터를 노출되지 않도록 바디나 헤더에 두는 것이 좀 더 낫다.<br />
이에 관한 정보는 아래 참고에 링크해 둔다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.spring.io/spring-security/site/migrate/current/3-to-4/html5/migrate-3-to-4-xml.html#m3to4-xmlnamespace-defaults">http://docs.spring.io/spring-security/site/migrate/current/3-to-4/html5/migrate-3-to-4-xml.html#m3to4-xmlnamespace-defaults</a></li>
	<li><a href="http://docs.spring.io/spring-security/site/docs/current/reference/htmlsingle/#nsa-logout-attributes">http://docs.spring.io/spring-security/site/docs/current/reference/htmlsingle/#nsa-logout-attributes</a></li>
	<li><a href="http://www.w3.org/Protocols/rfc2616/rfc2616-sec15.html#sec15.1.3">http://www.w3.org/Protocols/rfc2616/rfc2616-sec15.html#sec15.1.3</a></li>	
</ul>