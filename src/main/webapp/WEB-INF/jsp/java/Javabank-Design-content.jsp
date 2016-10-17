<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.12.7</div>

<h1>자바은행  구현</h1>

분석 작업의 결과물인 클래스 다이어그램을 토대로 각각의 클래스를 작성한다.<br />
먼저 입출금 명세 클래스를 작성한다.<br />
클래스 다이어그램에서 toString() 메서드가 추가되었다.<br />

<em class="filename">Transaction.java</em>
<pre class="prettyprint">
package net.java_school.bank;

public class Transaction {
	private String transactionDate;
	private String transactionTime;
	private String kind;
	private long amount;
	private long balance;

	public Transaction() {}
	
	public Transaction(String transactionDate,
			String transactionTime,
			String kind,
			long amount,
			long balance) {
			
		this.transactionDate = transactionDate;
		this.transactionTime = transactionTime;		
		this.kind = kind;
		this.amount = amount;
		this.balance = balance;
	}
	
	public String getTransactionDate() {
		return transactionDate;
	}
	public void setTransactionDate(String transactionDate) {
		this.transactionDate = transactionDate;
	}
	public String getTransactionTime() {
		return transactionTime;
	}
	public void setTransactionTime(String transactionTime) {
		this.transactionTime = transactionTime;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public long getAmount() {
		return amount;
	}
	public void setAmount(long amount) {
		this.amount = amount;
	}
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(this.transactionDate);
		sb.append("|");
		sb.append(this.transactionTime);
		sb.append("|");
		sb.append(this.kind);
		sb.append("|");
		sb.append(this.amount);
		sb.append("|");
		sb.append(this.balance);

		return sb.toString();
	}
        
}
</pre>

다음으로 계좌 클래스를 작성한다.<br />
private Transaction[] transactions = new Transaction[100];
배열 변수 transactions에는 크기가 100인 배열 객체를 할당하고 있다.<br />
100은 임의로 지정했는데 자바에서는 배열의 길이를 정하지 않고는 생성할 수 없기 때문이다.<br />
<br />
클래스 다이어그램과 차이나는 부분은 다음과 같다.<br />
private int totalTransaction;은 transactions 배열에 값을 순서대로 넣기 위해 추가했다.<br />
4개의 스태틱 상수를 추가했다.<br />
DATE_FORMAT는 입출금 날자 포맷을, TIME_FORMAT는 입출금 시간 포맷을 저장하고,
DEPOSIT는 입금, WITHDRAW는 출금이라는 문자열을 저장한다.<br />
<br />
생성자 2개를 추가했다.<br />
하나는 디폴트 생성자이고 다른 하나는 계좌번호와 소유자명을 인자 값으로 받는 생성자이다.<br />
출력을 쉽게 하기 위해서 toString() 메서드를 추가했다.<br />
코드 구현 중에 클래스 다이어그램과 비교하여 변경사항이 있으면, 그리고 그것이 테스를 위해 임시로 만든 것이 아니라면, 
클래스 다이어그램에 추가해야 한다.<br />

<em class="filename">Account.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Account {
	private String accountNo;
	private String name;
	private long balance;
	private Transaction[] transactions = new Transaction[100];
	private int totalTransaction;

	static final SimpleDateFormat DATE_FORMAT = 
			new SimpleDateFormat("yyyy/MM/dd");
			
	static final SimpleDateFormat TIME_FORMAT = 
			new SimpleDateFormat("HH:mm:ss");
			
	static final String DEPOSIT = "입금";
	static final String WITHDRAW = "출금";

	public Account() {}
	
	public Account(String accountNo, String name) {
		this.accountNo = accountNo;
		this.name = name;
	}
	
	public Account(String accountNo, String name, long balance) {
		this.accountNo = accountNo;
		this.name = name;
		this.balance = balance;
	}

	public void deposit(long amount) {
		balance = balance + amount;
		Transaction transaction = new Transaction();
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
		transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
		transaction.setAmount(amount);
		transaction.setKind(Account.DEPOSIT);
		transaction.setBalance(this.balance);
		transactions[totalTransaction++] = transaction;
	}

	public void withdraw(long amount) {
		if (amount &gt; balance) {
			return;
		}
		balance = balance - amount;
		Transaction transaction = new Transaction();
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
		transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
		transaction.setAmount(amount);
		transaction.setKind(Account.WITHDRAW);
		transaction.setBalance(this.balance);
		transactions[totalTransaction++] = transaction;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}

	public long getBalance() {
		return balance;
	}

	public void setBalance(long balance) {
		this.balance = balance;
	}

	public Transaction[] getTransactions() {
		return transactions;
	}

	public int getTotalTransaction() {
		return totalTransaction;
	}

	public void setTotalTransaction(int totalTransaction) {
		this.totalTransaction = totalTransaction;
	}

	public void setTransactions(Transaction[] transactions) {
		this.transactions = transactions;
	}

	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(accountNo);
		sb.append("|");
		sb.append(name);
		sb.append("|");
		sb.append(balance);

		return sb.toString();
	}

}
</pre>

마지막으로 은행 클래스를 작성한다.<br />
private Account[] accounts = new Account[10]; 코드로 
accounts 배열 변수에 크기 10의 배열 객체를 할당하고 있다.<br />
총 계좌수를 저장할 변수 totalAccount는 배열 변수 accounts에 값을 순서대로 넣기 위해서 사용된다.<br />
findAccountByName()는 소유자 이름으로 계좌를 찾는 메서드이다.<br />
소유자 이름이 같은 계좌가 있을 수 있으므로 반환 타입은 Account[]이다.<br />
findAccountByName() 메서드는 조건에 맞는 계좌를 찾고, 찾은 계좌 수를 크기로 하는 새로운 배열을 만들고, 찾은 계좌를 
모두 새로 만든 배열에 넣어 반환하는 것으로 구현했다.
 
<em class="filename">Bank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

public class Bank {
	private Account[] accounts = new Account[10];
	private int totalAccount;

	public void addAccount(String accountNo, String name) {
		accounts[totalAccount++] = new Account(accountNo, name);
	}
	
	public void addAccount(String accountNo, String name, long balance) {
		accounts[totalAccount++] = new Account(accountNo, name, balance);
	}

	public Account getAccount(String accountNo) {
		for (int i = 0; i &lt; totalAccount; i++) {
			if (accountNo.equals(accounts[i].getAccountNo())) {
				return accounts[i];
			}
		}
		return null;
	}

	public Account[] findAccountByName(String name) {
		Account[] temp = new Account[totalAccount];
		int total = 0;
		for (int i = 0; i &lt; totalAccount; i++) {
			if (name.equals(accounts[i].getName())) {
				temp[total++] = accounts[i];
			}
		}
		Account[] matched = new Account[total];
		for (int i = 0; i &lt; total; i++) {
			matched[i] = temp[i];
		}

		return matched;
	}

	public Account[] getAccounts() {
		return accounts;
	}

	public int getTotalAccount() {
		return totalAccount;
	}
        
}	

</pre>

테스트를 위한 클래스를 작성한다.<br />

<em class="filename">Test.java</em>
<pre class="prettyprint">
package net.java_school.bank;

public class Test {
	static final String ACCOUNTS_HEADING = "계좌번호|소유자명|잔고";
	static final String TRANSACTIONS_HEADING = "거래일|거래시간|구분|금액|잔고";

	public static void main(String[] args) {
	
		//테스트 계좌 추가
		Bank bank = new Bank();
		bank.addAccount("101", "홍길동");
		bank.addAccount("202", "임꺽정");
		bank.addAccount("303", "장길산");
		bank.addAccount("404", "홍길동");
		
		//1. 총 계좌 목록을 출력한다.
		System.out.println("1. 총 계좌 목록을 출력한다.");
		Account[] accounts = bank.getAccounts();
		int totalAccount = bank.getTotalAccount();
		System.out.println(Test.ACCOUNTS_HEADING);
		for (int i = 0; i &lt; totalAccount; i++) {
			System.out.println(accounts[i]);
		}

		System.out.println();
				
		//2. 101계좌에 10,000원을 입금한다.
		System.out.println("2. 101계좌에 10,000원을 입금한다.");		
		Account hong = bank.getAccount("101");
		hong.deposit(10000);
		System.out.println(Test.ACCOUNTS_HEADING);
		System.out.println(hong);

		System.out.println();
				
		//3. 101계좌에 5,000원을 출금한다.
		System.out.println("3. 101계좌에 5,000원을 출금한다.");		
		hong.withdraw(5000);
		System.out.println(Test.ACCOUNTS_HEADING);
		System.out.println(hong);

		System.out.println();
				
		//4. 101계좌의 입출금 명세를 출력한다.
		System.out.println("4. 101계좌의 입출금 명세를 출력한다.");		
		Transaction[] transactions = hong.getTransactions();
		int totalTransaction = hong.getTotalTransaction();
		System.out.println(Test.TRANSACTIONS_HEADING);
		for (int i = 0; i &lt; totalTransaction; i++) {
			System.out.println(transactions[i]);
		}

		System.out.println();
		
		//5. 고객명으로 계좌를 찾는다.
		System.out.println("5. 홍길동 계좌찾기");
		Account[] matched = bank.findAccountByName("홍길동");
		System.out.println(Test.ACCOUNTS_HEADING);
		//확장된 for문
		for (Account account : matched) {
			System.out.println(account);
		}
		
	}

}
</pre>

<h2>날짜와 시간</h2>

날짜와 시간을 위한 자바 API 클래스는 java.util.Date와 java.util.Calendar가 있다.<br />
날짜와 시간을 위한 외부 라이브러리는 joda-Time과 apache 프로젝트인 FastDateFormat이 있다.<br />
다음은 이들의 사용법에 관한 예제이다.<br />
 
<em class="filename">DateExample.java</em>
<pre class="prettyprint">
package net.java_school.example.basic;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

public class DateExample {

	public static void main(String[] args) {
		
		Date date = new Date();

		// 1. Date object's toString() call
		System.out.println("1: " + date);

		// 2. JDK SimpleDateFormat
		SimpleDateFormat DATE_FORMAT1 = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
		System.out.println("2-1: " + DATE_FORMAT1.format(date));

		SimpleDateFormat DATE_FORMAT2 = new SimpleDateFormat("yy/M/d H:m:s");
		System.out.println("2-2: " + DATE_FORMAT2.format(date));

		// 3. joda-Time 
		DateTime dt = new DateTime(date);
		System.out.println("3-1: " + dt.getYear() + "/" + dt.getMonthOfYear() + "/" + dt.getDayOfMonth());

		DateTimeFormatter fmt1 = ISODateTimeFormat.dateTime();
		System.out.println("3-2: " + fmt1.print(dt));

		DateTimeFormatter fmt2 = DateTimeFormat.forPattern("yyyy.MM.dd HH:mm:ss");
		System.out.println("3-3: " + fmt2.print(dt));

		// 4. apache FastDateFormat
		System.out.println("4-1: " + DateFormatUtils.ISO_DATETIME_FORMAT.format(date));

		System.out.println("4-2: " + DateFormatUtils.ISO_DATETIME_TIME_ZONE_FORMAT.format(date));

	}
}
</pre>

<pre class="console"><strong class="console-result">1: Mon Dec 07 15:44:55 KST 2015
2-1: 2015.12.07 15:44:55
2-2: 15/12/7 15:44:55
3-1: 2015/12/7
3-2: 2015-12-07T15:44:55.440+09:00
3-3: 2015.12.07 15:44:55
4-1: 2015-12-07T15:44:55
4-2: 2015-12-07T15:44:55+09:00</strong></pre>


<h3>과제</h3>
<ol>
	<li>배열은 모두 ArrayList로 변경</li>
	<li>중복된 계좌번호가 생성되지 않도록</li>
	<li>금액 표시는 1,000,000 같이 세 자리마다 ,(콤마)</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.infopub.co.kr/bookinfo/bookinfo.asp?sku=05000195">New 알기쉬운 Java 2 J2SE 1.4</a></li>
	<li><a href="http://www.joda.org/joda-time/">http://www.joda.org/joda-time/</a></li>
	<li><a href="http://www.joda.org/joda-time/userguide.html">joda-Time userguide</a></li>
	<li><a href="https://commons.apache.org/proper/commons-lang/">Apache Commons Lang</a></li>
	<li><a href="http://examples.javacodegeeks.com/core-java/apache/commons/lang3/date-andtime-format/">Date and Time format examples using Apache Commons Lang</a></li>
</ul>