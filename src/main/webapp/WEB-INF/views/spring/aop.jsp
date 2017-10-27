<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.6.5</div>

<h1>Spring AOP</h1>

pom.xml에 의존성을 추가한다.

<pre class="prettyprint">
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework&lt;/groupId&gt;
	&lt;artifactId&gt;spring-aspects&lt;/artifactId&gt;
	&lt;version&gt;${spring.version}&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
	&lt;groupId&gt;org.aspectj&lt;/groupId&gt;
	&lt;artifactId&gt;aspectjweaver&lt;/artifactId&gt;
	&lt;version&gt;1.8.4&lt;/version&gt;
&lt;/dependency&gt;
</pre>

로그를 출력하기 위한 테스트 클래스를 net.java_school.commons 팩키지에 작성한다.<br>

<em class="filename">TestLogger.java</em>
<pre class="prettyprint">
package net.java_school.commons;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Aspect
public class TestLogger {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@AfterReturning("execution(* net.java_school.bank.BankDao.deposit(..))")
	public void depositLog(JoinPoint point) {
		Object[] a = point.getArgs();
		String accountNo = (String) a[0];
		Long amount = (Long) a[1];
		String methodName = point.getSignature().getName();
		logger.debug("{}|{}|{}", methodName, accountNo, amount);
	}
	
	@AfterReturning("execution(* withdraw(..)) &amp;&amp; args(accountNo, amount)")
	public void withdrawLog(String accountNo, long amount) {
		logger.debug("WITHDRAW|{}|{}", accountNo, amount);
	}
	
}
</pre>

<em class="filename">applicationContext.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans"
 	<strong>xmlns:aop="http://www.springframework.org/schema/aop"</strong> 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans 
		http://www.springframework.org/schema/beans/spring-beans.xsd
		<strong>http://www.springframework.org/schema/aop 
		http://www.springframework.org/schema/aop/spring-aop.xsd</strong>"&gt;
	<strong>
	&lt;aop:aspectj-autoproxy&gt;
		&lt;aop:include name="testLogger"/&gt;
	&lt;/aop:aspectj-autoproxy&gt;

	&lt;bean id="testLogger" class="net.java_school.commons.TestLogger" /&gt;
    </strong>
	
	&lt;!-- ..이전과 같음.. --&gt;

		
&lt;/beans&gt;
</pre>

자바 소스에서 로그 설정을 모두 제거한다.<br />

<em class="filename">ShinhanBankDao.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShinhanBankDao implements BankDao {
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASSWORD = "tiger";
	
	//중간 생략..
	
	@Override
	public void deposit(String accountNo, long amount) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE bankaccount " +
				"SET balance = balance + ? " +
				"WHERE accountNo = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, amount);
			pstmt.setString(2, accountNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
	}

	@Override
	public void withdraw(String accountNo, long amount) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE bankaccount " +
				"SET balance = balance - ? " +
				"WHERE accountNo = ?";
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setLong(1, amount);
			pstmt.setString(2, accountNo);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
	}
	
	//중간 생략..
	
}	
</pre>

컴파일하고 실행한 후 프로젝트 루트 디렉터리의 로그 파일에 로그 메시지가 쌓이는지 확인한다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.spring.io/spring/docs/current/spring-framework-reference/html/aop.html">http://docs.spring.io/spring/docs/current/spring-framework-reference/html/aop.html</a></li>
</ul>