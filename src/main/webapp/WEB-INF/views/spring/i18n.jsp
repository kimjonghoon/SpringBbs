<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div id="last-modified">Last Modified : 2016.6.26</div>

<h1>국제화</h1>

src/java/resources에 messages.properties와 messages_ko.properties 파일을 생성한다.
생성 후 프로퍼티 파일을 선택하고 컨텍스트 메뉴에서 Properties를 선택하여 Text file encoding을 UTF-8로 변경한다.<br />

<img src="https://lh3.googleusercontent.com/-UpI9nf8Shxc/VYu4YgZVcsI/AAAAAAAACkw/MYjLW-BHlgA/s640/properties-context-menu-Properties.png" alt="메시지 리소스 파일를 선택하고 컨텍스트 메뉴를 오픈하고 Properties 선택한다. " /><br />
<img src="https://lh3.googleusercontent.com/-ODBHFIXeOZA/VYu4YqxT3iI/AAAAAAAACks/d_YeGThUX30/s889/properties-UTF-8.png" alt="메시지 리소스 파일의 Text file encoding을 UTF-8로 변경한다." /><br />
<br />
메시지 리소스 파일을 작성한다.<br />
<em class="filename">messages.properties</em>
<pre class="prettyprint">
bbs.search = Search
</pre>

<em class="filename">messages_ko.properties</em>
<pre class="prettyprint">
bbs.search = 검색
</pre>

스프링 설정 파일(우리의 프로젝트에서는 spring-bbs-servlet.xml)에 메시지 소스(MessageSource) 설정을 추가한다.

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;bean id="messageSource" class="org.springframework.context.support.ReloadableResourceBundleMessageSource"&gt;
	&lt;property name="basename" value="WEB-INF/classes/messages" /&gt;
	&lt;property name="defaultEncoding" value="UTF-8" /&gt;
&lt;/bean&gt;
</pre>

ReloadableResourceBundleMessageSource 대신 ResourceBundleMessageSource를 선택할 수 있다.<br />

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;bean id="messageSource" class="org.springframework.context.support.ResourceBundleMessageSource"&gt;
	&lt;property name="basename" value="messages" /&gt;
	&lt;property name="defaultEncoding" value="UTF-8" /&gt;
&lt;/bean&gt;
</pre>

<em class="path">&lt;property name="defaultEncoding" value="UTF-8" /&gt;</em>을 생략하면 한글이 나오지 않는다.<br />
<br />
list.jsp를 열고 스프링 태그 라이브러리 지시어를 추가한다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
&lt;%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%&gt;
</pre>

검색 폼에서 서밋 버튼 value를 수정한다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
&lt;input type="submit" value="<strong>&lt;spring:message code="bbs.search" /&gt;</strong>" /&gt;
</pre>

<h3>국제화 예제 설명</h3>
spring-bbs-servlet.xml에 추가한 설정은 메시지 소스에 대한 설정이다.<br />
메시지 소스(MessageSource)는 로케일을 보고 메시지를 결정하는 컴포넌트다.<br />
구현체로 ResourceBundleMessageSource와 ReloadableResourceBundleMessageSource가 있다.<br />
ResourceBundleMessageSource는 클래스 패스에 있는 리소스만 접근할 수 있다.<br />
ReloadableResourceBundleMessageSource는 리소스가 파일 시스템에 있으면 어디든 접근할 수 있다.<br />
LocaleResolver는 로케일을 결정하는 컴포넌트다.<br />
spring-bbs-servlet.xml에서 LocaleResolver에 대한 설정이 없다.<br />
설정을 생략하면 디폴트로 AcceptHeaderLocaleResolver가 선택된다.<br />
AcceptHeaderLocaleResolver는 요청 헤더의 "accept-language"에 설정된 로케일을 사용한다.<br />
이 헤더값에는 운영체제의 로케일이 들어간다.<br />
이경우 사용자가 로케일을 변경할 수 없다.<br />
사용자가 로케일을 변경할 수 있게 하려면 LocaleResolver로 SessionLocaleResolver 나 CookieLocaleResolver를 선택해야 하고
LocaleChangeInterceptor가 필요하다.<br />
다음 링크에서 사용자가 로케일을 변경하는 예제를 볼 수 있다.<br /> 
<a href="http://www.mkyong.com/spring-mvc/spring-mvc-internationalization-example/">http://www.mkyong.com/spring-mvc/spring-mvc-internationalization-example/</a>
