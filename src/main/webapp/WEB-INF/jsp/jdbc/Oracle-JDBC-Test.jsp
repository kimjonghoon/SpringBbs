<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2014.5.19</div>

<h1>오라클 JDBC 테스트</h1>

<h3>오라클 JDBC 드라이버를 클래스패스에 추가하여 테스트하기</h3>
자바 JDBC 프로그래밍을 하기 위해서는 데이터베이스에 맞는 JDBC드라이버를 설치해야 한다.<br />
오라클 JDBC드라이버는<br /> 
<em class="path">C:\oraclexe\app\oracle\product\11.2.0\server\jdbc\lib</em>
에서 찾을 수 있다.<br />
디렉토리에 있는 파일 중 ojdbc6.jar 가 우리가 사용할 JDBC 드라이버이다.<br />
<br />
다음 JDBC 테스트 파일은 scott 계정의 EMP 테이블의 모든 레코드를 가져와 출력하는 프로그램이다.<br />
아래 파일을 메모장에서 작성하고 C:/ 에 GetEmp.java라는 파일명으로 저장한다.<br />

<em class="filename">GetEmp.java</em>
<pre class="prettyprint">
import java.sql.*; 

public class GetEmp {
	public static void main(String[] args) {
		String DB_URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
		String DB_USER = "scott";
		String DB_PASSWORD = "tiger";

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String query = "SELECT * FROM emp";
		try {
			// 드라이버를 로딩한다.
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e ) {
			e.printStackTrace();
		}

		try {
			// 데이터베이스의 연결을 설정한다.
			conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

			// Statement를 가져온다.
			stmt = conn.createStatement();

			// SQL문을 실행한다.
			rs = stmt.executeQuery(query);

			while (rs.next()) { 
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				// 결과를 출력한다.
				System.out.println( 
					empno + " : " + ename + " : " + job + " : " + mgr
					+ " : " + hiredate + " : " + sal + " : " + comm + " : "
				+ depno); 
			}
		} catch ( Exception e ) {
			e.printStackTrace();
		} finally {
			try {
				// ResultSet를 닫는다.
				rs.close();
				// Statement를 닫는다.
				stmt.close();
				// Connection를 닫는다.
				conn.close();
			} catch ( SQLException e ) {}
		}
	} // main()의 끝
} // 클래스의 끝
</pre>

컴파일하고 실행시키면 다음과 같은 결과가 나와야 한다.

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\&gt;set classpath=.;C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar

C:\&gt;javac GetEmp.java

C:\&gt;java GetEmp
7369 : SMITH : CLERK : 7902 : 1980-12-17 00:00:00.0 : 800 : null : 20
7499 : ALLEN : SALESMAN : 7698 : 1981-02-20 00:00:00.0 : 1600 : 300 : 30
7521 : WARD : SALESMAN : 7698 : 1981-02-22 00:00:00.0 : 1250 : 500 : 30
7566 : JONES : MANAGER : 7839 : 1981-04-02 00:00:00.0 : 2975 : null : 20
7654 : MARTIN : SALESMAN : 7698 : 1981-09-28 00:00:00.0 : 1250 : 1400 : 30
7698 : BLAKE : MANAGER : 7839 : 1981-05-01 00:00:00.0 : 2850 : null : 30
7782 : CLARK : MANAGER : 7839 : 1981-06-09 00:00:00.0 : 2450 : null : 10
7839 : KING : PRESIDENT : null : 1981-11-17 00:00:00.0 : 5000 : null : 10
7844 : TURNER : SALESMAN : 7698 : 1981-09-08 00:00:00.0 : 1500 : 0 : 30
7900 : JAMES : CLERK : 7698 : 1981-12-03 00:00:00.0 : 950 : null : 30
7902 : FORD : ANALYST : 7566 : 1981-12-03 00:00:00.0 : 3000 : null : 20
7934 : MILLER : CLERK : 7782 : 1982-01-23 00:00:00.0 : 1300 : null : 10
</pre>

<dl class="note">
<dt>String DB_URL = <strong>"jdbc:oracle:thin:@127.0.0.1:1521:XE"</strong></dt>
<dd>
<strong>jdbc:oracle:thin</strong>은 사용하는 JDBC드라이버가 thin 타입을 의미한다.<br />
<strong>1521</strong> 은 오라클 리슨너(listener)의 포트번호이다.<br />
(listener 는 오라클에서 오라클과 외부 애플리케이션과의 통신 역활을 한다.)<br />
<strong>127.0.0.1</strong> 은 데이터베이스가 설치되어 있는 서버의 IP 이다.<br />
<strong>XE</strong> 은 SID 이름이다. SID는 오라클 데이터베이스 객체를 구별해주는 이름이다.<br />  
</dd>
</dl>

다음은 JDBC 테스트 파일 GetEmp.java 를 실행할 때 발생할 수 있는 에러와 그 해결방안이다.
<ol>
	<li>Exception in thread "main" java.lang.NoClassDefFoundError: GetEmp
		<ul>
			<li>GetEmp 클래스를 찾을 수 없다는 익셉션: GetEmp.class 파일이 있는 곳에서 실행했는지 확인</li>
			<li>클래스패스에 .이 있는지 확인</li>
		</ul>
	</li>
	<li>java.lang.ClassNotFoundException: oracle.jdbc.driver.OracleDriver
		<ul>
			<li>오라클 JDBC 드라이버의 시작 클래스를 찾을 수 없다는 익셉션: 오라클 JDBC 드라이버가 CLASSPATH 에 맞게 추가했는지 확인</li>
		</ul>
	</li>	
	<li>java.sql.SQLException: IO 예외 상황: The Network Adapter could not establish the connection
		<ul>
			<li>오라클의 리슨너(listener)가 서비스를 하고 있지 않을 가능성이 많다.</li>
			<li>명령 프롬프트에서 <strong>lsnrctl status</strong> 로 리슨너의 서비스 상태를 확인</li>
			<li>리슨너가 동작하고 있다면 서버의 IP 를 127.0.0.1 에서 loopback adapter 를 설치할 때 설정한 10.10.10.10 으로 바꾸고 시도해 본다</li>
		</ul>
	</li>
	<li>java.sql.SQLException: ORA-01017: invalid username/password; logon denied
		<ul>
			<li>scott 계정의 비밀번호가 틀린 경우: 비밀번호가 tiger이 아니라면 GetEmp.java 소스를 수정한다.</li>
		</ul>
	</li>	
</ol>

<h3>javac 와 java 의 -classpath 옵션을 사용하여 테스트</h3>
컴파일과 실행시에 -classpath 옵션을 사용하여 테스트하는 방법을 소개한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\&gt;javac -classpath C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar GetEmp.java

C:\&gt;java -classpath .;C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar GetEmp
7369 : SMITH : CLERK : 7902 : 1980-12-17 00:00:00.0 : 800 : null : 20
7499 : ALLEN : SALESMAN : 7698 : 1981-02-20 00:00:00.0 : 1600 : 300 : 30
7521 : WARD : SALESMAN : 7698 : 1981-02-22 00:00:00.0 : 1250 : 500 : 30
7566 : JONES : MANAGER : 7839 : 1981-04-02 00:00:00.0 : 2975 : null : 20
7654 : MARTIN : SALESMAN : 7698 : 1981-09-28 00:00:00.0 : 1250 : 1400 : 30
7698 : BLAKE : MANAGER : 7839 : 1981-05-01 00:00:00.0 : 2850 : null : 30
7782 : CLARK : MANAGER : 7839 : 1981-06-09 00:00:00.0 : 2450 : null : 10
7839 : KING : PRESIDENT : null : 1981-11-17 00:00:00.0 : 5000 : null : 10
7844 : TURNER : SALESMAN : 7698 : 1981-09-08 00:00:00.0 : 1500 : 0 : 30
7900 : JAMES : CLERK : 7698 : 1981-12-03 00:00:00.0 : 950 : null : 30
7902 : FORD : ANALYST : 7566 : 1981-12-03 00:00:00.0 : 3000 : null : 20
7934 : MILLER : CLERK : 7782 : 1982-01-23 00:00:00.0 : 1300 : null : 10

C:\&gt;
</pre>
GetEmp.class 파일에 있는 곳에 아래 내용으로 BAT 파일을 만들어 놓으면 테스트 파일로 이용할 수 있다.<br />

<em class="filename">JDBCTEST.bat</em>
<pre class="prettyprint">
@echo off

java -classpath .;C:/oraclexe/app/oracle/product/11.2.0/server/jdbc/lib/ojdbc6.jar GetEmp

pause
</pre>

<h3>이클립스에서 GetEmp.java 테스트하기</h3>
이클립스를 클래스패스 환경변수를 참조하지 않는다.<br />
이클립스에서 프로젝트 단위로 코드를 관리하므로 일단 프로젝트를 만들어야 한다.<br />
아래 그림은 jdbc라는 프로젝트를 만들고, net.java_school.jdbc라는 팩키지에 속하도록 GetEmp.java 파일을 생성한 경우이다.<br />
마우스로 프로젝트를 선택한다.<br />

<img src="https://lh3.googleusercontent.com/-owgWItb22OU/VYFQ3g0n38I/AAAAAAAACQw/DkBe_5MNb5YUBopR704ZgQ3TiQUDJ9oPgCCo/s556-Ic42/GetEmp-Project-select.png" alt="GetEmp.java 소스는 jdbc프로젝트에 위치한다." /><br />

오른쪽 버튼을 클릭하여 아래와 같이 메뉴를 선택한다.<br />

<img src="https://lh3.googleusercontent.com/-esNPczaQWLM/VYFQ21XMgJI/AAAAAAAACQ4/1jMACuioYf4V8ZPcS0zli6nnYCSg-N99gCCo/s512-Ic42/GetEmp-Configure-Build-Path.png" alt="프로젝트 - 오른쪽 마우스 버튼 - Build Path - Configure Build Path 선택" /><br />

Libraries탭을 선택한 후 Add External JARs..버튼을 클릭하여 오라클 JDBC드라이버 파일을 추가한다.<br />

<img src="https://lh3.googleusercontent.com/-E1VTR2trMK8/VYFQ2_dIhZI/AAAAAAAACQk/hwKGjkeAwwMREV5cpZgrWbfQ9gnQXPwHQCCo/s640-Ic42/GetEmp-Libraries-Tab-select.png" alt="Libraries 탭을 선택하고 Add External Lib를 선택한다." /><br />

오라클 JDBC 드라이버 파일을 찾아서 추가한다.<br />

<img src="https://lh3.googleusercontent.com/-sLvd5XnBjnk/VYFQ4PRqyKI/AAAAAAAACRA/bZ_DKxXzoH8ITcwIrsIoC79wrpVSyuGKgCCo/s512-Ic42/GetEmp-ojdbc6-select.png" alt="오라클 JDBC드라이버 파일중 ojdbc6.jar를 선택한다." /><br />

<img src="https://lh3.googleusercontent.com/-KRcL7vQtO8k/VYFQ2weuFQI/AAAAAAAACQ0/DsMp_n3rB_YzusPSx1mCrRM7UD7Nb7wiQCCo/s720-Ic42/GetEmp-Oracle-JDBC-Driver-Classpath.png" alt="ojdbc6.jar가 프로젝트 클래스 패스에 추가확인" /><br />

Package Explorer 뷰에서 GetEmp.java 를 마우스로 선택한 후 오른쪽 버튼을 클릭하여 아래처럼 실행한다.<br />

<img src="https://lh3.googleusercontent.com/-Rfh4TDU6QJg/VYFQ4GMN9hI/AAAAAAAACQ8/be58ONtH7aM8ynlDO1kom5k7ZndWtvOrQCCo/s657-Ic42/GetEmp-Run.png" alt="GetEmp.java를 이클립스에서 실행하는 화면" /><br />
