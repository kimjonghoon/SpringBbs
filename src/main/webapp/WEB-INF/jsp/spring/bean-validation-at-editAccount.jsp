<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.5.22</div>

<h1>내 정보 수정에서의 빈 유효성 검사</h1>

<em class="filename">UsersController.java</em>
<pre class="prettyprint">
RequestMapping(value="/editAccount",method=RequestMethod.POST)
public String editAccount(<strong>@Valid</strong> User user, 
        <strong>BindingResult bindingResult</strong>, Principal principal) {
        
    <strong>//유효성 검사
    if (bindingResult.hasErrors()) {
        return "users/editAccount";
    }</strong>
    
    user.setEmail(principal.getName());
    
    int check = userService.editAccount(user);
    
    if (check != 1) {
        throw new RuntimeException(WebContants.EDIT_ACCOUNT_FAIL);
    }
    
    return "redirect:/users/changePasswd";
}
</pre>

<em class="filename">editAccount.jsp</em>
<pre class="prettyprint">
<strong>
&lt;%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %&gt;

&lt;sf:form id="editAccountForm" action="editAccount" method="post" 
        commandName="user" onsubmit="return check();"&gt;
    &lt;sf:hidden path="email" value="abc@def.ghi" /&gt;
    &lt;sf:errors path="*" cssClass="error" /&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;이름(Full Name)&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:input path="name" value="${user.name }" /&gt;&lt;br /&gt;
        &lt;sf:errors path="name" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;손전화(Mobile)&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:input path="mobile" value="${user.mobile }" /&gt;&lt;br /&gt;
        &lt;sf:errors path="mobile" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;현재 비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:password path="passwd" /&gt;&lt;br /&gt;
        &lt;sf:errors path="passwd" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="전송" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
<strong>&lt;/sf:form&gt;</strong>
</pre>

<h2>테스트</h2>
로그인 후, 내 정보 수정 화면에서 기존 정보 값을 모두 지우고 전송한다.<br />

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

