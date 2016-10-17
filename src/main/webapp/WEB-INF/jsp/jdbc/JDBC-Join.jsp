<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2011.1.10</div>

<h1>테이블 조인(Join)</h1>

명함관리는 테이블이 하나밖에 없으니 EMP와 DEPT를 조인하는 예제를 실습한다.<br />
JoinTable.java 파일의 메인 메소드에 아래 JDBC 프로그래밍 순서를 참조하여 작성한다.<br />
우리의 목표는<br />
<br />
<em>SELECT ENAME, JOB, D.DEPTNO, DNAME<br />
FROM EMP E, DEPT D<br />
WHERE E.DEPTNO = D.DEPTNO<br />
AND D.LOC = 'DALLAS'</em><br />
<br />
문을 실행하는 것이다.<br />

<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 처리]</li>
	<li>자원 반환</li>
</ol>

<em class="filename">JoinTable.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JoinTable {
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
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT ENAME,JOB,D.DEPTNO,DNAME " +
				"FROM EMP E, DEPT D " +
				"WHERE E.DEPTNO = D.DEPTNO " +
				"AND D.LOC = 'DALLAS'";
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				String deptno = rs.getString("deptno");
				String dname = rs.getString("dname");
				System.out.println(ename + " " + job + " " + deptno + " " + dname);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				pstmt.close();
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