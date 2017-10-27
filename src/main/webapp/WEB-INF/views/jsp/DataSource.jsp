<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.9.11</div>

			
<h1>DataSource</h1>

<a href="/jdbc/Connection-Pool">Connection Pooling</a>에서 DataSource 를 소개했었다.<br />
썬은 DataSource 인터페이스를 만들었고 서블릿 스펙도 이에 맞게 변경했다.<br />
서블릿 컨테이너는 javax.sql.DataSource 구현체를 제공해야 한다.<br />
DataSource 구현체는 대부분 JNDI API를 기반으로 하는 Java  Naming 서비스를 통해 사용한다.<br />
지금부터 톰캣에서 DataSource 를 위한 설정을 소개한 후, 구현된 게시판을 데이터소스를 이용하는 코드로 수정한다.<br />

<h2>톰캣에서 데이터소스 설정</h2>
탐색기로 사용하여 {톰캣홈}/conf/Catalina/localhost 로 이동한다.<br /> 
ROOT.xml 파일을 열고 아래와 같이 설정을 추가한다.<br /> 

<em class="filename">ROOT.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
	docBase="C:/www/myapp"
	reloadable="true"&gt;
    <strong>
	&lt;Resource
		name="jdbc/scott"
		auth="Container"
		type="javax.sql.DataSource"
		username="scott"
		password="tiger"
		driverClassName="oracle.jdbc.driver.OracleDriver"
		url="jdbc:oracle:thin:@127.0.0.1:1521:XE"
		maxActive="8"
		maxIdle="4" /&gt;</strong>
	  
&lt;/Context&gt;  
</pre>

이때 useNaming 설정이 true 이어야 한다.<br />
이 속성의 디폴트가 true 이므로 생략해도 문제가 되지 않는다.<br /> 

다음으로 web.xml 파일을 열고 아래 코드를 추가한다.<br />
이때 엘리먼트의 순서에 주의해서 추가한다.<br />

엘리먼트의 순서는 <a href="Servlet.php#web-app">엘리먼트의 순서</a>를 참고한다.<br />
 
<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;resource-ref&gt; 
	&lt;description&gt;Oracle Datasource example&lt;/description&gt; 
	&lt;res-ref-name&gt;jdbc/scott&lt;/res-ref-name&gt; 
	&lt;res-type&gt;javax.sql.DataSource&lt;/res-type&gt; 
	&lt;res-auth&gt;Container&lt;/res-auth&gt; 
&lt;/resource-ref&gt;
</pre>

web.xml 에 추가하는 설정은 톰캣 최신 버전에서는 하지 않아도 된다.<br />

지금까지 테스트가 성공했다면 당연히 있겠지만,
오라클 JDBC 파일이 {톰캣홈}/lib 에 있어야 한다.<br />


아래의 JSP 파일을 만든다.<br />

<em class="filename">/dataSourceTest.jsp</em>
<pre class="prettyprint">
&lt;%@ page contentType="text/html;charset=UTF-8" %&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="javax.sql.*" %&gt;
&lt;%@ page import="javax.naming.*" %&gt;
&lt;%@ page import="net.java_school.util.Log" %&gt;
&lt;html&gt;
&lt;head&gt;
   &lt;title&gt;DataSource Test&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
  Log log = new Log();
  DataSource ds = null;
  Context ic = null;
  Connection con = null;
  PreparedStatement stmt = null;
  ResultSet rs = null;
  String sql = null;
  int totalRecord = 0;
  	
  try {
    ic = new InitialContext();
    Context envCtx = (Context) ic.lookup("java:comp/env");
	ds = (DataSource) envCtx.lookup("jdbc/scott");
  } catch (NamingException e) {
    System.out.println(e.getMessage());
  }

  try {
    con = ds.getConnection();

    sql = "SELECT count(*) FROM emp";

    stmt = con.prepareStatement(sql);
    rs = stmt.executeQuery();
    rs.next();
    totalRecord = rs.getInt(1);
  } catch (SQLException e) {
      log.debug("Error Source:/DataSourceTest.jsp : SQLException");
      log.debug("SQLState : " + e.getSQLState());
      log.debug("Message : " + e.getMessage());
      log.debug("Oracle Error Code : " + e.getErrorCode());
      log.debug("sql : " + sql);
  } finally {
    try {
      if (rs != null) rs.close();
      if (stmt != null) stmt.close();
      if (con != null) con.close();
    } catch (SQLException e) {}
    log.close();
  }
%&gt;
&lt;%=totalRecord %&gt;
</pre>

테스트가 성공했다면
게시판의 소스를 수정한다.<br />
모델 1 이전 게시판일 경우 거의 모든 JSP 서블릿 모두를 수정해야 한다.<br />
하지만 모델1 게시판의 경우 JDBC 코드를 빈즈에 구현했으므로 해당 빈만 수정하면 된다.<br />

<em class="filename">BoardDao.java 를 DataSource를 이용하도록 수정</em>
<pre class="prettyprint">
package net.java_school.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
<strong>
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
</strong>
import net.java_school.util.Log;

public class BoardDao {
	<strong>
	private DataSource ds;
	</strong>
	public BoardDao() {
		<strong>try {
			Context init = new InitialContext();
			ds  = (DataSource) init.lookup("java:comp/env/jdbc/scott");
		} catch (NamingException e) {
			System.out.println(e.getMessage());
		}</strong>
	}
	
	private Connection getConnection() throws SQLException {
		return <strong>ds.getConnection();</strong>
	}
	
	//..이하 이전 소스와 같다.

}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://tomcat.apache.org/tomcat-6.0-doc/jndi-resources-howto.html">http://tomcat.apache.org/tomcat-6.0-doc/jndi-resources-howto.html</a></li>
</ul>
