<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.1.14</div>

<h1>Spring MVC 컨트롤러 설정</h1>

Spring MVC 의 최신 권고대로 핸들러를 만들고 테스트해보자.<br />
예제를 최대한 간단하게 만들도록 하겠다.<br />

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="ISO-8859-1"?&gt;
&lt;web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true"&gt;
  
	&lt;servlet&gt;
		&lt;servlet-name&gt;hello&lt;/servlet-name&gt;
		&lt;servlet-class&gt;
			org.springframework.web.servlet.DispatcherServlet
		&lt;/servlet-class&gt;
		&lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
	&lt;/servlet&gt;
	
	&lt;servlet-mapping&gt;
		&lt;servlet-name&gt;hello&lt;/servlet-name&gt;
		<strong>&lt;url-pattern&gt;/&lt;/url-pattern&gt;</strong>
	&lt;/servlet-mapping&gt;
	
&lt;/web-app&gt;
</pre>


<em class="filename">hello-servlet.xml</em> 
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc.xsd
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context.xsd"&gt;
	<strong>
	&lt;mvc:annotation-driven /&gt;
	</strong>
	&lt;context:component-scan
        base-package="net.java_school.user.spring,net.java_school.user" /&gt;

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

<em class="filename">User.java</em> 
<pre class="prettyprint">
package net.java_school.user;

public class User {
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

<em class="filename">UserDao.java</em> 
<pre class="prettyprint">
package net.java_school.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {
	
	public User selectOne(String id) {
		User user = new User();
		user.setName("홍길동");
		return user;
	}

}
</pre>

<em class="filename">UserService.java</em> 
<pre class="prettyprint">
package net.java_school.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
	
	@Autowired
	private UserDao dao;
	
	public User getUser(String id) {
		return dao.selectOne(id);
	}
	
}
</pre>


<em class="filename">UserController.java</em> 
<pre class="prettyprint">
package net.java_school.user.spring;

import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/view",method=RequestMethod.GET)
	public String view(String id, Model model) {
		User user = userService.getUser(id);
		model.addAttribute("user", user);
		return "user/view";
	}
}
</pre>

<em class="filename">WEB-INF/jsp/user/view.jsp</em> 
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;테스트&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
Hello, <strong>${user.name }</strong> !
&lt;/body&gt;
&lt;/html&gt;
</pre>

dao 에 어노테이션 @Repository 을 적용하면 &lt;context:component-scan /&gt; 으로 검색된다.<br />
http://localhost:<strong>port</strong>/<strong>ContextPath</strong>/user/view?id=hero<br />를 방문하여 테스트한다.<br />
port 와 ContextPath는 각자 환경에 따라 다르다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">spring-framework-reference.pdf</a></li>
</ul>