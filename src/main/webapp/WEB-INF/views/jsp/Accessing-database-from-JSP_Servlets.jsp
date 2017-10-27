<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="last-modified">Last Modified : 2014.7.15</div>

<h1>데이터베이스 연동</h1>
<strong>아래 나오는 모든 예제를 이클립스를 사용하여 ROOT 애플리케이션에 작성한다.<br />
이클립스 설정은 <a href="Namecard-Webapp.php#3rd-Test">명함관리 웹 애플리케이션의 3번째 테스트</a>를 참고한다.</strong>
<br />
서블릿/JSP에 익숙하지 않은 바쁜 웹 프로그래머가 가장 궁금한 부분은 데이터베이스와 연동하는 방법일 것이다.<br />
다음 순서로 진행한다.<br />

<ol>
	<li>서블릿과 JSP에서 데이터베이스 연동</li>
	<li>성능향상을 위한 커넥션풀링 적용</li>
	<li>사용자 정의 로그 파일 적용</li>
</ol>

여기서 실습하는 예제는 재사용과 유지보수 측면에서는 악몽이라고 표현되는 코드이다.<br />
JDBC 코드를 포함하는 JSP나 서블릿은 직관적인 이해에는 도움이 되지만 이해한 후 버려야 한다.<br />
결론적으로 말하면, JDBC 관련 코드는 JSP 빈즈에 있어야 한다.<br />

<h2>GetEmpServlet.java 서블릿</h2>
이전에 실습했던 GetEmpServlet 서블릿을 이클립스에서 연다.<br />
아마도 컴파일 에러를 잔뜩 만나게 될 것이다.<br />
서블릿 API를 ROOT 애플리케이션의 빌드 패스에 추가해야 한다.<br />
<br />
아래와 같은 화면에서 Libraries 탭을 선택하고,<br />
왼쪽의 Add External JARs..버튼을 클릭하여 <br />
서블릿 API를 {톰캣홈}/lib 에서 찾아 추가한다.<br />
<br /> 
<img src="https://lh3.googleusercontent.com/LfjzoAb113QCQk9AqqcxY8hJWesV6w1iGr1ADWG1CYTC_1MezPKFpBqp5KPiQ4HEVznRM2RYBt9TAfUs43L4zRhIKRHmjXlgPryvjUF0ZlIhnewRkg8dsQ2oDMMqfO85Q15nbkRCJlmty5E0WTshV2WcMx9pb9fxFtqapyEgQfN48tJjZ0LTDVAdh9tiZHNO1tbNXkd16OBcu6-NCLkqOADzclE1AuPaXqiBG6gycOyfOriFRCjQ6i7YF2jRr30xqG-HYcdfzFotGPx5H_zUXNa-sY1e48dQHL8_i3CbUpy1UGVp5Atf8poCMQO8WQBaksdKaKJp2p4zOGdxLUBztpVn2lobVnofEIvBxLhBIhhI8z91AzOalH9Wk_aOFbuWDwzdTNhL1geqpK_Vb65FGyodA2E9Z38Zz_MKNxdrn0ZM50VAxIliYUtsvDZWMYZ_FGbTW9cBET6MtFvLyvlURodLfpfxKl4LNSwWKbCpyFtkstuaFdWPtvohW05dqP7Iiego9MZMQ9cRTWTD8msOerRtZw5tTHC0DTw_vVQCuWmd834gglb1IAnAMw8EozUP6lHsX-YXsRLpzzvRnQTh68p1KGOoNmg=w801-h470-no" alt="서블릿API를 ROOT애플리케이션의 빌드패스에 추가한다." /><br />

<h3>JSP에서 데이터베이스 연동</h3>
이번에는 위의 서블릿을 JSP 로 바꾸는 예제이다.<br />
getEmp1.jsp 파일을 ROOT 애플리케이션의 최상위 디렉토리에 만든다.<br />

<em class="filename">getEmp1.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;getEmp1&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
String DB_URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
String DB_USER = "scott";
String DB_PASSWORD = "tiger";

try {
	Class.forName("oracle.jdbc.driver.OracleDriver");
} catch (ClassNotFoundException e) {
	e.printStackTrace();
}

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String sql = "select * from emp";

try {
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();

	while (rs.next()) {
		String empno = rs.getString(1);
		String ename = rs.getString(2);
		String job = rs.getString(3);
		String mgr = rs.getString(4);
		String hiredate = rs.getString(5);
		String sal = rs.getString(6);
		String comm = rs.getString(7);
		String depno = rs.getString(8);
		
		//결과를 출력
		out.println( empno + " : " + ename + " : " + job + " : " + mgr + 
		" : " + hiredate + " : " + sal + " : " + comm + " : " + depno + "&lt;br /&gt;" );
	}

} catch (SQLException e) {
	System.out.println("Error Source : getEmp1.jsp : SQLException");
	System.out.println("SQLState : " + e.getSQLState());
	System.out.println("Message : " + e.getMessage());
	System.out.println("Oracle Error Code : " + e.getErrorCode());
	System.out.println("sql : " + sql);
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (con != null) {
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

JSP파일이므로 톰캣을 재실행할 필요가 없다.
http://localhost:8989/getEmp1.jsp를 방문하여 테스트한다.<br />
서블릿에서의 예제와 JSP 에서의 예제에서 구현코드에는 조금 차이가 있다.
서블릿 예제에서는 init() 메소드 바디에서 JDBC 드라이버에 대한 설정을 했다.<br />
"서블릿 문법"에서 보았듯이 init() 메소드는 서블릿이 인스턴스가 된 후 서블릿 컨테이너에 
의해 단 한번 자동으로 호출된다.<br />
JSP 에서도 서블릿의 init() 에 해당하는 메소드가 있다.<br />
이 메소드에 드라이버 로딩부분을 담당하도록 하면 성능이 더 좋아질 것이다.<br />
아래 링크에서 서블릿의 init()에 해당하는 JSP 메소드를 찾을 수 있다.<br />
<a href="http://docs.oracle.com/javaee/7/api/javax/servlet/jsp/JspPage.html#jspInit()">http://docs.oracle.com/javaee/7/api/javax/servlet/jsp/JspPage.html#jspInit()</a>

<h2>성능향상을 위한 커넥션풀링 기법 적용</h2>
JDBC에서 Connection 객체를 획득하는 데에 시간이 많이 걸린다.<br />
이에 대한 해결책으로 Connection Pooling 기법이 있는데, 이것은 
Connection 을 미리 여러 개 만들어 저장해 두고 필요할 때마다 꺼내 쓰겠다는 아이디어를 
구현한 것이다.<br />

<h3>커넥션 풀링을 ROOT 애플리케이션에 적용하는 방법</h3>
우리는 서블릿 예제에서 이미 커넥션풀링을 사용해 보았다.<br />
다시 복습상 되돌아 보면 아래와 같은 작업을 했다.<br />

<a href="../jdbc/Connection-Pool">Connection Pooling</a> 에서 참고하여 Log.java, DBConnectionPool.java,
DBConnectionPoolManager.java, ConnectionManager.java, DBConnectionPoolManager,
OracleConnectionManager.java, oracle.properties 을 웹 애플리케이션을 위한 소스 디렉토리에 
복사했다.<br />
그런 후에, Log.java 파일을 열어서 로그 파일이 쌓일 파일명과 파일 위치를 웹 애플리케이션에 맞게 수정했다.<br />
참고로 유닉스 시스템에서는 로그 파일을 만들어 주고 권한 설정을 따로  해 주어야 한다.<br />

<pre class="prettyprint">
public String dbgFile = "C:/www/myapp/WEB-INF/debug.txt";
</pre>

오라클 커넥션 풀을 위한 설정 파일 oracle.properties 를, 어디든 괜찮으나 우리는 로그파일과 같이 WEB-INF/ 에 복사했다.<br /> 
그런 후에 ConnectionManager.java 파일을 열고 oracle.properties 의 절대경로를 아래와 같이 수정했다.<br />

<pre class="prettyprint">
configFile = "C:/www/myapp/WEB-INF/"+poolName+".properties";
</pre>

내용이 바뀐 Log.java 와 ConnectionManager.java 소스 파일을 다시 컴파일 했다.<br />
이것이 우리가 사용할 사용자 정의 커넥션풀 관련 소스의 사용법이다.<br />
서블릿 예제를 모두 실습했다면 위 과정을 다시 할 필요는 없겠다.<br />

<h3>커넥션 풀링을 사용하는 JSP테스트</h3>
아래 코드에서 jsp:useBean 표준 액션을 사용하여 커넥션 풀링을 위한 
OracleConnectionManager 객체의 레퍼런스를 획득한다.<br />
이제 커넥션이 필요할 때마다 OracleConnectionManager 의 getConnection() 메소드를 호출하면 
커넥션을 획득할 수 있다.<br />
주의할 점은 커넥션을 사용하고 난 후 자원 반납할 때 기존과 같이 Connection의 
close() 메소드를 사용하는 것이 아니라 OracleConnectionManager의 freeConnection() 메소드를 
사용해서 커넥션을 돌려주어야 한다는 것이다.
다음 getEmp2.jsp 파일을 ROOT 애플리케이션의 최상위 디렉토리에 생성한다.<br />

<em class="filename">getEmp2.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
<strong>&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;jsp:useBean id="dbmgr" class="net.java_school.db.dbpool.OracleConnectionManager" scope="application" /&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;getEmp2&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

String sql = "select * from emp";

try {
	con = dbmgr.getConnection();
  
	//Statement를 가져온다.
	stmt = con.createStatement();
	
	//SQL문을 실행합니다.
	rs = stmt.executeQuery(sql);

	while (rs.next()) {
		String empno = rs.getString(1);
		String ename = rs.getString(2);
		String job = rs.getString(3);
		String mgr = rs.getString(4);
		String hiredate = rs.getString(5);
		String sal = rs.getString(6);
		String comm = rs.getString(7);
		String depno = rs.getString(8);
		
		//결과를 출력합니다.
		out.println( empno + " : " + ename + " : " + job + " : " + mgr + 
		" : " + hiredate + " : " + sal + " : " + comm + " : " + depno + "&lt;br /&gt;" );
	}

} catch (SQLException e) {
	System.out.println("Error Source : getEmp2.jsp : SQLException");
	System.out.println("SQLState : " + e.getSQLState());
	System.out.println("Message : " + e.getMessage());
	System.out.println("Oracle Error Code : " + e.getErrorCode());
	System.out.println("sql : " + sql);
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}
	if (con != null) {
		<strong>dbmgr.freeConnection(con);</strong>
	}
}
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h2>사용자 정의 로그 파일 적용</h2>
이제까지 예제에서는 로그 메시지를 출력하기 위해서 System.out.println()이라는 
자바의 표준 출력 메소드를 이용했다.<br />
만일 여러분이 윈도우 시스템에서 톰캣을 인스톨러를 포함한 버전을 설치했고, 
Tomcat Monitor를 이용했다면 톰캣을 시작했다면 
자바 표준 출력 메소드는 {톰캣 홈 디렉토리}/logs 디렉토리에서 stdout_로 시작하는 파일에 
출력한다.<br />
<br />
개발할 때나 운영할 때 좀더 낳은 환경을 제공하기 위해서는 프로그래머나 운영자가 원하는 
파일에 로그 메시지가 출력되도록 해야 한다.<br />
로깅과 관련해서 좋은 오픈 소스가 있는데 Java Basic 에서 다루었던 log4j 가 대표적이다.<br />
하지만 여기서는 예제를 간단하게 하기 위해 
Connection Pooling 에 포함된 사용자 정의 로그 파일인 Log.java 을 이용하도록 한다.<br />
다음 getEmp3.jsp 파일을 ROOT 애플리케이션의 최상위 디렉토리에 만든다.<br />

<em class="filename">getEmp3.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;jsp:useBean id="dbmgr" class="net.java_school.db.dbpool.OracleConnectionManager" scope="application" /&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;getEmp3&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
<strong>Log log = new Log();</strong>
Connection con = null;
Statement stmt = null;
ResultSet rs = null;

String sql = "select * from emp";

try {
	con = dbmgr.getConnection();
  
	//Statement를 가져온다.
	stmt = con.createStatement();
	
	//SQL문을 실행합니다.
	rs = stmt.executeQuery(sql);

	while (rs.next()) {
		String empno = rs.getString(1);
		String ename = rs.getString(2);
		String job = rs.getString(3);
		String mgr = rs.getString(4);
		String hiredate = rs.getString(5);
		String sal = rs.getString(6);
		String comm = rs.getString(7);
		String depno = rs.getString(8);
		
		//결과를 출력합니다.
		out.println( empno + " : " + ename + " : " + job + " : " + mgr + 
		" : " + hiredate + " : " + sal + " : " + comm + " : " + depno + "&lt;br /&gt;" );
	}

} catch (SQLException e) {
	<strong>log.debug</strong>("Error Source:getEmp3.jsp : SQLException");
	<strong>log.debug</strong>("SQLState : " + e.getSQLState());
	<strong>log.debug</strong>("Message : " + e.getMessage());
	<strong>log.debug</strong>("Oracle Error Code : " + e.getErrorCode());
	<strong>log.debug</strong>("sql : " + sql);
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {

			e.printStackTrace();
		}
	}
	if (con != null) {
		dbmgr.freeConnection(con);
	}
	<strong>log.close();</strong>
}
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

고의적으로 에러가 발생하도록 소스를 고치고 로그 메시지를 확인하자<br />
위 소스에서 String sql = "<strong>select * from emp" 를 select * fromemp</strong>" 로 
고치고 다시 테스트한다.<br />
로그파일은 Log.java 파일에서 지정한 파일에 다음과 같이 로그가 쌓이는 것을 확인할 수 있다.

<pre class="prettyprint">
Thu Jun 12 14:30:51 KST 2014 : Oracle Error Code : 923
Thu Jun 12 14:30:51 KST 2014 : sql : select * fromemp
Thu Jun 12 14:30:52 KST 2014 : Error Source:getEmp3.jsp : SQLException
Thu Jun 12 14:30:52 KST 2014 : SQLState : 42000
Thu Jun 12 14:30:52 KST 2014 : Message : ORA-00923: FROM keyword not found where expected
</pre>
