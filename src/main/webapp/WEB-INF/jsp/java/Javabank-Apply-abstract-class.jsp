<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.5.25</div>
	
<h1>자바은행 수정 (추상클래스 적용)</h1>

기존의 계좌 클래스를 추상 클래스로 수정하고, 일반 계좌와 마이너스 계좌를 추상 계좌 클래스를 상속하도록 결정했다.
새로운 종류의 계좌가 필요하다면 추상 계좌 클래스를 상속하여 만들면 될 것이다.<br />
<br />
출금시 잔고가 부족할 때 발생시킬 사용자 정의 예외 클래스를 작성한다.<br />
아래 그림처럼 RuntimeException을 상속하도록 InsufficientBalanceException.java를 작성하고 저장한다.<br />

<img alt="" src="https://lh3.googleusercontent.com/-k8W3Fdv4UsY/VWKmyB_TZaI/AAAAAAAACJM/Fth5yxSkTR8/s590/create-exception-with-eclipse.png"><br />

에디터 뷰에서 마우스 오른쪽 버튼으로 컨텍스트 메뉴를 보이게 한 후,
Source - Generate Constructors form SuperClass...를 차례로 선택하여 생성자를 만든다.<br />

<img alt="" src="https://lh3.googleusercontent.com/-cghmWWIl6n0/VWKjEDyc0dI/AAAAAAAACIA/EkwIZL_GRmE/s720/source-Generate-Constructors-form-SuperClass.png"><br />

<em class="filename">InsufficientBalanceException.java</em>
<pre class="prettyprint">
package net.java_school.bank;

public class InsufficientBalanceException extends RuntimeException {

	private static final long serialVersionUID = -8617159875648641557L;

	public InsufficientBalanceException() {
		super();
	}

	public InsufficientBalanceException(String message, Throwable cause) {
		super(message, cause);
	}

	public InsufficientBalanceException(String message) {
		super(message);
	}

	public InsufficientBalanceException(Throwable cause) {
		super(cause);
	}

}
</pre>

중복된 계좌를 등록하려 할 때 발생시킬 예외 클래스를 위와 동일한 방법으로 생성한다.<br />

<em class="filename">DuplicateAccountException.java</em>
<pre class="prettyprint">
package net.java_school.bank;

public class DuplicateAccountException extends RuntimeException {

	private static final long serialVersionUID = -100648724423914991L;

	public DuplicateAccountException() {
		super();
	}

	public DuplicateAccountException(String message, Throwable cause) {
		super(message, cause);
	}

	public DuplicateAccountException(String message) {
		super(message);
	}

	public DuplicateAccountException(Throwable cause) {
		super(cause);
	}

}
</pre>

계좌(Account) 클래스를 추상 클래스로 변경한다.<br />
출금 메서드 withdraw()를 추상 메서드로 변경한다.<br />

<em class="filename">Account.java</em>
<pre class="prettyprint">
public <strong>abstract</strong> class Account {

	//.. 기존 코드와 같다..
		
	<strong>public abstract void withdraw(long amount);</strong>
	
	//.. 기존 코드와 같다 .. 
}
</pre>

출금액이 잔고보다 클 수 없는 일반 계좌를 생성한다.<br />

<em class="filename">NormalAccount.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.Calendar;
import java.util.Date;

public class NormalAccount extends Account {

	public NormalAccount() {}
	
	public NormalAccount(String accountNo, String name, String kind) {
		super(accountNo, name, kind);
	}

	public NormalAccount(String accountNo, String name, long balance, String kind) {
		super(accountNo, name, balance, kind);
	}
	
	@Override
	public void withdraw(long amount)  {
		<strong>if (amount &gt; balance) {
			throw new InsufficientBalanceException("잔고가 부족합니다.");
		}</strong>
		balance = balance - amount;
		Transaction transaction = new Transaction();
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
		transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
		transaction.setAmount(amount);
		transaction.setKind(Account.WITHDRAW);
		transaction.setBalance(this.balance);
		transactions.add(transaction);
	}
	
}
</pre>

<em class="filename">Bank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.ArrayList;
import java.util.List;

public class Bank {
	private ArrayList&lt;Account&gt; accounts = new ArrayList&lt;Account&gt;();

	public void addAccount(String accountNo, String name, String kind) {
		Account account = getAccount(accountNo);
		<strong>if (account != null) throw new DuplicateAccountException("중복된 계좌입니다.");</strong>
		
		if (Account.NORMAL.equals(kind)) {
			accounts.add(new NormalAccount(accountNo, name, kind));
		} else if (Account.MINUS.equals(kind)) {
			accounts.add(new MinusAccount(accountNo, name, kind));
		}
	}
	
	public void addAccount(String accountNo, String name, long balance, String kind) {
		Account account = getAccount(accountNo);
		<strong>if (account != null) throw new DuplicateAccountException("중복된 계좌입니다.");</strong>
		
		if (Account.NORMAL.equals(kind)) {
			accounts.add(new NormalAccount(accountNo, name, balance, kind));
		} else if (Account.MINUS.equals(kind)) {
			accounts.add(new MinusAccount(accountNo, name, balance, kind));
		}
	}
	
	//.. 중간 생략 ..  
	
}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li>New 알기쉬운 자바2(개정판) 저자: 김철회 출판사: 정보문화사</li> 
</ul>