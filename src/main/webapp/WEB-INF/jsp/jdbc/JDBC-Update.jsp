<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.5.21</div>

<h1>UPDATE</h1>

이번 강좌에서는 JDBC를 이용해서 UPDATE 문을 실행하는 예제를 구현한다.<br />
UpdateNamecard.java 의 메인 메소드에 아래 JDBC 프로그래밍 순서를 참조하여 작성한다.<br />
우리의 목표는<br /> 
UPDATE NAMECARD SET EMAIL ='gildonghong@gmail.org' WHERE NO = 1<br />
문장을 실행하는 것이다.<br />

<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 실행결과 처리]</li>
	<li>자원 반환</li>
</ol>

<em class="filename">NamecardUpdate.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class NamecardUpdate {
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASS = "tiger";
	
	public static void main(String[] args) {
		// JDBC 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Connection con = null;
		Statement stmt = null;
		String sql = "UPDATE NAMECARD " +
			"SET EMAIL ='gildonghong@gmail.org' " +
			"WHERE NO = 1";
		try {
			// Connection 맺기
			con = DriverManager.getConnection(URL, USER, PASS);
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(sql);
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