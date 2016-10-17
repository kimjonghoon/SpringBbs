<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.5.21</div>

<h1>INSERT</h1>

이번 장에서는 NAMECARD 테이블에 JDBC를 이용해서 데이터를 INSERT 시키는 예제를 구현한다.<br />
우리의 목표는 다음  인서트 문을  실행하는 것이다.<br />

<pre class="prettyprint">
INSERT INTO NAMECARD VALUES
(
  SEQ_NAMECARD_NO.NEXTVAL,
  '홍길동',
  '011-0000-0000',
  'hongkildong@gmail.org',
  '활빈당'
);
</pre>

아래 NamecardInsert.java 의 메인 메소드에 아래 JDBC프로그래밍 순서를 참고해서 작성한다.

<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 처리]</li>
	<li>자원 반환</li>
</ol>

<em class="filename">NamecardInsert.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class NamecardInsert {
	<strong>static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASS = "tiger";</strong>
	
	public static void main(String[] args) {
		// JDBC 드라이버를 로딩한다.
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Connection con = null;
		Statement stmt = null;
		<strong>String sql = "INSERT INTO NAMECARD VALUES " +
			"(SEQ_NAMECARD_NO.NEXTVAL," +
			"'홍길동'," +
			"'011-0000-0000'," +
			"'hongkildong@gmail.org'," +
			"'활빈당')";</strong>

		try {
			// Connection 맺기
			con = DriverManager.getConnection(<strong>URL, USER, PASS</strong>);
			// SQL 실행
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			<strong>System.out.println(sql);</strong>
		} finally {
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		

	}

}
</pre>

한번 실행하고 난 다음 데이터가 삽입되었는지 SQL*PLUS에서 확인한다.<br />