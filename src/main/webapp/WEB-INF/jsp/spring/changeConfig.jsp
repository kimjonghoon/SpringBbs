<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.1.24</div>

<h1>스프링 웹 애플리케이션을 아파치 톰캣 연동 환경에서 테스트</h1>

2014년 1월 24일 현재 테스트 실패!! -- 수정할 것<br />

스프링 웹 애플리케이션을 아파치와 톰캣이 연동되는 상황에서 테스트한다.<br />
이미지, CSS, 자바스크립트와 같은 정적인 컨텐츠는 앞단에서 아파치가 처리하도록 할 것이다.<br />

이클립스에서 Maven Project 를 선택하여 프로젝트를 만든다.<br />
메이븐 아키타입은 maven-archetype-webapp 를 선택하다.<br />

pom.xml 파일을 다음과 같이 수정한다.<br />
아래 파일은 spring-bbs 프로젝트의 pom.xml 파일과 같다.<br />

<em class="filename">pom.xml</em>
<pre class="brush: xml;">
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
		http://maven.apache.org/maven-v4_0_0.xsd"&gt;
	&lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  
	&lt;groupId&gt;net.java_school&lt;/groupId&gt;
	&lt;artifactId&gt;coreweb&lt;/artifactId&gt;
	&lt;packaging&gt;war&lt;/packaging&gt;
	&lt;version&gt;0.0.1-SNAPSHOT&lt;/version&gt;
	&lt;name&gt;coreweb Maven Webapp&lt;/name&gt;
	&lt;url&gt;http://maven.apache.org&lt;/url&gt;

	&lt;dependencies&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;junit&lt;/groupId&gt;
			&lt;artifactId&gt;junit&lt;/artifactId&gt;
			&lt;version&gt;3.8.1&lt;/version&gt;
			&lt;scope&gt;test&lt;/scope&gt;
		&lt;/dependency&gt;
		&lt;!-- Spring --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.springframework&lt;/groupId&gt;
			&lt;artifactId&gt;spring-context&lt;/artifactId&gt;
			&lt;version&gt;4.0.0.RELEASE&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.springframework&lt;/groupId&gt;
			&lt;artifactId&gt;spring-webmvc&lt;/artifactId&gt;
			&lt;version&gt;4.0.0.RELEASE&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.springframework&lt;/groupId&gt;
			&lt;artifactId&gt;spring-jdbc&lt;/artifactId&gt;
			&lt;version&gt;4.0.0.RELEASE&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;!-- AspectJ --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.aspectj&lt;/groupId&gt;
			&lt;artifactId&gt;aspectjrt&lt;/artifactId&gt;
			&lt;version&gt;1.7.4&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;!-- Spring-security --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
			&lt;artifactId&gt;spring-security-web&lt;/artifactId&gt;
			&lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
			&lt;artifactId&gt;spring-security-config&lt;/artifactId&gt;
			&lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.springframework.security&lt;/groupId&gt;
			&lt;artifactId&gt;spring-security-taglibs&lt;/artifactId&gt;
			&lt;version&gt;3.2.0.RELEASE&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;!-- MyBatis --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.mybatis&lt;/groupId&gt;
			&lt;artifactId&gt;mybatis-spring&lt;/artifactId&gt;
			&lt;version&gt;1.1.1&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;!-- Hibernate Validator --&gt;
		&lt;dependency&gt;
		   &lt;groupId&gt;org.hibernate&lt;/groupId&gt;
		   &lt;artifactId&gt;hibernate-validator&lt;/artifactId&gt;
		   &lt;version&gt;5.0.2.Final&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
		   &lt;groupId&gt;javax.el&lt;/groupId&gt;
		   &lt;artifactId&gt;javax.el-api&lt;/artifactId&gt;
		   &lt;version&gt;2.2.4&lt;/version&gt;
		   &lt;scope&gt;provided&lt;/scope&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
		   &lt;groupId&gt;org.glassfish.web&lt;/groupId&gt;
		   &lt;artifactId&gt;javax.el&lt;/artifactId&gt;
		   &lt;version&gt;2.2.4&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;!-- File Upload --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.apache.commons&lt;/groupId&gt;
			&lt;artifactId&gt;commons-io&lt;/artifactId&gt;
			&lt;version&gt;1.3.2&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;commons-fileupload&lt;/groupId&gt;
			&lt;artifactId&gt;commons-fileupload&lt;/artifactId&gt;
			&lt;version&gt;1.3&lt;/version&gt;
		&lt;/dependency&gt;        
		&lt;!-- Logging --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;log4j&lt;/groupId&gt;
			&lt;artifactId&gt;log4j&lt;/artifactId&gt;
			&lt;version&gt;1.2.12&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;!-- Servlet --&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;org.apache.tomcat&lt;/groupId&gt;
			&lt;artifactId&gt;tomcat-servlet-api&lt;/artifactId&gt;
			&lt;version&gt;7.0.30&lt;/version&gt;
			&lt;scope&gt;provided&lt;/scope&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;javax.servlet.jsp&lt;/groupId&gt;
			&lt;artifactId&gt;jsp-api&lt;/artifactId&gt;
			&lt;version&gt;2.1&lt;/version&gt;
			&lt;scope&gt;provided&lt;/scope&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;taglibs&lt;/groupId&gt;
			&lt;artifactId&gt;standard&lt;/artifactId&gt;
			&lt;version&gt;1.1.2&lt;/version&gt;
		&lt;/dependency&gt;
		&lt;dependency&gt;
			&lt;groupId&gt;javax.servlet.jsp.jstl&lt;/groupId&gt;
			&lt;artifactId&gt;jstl-api&lt;/artifactId&gt;
			&lt;version&gt;1.2&lt;/version&gt;
			&lt;exclusions&gt;
				&lt;exclusion&gt;
					&lt;groupId&gt;javax.servlet&lt;/groupId&gt;
					&lt;artifactId&gt;servlet-api&lt;/artifactId&gt;
				&lt;/exclusion&gt;
			&lt;/exclusions&gt;
		&lt;/dependency&gt;
	&lt;/dependencies&gt;
	
	&lt;build&gt;
	&lt;finalName&gt;coreweb&lt;/finalName&gt;
	&lt;/build&gt;
	
&lt;/project&gt;
</pre>

web.xml 파일을 아래 내용으로 수정한다.<br />
이때 필터는 인코딩 필터가 먼저 수행되도록 앞에 두어야 한다.<br />

<em class="filename">web.xml</em>
<pre class="brush: xml;">
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
		
	&lt;display-name&gt;coreweb&lt;/display-name&gt;

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

	&lt;filter&gt;
		&lt;filter-name&gt;springSecurityFilterChain&lt;/filter-name&gt;
		&lt;filter-class&gt;
			org.springframework.web.filter.DelegatingFilterProxy
		&lt;/filter-class&gt;
	&lt;/filter&gt;

	&lt;filter-mapping&gt;
		&lt;filter-name&gt;encodingFilter&lt;/filter-name&gt;
		&lt;url-pattern&gt;/*&lt;/url-pattern&gt;
	&lt;/filter-mapping&gt;

	&lt;filter-mapping&gt;
		&lt;filter-name&gt;springSecurityFilterChain&lt;/filter-name&gt;
		&lt;url-pattern&gt;/*&lt;/url-pattern&gt;
	&lt;/filter-mapping&gt;

	&lt;servlet&gt;
		&lt;servlet-name&gt;coreweb&lt;/servlet-name&gt;
		&lt;servlet-class&gt;org.springframework.web.servlet.DispatcherServlet&lt;/servlet-class&gt;
		&lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
	&lt;/servlet&gt;

	&lt;servlet-mapping&gt;
		&lt;servlet-name&gt;coreweb&lt;/servlet-name&gt;
		&lt;url-pattern&gt;/&lt;/url-pattern&gt;
	&lt;/servlet-mapping&gt;

	&lt;error-page&gt;
		&lt;error-code&gt;403&lt;/error-code&gt;
		&lt;location&gt;/WEB-INF/jsp/noAuthority.jsp&lt;/location&gt;
	&lt;/error-page&gt;

&lt;/web-app&gt;
</pre>

web.xml 파일에서 DispatcherServlet 이름을 coreweb 이므로 
coreweb-servlet.xml 이라는 이름으로 스프링 설정파일 WEB-INF 폴더안에 만들어야 한다.<br />

<em class="filename">coreweb-servlet.xml</em>
<pre class="brush: xml;">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:security="http://www.springframework.org/schema/security" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:p="http://www.springframework.org/schema/p"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
		http://www.springframework.org/schema/security
		http://www.springframework.org/schema/security/spring-security-3.2.xsd
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc-4.0.xsd
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context-4.0.xsd"&gt;

	&lt;security:global-method-security pre-post-annotations="enabled" /&gt;
	
	&lt;!-- 스프링의 DispatcherServet에게 정적인 자원을 알려준다.  --&gt;
	&lt;mvc:resources location="/images/" mapping="/images/**" /&gt;
	&lt;mvc:resources location="/css/" mapping="/css/**" /&gt;
		
	&lt;mvc:annotation-driven /&gt;
	
	&lt;mvc:view-controller path="/" view-name="index" /&gt;
	
	&lt;context:component-scan 
		base-package="net.java_school.test" /&gt;
	
	&lt;!-- ViewResolver --&gt;
	&lt;bean id="internalResourceViewResolver"
		class="org.springframework.web.servlet.view.InternalResourceViewResolver"&gt;
		&lt;property name="viewClass"&gt;
			&lt;value&gt;org.springframework.web.servlet.view.JstlView&lt;/value&gt;
		&lt;/property&gt;
		&lt;property name="prefix"&gt;
			&lt;value&gt;/WEB-INF/jsp/&lt;/value&gt;
		&lt;/property&gt;
		&lt;property name="suffix"&gt;
			&lt;value&gt;.jsp&lt;/value&gt;
		&lt;/property&gt;
	&lt;/bean&gt;
	
&lt;/beans&gt;
</pre>


applicationContex.xml 과 security.xml 파일을 만든다.

<em class="filename">applicationContex.xml</em>
<pre class="code">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans-3.2.xsd"&gt;
	
	&lt;bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean"&gt;
		&lt;property name="dataSource" ref="dataSource" /&gt;
		&lt;property name="configLocation" value="classpath:net/java_school/mybatis/Configuration.xml" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="dataSource" 
		class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"&gt;
		&lt;property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/&gt;
		&lt;property name="url" value="jdbc:oracle:thin:@127.0.0.1:1521:XE"/&gt;
		&lt;property name="username" value="STRUTS2"/&gt;
		&lt;property name="password" value="BBS"/&gt;
		&lt;property name="maxActive" value="100"/&gt;
		&lt;property name="maxWait" value="1000"/&gt;
		&lt;property name="poolPreparedStatements" value="true"/&gt;
		&lt;property name="defaultAutoCommit" value="true"/&gt;
		&lt;property name="validationQuery" value=" SELECT 1 FROM DUAL" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="multipartResolver" 
		class="org.springframework.web.multipart.commons.CommonsMultipartResolver"
    	p:maxUploadSize="104857600" p:maxInMemorySize="10485760" /&gt;
	    
&lt;/beans&gt;
</pre>

<em class="filename">security.xml</em>
<pre class="code">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;

&lt;beans:beans xmlns="http://www.springframework.org/schema/security"
	xmlns:beans="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="
		http://www.springframework.org/schema/beans
		http://www.springframework.org/schema/beans/spring-beans-4.0.xsd
		http://www.springframework.org/schema/security
		http://www.springframework.org/schema/security/spring-security-3.2.xsd"&gt;

	&lt;http auto-config="true" use-expressions="true"&gt;
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
			default-target-url="/bbs/list" /&gt;
		
		&lt;logout 
			logout-success-url="/users/login" 
			invalidate-session="true" /&gt;
		
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

/WEB-INF/ 폴더에 jsp 라는 폴더를 만들고 그 안에 index.jsp 파일을 만든다.
설정에 따르면 이 파일은 홈페이지가 된다.<br />

<em class="filename">index.jsp</em>
<pre class="code">
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;Insert title here&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
홈페이지
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h2>Ubuntu 12.04 LTS 시스템에서 아파치 톰캣 연동</h2>
아파치와 톰캣은 이미 설치되어 있어야 한다.<br />

<em class="filename">/etc/hosts 편집</em>
<pre class="code">
sudo gedit /etc/hosts
</pre>
<pre class="code">
<strong>
127.0.0.1 localhost
127.0.0.1 gildong.hong
127.0.0.1 www.gildong.hong
</strong>
</pre>

<em class="filename">mod_jk 설치와 설정</em>
<pre class="code">
sudo apt-get install libapache2-mod-jk
</pre>

<em class="filename">server.xml 다음 주석 제거</em>
<pre class="code">
sudo gedit /etc/tomcat7/server.xml
</pre>
<pre class="code">
<strong>
&lt;Connector port="8009" protocol="AJP/1.3" redirectPort="8443" /&gt;
</strong>
</pre>

<em class="filename">/etc/apache2/workers.properties 파일 생성</em>
<pre class="code">
sudo gedit /etc/apache2/workers.properties
</pre>
<pre class="code">
<strong>
worker.list=worker1
worker.worker1.type=ajp13
worker.worker1.host=localhost
worker.worker1.port=8009
</strong>
</pre>

<em class="filename">jk.conf 파일 수정</em>
<pre class="code">
sudo gedit /etc/apache2/mods-available/jk.conf
</pre>
<pre class="code">
<strong>
JkWorkersFile /etc/apache2/workers.properties
</strong>
</pre>

<em class="filename">gildong.hong 파일 생성</em>
<pre class="code">
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/gildong.hong
</pre>

<em class="filename">gildong.hong 파일 수정</em>
<pre class="code">
sudo gedit /etc/apache2/sites-available/gildong.hong
</pre>
<pre class="code">
&lt;VirtualHost *:80&gt;
	ServerAdmin webmaster@localhost
	<strong>ServerName gildong.hong
	DocumentRoot /home/kim/www2/coreweb/src/main/webapp</strong>
	&lt;Directory /&gt;
		Options FollowSymLinks
		AllowOverride None
	&lt;/Directory&gt;
	&lt;Directory <strong>/home/kim/www2/coreweb/src/main/webapp/</strong>&gt;
		Options Indexes FollowSymLinks MultiViews
		AllowOverride None
		Order allow,deny
		allow from all
	&lt;/Directory&gt;
	
	..생략..
	
	<strong>JkMount /* worker1</strong>	
&lt;/VirtualHost *:80&gt;	
</pre>


<em class="filename">server.xml 에 Host 추가</em>
<pre class="code">
sudo gedit /etc/tomcat7/server.xml
</pre>
<pre class="code">
<strong>
&lt;Host name="gildong.hong" appBase="/home/kim/www2"
	unpackWARs="true" autoDeploy="true"&gt;
        &lt;!-- 이하는 기존 Host 엘리먼트를 참조한다. --/&gt;
&lt;/Host&gt;
</strong>
</pre>

<em class="filename">/etc/tomcat7/Catalina/gildong.hong 디렉토리 생성</em>
<pre class="code">
sudo mkdir /etc/tomcat7/Catalina/gildong.hong
</pre>

<em class="filename">톰캣매니저 복사</em>
<pre class="code">
sudo cp /etc/tomcat7/Catalina/localhost/manager.xml /etc/tomcat7/Catalina/gildong.hong/
</pre>

<em class="filename">ROOT.xml 컨텍스트 파일 생성</em>
<pre class="code">
<strong>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="/home/kim/www2/coreweb/src/main/webapp"
    reloadable="true"&gt;
&lt;/Context&gt;</strong>
</pre>

이 파일을 /etc/tomcat7/Catalina/gildong.hong 에 복사한다.<br />

<h3>테스트</h3>

<pre class="code">
sudo service tomcat7 restart
sudo service apache2 restart
</pre>

http://gildong.hong:8080 방문한다.<br />
http://gildong.hong 방문한다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://thelinuz.wordpress.com/2012/05/31/modjk-on-ubuntu-12-04-apache2-virtualhost-with-tomcat6-and-sun-java6/">modjk on Ubuntu 12.04 Apache2 VirtualHost with tomcat6 and sun-java6</a></li>
	<li><a href="https://www.digitalocean.com/community/articles/how-to-set-up-apache-virtual-hosts-on-ubuntu-12-04-lts">How To Set Up Apache Virtual Hosts on Ubuntu 12.04 LTS</a></li>
	<li><a href="http://thetechnocratnotebook.blogspot.kr/2012/05/installing-tomcat-7-and-apache2-with.html">Installing Tomcat 7 and Apache2 with mod_jk on Ubuntu 12.04</a></li>
	<li><a href="http://tomcat.apache.org/tomcat-7.0-doc/virtual-hosting-howto.html">Virtual Hosting and Tomcat</a></li>
	<li><a href="http://tomcat.apache.org/connectors-doc/reference/apache.html">The Apache Tomcat Connector - Reference Guide</a></li>
</ul>
