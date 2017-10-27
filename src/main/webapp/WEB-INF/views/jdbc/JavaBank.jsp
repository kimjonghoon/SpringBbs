<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.6.3</div>

<h1>자바은행</h1>

<h2>테이블과 트리거 생성</h2>
자바은행 예제에서 계좌와 입출금 명세 정보를 데이터베이스에 저장하도록 수정한다.<br />
SQL*PLUS에서 soctt/tiger로 접속하여 다음 테이블을 생성한다.

<pre class="prettyprint">
create table bankaccount (
	accountno varchar2(50),
	owner varchar2(20) not null,
	balance number,
	kind varchar2(10),
	constraint PK_BANKACCOUNT primary key(accountno),
	constraint CK_BANKACCOUNT_NORMAL 
		CHECK (balance &gt;= CASE WHEN kind='NORMAL' THEN 0 END),
	constraint CK_BANKACCOUNT_KIND CHECK (kind in ('NORMAL', 'MINUS'))
);  

create table transaction (
    transactiondate timestamp,
    kind varchar2(10),
    amount number,
    balance number,
    accountno varchar2(50),
    constraint FK_TRANSACTION FOREIGN KEY(accountno)
    	REFERENCES bankaccount(accountno)
);
</pre>

거래 내용 테이블은 트리거를 사용하여 데이터를 인서트할 것이다.
다음은 힌트가 되는 트리거 예제이다.

<pre class="prettyprint">
create table a (name varchar2(10));

create table b (name varchar2(10));

CREATE OR REPLACE TRIGGER test_tri
AFTER
INSERT OR UPDATE ON a
FOR EACH ROW
BEGIN
	insert into b values (:new.name);
END;
/

insert into a values ('홍길동');
insert into a values ('임꺽정');
insert into a values ('장길산');

select * from b;
</pre>
<!-- 트리거 검색 쿼리
 
SELECT TRIG.TRIGGER_NAME "Trigger",
       TRIG.STATUS "Status",
       ALLO.STATUS "Validation",
       TRIG.TABLE_NAME "Table",
       TRIG.TABLE_OWNER "Table Owner"
  FROM SYS.ALL_OBJECTS ALLO,
       SYS.ALL_TRIGGERS TRIG
 WHERE ALLO.OBJECT_TYPE   = 'TRIGGER'
       AND ALLO.OBJECT_NAME   = TRIG.TRIGGER_NAME
       AND ALLO.OWNER         = TRIG.OWNER
order by TRIG.TRIGGER_NAME asc;
 -->
계좌 잔액이 변할 때마다 입출금 명세 테이블에 데이터를 쌓는 트리거를 만든다.

<pre class="prettyprint">
create or replace trigger bank_trigger
after insert or update of balance on bankaccount
for each row
begin
	if :new.balance &gt; :old.balance then
		insert into transaction 
		values 
		(
			systimestamp,
			'DEPOSIT',
			:new.balance - :old.balance,
			:new.balance,
			:old.accountno
		);
	end if;
	if :new.balance &lt; :old.balance then
		insert into transaction 
		values 
		(
			systimestamp,
			'WITHDRAW',
			:old.balance - :new.balance,
			:new.balance,
			:old.accountno
		);
	end if;
end;
/
</pre>

<h2>자바 빈 수정</h2>

입출금 명세 클래스는 기존과 같다.<br />

<em class="filename">Transaction.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.io.Serializable;

public class Transaction implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4845616677229242217L;
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

원래 추상 클래스였던 Account에서 abstract를 제거한다.<br />
NormalAccount와 MinusAccount는 제거한다.<br />

<em class="filename">Account.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.io.Serializable;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class Account implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8412950380936847545L;
	private String accountNo;
	private String name;
	protected long balance;
	private String kind;
	protected List&lt;Transaction&gt; transactions = new ArrayList&lt;Transaction&gt;();
	
	static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy/MM/dd");
	static final SimpleDateFormat TIME_FORMAT = new SimpleDateFormat("HH:mm:ss");
	static final String DEPOSIT = "입금";
	static final String WITHDRAW = "출금";
	static final String NORMAL = "NORMAL";
	static final String MINUS = "MINUS";
	static final NumberFormat NUMBER_FORMAT = NumberFormat.getInstance();

	public Account() {}
	
	public Account(String accountNo, String name, String kind) {
		this.accountNo = accountNo;
		this.name = name;
		this.kind = kind;
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
	
	public List&lt;Transaction&gt; getTransactions() {
		return transactions;
	}
	
	public void setTransactions(List&lt;Transaction&gt; transactions) {
		this.transactions = transactions;
	}
	
	public String getKind() {
		return kind;
	}
	
	public void setKind(String kind) {
		this.kind = kind;
	}
	
	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(accountNo);
		sb.append("|");
		sb.append(name);
		sb.append("|");
		sb.append(balance);
		sb.append("|");
		sb.append(kind);

		return sb.toString();
	}

}
</pre>

자바은행 시스템이 할 수 있는 기능을 Bank.java에 모두 보여준다.<br />

<em class="filename">Bank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.io.Serializable;
import java.util.List;

public interface Bank extends Serializable {
	
	//계좌를 생성한다.
	public void addAccount(String accountNo, String name, String kind);
	
	/*//계좌를 생성한다.
	public void addAccount(String accountNo, String name, long balance, String kind);
	*/
	//계좌번호로 계좌를 찾는다.
	public Account getAccount(String accountNo);
	
	//소유자 명으로 계좌를 찾는다.
	public List&lt;Account&gt; findAccountByName(String name);
	
	//모든 계좌를 반환한다.
	public List&lt;Account&gt; getAccounts();
	
	//입금
	public void deposit(String accountNo, long amount);
	
	//출금
	public void withdraw(String accountNo, long amount);
	
	//이체
	public void transfer(String from, String to, long amount);
	
	//입출금 명세
	public List&lt;Transaction&gt; getTransactions(String accountNo); 
  
}
</pre>

데이터베이스 관련된 기능을 BankDao.java에 모두 보여준다.<br />

<em class="filename">BankDao.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.List;

public interface BankDao {
	
	//계좌 생성
	public void insertAccount(String accountNo, String name, String kind);
	
	//계좌번호로 계좌 찾기
	public Account selectOneAccount(String accountNo);
	
	//소유자로 계좌 찾기
	public List&lt;Account&gt; selectAccountsByName(String name);
	
	//계좌 목록
	public List&lt;Account&gt; selectAllAccounts();
	
	//입금
	public void deposit(String accountNo, long amount);
	
	//출금
	public void withdraw(String accountNo, long amount);
	
	//입출금 명세
	public List&lt;Transaction&gt; selectAllTransactions(String accountNo);

}
</pre>

BankDao의 구현 클래스를 만든다.

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

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ShinhanBankDao implements BankDao {
	Logger logger = LoggerFactory.getLogger(ShinhanBankDao.class);
	
	static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	static final String USER = "scott";
	static final String PASSWORD = "tiger";

	//생성자에서 JDBC 드라이버 로딩
	public ShinhanBankDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
    
	//커넥션 얻기
	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}
    
	//자원 반환
	private void close(ResultSet rs, PreparedStatement pstmt, Connection con) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		    
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
    
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
			
			logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{}", 
		            accountNo, amount, Account.DEPOSIT);

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
			
			logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{}", 
		            accountNo, amount, Account.DEPOSIT);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
	}

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

}
</pre>

Bank의 구현 클래스를 만든다.

<em class="filename">ShinhanBank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.List;

public class ShinhanBank implements Bank {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2284812319594381302L;
	
	private BankDao dao = new ShinhanBankDao();

	@Override	
	public void addAccount(String accountNo, String name, String kind) {
		dao.insertAccount(accountNo, name, kind);
	}
	
	@Override
	public Account getAccount(String accountNo) {
		return dao.selectOneAccount(accountNo);
	}

	@Override
	public List&lt;Account&gt; findAccountByName(String name) {
		return dao.selectAccountsByName(name);
	}

	@Override
	public List&lt;Account&gt; getAccounts() {
		return dao.selectAllAccounts();
	}

	@Override
	public void deposit(String accountNo, long amount) {
		dao.deposit(accountNo, amount);
	}

	@Override
	public void withdraw(String accountNo, long amount) {
		dao.withdraw(accountNo, amount);
	}

	@Override
	public void transfer(String from, String to, long amount) {
		dao.withdraw(from, amount);
		dao.deposit(to, amount);
	}

	@Override
	public List&lt;Transaction&gt; getTransactions(String accountNo) {
		return dao.selectAllTransactions(accountNo);
	}

}
</pre>


<em class="filename">BankUi.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;

public class BankUi {

	private Bank bank = new ShinhanBank();
	
	private String readCommandLine() throws IOException {
		InputStreamReader isr = new InputStreamReader(System.in);
		BufferedReader br = new BufferedReader(isr);
		String input = br.readLine();
		return input;
	}
	
	public void startWork() {
			
		String menu = null;
		
			do {
				System.out.println(" ** 메뉴를 선택하세요 ** ");
				System.out.println(" 1 ** 계좌 등록    ");
				System.out.println(" 2 ** 계좌 목록    ");
				System.out.println(" 3 ** 입금    ");
				System.out.println(" 4 ** 출금    ");
				System.out.println(" 5 ** 이체    ");
				System.out.println(" 6 ** 입출금 명세    ");
				System.out.println(" q ** 종료    ");
				System.out.println(" ********************** ");
				System.out.print("&gt;&gt;");
				
				try {
					menu = readCommandLine();
				
					String accountNo = null;
					String name = null;
					String kind = null;
					long amount = 0;
					
					if (menu.equals("1")) {
						//TODO 계좌등록
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						System.out.print("소유자 이름을 입력하세요: ");
						name = this.readCommandLine();
						System.out.print("계좌 종류를 선택하세요. 일반(n), 마이너스(m):  일반(n): : ");
						kind = this.readCommandLine();
						if (kind.equals("") || kind.equals("n") || kind.equals("m")) {
							if (kind.equals("")) {
								kind = Account.NORMAL;
							} else if (kind.equals("n")) {
								kind = Account.NORMAL;
							} else {
								kind = Account.MINUS;
							}
							bank.addAccount(accountNo, name, kind);
						}
						
					} else if (menu.equals("2")) {
						//TODO 계좌목록
						List&lt;Account&gt; accounts = bank.getAccounts();
						for (Account account : accounts) {
							System.out.println(account);
						}
					} else if (menu.equals("3")) {
						//TODO 입금
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						System.out.print("입금 액을 입력하세요: ");
						amount = Integer.parseInt(this.readCommandLine());
						bank.deposit(accountNo, amount);
					} else if (menu.equals("4")) {
						//TODO 출금
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						System.out.print("출금 액을 입력하세요: ");
						amount = Integer.parseInt(this.readCommandLine());
						bank.withdraw(accountNo, amount);
					} else if (menu.equals("5")) {
						//TODO 이체
						System.out.print("송금 계좌(From) 번호를 입력하세요: ");
						String from = this.readCommandLine();
						System.out.print("입금 계좌(To) 번호를 입력하세요: ");
						String to = this.readCommandLine();
						System.out.print("이체 금액을 입력하세요: ");
						amount = Integer.parseInt(this.readCommandLine());
						bank.transfer(from, to, amount);
					} else if (menu.equals("6")) {
						//TODO 입출금 명세
						System.out.print("계좌 번호를 입력하세요: ");
						accountNo = this.readCommandLine();
						List&lt;Transaction&gt; transactions = bank.getTransactions(accountNo);
						for (Transaction transaction : transactions) {
							System.out.println(transaction);
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				System.out.println();
			} while (!menu.equals("q"));
		
	}
	
	public static void main(String[] args) throws Exception {
		BankUi ui = new BankUi();
		ui.startWork();
	}
	
}
</pre>