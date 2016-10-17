<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div id="last-modified">Last Modified : 2015.9.18</div>

<h1>스프링 시큐리티에서 접근 거부 상황 다루기</h1>

ROLE_USER 권한만 가진 사용자가 http://localhost:8080/admin으로 접근할 때  
에러 페이지로 이동할 것을 기대했으나 다음과 같이 아무 내용이 없는 페이지를 보여주고 있음을 확인했다.<br />

<img src="https://lh3.googleusercontent.com/-NWqp6V9oM4k/VeBGsEQyPYI/AAAAAAAACpA/ruMGGXWTDz0/s590-Ic42/blank.png" alt="blank page" /><br />

web.xml에서 403 에러 페이지 설정을 주석 처리했다.<br />

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;!--
  &lt;error-page&gt;
    &lt;error-code&gt;403&lt;/error-code&gt;
    &lt;location&gt;/WEB-INF/jsp/error.jsp&lt;/location&gt;
  &lt;/error-page&gt;
--&gt;
  &lt;error-page&gt;
    &lt;error-code&gt;404&lt;/error-code&gt;
    &lt;location&gt;/WEB-INF/jsp/error.jsp&lt;/location&gt;
  &lt;/error-page&gt;

  &lt;error-page&gt;
    &lt;error-code&gt;500&lt;/error-code&gt;
    &lt;location&gt;/WEB-INF/jsp/error.jsp&lt;/location&gt;
  &lt;/error-page&gt;
</pre>

다시 http://localhost:8080/admin을 방문하면 이번에는 톰캣이 보여주는 403페이지를 만났다.<br />

<img src="https://lh3.googleusercontent.com/-L4XewThzRpU/VeAyOauwXcI/AAAAAAAACoo/RVIqhMVczAM/s590-Ic42/403.png" alt="HTTP 403 Status" /><br />

톰캣이 보여주는 403 에러 페이지나 공백 페이지가 보이지 않도록 수정해 보자.<br />

<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;http&gt;
  <strong>&lt;access-denied-handler error-page="/403" /&gt;</strong>
  &lt;intercept-url pattern="/" access="permitAll"/&gt;
  &lt;intercept-url pattern="/users/bye_confirm" access="permitAll"/&gt;
  &lt;intercept-url pattern="/users/welcome" access="permitAll"/&gt;
  &lt;intercept-url pattern="/users/signUp" access="permitAll"/&gt;
  &lt;intercept-url pattern="/users/login" access="permitAll"/&gt;
  &lt;intercept-url pattern="/images/**" access="permitAll"/&gt;
  &lt;intercept-url pattern="/css/**" access="permitAll"/&gt;
  &lt;intercept-url pattern="/js/**" access="permitAll"/&gt;
  &lt;intercept-url pattern="/admin/**" access="hasRole('ROLE_ADMIN')"/&gt;
  &lt;intercept-url pattern="/**" access="hasAnyRole('ROLE_ADMIN','ROLE_USER')"/&gt;
  
</pre>

<em class="path">&lt;access-denied-handler error-page="/403" /&gt;</em>를 추가했다.<br />
error-page 속성값 /403은 요청 URL로, 이 설정만으로 접근이 금지되는 상황에서 /403.jsp 페이지로 이동하지 않는다.<br />
이 설정만 하고 테스트하면 http://localhost:8080/403을 요청하게 되고, 결과적으로 에러 페이지에서 
404 메시지를 보게 된다.<br />
WEB-INF/jsp/ 디렉터리에 403.jsp 파일을 만들고 HomeController에 다음을 추가한다.<br />

<em class="filename">HomeController.java</em>
<pre class="prettyprint">
@RequestMapping(value="/403", method=RequestMethod.GET)
public String error() {
  return "403";
}
</pre>

mvn clean compile war:inplace로 컴파일하고,
톰캣을 재실행한 후 http://localhost:8080/admin을 요청한다.
로그인한 사용자가 ROLE_USER 권한만 가진 사용자라면 /403.jsp가 보일 것이다.<br />

<h3>AccessDeniedHandler 구현</h3>
접근 권한이 없어 에러 페이지로 이동하는 상황에서 수행해야 할 비즈니스 로직이 있다면  
<em class="path">org.springframework.security.web.access.AccessDeniedHandler</em>를 구현해야 한다.<br />
security.xml 파일을 다음과 같이 수정한다.<br />

<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;access-denied-handler <strong>ref="my403"</strong> /&gt;
</pre>

security.xml에 다음을 추가한다.<br />
 
<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;beans:bean id="my403" class="net.java_school.spring.MyAccessDeniedHandler"&gt;
  &lt;beans:property name="errorPage" value="403" /&gt;
&lt;/beans:bean&gt;
</pre>

security.xml에 추가한 설정대로 AccessDeniedHandler를 구현하는 MyAccessDeniedHandler를 생성한다.<br />

<em class="filename">MyAccessDeniedHandler.java</em>
<pre class="prettyprint">
package net.java_school.spring;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class MyAccessDeniedHandler implements AccessDeniedHandler {

  private String errorPage;

  public void setErrorPage(String errorPage) {
    this.errorPage = errorPage;
  }

  @Override
  public void handle(HttpServletRequest req, HttpServletResponse resp, AccessDeniedException e)
    throws IOException, ServletException {
    //TODO 수행할 비즈니스 로직
    req.getRequestDispatcher(errorPage).forward(req, resp);
  }

}
</pre>

다음은 테스트에 사용한 /403.jsp 파일 코드이다.<br />
이 페이지는 스프링 시큐리티 태그를 사용할 수 있으므로 header.jsp 파일을 인클루드하고 있다.<br />

<em class="filename">/403.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%
String contextPath = request.getContextPath();
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;403&lt;/title&gt;
&lt;link rel="stylesheet" href="&lt;%=contextPath %&gt;/css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript" src="&lt;%=contextPath %&gt;/js/jquery-1.11.3.min.js"&gt;&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        <strong>&lt;%@ include file="inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="main-menu"&gt;
        &lt;%@ include file="inc/main-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;
            &lt;div id="url-navi"&gt;Error&lt;/div&gt;

&lt;h1&gt;403&lt;/h1&gt;
Access is Denied.

        &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Error&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="inc/extra.jsp" %&gt;    
    &lt;/div&gt;
    
    &lt;div id="footer"&gt;
        &lt;%@ include file="inc/footer.jsp" %&gt;
    &lt;/div&gt;
        
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>