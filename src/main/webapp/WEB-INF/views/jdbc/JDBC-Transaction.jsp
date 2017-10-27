<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.5.21</div>

<h1>트랜잭션</h1>

트랜잭션 관리의 예는 계좌이체가 가장 좋은 예제이다.<br />
A 계좌에서 B 계좌로 1000 원을 이체한다면 <br />
<br />
<strong>과정 1. A계좌에서 1000원을 뺀다.</strong><br />
<strong>과정 2. B계좌에서 1000원을 더한다.</strong><br />
<br />
위와 같을 것이다.<br />
만일 <strong>과정 1</strong>이 성공했는데 <strong>과정 2</strong>가 실패했다면 <strong>과정 1</strong>까지 
취소하고 <strong>과정 1</strong>이전의 상태로 복구하는 것이 트랜잭션 관리의 목적이다.<br />
트랜잭션 관리를 위해서 <strong>과정 1</strong>과 <strong>과정 2</strong>는 하나의 단위로 보는 것이 가장 중요하다.<br />
이때 <strong>과정 1</strong>과 <strong>과정 2</strong>를 묶어서 트랜잭션의 단위라고 한다.<br />
<br />
JDBC 프로그램에서 얻은 커넥션은 기본적으로 자동 커밋 모드이다.<br />
자동 커밋 모드는 SQL문장 하나 하나를 트랜잭션 단위로 보는 것이다.<br />
이를 해제하기 위해서는 자동 커밋 모드를 false로 설정하고 프로그램상에서 커밋 시점을 정의하는 것이 트랙잭션 관리 코딩 방법이다.<br />
<br />
계좌이체에 적용하면,<br />
<br />
<em>con.setAutoCommit(false);</em><br />
<strong>과정 1. A계좌에서 1000원을 뺀다.</strong><br />
<strong>과정 2. B계좌에서 1000원을 더한다.</strong><br />
<em>con.commit();</em><br />
<br />
트랜잭션 예제를 위해서 아래와 같이 scott계정에 ACCOUNT 테이블을 만들고 데이터를 인서트한다. 

<pre class="prettyprint">
create table account (
 accountno varchar2(3) primary key,
 balance number,
 constraint account_balance_ck check(balance between 0 and 3000)
)
/
insert into account values ('111', 3000)
/
insert into account values ('222', 2000)
/
</pre>
TransactionPairs.java의 메인 메소드에 아래 JDBC 프로그램 방법을 참조하여 작성한다.
<ol>
	<li>JDBC 드라이버 로딩</li>
	<li>Connection 맺기</li>
	<li>SQL 실행</li>
	<li>[SQL문이 select문이었다면 ResultSet을 이용한 처리]</li>
	<li>자원 반환</li>
</ol>
우리의 목표는 <br />
<em>update account set balance = balance - 1500 where accountno = '111'<br />
update account set balance = balance + 1500 where accountno = '222'</em><br />
을 실행하는 것이다.<br />

<em class="filename">TransactionPairs.java</em>
<pre class="prettyprint">
package net.java_school.jdbc.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TransactionPairs {
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASS = "tiger";
	
	public static void main(String[] args) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE account SET balance = balance + ? WHERE accountno = ?";
		
		try {
			con = DriverManager.getConnection(URL, USER, PASS);
			<strong>
			con.setAutoCommit(false);
			</strong>
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, -1500);
			pstmt.setString(2, "111");
			pstmt.executeUpdate();
			
			pstmt.setInt(1, 1500);
			pstmt.setString(2, "222");
			pstmt.executeUpdate();
			<strong>
			con.commit();
			</strong>
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				<strong>con.rollback();</strong> //익셉션이 발생하면 롤백한다.
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
</pre>

실행하고 SQL*PLUS로 결과를 확인한다.<br />
<em>java.sql.SQLException: ORA-02290: 체크 제약조건(SCOTT.ACCOUNT_BALANCE_CK)이 위배되었습니다</em>
라는 익셉션 메시지를 보게 될 것이다.<br />
ACCOUNT 테이블의 BALANCE 컬럼은 0에서 3000까지의 수만 저장될 수 있기 때문이다.<br />
그 결과 catch블록에서 롤백이 실행된다.<br />
