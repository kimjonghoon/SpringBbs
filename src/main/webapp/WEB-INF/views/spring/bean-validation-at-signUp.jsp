<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.5.22</div>

<h1>회원가입에서의 빈 유효성 검사</h1>

<h2>빈 유효성 검사를 위한 사전 작업</h2>
1. JSR-349 구현체인 Hibernate Validator 의존 라이브러리를 pom.xml에 추가한다.

<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;!-- Hibernate Validator --&gt;
&lt;dependency&gt;
    &lt;groupId&gt;org.hibernate&lt;/groupId&gt;
    &lt;artifactId&gt;hibernate-validator&lt;/artifactId&gt;
    &lt;version&gt;5.1.3.Final&lt;/version&gt;
&lt;/dependency&gt;
</pre>

pom.xml의 내용이 변경되었으니 이클립스와 동기화한다.<br />
컨텍스트 메뉴의 Maven - Update Project Cofiguraion을 실행한다.<br />
<br />
2. 스프링 설정 파일에 &lt;mvc:annotation-driven /&gt; 설정이 있는지 확인한다.<br /> 
3. web.xml에 요청 파라미터의 캐릭터 셋을 "UTF-8"로 바꾸는 필터가 설정되어 있는지 확인한다.<br />
<br />
다음 순서로 실습을 진행할 것이다.<br />
<ol>	
	<li>폼 입력에 바인딩 되는 자바 빈에 유효성 검사 규칙 선언</li>
	<li>컨트롤러 메서드에 폼의 유효성 검사 로직 추가</li>
	<li>JSP에 스프링 태그 라이브러리를 적용하여 검사 에러가 출력되도록 수정</li>
</ol>

<em class="filename">User.java</em>
<pre class="prettyprint">
<strong>
import javax.validation.constraints.Size;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

@NotBlank(message="이메일 형식이 아닙니다.")
@Email(message="이메일 형식이 아닙니다.")</strong>
private String email;
<strong>
@Size(min=4, message="패스워드는 4자 이상이어야 합니다.")</strong>
private String passwd;
<strong>
@Size(min=2, message="이름은 2자 이상이어야 합니다.")</strong>
private String name;
<strong>
@Size(min=6, max=20, message="모바일폰 번호형식이 아닙니다.")</strong>
private String mobile;
</pre>

<em class="filename">UsersController.java</em>
<pre class="prettyprint">

import javax.validation.Valid;
import org.springframework.validation.BindingResult;

@RequestMapping(value="/signUp", method=RequestMethod.GET)
public String signUp(<strong>Model model</strong>) {
    <strong>model.addAttribute(WebContants.USER_KEY, new User());</strong>
    
    return "users/signUp";
}

@RequestMapping(value="/signUp", method=RequestMethod.POST)
public String signUp(<strong>@Valid</strong> User user, <strong>BindingResult bindingResult</strong>) {
    <strong>//유효성 검사
    if (bindingResult.hasErrors()) {
        return "users/signUp";
    }</strong>
	
    //...중간 생략...
}
</pre>

CSS 파일에 에러 메시지를 위한 스타일을 추가한다.<br />

<em class="filename">screen.css</em>
<pre class="prettyprint">
.error {
	color: red;
}
</pre>

<em class="filename">signUp.jsp</em>
<pre class="prettyprint">
<strong>
&lt;%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %&gt;

&lt;sf:form id="signUpForm" action="signUp" method="post" commandName="user" 
        onsubmit="return check();"&gt;
&lt;sf:errors path="*" cssClass="error" /&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
    &lt;td style="width: 200px;"&gt;이름(Full Name)&lt;/td&gt;
    &lt;td style="width: 390px"&gt;
        <strong>&lt;sf:input path="name" /&gt;&lt;br /&gt;
        &lt;sf:errors path="name" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:password path="passwd" /&gt;&lt;br /&gt;
        &lt;sf:errors path="passwd" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2" style="text-align: center;font-weight: bold;"&gt;
        Email이 아이디로 쓰이므로 비밀번호는 Email계정 비밀번호와 같게 하지 마세요.
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호 확인(Confirm)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="confirm" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;Email&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:input path="email" /&gt;&lt;br /&gt;
        &lt;sf:errors path="email" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;손전화(Mobile)&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:input path="mobile" /&gt;&lt;br /&gt;
        &lt;sf:errors path="mobile" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="확인" /&gt;
&lt;/div&gt;
&lt;/sf:form&gt;
</pre>

<h2>테스트</h2>
빌드하고 톰캣을 재실행한다.<br />
http://localhost:port/spring-bbs/login으로 이동한다.<br />
상단 회원가입 버튼을 클릭하여 회원가입 양식 페이지로 이동한다.<br />
아무것도 입력하지 않은 채 확인 버튼을 클릭한다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://hibernate.org/validator/documentation/getting-started/">Getting started with Hibernate Validator</a></li>
	<li><a href="http://forum.spring.io/forum/spring-projects/web/80192-validation-empty-int-field">Validation - Empty int field</a></li>
	<li><a href="http://stackoverflow.com/questions/14715248/simple-springmvc-3-login-doesnt-work">http://stackoverflow.com/questions/14715248/simple-springmvc-3-login-doesnt-work</a></li>
	<li><a href="http://stackoverflow.com/questions/6227547/spring-3-validation-not-working">http://stackoverflow.com/questions/6227547/spring-3-validation-not-working</a></li>
	<li><a href="http://stackoverflow.com/questions/8909482/spring-mvc-3-ambiguous-mapping-found">http://stackoverflow.com/questions/8909482/spring-mvc-3-ambiguous-mapping-found</a></li>
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=978-89-7914-887-9#binfo5">예제로 쉽게 배우는 스프링 프레임워크 3.0(한빛미디어) - 사카타 코이치</a></li>
	<li><a href="http://jpub.tistory.com/196">Spring in Action(Jpub) - 크레이그 월즈</a></li>
	<li><a href="http://docs.spring.io/spring/docs/current/spring-framework-reference/pdf/">spring-framework-reference.pdf</a></li>
	<li><a href="http://mybatis.github.io/mybatis-3/getting-started.html">MyBatis Getting started</a></li>
</ul>

