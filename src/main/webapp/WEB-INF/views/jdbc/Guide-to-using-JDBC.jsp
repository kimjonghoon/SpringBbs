<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.5.19</div>

<h1>JDBC 프로그래밍 방법</h1>

아래 JDBC 프로그래밍 방법을 순서대로 외운다.
<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 처리]</li>
	<li>자원 반환</li>
</ol>
아래는 각 순서의 설명이다.<br />
전 강좌, 오라클 JDBC 테스트의 GetEmp.java 소스를 참고하면서 본다.<br />

<h2>1. JDBC 드라이버 로딩</h2>
<pre class="prettyprint">
Class.forName("oracle.jdbc.driver.OracleDriver");
</pre>
괄호안에 문자열은 오라클 JDBC 드라이버 중의 시작 클래스를 나타내고 있다.<br />
ojdbc6.jar 파일을 풀면 oracle.jdbc.driver 팩키지의 OracleDriver.class 를 확인할 수 있다.<br />
Class 란 클래스의 forName() static 란 메소드가 쓰였는데 Class 는 JDBC 에 속한 클래스가 아니다.<br />
Class 는 클래스 정보를 알아내기 위한 클래스로 forName(String) 메소드는 인자로 들어온 문자열에 
해당하는 클래스를 클래스 로더가 메모리 공간에 로딩하도록 한다.<br />
<em>사실 forName() 메소드의 리턴값이 있으나 JDBC 프로그래밍에서는 필요없다.</em><br />
이 메소드가 실행될 때 클래스 로더가 클래스 패스를 참조해서 해당하는 클래스를 찾지 못한다면 
ClassNotFoundException 을 만나게 된다.<br />
결론적으로 위 코드의 역할은 oracle.jdbc.driver.OracleDriver 클래스를 메모리에 로딩하는 것이다.<br />
로딩된 OracleDriver 클래스는 자기 자신을 java.sql.DriverManager 에 등록한다.<br />
이후로 DriverManager의 getConnection() 를 호출하면서 약속된 값을 인자값으로 넣어주면 오라클에서 만든 
Connection 구현체가 리턴될 것이다.<br />   

<h2>2. Connection 맺기</h2>
<pre class="prettyprint">
conn = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:XE", "scott", "tiger");
</pre>
JDBC API는 대부분 인터페이스이다.<br />
DriverManager 는 우리 예제에서 유일하게 온전한 클래스이다.<br />
DriverManager 클래스의 역활은 이름 그대로 데이터베이스 벤더들이 썬의 JDBC API를 구현한 드라이버를 
관리한다.<br />
DriverManager.getConnection 메소드는 인자로 들어오는 값에 따라서 특정 데이터베이스 벤더가 구현한 
Connection 타입의 객체를 반환한다.<br />
Connection 객체를 얻었다는 것은 데이터베이스와 연결 상태가 되었음을 의미한다.<br />

<h2>3. SQL 실행</h2>
<pre class="prettyprint">
// Statement를 가져온다.
stmt = conn.createStatement();
// SQL문을 실행한다.
rs = stmt.executeQuery(query);
</pre>
데이터베이스와 연결 상태가 되었으므로 이젠 SQL문을 DBMS에 전달해야 한다.<br />
SQL 문을 데이터베이스로 전송하기 위해서는 Statement 구현체나 PreparedStatement 구현체를 
이용해야 한다.<br />
Statement 구현체나 PreparedStatement 구현체는 Connection 구현체를 통해서 생성한다.<br />
SQL문이 select 문장일 경우 Statement 객체의 executeQuery 메소드를 이용한다.<br />
만일 SQL문이 insert나 update 문일 경우는 executeUpdate 메소드를 이용한다.<br />

<h2>4. [SQL문이 select문이었다면 ResultSet을 이용한 처리]</h2>
<pre class="prettyprint">
while (rs.next()) {
	String empno = rs.getString(1);
	String ename = rs.getString(2);
	...
	..
</pre>
SQL문이 select 문이면 반환한 레코드를 저장할 객체가 필요하다.<br />
이때 레코드를 담을 그릇 역활을 하는 것이 ResultSet 이다.<br />
테이블 형태의 데이터를 저장하는 JDBC 에서만 쓰이는 컬렉션이라 생각하자.<br />
반환된 ResultSet 객체는 커서를 가지는데 커서의 위치는 처음에는 첫번째 레코드 이전을 가리킨다.<br />
따라서 첫번째 레코드를 가리키려면 next()메소드가 실행되어야 한다.<br />
next() 메소드가 실행되면 커서를 한단계 아래로 이동시키고 이때 커서가 가리키는 곳에 레코드가 있다면 
true 를 리턴한다.<br />

<h2>5. 자원 반환</h2>
JDBC 프로그래밍에서 자원 반환은 정말 중요하다.<br />
객체가 더이상 쓰이지 않을 때 가베지 컬렉터가 동작한다고 했는데 이때 예외가 있다.<br />
객체 자체가 열심히 동작하고 있다고 판단되면 가베지 컬렉터는 그 객체를 회수하지 않는다.<br />
JDBC 와 관련된 객체가 이런 객체에 속한다.<br />
따라서 JDBC 프로그래밍에서 작업이 끝나면 반드시 생성된 객체의 자원을 반환하는 코드를 작성해야 한다.<br />
그러기 위해서는 자원 반환 코드 조각을 finally 블록에 구현한다.<br />
finally 블록은 익셉션이 발생하건 안하건 실행되는 블록이기 때문이다.<br />
다음 코드는 finally 블록에 구현해야 한다.<br />

<pre class="prettyprint">
// ResultSet를 닫는다.
rs.close();
// Statement를 닫는다.
stmt.close();
// Connection를 닫는다.
conn.close();
</pre>
자원 반환 순서는 생성한 순서의 반대로 반환한다.