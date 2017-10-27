<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2016.6.4</div>

<h1>Spring 트랜잭션</h1>

<em class="filename">applicationContext.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:aop="http://www.springframework.org/schema/aop"<strong>
	xmlns:tx="http://www.springframework.org/schema/tx"</strong>
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans
		http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/aop
		http://www.springframework.org/schema/aop/spring-aop.xsd<strong>
		http://www.springframework.org/schema/tx
		http://www.springframework.org/schema/tx/spring-tx.xsd"</strong>&gt;
	
	&lt;!-- transactionManager begin --&gt;
	<strong>&lt;bean id="transactionManager" 
	    class="org.springframework.jdbc.datasource.DataSourceTransactionManager"&gt;
		&lt;property name="dataSource" ref="dataSource" /&gt;
	&lt;/bean&gt;
	
	&lt;tx:annotation-driven transaction-manager="transactionManager" /&gt;</strong>
	&lt;!-- transactionManager end --&gt;
	
	&lt;!-- 기존과 같음. --&gt;

&lt;/beans&gt;
</pre>

클래스에 어노테이션을 사용해서 트랜잭션을 설정한다.

<em class="filename">ShinhanBank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.List;
<strong>
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Transactional(propagation=Propagation.SUPPORTS)</strong>
public class ShinhanBank implements Bank {
	
	//중간 생략..
	
	@Override
	<strong>@Transactional(propagation=Propagation.REQUIRED)</strong>
	public void transfer(String from, String to, long amount) {
		<strong>int check = dao.withdraw(from, amount);
		if (check &lt; 1) {
			throw new RuntimeException("출금 실패");
		}
		check = dao.deposit(to, amount);
		if (check &lt; 1) {
			throw new RuntimeException("입금 실패");
		}</strong>
	}

	//중간 생략..
	
}
</pre>

입금과 출금시 dao가 정수값을 리턴하도록 자바 클래스를 수정한다.

<em class="filename">BankDao.java</em>
<pre class="prettyprint">
//입금
public int deposit(String accountNo, long amount);

//출금
public int withdraw(String accountNo, long amount);
</pre>


<em class="filename">ShinhanBankDao.java</em>
<pre class="prettyprint">
@Override
public <strong>int</strong> deposit(String accountNo, long amount) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("amount", amount);
	params.put("accountNo", accountNo);
	
	<strong>return</strong> getNamedParameterJdbcTemplate().update(DEPOSIT, params);
}

@Override
public <strong>int</strong> withdraw(String accountNo, long amount) {
	Map&lt;String, Object&gt; params = new HashMap&lt;String, Object&gt;();
	params.put("amount", amount);
	params.put("accountNo", accountNo);
	
	<strong>return</strong> getNamedParameterJdbcTemplate().update(WITHDRAW, params);		
}
</pre>


컴파일하고 실행한 후,
101 계좌에서 505 계좌(존재하는 않는 계좌)로 이체 테스트를 해본다.<br />
테스트에 성공했다면, 
ShinhanBank 클래스에서 transfer() 메서드 위에 있는 @Transactional(propagation=Propagation.REQUIRED)을 제거하고 
테스트한다.

