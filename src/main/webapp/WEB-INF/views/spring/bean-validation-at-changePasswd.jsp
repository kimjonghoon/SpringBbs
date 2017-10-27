<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.5.22</div>

<h1>비밀번호 변경에서의 빈 유효성 검사</h1>

<em class="filename">Password.java</em>
<pre class="prettyprint">
package net.java_school.user;

import javax.validation.constraints.Size;

public class Password {

    @Size(min=4, message="패스워드는 4자 이상이어야 합니다.")
    private String currentPasswd;
    
    @Size(min=4, message="패스워드는 4자 이상이어야 합니다.")
    private String newPasswd;

    public String getCurrentPasswd() {
        return currentPasswd;
    }
    public void setCurrentPasswd(String currentPasswd) {
        this.currentPasswd = currentPasswd;
    }
    public String getNewPasswd() {
        return newPasswd;
    }
    public void setNewPasswd(String newPasswd) {
        this.newPasswd = newPasswd;
    }
}
</pre>

<em class="filename">UsersController.java</em>
<pre class="prettyprint">
@RequestMapping(value="/changePasswd", method=RequestMethod.GET)
public String changePasswd(Principal principal, Model model) {
    User user = userService.getUser(principal.getName());
    model.addAttribute(WebContants.USER_KEY, user);
    <strong>model.addAttribute("password", new Password());</strong>
    
    return "users/changePasswd";
}

@RequestMapping(value="/changePasswd", method=RequestMethod.POST)
public String changePasswd(@Valid Password password,
        BindingResult bindingResult,
        Model model,
        Principal principal) {

    if (bindingResult.hasErrors()) {
        User user = userService.getUser(principal.getName());
        model.addAttribute(WebContants.USER_KEY, user);
        return "users/changePasswd";
    }
    
    int check = userService.changePasswd(password.getCurrentPasswd(),
    		password.getNewPasswd(), principal.getName());
    
    if (check &lt; 1) {
        throw new RuntimeException(WebContants.CHANGE_PASSWORD_FAIL);
    }

    return "redirect:/users/changePasswd_confirm";
}
</pre>

<em class="filename">changePasswd.jsp</em>
<pre class="prettyprint">
<strong>
&lt;%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %&gt;

&lt;sf:form id="changePasswordForm" action="changePasswd" method="post"
        commandName="password" onsubmit="return check();"&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;현재 비밀번호&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:password path="currentPasswd" /&gt;&lt;br /&gt;
        &lt;sf:errors path="currentPasswd" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;변경 비밀번호&lt;/td&gt;
    &lt;td&gt;
        <strong>&lt;sf:password path="newPasswd" /&gt;&lt;br /&gt;
        &lt;sf:errors path="newPasswd" cssClass="error" /&gt;</strong>
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;변경 비밀번호 확인&lt;/td&gt;
    &lt;td&gt;
        &lt;input type="password" name="confirm" /&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="확인" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
<strong>&lt;/sf:form&gt;</strong>
</pre>

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

