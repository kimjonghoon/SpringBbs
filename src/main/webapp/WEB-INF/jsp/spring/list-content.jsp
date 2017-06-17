<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<h1>게시판 목록</h1>

JSP Project에서 구현한 웹사이트 최종본에 Spring MVC를 적용하는 것을 실습할 것이다.<br />
<a href="src/spring-mvc.zip">spring-mvc.zip</a>을 다운로드하고 적당한 곳에 압축을 푼다.<br />
images와 css폴더는 src/main/webapp 바로 아래에 위치하도록 붙여넣는다.<br />
java 폴더를 복사하여 src/main 아래에 붙여넣는다.(기존 java 폴더를 덮어쓴다)<br />
resources 폴더를 복사하여 src/main 아래에 붙여넣는다.(기존 resources 폴더를 덮어쓴다)<br />
src/main/resources/log4j.xml 파일을 열고 로그가 위치할 경로를 수정한다.<br />
jsp 폴더를 복사하여 WEB-INF 아래에 붙여넣는다.<br>
<br />

"/bbs"를 포함하는 요청을 처리할 컨트롤러를 생성한다.<br />

<em class="filename">BbsController.java</em>
<pre class="prettyprint">
package net.java_school.board.spring;

import java.util.List;

import net.java_school.board.Article;
import net.java_school.board.BoardService;
import net.java_school.commons.PagingHelper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/bbs")
public class BbsController {
	
    @Autowired
    private BoardService boardService;
	
    @RequestMapping(value="/list", method=RequestMethod.GET)
    public String list(String boardCd, Integer page, String searchWord, Model model) {
        
        int numPerPage = 10;
        int pagePerBlock = 10;
        
        int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
        
        PagingHelper pagingHelper = 
                new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
        boardService.setPagingHelper(pagingHelper);

        List&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord);
        String boardNm = boardService.getBoardNm(boardCd);
        Integer listItemNo = boardService.getListItemNo();
        Integer prevPage = boardService.getPrevPage();
        Integer nextPage = boardService.getNextPage();
        Integer firstPage = boardService.getFirstPage();
        Integer lastPage = boardService.getLastPage();
        
        model.addAttribute("list", list);
        model.addAttribute("boardNm", boardNm);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        
        return "bbs/list";
        
    }	
}
</pre>

spring-bbs-servlet.xml 파일을 수정한다.<br />

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
	
	&lt;!-- 스프링의 DispatcherServet에게 정적인 자원을 알려준다.  --&gt;
	&lt;mvc:resources location="/images/" mapping="/images/**" /&gt;
	&lt;mvc:resources location="/css/" mapping="/css/**" /&gt;
	
	&lt;mvc:annotation-driven /&gt;
		
	&lt;context:component-scan
		base-package="net.java_school.board.spring,
		net.java_school.board,
		net.java_school.soccer" /&gt;
	
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
	<strong>
	&lt;bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"&gt;
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
    	
	&lt;bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean"&gt;
		&lt;property name="dataSource" ref="dataSource" /&gt;
		&lt;property name="configLocation" value="classpath:net/java_school/mybatis/Configuration.xml" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="boardMapper" class="org.mybatis.spring.mapper.MapperFactoryBean"&gt;
		&lt;property name="mapperInterface" value="net.java_school.mybatis.BoardMapper" /&gt;
		&lt;property name="sqlSessionFactory" ref="sqlSessionFactory" /&gt;
	&lt;/bean&gt;
	</strong>
	&lt;!-- 
	&lt;bean id="boardService" class="net.java_school.board.BoardServiceImpl"&gt;
		&lt;property name="boardMapper" ref="boardMapper" /&gt;
	&lt;/bean&gt;
	--&gt;
	
&lt;/beans&gt;
</pre>

자바 소스가 바뀌었으니 빌드한다.<br />
Proejct Explorer 뷰에서 프로젝트를 선택한다.<br />
마우스 오른쪽 버튼을 클릭하여 Run As -- Maven Build를 선택한다.<br />
아래 그림처럼 Goals:에 compile war:inplace를 입력한다.<br />
Apply 클릭하고 Run을 실행한다.<br /> 

<img src="images/MVC/compile-war_inplace.png" alt="compile war:inplace" /><br />

compile war:inplace는 src/main/webapp/WEB-INF/lib에 라이브러리를 복사한다.<br />

<img src="images/MVC/compile-war-result.png" alt="src/main/webapp/WEB-INF/lib" /><br />

/spring-bbs/bbs/list?boardCd=free&amp;page=1를 방문하여 테스트한다.<br />
데이터가 있다면 검색을 테스트한다.<br />
만일 한글 검색이 되지 않는다면 TOMCAT_HOME/conf/server.xml 파일을 열고 다음을 확인한다.<br />

<em class="filename">server.xml</em>
<pre class="prettyprint">
&lt;Connector port="8989" protocol="HTTP/1.1"
    connectionTimeout="20000"
    <strong>URIEncoding="UTF-8"</strong>
    redirectPort="8443" /&gt;
</pre>

강조된 부분이 있어야 한글 검색이 된다.

<dl class="note">
<dt>에러를 만났을 때 체크 리스트</dt>
<dd> 
1. /WEB-INF/classes에 바이트 코드가 있는지 확인<br />
2. /WEB-INF/lib에 라이브러리 파일이 있는지 확인<br /> 
3. JDBC 드라이버 파일(ojdbc6.jar)이 TOMCAT_HOME/lib에 있는지 확인<br />
4. JSP에서 EL이 해석되지 않는다면 web.xml 파일의 dtd 버전이 2.4 이상인지 확인<br />
</dd>
</dl>

spring-bbs-servlet.xml에서 &lt;bean id="boardService"이 생략가능한 이유는 
BoardServiceImple.java에 @Service 어노테이션이 적용되어 자동 스캔되기 때문이다.<br />
&lt;bean id="boardMapper"을 생략할 수 없는 이유는 마이바티스와 관련된 매퍼는 
context:component-scan으로 스캔되지 않기 때문이다.<br />
매퍼가 자동 스캔되도록 하려면 스프링 설정 파일을 다음과 같이 수정한다.<br />

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	<strong>xmlns:mybatis="http://mybatis.org/schema/mybatis-spring"</strong>
	xmlns:p="http://www.springframework.org/schema/p"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context
		http://www.springframework.org/schema/context/spring-context.xsd
		http://www.springframework.org/schema/mvc
		http://www.springframework.org/schema/mvc/spring-mvc.xsd
		<strong>http://mybatis.org/schema/mybatis-spring 
		http://mybatis.org/schema/mybatis-spring.xsd</strong>"&gt;
	
	&lt;!-- 스프링의 DispatcherServet에게 정적인 자원을 알려준다.  --&gt;
	&lt;mvc:resources location="/images/" mapping="/images/**" /&gt;
	&lt;mvc:resources location="/css/" mapping="/css/**" /&gt;
	
	&lt;mvc:annotation-driven /&gt;
		
	&lt;context:component-scan
		base-package="net.java_school.board.spring,
		net.java_school.board,
		net.java_school.soccer" /&gt;
	
	<strong>&lt;mybatis:scan base-package="net.java_school.mybatis" /&gt;</strong>
	
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
	
	&lt;bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"&gt;
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
    	
	&lt;bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean"&gt;
		&lt;property name="dataSource" ref="dataSource" /&gt;
		&lt;property name="configLocation" value="classpath:net/java_school/mybatis/Configuration.xml" /&gt;
	&lt;/bean&gt;

	&lt;!--
	&lt;bean id="boardMapper" class="org.mybatis.spring.mapper.MapperFactoryBean"&gt;
		&lt;property name="mapperInterface" value="net.java_school.mybatis.BoardMapper" /&gt;
		&lt;property name="sqlSessionFactory" ref="sqlSessionFactory" /&gt;
	&lt;/bean&gt;
	
	&lt;bean id="boardService" class="net.java_school.board.BoardServiceImpl"&gt;
		&lt;property name="boardMapper" ref="boardMapper" /&gt;
	&lt;/bean&gt;
	--&gt;
&lt;/beans&gt;
</pre>
톰캣을 재실행하고 /spring-bbs/bbs/list?boardCd=data&amp;page=1를 방문하여 테스트한다.<br />
<br />
BoardServiceImpl.java의 종속 변수인 매퍼에 @Autowired를 적용한다.<br />
<em class="filename">BoardServiceImpl.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.HashMap;
import java.util.List;

<strong>import org.springframework.beans.factory.annotation.Autowired;</strong>
import org.springframework.stereotype.Service;

import net.java_school.commons.PagingHelper;
import net.java_school.mybatis.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	<strong>@Autowired</strong>
	private BoardMapper boardMapper;
	private PagingHelper pagingHelper; //페이징 처리 유틸리티 클래스
	
/*	//setter는 생략한다.
	public void setBoardMapper(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}
*/

	//이하 내용이 같으므로 생략
	
}
	
</pre>
자바 소스가 변경됬으니 빌드한다.<br />
톰캣을 재실행하고 /spring-bbs/bbs/list?boardCd=data&amp;page=1를 방문하여 테스트한다.<br />

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