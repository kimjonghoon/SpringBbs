<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="last-modified">Last Modified : 2015.5.19</div>

<h1>Maven으로 Spring MVC 실습하기</h1>

웹 프로젝트를 위한 워크스페이스가 <em class="path">C:\www</em>라고 가정한다.<br />
명령 프롬프트로 <em class="path">C:\www</em>로 이동한다.<br />

<h2>명령 프롬프트에서 메이븐 프로젝트 생성</h2>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\www&gt;mvn archetype:generate

Choose a number or apply filter 
    (format: [groupId:]artifactId, case sensitive contains): 600:603   

Choose org.apache.maven.archetypes:maven-archetype-webapp version: 
1: 1.0-alpha-1
2: 1.0-alpha-2
3: 1.0-alpha-3
4: 1.0-alpha-4
5: 1.0
Choose a number: 5:
Define value for property 'groupId': : net.java_school
Define value for property 'artifactId': : spring-bbs
Define value for property 'version':  1.0-SNAPSHOT: :   
Define value for property 'package':  net.java_school: : spring-bbs
Confirm properties configuration:
groupId: net.java_school
artifactId: spring-bbs
version: 1.0-SNAPSHOT
package: spring-bbs
 Y: : 
</pre>
Choose a number or apply filter에서 디폴트 값 600은 maven-archetype-quickstart이다.<br />
디폴트 값 주변에서 maven-archetype-webapp를 찾아 해당 번호를 입력하거나 maven-archetype-webapp를 입력하고 진행한다.<br />
진행이 완료되면 <em class="path">C:\www</em>에 spring-bbs라는 폴더가 생긴다.<br />
<em class="path">C:\www\spring-bbs</em>가 메이븐 프로젝트의 루트 디렉토리이다.<br />
<br />
톰캣 컨텍스트 파일을 만든다.<br />
WEB-INF 바로 위인 src/main/webapp가 도큐먼트베이스(DocumentBase)이다.<br />

<em class="filename">spring-bbs.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="C:/www/spring-bbs/<strong>src/main/webapp</strong>"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>

TOMCAT_HOME/conf/Catalina/localhost 폴더에 spring-bbs.xml 파일을 복사한다.<br />
톰캣을 재실행한 후, http://localhost:port/spring-bbs를 방문하여 웹 애플리케이션이 동작하는지 확인한다.<br />


<h2>Spring MVC 테스트</h2> 
Spring MVC 테스트를 위해 다음 자바 소스를 작성한다.<br />
src/main/java 폴더가 없으면 만들고 진행한다.<br />
 
<em class="filename">Player.java</em>
<pre class="prettyprint">
package net.java_school.soccer;

public class Player {
	private String id;
	private String passwd;
	private String name;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
</pre>

<em class="filename">PlayerDao.java</em>
<pre class="prettyprint">
package net.java_school.soccer;

public class PlayerDao {

	public Player selectOne(String id) {
		Player player = new Player();
		if (id != null &amp;&amp; id.equals("1")) {
			player.setName("Lionel Messi");
		} else if (id != null &amp;&amp; id.equals("2")) {
			player.setName("Cristiano Ronaldo");
		} else {
			player.setName("Neymar");
		}
		return player;
	}

}
</pre>

<em class="filename">PlayerService.java</em>
<pre class="prettyprint">
package net.java_school.soccer;

public class PlayerService {
	private PlayerDao dao;
	
	public void setDao(PlayerDao dao) {
		this.dao = dao;
	}

	public Player getPlayer(String id) {
		return dao.selectOne(id);
	}
	
}
</pre>

<em class="filename">PlayerController.java</em>
<pre class="prettyprint">
package net.java_school.soccer;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class PlayerController implements Controller {
	
	private PlayerService service;
	
	public void setService(PlayerService service) {
		this.service = service;
	}
	
	public ModelAndView handleRequest(HttpServletRequest req,
			HttpServletResponse res) throws Exception {
		
		String id = req.getParameter("id");
		Player player = service.getPlayer(id);
		
		// 모델 생성
		Map&lt;String, Object&gt; model = new HashMap&lt;String, Object&gt;();
		model.put("player", player);
		
		//반환값인 ModelAndView 인스턴스 생성
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/WEB-INF/jsp/player/test.jsp");
		modelAndView.addAllObjects(model);
		
		return modelAndView;
		
	}
	
}
</pre>

이전 예제에서 applicationContext.xml에 해당하는 스프링 설정 파일을 만들 차례다.<br />
Spring MVC에서는 스프링 설정 파일의 이름을 약속된 이름으로 지어야 한다.<br />
이름은 web.xml에서 어떤 설정값에 의해 결정된다.<br />
따라서 이름 결정은 web.xml를 수정한 다음에 하도록 한다.<br />
web.xml를 수정한다.<br />

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
		
	&lt;filter-mapping&gt;
		&lt;filter-name&gt;encodingFilter&lt;/filter-name&gt;
		&lt;url-pattern&gt;/*&lt;/url-pattern&gt;
	&lt;/filter-mapping&gt;
	
	&lt;servlet&gt;
		&lt;servlet-name&gt;spring-bbs&lt;/servlet-name&gt;
		&lt;servlet-class&gt;org.springframework.web.servlet.DispatcherServlet&lt;/servlet-class&gt;
		&lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
	&lt;/servlet&gt;
	
	&lt;servlet-mapping&gt;
		&lt;servlet-name&gt;spring-bbs&lt;/servlet-name&gt;
		&lt;url-pattern&gt;/&lt;/url-pattern&gt;
	&lt;/servlet-mapping&gt;
 	</strong> 
&lt;/web-app&gt;
</pre>

모든 요청에 대해 setCharacterEncoding("UTF-8");를 호출하는 필터가 작동하도록 설정했다.<br />
이 필터는 다른 필터보다 먼저 작동하도록 순서에 주의해야 한다.<br />
스프링 MVC의 DispatcherServlet이라는 서블릿을 등록하고 매핑했다.<br />
DispatcherServlet의 이름을 spring-bbs라고 했으므로 스프링 설정파일의 이름은 sprng-bbs-servlet.xml으로 결정된다.
spring-bbs-servlet.xml 파일을 web.xml과 같은 위치인 /WEB-INF에 생성한다.<br />

<em class="filename">spring-bbs-servlet.xml</em> 
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc.xsd"&gt;
	
	&lt;!-- HandlerMapping --&gt;
	&lt;!--  정의 없음. BeanNameUrlHandlerMapping이 적용된다. --&gt;
	
	&lt;bean id="playerController" <strong>name ="/player/test"</strong> 
		class="net.java_school.soccer.PlayerController"
			p:service-ref="playerService" /&gt;
	
	&lt;!-- ViewResolver --&gt;
	&lt;!--  정의 없음. InternalResourceViewResolver이 적용된다. --&gt;
	
	&lt;bean id="playerService" class="net.java_school.soccer.PlayerService"&gt;
		&lt;property name="dao" ref="playerDao" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="playerDao" class="net.java_school.soccer.PlayerDao" /&gt;
	
&lt;/beans&gt;
</pre>

pom.xml 파일을 다음과 같이 수정한다.
참고로 이 파일은 Spring MVC 과정의 최종본이다.<br />
 
<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/maven-v4_0_0.xsd"&gt;
  &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  &lt;groupId&gt;net.java_school&lt;/groupId&gt;
  &lt;artifactId&gt;spring-bbs&lt;/artifactId&gt;
  &lt;packaging&gt;war&lt;/packaging&gt;
  &lt;version&gt;1.0-SNAPSHOT&lt;/version&gt;
  &lt;name&gt;spring-bbs Maven Webapp&lt;/name&gt;
  &lt;url&gt;http://maven.apache.org&lt;/url&gt;

  &lt;properties&gt;
    &lt;spring.version&gt;4.1.4.RELEASE&lt;/spring.version&gt;
    &lt;jdk.version&gt;1.7&lt;/jdk.version&gt;
  &lt;/properties&gt;
  
  &lt;dependencies&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;junit&lt;/groupId&gt;
      &lt;artifactId&gt;junit&lt;/artifactId&gt;
      &lt;version&gt;3.8.1&lt;/version&gt;
      &lt;scope&gt;test&lt;/scope&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-context&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-webmvc&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-jdbc&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;    
    &lt;!-- AspectJ --&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.aspectj&lt;/groupId&gt;
      &lt;artifactId&gt;aspectjrt&lt;/artifactId&gt;
      &lt;version&gt;1.8.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- MyBatis --&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.mybatis&lt;/groupId&gt;
      &lt;artifactId&gt;mybatis-spring&lt;/artifactId&gt;
      &lt;version&gt;1.2.2&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.mybatis&lt;/groupId&gt;
      &lt;artifactId&gt;mybatis&lt;/artifactId&gt;
      &lt;version&gt;3.2.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- commons-dbcp --&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;commons-dbcp&lt;/groupId&gt;
      &lt;artifactId&gt;commons-dbcp&lt;/artifactId&gt;
      &lt;version&gt;1.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- File Upload --&gt; 
    &lt;dependency&gt;
      &lt;groupId&gt;commons-io&lt;/groupId&gt;
      &lt;artifactId&gt;commons-io&lt;/artifactId&gt;
      &lt;version&gt;2.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;commons-fileupload&lt;/groupId&gt;
      &lt;artifactId&gt;commons-fileupload&lt;/artifactId&gt;
      &lt;version&gt;1.3.1&lt;/version&gt;
    &lt;/dependency&gt;    
    &lt;!-- Logging --&gt;                
    &lt;dependency&gt;
      &lt;groupId&gt;log4j&lt;/groupId&gt;
      &lt;artifactId&gt;log4j&lt;/artifactId&gt;
      &lt;version&gt;1.2.17&lt;/version&gt;
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
    &lt;finalName&gt;spring-bbs&lt;/finalName&gt;
      &lt;pluginManagement&gt;
        &lt;plugins&gt;
          &lt;plugin&gt;
            &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
            &lt;version&gt;3.1&lt;/version&gt;
            &lt;configuration&gt;
              &lt;source&gt;${jdk.version}&lt;/source&gt;
              &lt;target&gt;${jdk.version}&lt;/target&gt;
              &lt;compilerArgument&gt;&lt;/compilerArgument&gt;
              &lt;encoding&gt;UTF-8&lt;/encoding&gt;
            &lt;/configuration&gt;
          &lt;/plugin&gt;
        &lt;/plugins&gt;
      &lt;/pluginManagement&gt;
  &lt;/build&gt;
    
&lt;/project&gt;
</pre>

/src/main/webapp/WEB-INF/jsp/player 디렉토리를 만들고, 
test.jsp 파일을 만들어 위치시킨다.<br />

<em class="filename">test.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;TEST&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
${player.name }
&lt;/body&gt;
&lt;/html&gt;
</pre>

빌드를 한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\www\sprng-bbs&gt;mvn clean compile war:inplace
</pre>
톰캣을 재실행한 후,
http://localhost:8080/spring-bbs/player/test?id=1를 방문한다.<br />

<h3>SimpleUrlHandlerMapping</h3>
핸들러매핑 설정을 SimpleUrlHandlerMapping를 이용하는 것으로 변경한다.<br />
spring-bbs-servlet.xml 파일을 열고 아래 코드를 참조하여 수정한다.<br />
이때 id가 playerController인 bean 엘리먼트의 name 속성과 값을 지워야 한다.<br /> 
&lt;bean id="playerController" <span style="color: red;text-decoration: line-through">name="/player/test"</span>

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;!-- 중간 생략 --&gt;

&lt;!-- HandlerMapping --&gt;
&lt;bean id="handlerMapping" 
  class="<strong>org.springframework.web.servlet.handler.SimpleUrlHandlerMapping</strong>"&gt;
	
  &lt;property name="mappings"&gt;
    &lt;value&gt;
	<strong>/player/test=playerController</strong>
    &lt;/value&gt;
  &lt;/property&gt;
	
&lt;/bean&gt;

&lt;bean id="playerController" 
  class="net.java_school.soccer.PlayerController"
  p:service-ref="playerService" /&gt;
	
&lt;!-- 중간 생략 --&gt;
</pre>

톰캣을 재실행하고 http://localhost:port/spring-bbs/player/test?id=1를 방문한다.<br />

<h3>InternalResourceViewResolver</h3>
InternalResourceViewResolver는 직관적이라 이해하기 쉬운 뷰리졸버이다.<br />
spring-bbs-servlet.xml 파일을 열고 &lt;!-- ViewResolver --&gt; 부분에 다음을 추가한다.<br />

<em class="filename">spring-bbs-servlet.xml</em> 
<pre class="prettyprint">
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
</pre>

PlayerController.java을 열고 강조된 부분을 수정한다.<br />

<em class="filename">PlayerController.java</em>
<pre class="prettyprint">
//반환값인 ModelAndView 인스턴스 생성
ModelAndView modelAndView = new ModelAndView();
modelAndView.setViewName("<strong>player/test</strong>");
modelAndView.addAllObjects(model);

return modelAndView;
</pre>

InternalResourceViewResolver 설정대로 player/test는
/WEB-INF/jsp/player/test.jsp로 해석될 것이다.<br />
자바 소스가 변경되었으므로 빌드를 한다.<br />
톰캣을 재실행하고 http://localhost:port/spring-bbs/player/test?id=1를 방문한다.<br />

<h3>RequestMappingHandlerMapping</h3>
SimpleUrlHandlerMapping은 요청마다 컨트롤러가 하나씩 있어야 한다.<br />
프로젝트가 규모가 커질수록 이런 모양은 좋아 보이지 않는다.<br />
이상적인 것은 유즈 케이스별로 컨트롤러를 하나씩 두는 것이다.<br />
RequestMappingHandlerMapping으로 핸들러 매핑을 하면 그렇게 할 수 있다.<br />
<br />
RequestMappingHandlerMapping으로 핸들러 매핑을 한다는 것은 어노테이션과 
자동 스캔 기능을 이용하게 됨을 의미한다. 
spring-bbs-servlet.xml 파일을 열고 강조된 부분을 추가한다.<br />
&lt;!-- HandlerMapping --&gt;부분은 모두 제거한다.<br />

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"<strong>
	xmlns:context="http://www.springframework.org/schema/context"</strong>
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd<strong>
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context.xsd</strong>
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc.xsd"&gt;
	<strong>
	&lt;mvc:annotation-driven /&gt;
		
	&lt;context:component-scan
		base-package="net.java_school.soccer" /&gt;
	</strong>
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
	
	&lt;bean id="playerService" class="net.java_school.soccer.PlayerService"&gt;
		&lt;property name="dao" ref="playerDao" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="playerDao" class="net.java_school.soccer.PlayerDao" /&gt;
	
&lt;/beans&gt;
</pre>

<em class="path">&lt;context:component-scan base-package="net.java_school.soccer" /&gt;</em>
설정은 스프링으로 하여금 어노테이션이 적용된 컴포넌트(컴포넌트는 Dao, Service, 컨트롤러를 의미한다)를 찾아 
자동으로 등록하게 한다.<br />
이 설정으로 구체적인 핸들러 매핑 클래스에 대한 설정을 스프링 설정 파일에서 생략할 수 있는 것이다.<br />
<em class="path">&lt;mvc:annotation-driven /&gt;</em>은 스프링 MVC에서 필요한 어노테이션 기반의 
모든 기능을 사용할 수 있도록 하는 설정이다.<br />
<em class="path">&lt;context:component-scan /&gt;</em> 은 <em class="path">&lt;mvc:annotation-driven /&gt;</em>과
함께 쓰지 않으면 작동하지 않는다.<br /> 
<br />
스프링이 스캔해서 컨트롤러를 찾을 수 있도록 컨트롤러에 어노테이션을 적용해야 한다.<br />
PlayerController.java 파일을 아래와 같이 다시 작성한다.<br />

<em class="filename">PlayerController.java</em>
<pre class="prettyprint">
package net.java_school.soccer;
<strong>
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;</strong>
<strong>
@Controller
@RequestMapping("/player")</strong>
public class PlayerController {
	<strong>
	@Autowired</strong>
	private PlayerService service;
	<strong>
	@RequestMapping(value="/test", method={RequestMethod.GET, RequestMethod.POST})</strong>
	public String pickPlayer(String id, Model model) {
			
		Player player = service.getPlayer(id);
		
		model.addAttribute("player", player);
		
		return "player/test";
		
	}
	
}
</pre>


빌드하고 톰캣을 재실행한 후, http://localhost:8080/spring-bbs/player/test?id=1를 방문한다.<br />

<dl class="note">
<dt>PlayerController.java에 쓰인 어노테이션</dt>
<dd>
클래스 선언부의 @Controller는 클래스가 컨트롤러 컴포넌트임을 표시한다.<br />
클래스 선언부의 @RequestMapping("/player")는 컨트롤러가 "/player"를 포함하는 모든 요청을 담당함을 표시한다.<br />
메소드 선언부의 @RequestMapping(value="/test", method={RequestMethod.GET, RequestMethod.POST}):는
메소드가 GET 방식이나 POST 방식의 "/player/test" 요청에 호출됨을 표시한다.<br />
@Autowired를 종속변수에 적용하면 setter 없이도 종속객체가 주입된다. 종속변수 접근자가 private여도 상관없다.
</dd>
</dl>

컴포넌트 스캔 기능이 동작하므로 서비스와 Dao에 어노테이션을 적용하면 spring-bbs-servlet.xml에서 이들의 설정을 생략할 수 있다.<br />

<em class="filename">PlayerDao.java</em>
<pre class="prettyprint">
package net.java_school.soccer;
<strong>
import org.springframework.stereotype.Repository;

@Repository</strong>
public class PlayerDao {

	public Player selectOne(String id) {
		Player player = new Player();
		if (id != null &amp;&amp; id.equals("1")) {
			player.setName("Lionel Messi");
		} else if (id != null &amp;&amp; id.equals("2")) {
			player.setName("Cristiano Ronaldo");
		} else {
			player.setName("Neymar");
		}
		return player;
	}

}
</pre>

<em class="filename">PlayerService.java</em>
<pre class="prettyprint">
package net.java_school.soccer;
<strong>
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

@Service</strong>
public class PlayerService {
	@Autowired
	private PlayerDao dao;
	
	public Player getPlayer(String id) {
		return dao.selectOne(id);
	}
	
}
</pre>

어노테이션을 적용하면 스프링 설정 파일은 다음과 같이 간단해진다.<br />

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context.xsd
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc.xsd"&gt;

	&lt;mvc:annotation-driven /&gt;
		
	&lt;context:component-scan
		base-package="net.java_school.soccer" /&gt;
		
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


<h2>이클립스 작업환경 구축</h2>
이클립스를 시작하고 워크스페이스를 <em class="path">C:\www</em>로 선택한다.<br />
Project Explorer 뷰에서 마우스 오른쪽 버튼을 사용하여 컨텍스트 메뉴를 보이게 한다.<br />
Import를 사용하여 spring-bbs 프로젝트를 이클립스로 불러온다.<br />

<img alt="컨텍스트 메뉴에서 Import" src="https://lh3.googleusercontent.com/-VjWpQCEiqes/VYYV3b2GPFI/AAAAAAAACh0/-KoRbgI8nn0/s590/maven-project-import.png" /><br />
<img alt="이클립스에서 메이븐 프로젝트 Import" src="https://lh3.googleusercontent.com/-uDuAOI41Aj4/VYYV3Pmo4qI/AAAAAAAAChw/m4HA61kOVbE/s610/eclipse-with-maven.png" /><br />
진행하면서 pom.xml 파일이 바뀌면 이클립스 설정과 동기화를 해주어야 한다.<br />
<img alt="pom과 이클립스 설정 동기화" src="https://lh3.googleusercontent.com/-CB-gDjPd5BQ/VYYdFhRh0WI/AAAAAAAACiE/GDH5LExU4FI/s640/maven-update-project-configuration.png" /><br />
<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://stackoverflow.com/questions/14004308/spring-autowiring-not-able-to-hit-my-dao-class-method">http://stackoverflow.com/questions/14004308/spring-autowiring-not-able-to-hit-my-dao-class-method</a></li>
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
	<li><a href="https://maven.apache.org/guides/mini/guide-naming-conventions.html">Guide to naming conventions on groupId, artifactId and version</a></li>
	<li><a href="http://maven.apache.org/plugins/maven-war-plugin/usage.html">4 ways to use the WAR Plugin</a></li>
	<li><a href="http://whiteship.tistory.com/1890">4 ways to use the WAR Plugin 한글 해설</a></li>
	<li><a href="https://github.com/spring-projects/spring-mvc-showcase/blob/master/pom.xml">스프링 웹 애플리케이션을 위한 pom.xml 참조</a></li>
	<li><a href="http://stackoverflow.com/questions/793983/jsp-el-expression-is-not-evaluated">메이븐의 만들어준 web.xml 파일을 쓰면 EL이 해석되지 않는 경우</a></li>
</ul>

