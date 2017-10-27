<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.5.20</div>

<h1>웹 요청 보안</h1>

<h2>Spring Security 의존 라이브러리 설정 추가</h2>

<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;!-- Spring-security --&gt;
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
	&lt;artifactId&gt;spring-security-web&lt;/artifactId&gt;
	&lt;version&gt;3.2.5.RELEASE&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
	&lt;artifactId&gt;spring-security-config&lt;/artifactId&gt;
	&lt;version&gt;3.2.5.RELEASE&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
	&lt;artifactId&gt;spring-security-taglibs&lt;/artifactId&gt;
	&lt;version&gt;3.2.5.RELEASE&lt;/version&gt;
&lt;/dependency&gt;
</pre>

Spring Security를 사용하기 위해서 회원과 권한 테이블이 필요하다.<br />
회원 테이블은 member를 그대로 사용한다.<br />
권한 테이블을 새로 만들고 테스트를 위한 데이터를 인서트한다.<br />

<h2>권한 테이블 생성과 테스트 레코드 추가</h2>
<pre class="prettyprint">
CREATE TABLE authorities (
  email VARCHAR2(60) NOT NULL,
  authority VARCHAR2(20) NOT NULL,
  CONSTRAINT fk_authorities FOREIGN KEY(email) REFERENCES member(email)
);

CREATE UNIQUE INDEX ix_authorities ON authorities(email,authority); 

INSERT INTO member VALUES ('hong@gmail.org','1111','홍길동','010-1111-1111');
INSERT INTO member VALUES ('im@gmail.org','1111','임꺽정','010-1111-2222');

INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_USER');
INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_ADMIN');
INSERT INTO authorities VALUES ('im@gmail.org','ROLE_USER');

commit;
</pre>

ROLE_USER은 일반 사용자 권한, ROLE_ADMIN은 관리자 권한이다.<br />
홍길동은 일반 사용자 권한과 관리자 권한 모두를 가지고, 임꺽정은 일반 사용자 권한만 갖는다.<br />



<h2>스프링 시큐리티 설정파일 생성</h2>
스프링 시큐리티만을 위한 스프링 설정 파일을 /WEB-INF 폴더에 security.xml란 이름으로 생성한다.<br />

<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;

&lt;beans:beans xmlns="http://www.springframework.org/schema/security"
	xmlns:beans="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/security
		http://www.springframework.org/schema/security/spring-security.xsd"&gt;

	&lt;http auto-config="true" use-expressions="true"&gt;
		&lt;intercept-url pattern="/users/bye_confirm" access="permitAll" /&gt;
		&lt;intercept-url pattern="/users/welcome" access="permitAll" /&gt;
		&lt;intercept-url pattern="/users/signUp" access="permitAll" /&gt;
		&lt;intercept-url pattern="/users/login" access="permitAll" /&gt;
		&lt;intercept-url pattern="/images/**" access="permitAll" /&gt;
		&lt;intercept-url pattern="/css/**" access="permitAll" /&gt;
		&lt;intercept-url pattern="/admin/**" access="hasRole('ROLE_ADMIN')"/&gt;
		&lt;intercept-url pattern="/users/**" access="hasAnyRole('ROLE_ADMIN','ROLE_USER')"/&gt;
		&lt;intercept-url pattern="/bbs/**" access="hasAnyRole('ROLE_ADMIN','ROLE_USER')" /&gt;
		
		&lt;form-login 
			login-page="/users/login" 
			authentication-failure-url="/users/login?login_error=1" 
			default-target-url="/bbs/list?boardCd=free&amp;amp;page=1" /&gt;
		
		&lt;logout 
			logout-success-url="/users/login" 
			invalidate-session="true"  /&gt;
		
	&lt;/http&gt;

	&lt;authentication-manager&gt;
		&lt;authentication-provider&gt;
			&lt;jdbc-user-service 
				data-source-ref="dataSource"
				users-by-username-query="select email as username,passwd as password,1 as enabled 
					from MEMBER where email = ?"
				authorities-by-username-query="select email as username,authority 
					from AUTHORITIES where email = ?" /&gt;
		&lt;/authentication-provider&gt;
	&lt;/authentication-manager&gt;
		
&lt;/beans:beans&gt;
</pre>

spring-bbs-servlet.xml파일에서 빈 설정만을 분리하여 applicationContext.xml 파일로 /WEB-INF 폴더에 만든다.<br />

<em class="filename">applicationContext.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd"&gt;
	<strong>
	&lt;bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean"&gt;
		&lt;property name="dataSource" ref="dataSource" /&gt;
		&lt;property name="configLocation" value="classpath:net/java_school/mybatis/Configuration.xml" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="dataSource" 
		class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"&gt;
		&lt;property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/&gt;
		&lt;property name="url" value="jdbc:oracle:thin:@127.0.0.1:1521:XE"/&gt;
		&lt;property name="username" value="java"/&gt;
		&lt;property name="password" value="school"/&gt;
		&lt;property name="maxActive" value="100"/&gt;
		&lt;property name="maxWait" value="1000"/&gt;
		&lt;property name="poolPreparedStatements" value="true"/&gt;
		&lt;property name="defaultAutoCommit" value="true"/&gt;
		&lt;property name="validationQuery" value=" SELECT 1 FROM DUAL" /&gt;
	&lt;/bean&gt;
    
	&lt;bean id="multipartResolver"
		class="org.springframework.web.multipart.commons.CommonsMultipartResolver"
		p:maxUploadSize="104857600" p:maxInMemorySize="10485760" /&gt;
	</strong>
&lt;/beans&gt;
</pre>

spring-bbs-servlet.xml 파일을 수정한다.<br />

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans"
	<strong>xmlns:security="http://www.springframework.org/schema/security"</strong> 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:mybatis="http://mybatis.org/schema/mybatis-spring"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
		<strong>http://www.springframework.org/schema/security
		http://www.springframework.org/schema/security/spring-security.xsd</strong>
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context.xsd
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc.xsd
		http://mybatis.org/schema/mybatis-spring 
		http://mybatis.org/schema/mybatis-spring.xsd"&gt;
	<strong>	
	&lt;security:global-method-security pre-post-annotations="enabled" /&gt;
	</strong>
	&lt;!-- 스프링의 DispatcherServet에게 정적인 자원을 알려준다.  --&gt;
	&lt;mvc:resources location="/images/" mapping="/images/**" /&gt;
	&lt;mvc:resources location="/css/" mapping="/css/**" /&gt;
	
	&lt;mvc:annotation-driven /&gt;

	&lt;context:component-scan
        	base-package="net.java_school.board,
			net.java_school.board.spring,
			net.java_school.soccer,	
			net.java_school.user,
			net.java_school.user.spring" /&gt;

	&lt;mybatis:scan base-package="net.java_school.mybatis" /&gt;
	
	&lt;!-- ViewResolver --&gt;
	&lt;bean id="internalResourceViewResolver"
			class="org.springframework.web.servlet.view.InternalResourceViewResolver"&gt;
		&lt;property name="viewClass"&gt;
			&lt;value&gt;org.springframework.web.servlet.view.JstlView&lt;/value&gt;
		&lt;/property&gt;
		&lt;property name="prefix"&gt;
			&lt;value&gt;/WEB-INF/views/&lt;/value&gt;
		&lt;/property&gt;
		&lt;property name="suffix"&gt;
			&lt;value&gt;.jsp&lt;/value&gt;
		&lt;/property&gt;
	&lt;/bean&gt;
	
&lt;/beans&gt;	
</pre>


<h2>web.xml 수정</h2>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="ISO-8859-1"?&gt;
&lt;!--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--&gt;


&lt;web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true"&gt;
    
	&lt;display-name&gt;Spring BBS&lt;/display-name&gt;
	<strong>
	&lt;context-param&gt;
		&lt;param-name&gt;contextConfigLocation&lt;/param-name&gt;
		&lt;param-value&gt;
			/WEB-INF/applicationContext.xml
			/WEB-INF/security.xml
		&lt;/param-value&gt;
	&lt;/context-param&gt;

	&lt;listener&gt;
		&lt;listener-class&gt;
		org.springframework.web.context.ContextLoaderListener
		&lt;/listener-class&gt;	
	&lt;/listener&gt;
	
	&lt;listener&gt;
		&lt;listener-class&gt;
		org.springframework.security.web.session.HttpSessionEventPublisher
		&lt;/listener-class&gt;
	&lt;/listener&gt;
	</strong>
	&lt;filter&gt;
		&lt;filter-name&gt;encodingFilter&lt;/filter-name&gt;
		&lt;filter-class&gt;org.springframework.web.filter.CharacterEncodingFilter&lt;/filter-class&gt;
		&lt;init-param&gt;
			&lt;param-name&gt;encoding&lt;/param-name&gt;
			&lt;param-value&gt;UTF-8&lt;/param-value&gt;
		&lt;/init-param&gt;
		&lt;init-param&gt;
			&lt;param-name&gt;forceEncoding&lt;/param-name&gt;
			&lt;param-value&gt;true&lt;/param-value&gt;
		&lt;/init-param&gt;
	&lt;/filter&gt;
	<strong>
	&lt;filter&gt;
		&lt;filter-name&gt;springSecurityFilterChain&lt;/filter-name&gt;
		&lt;filter-class&gt;
		org.springframework.web.filter.DelegatingFilterProxy
		&lt;/filter-class&gt;
	&lt;/filter&gt;
	</strong>
	&lt;filter-mapping&gt;
		&lt;filter-name&gt;encodingFilter&lt;/filter-name&gt;
		&lt;url-pattern&gt;/*&lt;/url-pattern&gt;
	&lt;/filter-mapping&gt;
	<strong>
	&lt;filter-mapping&gt;
		&lt;filter-name&gt;springSecurityFilterChain&lt;/filter-name&gt;
		&lt;url-pattern&gt;/*&lt;/url-pattern&gt;
	&lt;/filter-mapping&gt;	
	</strong>
	&lt;servlet&gt;
		&lt;servlet-name&gt;spring-bbs&lt;/servlet-name&gt;
		&lt;servlet-class&gt;org.springframework.web.servlet.DispatcherServlet&lt;/servlet-class&gt;
		&lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
	&lt;/servlet&gt;

	&lt;servlet-mapping&gt;
		&lt;servlet-name&gt;spring-bbs&lt;/servlet-name&gt;
		&lt;url-pattern&gt;/&lt;/url-pattern&gt;
	&lt;/servlet-mapping&gt;
	<strong>
	&lt;error-page&gt;
		&lt;error-code&gt;403&lt;/error-code&gt;
		&lt;location&gt;/WEB-INF/views/noAuthority.jsp&lt;/location&gt;
	&lt;/error-page&gt;
	</strong>
&lt;/web-app&gt;
</pre>

UsersController.java에서 로그인과 로그아웃 메소드를 삭제한다.<br />

<em class="filename">UsersController.java</em>
<pre class="prettyprint">
/*	
@RequestMapping(value="/login", method=RequestMethod.POST)
public String login(String email, String passwd, HttpSession session) {
	User user = userService.login(email, passwd);
	if (user != null) {
		session.setAttribute(WebContants.USER_KEY, user);
		return "redirect:/users/changePasswd";
	} else {
		return "redirect:/users/login";
	}
}

@RequestMapping(value="/logout", method=RequestMethod.GET)
public String logout(HttpSession session) {
	session.removeAttribute(WebContants.USER_KEY);
	//로그아웃하면 로그인페이지로
	return "redirect:/users/login";
}
*/
</pre>

<h2>JSP</h2>

<em class="filename">/WEB-INF/views/noAuthority.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;403&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
권한이 없습니다.
&lt;/body&gt;
&lt;/html&gt;
</pre>

login.jsp, header.jsp, loginUsers-menu.jsp를 수정한다.<br />

<em class="filename">/WEB-INF/views/users/login.jsp</em>
<pre class="prettyprint">
&lt;h1&gt;로그인&lt;/h1&gt;
<strong>&lt;c:if test="${not empty param.login_error }"&gt;
	&lt;h2&gt;${SPRING_SECURITY_LAST_EXCEPTION.message }&lt;/h2&gt;
&lt;/c:if&gt;</strong>
&lt;form id="loginForm" action="<strong>../j_spring_security_check</strong>" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td style="width: 200px;"&gt;Email&lt;/td&gt;
	&lt;td style="width: 390px"&gt;&lt;input type="text" name="<strong>j_username</strong>" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td&gt;Password&lt;/td&gt;
	&lt;td&gt;&lt;input type="password" name="<strong>j_password</strong>" style="width: 99%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
</pre>

<em class="filename">/WEB-INF/views/inc/header.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %&gt;
&lt;h1 style="float: left;width: 150px;"&gt;&lt;a href="../"&gt;&lt;img src="../images/ci.gif" alt="java-school logo" /&gt;&lt;/a&gt;&lt;/h1&gt;
&lt;div id="memberMenu" style="float: right;position: relative;top: 7px;"&gt;
<strong>&lt;security:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')"&gt;
	&lt;security:authentication property="principal.username" var="<strong>check</strong>" /&gt;
&lt;/security:authorize&gt;</strong>
&lt;c:choose&gt;
	&lt;c:when test="${empty check}"&gt;
		&lt;input type="button" value="로그인" onclick="location.href='../users/login'" /&gt;
		&lt;input type="button" value="회원가입" onclick="location.href='../users/signUp'" /&gt;
	&lt;/c:when&gt;
	&lt;c:otherwise&gt;
		&lt;input type="button" value="로그아웃" onclick="location.href='<strong>../j_spring_security_logout</strong>'" /&gt;
		&lt;input type="button" value="내정보수정" onclick="location.href='../users/editAccount'" /&gt;
	&lt;/c:otherwise&gt;
&lt;/c:choose&gt;
&lt;/div&gt;
</pre>

스프링 시큐리티는 사용자 정보를 세션에 담지 않으므로 수정하지 않으면 로그인 후 로그아웃/내정보수정 버튼을 볼 수 없다.
스프링 시큐리티 태그를 사용하는 예는 <a href="security-at-view-layer">뷰 레벨 보안</a>에서도 다룬다.<br />

<em class="filename">/WEB-INF/views/users/loginUsers-menu.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;회원&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="<strong>../j_spring_security_logout</strong>"&gt;로그아웃&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="editAccount"&gt;내정보수정&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="changePasswd"&gt;비밀번호 변경&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="bye"&gt;탈퇴&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

<h2>테스트</h2>
라이브러리가 추가되었으니 빌드를 한다.<br />
설정이 바뀌었으니 톰캣을 재실행한다.<br />
http://localhost:port/spring-bbs/list?boardCd=free&amp;page=1를 방문한다.<br />
로그인 페이지로 이동하면 im@gmail.org/1111로 로그인하고 게시판으로 이동하는지 확인한다.<br />
주소창에 http://localhost:port/spring-bbs/admin를 입력하여 방문을 시도한다.<br />
임꺽정은 일반 사용자 권한만 가지고 있으므로 noAuthority.jsp로 이동하게 된다.<br />

<h2>소스 수정</h2>

<em class="filename">UserMapper.xml</em>
<pre class="prettyprint">
&lt;insert id="insertAuthority"&gt;
    INSERT INTO authorities VALUES (<%="#" %>{email}, <%="#" %>{authority})
&lt;/insert&gt;

&lt;delete id="deleteAuthority"&gt;
    DELETE FROM authorities WHERE email = <%="#" %>{email}	
&lt;/delete&gt;
</pre>

<em class="filename">UserMapper.java</em>
<pre class="prettyprint">
public void insertAuthority(@Param("email") String email, @Param("authority") String authority);
  
public void deleteAuthority(@Param("email") String email);
</pre>

<em class="filename">UserService.java</em>
<pre class="prettyprint">
//회원권한 추가
public void addAuthority(String email, String authority);
</pre>

<em class="filename">UserServiceImpl.java</em>
<pre class="prettyprint">
@Override
public void addAuthority(String email, String authority) {
    userMapper.insertAuthority(email, authority);
}

@Override
public void bye(User user) {
    <strong>userMapper.deleteAuthority(user.getEmail());</strong>
    userMapper.delete(user);
}
</pre>

<em class="filename">UsersController</em>
<pre class="prettyprint">
//중간 생략..

<strong>
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import java.security.Principal;
import org.springframework.ui.Model;
</strong>

//중간 생략..

@RequestMapping(value="/signUp", method=RequestMethod.POST)
public String signUp(User user) {

    <strong>String authority = "ROLE_USER";</strong>

    userService.addUser(user);
    <strong>userService.addAuthority(user.getEmail(), authority);</strong>

    return "redirect:/users/welcome";
}

@RequestMapping(value="/editAccount", method=RequestMethod.GET)
public String editAccount(<strong>Principal principal, Model model</strong>) {
    User user = userService.getUser(<strong>principal.getName()</strong>);
    model.addAttribute(WebContants.USER_KEY, user);

    return "users/editAccount";
}

@RequestMapping(value="/editAccount", method=RequestMethod.POST)
public String editAccount(User user, <strong>Principal principal</strong>) {
	
    user.setEmail(<strong>principal.getName()</strong>);

    int check = userService.editAccount(user);
    if (check &lt; 1) {
        throw new RuntimeException(WebContants.EDIT_ACCOUNT_FAIL);
    } 

    return "redirect:/users/changePasswd";
	
}

@RequestMapping(value="/changePasswd", method=RequestMethod.GET)
public String changePasswd(<strong>Principal principal, Model model</strong>) {
    User user = userService.getUser(<strong>principal.getName()</strong>);

    model.addAttribute(WebContants.USER_KEY, user);

    return "users/changePasswd";
}

@RequestMapping(value="/changePasswd", method=RequestMethod.POST)
public String changePasswd(String currentPasswd, String newPasswd, <strong>Principal principal</strong>) {
	
    int check = userService.changePasswd(currentPasswd,newPasswd, <strong>principal.getName()</strong>);

    if (check &lt; 1) {
        throw new RuntimeException(WebContants.CHANGE_PASSWORD_FAIL);
    }	

    return "redirect:/users/changePasswd_confirm";

}

@RequestMapping(value="/bye", method=RequestMethod.POST)
public String bye(String email, String passwd, HttpServletRequest req) 
        throws ServletException {

    User user = userService.login(email, passwd);
    userService.bye(user);
    req.logout();

    return "redirect:/users/bye_confirm";
}
</pre>

<em class="filename">BbsController.java</em>
<pre class="prettyprint">
//중간 생략..

<strong>import java.security.Principal;</strong>

//중간 생략..

@RequestMapping(value="/write", method=RequestMethod.POST)
public String write(MultipartHttpServletRequest mpRequest, <strong>Principal principal</strong>) 
        throws Exception {

    //중간 생략..
    Article article = new Article();
    article.setBoardCd(boardCd);
    article.setTitle(title);
    article.setContent(content);
    article.setEmail(<strong>principal.getName()</strong>);
    
    boardService.addArticle(article);	
    
    //중간 생략..
    
    //파일데이터 삽입
    int size = fileList.size();
    for (int i = 0; i &lt; size; i++) {
        MultipartFile mpFile = fileList.get(i);
        AttachFile attachFile = new AttachFile();
        String filename = mpFile.getOriginalFilename();
        attachFile.setFilename(filename);
        attachFile.setFiletype(mpFile.getContentType());
        attachFile.setFilesize(mpFile.getSize());
        attachFile.setArticleNo(article.getArticleNo());
        attachFile.setEmail(<strong>principal.getName()</strong>);
        boardService.addAttachFile(attachFile);
    }

    //중간 생략..
}

@RequestMapping(value="/addComment", method=RequestMethod.POST)
public String addComment(Integer articleNo, 
        String boardCd, 
        Integer page, 
        String searchWord, 
        String memo,
        <strong>Principal principal</strong>) throws Exception {
		
    Comment comment = new Comment();
    comment.setArticleNo(articleNo);
    comment.setEmail(<strong>principal.getName()</strong>);
    comment.setMemo(memo);

    //생략..
}
</pre>


<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://dhappy.net/?p=260">Error creating bean with name 'sqlSessionFactory' 구글 검색(spring-mybatis 1.1.1로 교체)</a></li>
	<li><a href="http://stackoverflow.com/questions/10421588/spring-security-not-working-what-am-i-doing-wrong">시큐리티가 작동하지 않을 때는 web.xml 파일에 스프링 시큐리티에 대한 설정을 검사해야 한다.</a></li>
	<li><a href="http://static.springsource.org/spring-security/site/faq/faq.html#faq-method-security-in-web-context">컨트롤러보다는 서비스에 시큐리티 적용 권고</a></li>
	<li><a href="http://stackoverflow.com/questions/3087548/can-spring-security-use-preauthorize-on-spring-controllers-methods">컨트롤러에 시큐리티 적용-테스트 실패</a></li>
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=978-89-7914-887-9#binfo5">예제로 쉽게 배우는 스프링 프레임워크 3.0(한빛미디어) - 사카타 코이치</a></li>
	<li><a href="http://www.jpub.kr/">Spring in Action(Jpub) - 크레이그 월즈</a></li>
</ul>

