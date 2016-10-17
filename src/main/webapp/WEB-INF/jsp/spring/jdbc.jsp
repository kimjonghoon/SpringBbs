<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.6.4</div>

<h1>Spring JDBC</h1>

의존성을 추가한다.<br />
 
<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;dependency&gt;
	&lt;groupId&gt;org.springframework&lt;/groupId&gt;
	&lt;artifactId&gt;spring-jdbc&lt;/artifactId&gt;
	&lt;version&gt;${spring.version}&lt;/version&gt;
&lt;/dependency&gt;
</pre>

ShinhanBankDao 클래스가 NamedParameterJdbcDaoSupport 클래스를 상속하도록 선언한다.<br />
생성자와 getConnection(), close(rs,pstmt,con) 메서드는 제거한다.<br />

<em class="filename">ShinhanBankDao.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

<strong>import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;</strong>

public class ShinhanBankDao <strong>extends NamedParameterJdbcDaoSupport</strong> 
		implements BankDao {
	//생성자, getConnection(), close(rs,pstmt,con) 메서드는 삭제한다.
	
	//중간 생략..

}
</pre>


수정 전 메서드를 보여주고 이어서 메서드를 수정하도록 하겠다.

<em class="filename">insertAccount</em>
<pre class="prettyprint">
@Override
public void insertAccount(String accountNo, String name, String kind) {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	
	String sql = "INSERT INTO bankaccount VALUES (?, ?, 0, ?)";
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, accountNo);
		pstmt.setString(2, name);
		pstmt.setString(3, kind);
		pstmt.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(null, pstmt, con);
	}
	
}
</pre>

<em class="filename">insertAccount</em>
<pre class="prettyprint">
private static final String INSERT_ACCOUNT = 
		"INSERT INTO " +
		"bankaccount (accountno, owner, kind) " +
		"VALUES (:accountNo, :name, :kind)";
   
@Override
public void insertAccount(String accountNo, String name, String kind) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("accountNo", accountNo);
	params.put("name", name);
	params.put("kind", kind);
	
	getNamedParameterJdbcTemplate().update(INSERT_ACCOUNT, params);		
}
</pre>

<em class="filename">selectOneAccount</em>
<pre class="prettyprint">
@Override
public Account selectOneAccount(String accountNo) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	Account account = null;
	
	String sql = "SELECT accountNo,owner,balance,kind " +
			"FROM bankaccount " +
			"WHERE accountNo = ?";
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, accountNo);
		rs = pstmt.executeQuery();
		
		if (rs.next()) {
			account = new Account();
			account.setAccountNo(rs.getString("accountNo"));
			account.setName(rs.getString("owner"));
			account.setBalance(rs.getLong("balance"));
			account.setKind(rs.getString("kind"));
			
			return account;
			
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rs, pstmt, con);
	}
	return null;
}
</pre>

<em class="filename">selectOneAccount</em>
<pre class="prettyprint">
private static final String SELECT_ONE_ACCOUNT = 
		"SELECT accountno,owner,balance,kind " +
		"FROM bankaccount " +
		"WHERE accountno = :accountNo";

@Override
public Account selectOneAccount(String accountNo) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("accountNo", accountNo);
	
	return getNamedParameterJdbcTemplate().queryForObject(
		SELECT_ONE_ACCOUNT,
		params,
		new RowMapper&lt;Account&gt;() {
			public Account mapRow(ResultSet rs,int rowNum) throws SQLException {
				Account account = new Account();
				account.setAccountNo(rs.getString("accountNo"));
				account.setName(rs.getString("owner"));
				account.setBalance(rs.getLong("balance"));
				account.setKind(rs.getString("kind"));
				
				return account;
			}
		}
	);
}
</pre>

<em class="filename">selectAccountsByName</em>
<pre class="prettyprint">
@Override
public List&lt;Account&gt; selectAccountsByName(String name) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	List&lt;Account&gt; matched = new ArrayList&lt;Account&gt;();
	Account account = null;
	
	String sql = "SELECT accountNo,owner,balance,kind " +
			"FROM bankaccount " +
			"WHERE owner = ? " +
			"ORDER By accountNo DESC";
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			account = new Account();
			account.setAccountNo(rs.getString("accountNo"));
			account.setName(rs.getString("owner"));
			account.setBalance(rs.getLong("balance"));
			account.setKind(rs.getString("kind"));
			matched.add(account);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rs, pstmt, con);
	}

	return matched;
}
</pre>

<em class="filename">selectAccountsByName</em>
<pre class="prettyprint">
private static final String SELECT_ACCOUNTS_BY_NAME = 
		"SELECT accountno,owner,balance,kind " +
		"FROM bankaccount " +
		"WHERE owner = :name";

@Override
public List&lt;Account&gt; selectAccountsByName(String name) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("name", name);
	RowMapper&lt;Account&gt; rowMapper = new AccountRowMapper();
	
	return getNamedParameterJdbcTemplate().query(SELECT_ACCOUNTS_BY_NAME,params,rowMapper);
}

protected class AccountRowMapper implements RowMapper&lt;Account&gt; {

	public Account mapRow(ResultSet rs,int rowNum) throws SQLException {

		String accountNo = rs.getString("accountNo");
		String name = rs.getString("owner");
		long balance = rs.getLong("balance");
		String kind = rs.getString("kind");
		
		Account account = new Account();
		account.setAccountNo(accountNo);
		account.setName(name);
		account.setBalance(balance);
		account.setKind(kind);
		
		return account;
	}
}
</pre>

<em class="filename">selectAllAccounts</em>
<pre class="prettyprint">
@Override
public List&lt;Account&gt; selectAllAccounts() {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	List&lt;Account&gt; all = new ArrayList&lt;Account&gt;();
	Account account = null;
	
	String sql = "SELECT accountNo,owner,balance,kind " +
			"FROM bankaccount " +
			"ORDER By accountNo DESC";
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			account = new Account();
			account.setAccountNo(rs.getString("accountNo"));
			account.setName(rs.getString("owner"));
			account.setBalance(rs.getLong("balance"));
			account.setKind(rs.getString("kind"));
			all.add(account);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rs, pstmt, con);
	}

	return all;

}
</pre>

<em class="filename">selectAllAccounts</em>
<pre class="prettyprint">
private static final String SELECT_ALL_ACCOUNTS = 
		"SELECT accountNo,owner,balance,kind " +
		"FROM bankaccount " +
		"ORDER BY accountNo DESC";

@Override
public List&lt;Account&gt; selectAllAccounts() {
	RowMapper&lt;Account&gt; rowMapper = new AccountRowMapper();
	return getJdbcTemplate().query(SELECT_ALL_ACCOUNTS,rowMapper);
}
</pre>

<em class="filename">deposit</em>
<pre class="prettyprint">
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
</pre>

<em class="filename">deposit</em>
<pre class="prettyprint">
private static final String DEPOSIT = 
		"UPDATE bankaccount " +
		"SET balance = balance + :amount " +
		"WHERE accountno = :accountNo";

@Override
public void deposit(String accountNo, long amount) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("amount", amount);
	params.put("accountNo", accountNo);
	
	getNamedParameterJdbcTemplate().update(DEPOSIT, params);
}
</pre>

<em class="filename">withdraw</em>
<pre class="prettyprint">
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
</pre>

<em class="filename">withdraw</em>
<pre class="prettyprint">
private static final String WITHDRAW = 
		"UPDATE bankaccount " +
		"SET balance = balance - :amount " +
		"WHERE accountno = :accountNo";

@Override
public void withdraw(String accountNo, long amount) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("amount", amount);
	params.put("accountNo", accountNo);
	
	getNamedParameterJdbcTemplate().update(WITHDRAW, params);		
}
</pre>

<em class="filename">selectAllTransactions</em>
<pre class="prettyprint">
@Override
public List&lt;Transaction&gt; selectAllTransactions(String accountNo) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	List&lt;Transaction&gt; all = new ArrayList&lt;Transaction&gt;();
	Transaction transaction = null;
	
	String sql = "SELECT transactionDate,kind,amount,balance " +
			"FROM transaction " +
			"WHERE accountNo = ? " +
			"ORDER By transactionDate ASC";
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, accountNo);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			transaction = new Transaction();
			String date = Account.DATE_FORMAT.format(rs.getTimestamp("transactionDate"));
			String time = Account.TIME_FORMAT.format(rs.getTimestamp("transactionDate"));
			transaction.setTransactionDate(date);
			transaction.setTransactionTime(time);
			transaction.setKind(rs.getString("kind"));
			transaction.setAmount(rs.getLong("amount"));
			transaction.setBalance(rs.getLong("balance"));
			all.add(transaction);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		close(rs, pstmt, con);
	}

	return all;

}
</pre>

<em class="filename">selectAllTransactions</em>
<pre class="prettyprint">
private static final String SELECT_ALL_TRANSACTIONS = 
		"SELECT transactionDate,kind,amount,balance " +
		"FROM transaction " +
		"WHERE accountno = :accountNo " +
		"ORDER By transactionDate ASC";

@Override
public List&lt;Transaction&gt; selectAllTransactions(String accountNo) {
	RowMapper&lt;Transaction&gt; rowMapper = new TransactionRowMapper();
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("accountNo", accountNo);

	return getNamedParameterJdbcTemplate().query(SELECT_ALL_TRANSACTIONS,params,rowMapper);
}

protected class TransactionRowMapper implements RowMapper&lt;Transaction&gt; {

	public Transaction mapRow(ResultSet rs,int rowNum) throws SQLException {

		String date = Account.DATE_FORMAT.format(rs.getTimestamp("transactionDate"));
		String time = Account.TIME_FORMAT.format(rs.getTimestamp("transactionDate"));
		String kind = rs.getString("kind");
		long amount = rs.getLong("amount");
		long balance = rs.getLong("balance");

		Transaction transaction = new Transaction();
		transaction.setTransactionDate(date);
		transaction.setTransactionTime(time);
		transaction.setKind(kind);
		transaction.setAmount(amount);
		transaction.setBalance(balance);
		
		return transaction;
	}
}
</pre>

ShinhanBankDao 클래스의 최종 임포트 문은 다음과 같다.<br />

<pre class="prettyprint">
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcDaoSupport;
</pre>

applicationContext.xml에 강조된 부분을 추가한다.

<em class="filename">applicationContext.xml</em>
<pre class="prettyprint">

&lt;bean id="shinhanBankDao" class="net.java_school.bank.ShinhanBankDao"&gt;
	<strong>&lt;property name="dataSource" ref="dataSource" /&gt;</strong>
&lt;/bean&gt;
<strong>
&lt;bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource"&gt;
    &lt;property name="driverClassName" value="oracle.jdbc.driver.OracleDriver" /&gt;
    &lt;property name="url" value="jdbc:oracle:thin:@127.0.0.1:1521:XE" /&gt;
    &lt;property name="username" value="scott" /&gt;
    &lt;property name="password" value="tiger" /&gt;
&lt;/bean&gt;
</strong>
</pre>

<h3>테스트</h3>
101계좌는 존재하나 505계좌는 존재하는 않는다고 가정한다.<br />
101계좌에서 505계좌로 이체 테스트를 한다.<br />
이체 후 101계좌는 이체 금액만큼 잔액이 줄어든다.<br />
트랜잭션에서 이 문제를 다루겠다.<br />