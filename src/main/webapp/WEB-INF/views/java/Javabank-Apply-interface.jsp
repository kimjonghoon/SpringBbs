<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.5.25</div>
	
<h1>자바은행 수정(인터페이스 적용)</h1>

인터페이스는 컴포넌트의 기능을 정의한다.<br />
기존의 Bank 클래스를 일반적인 클래스에서 은행 컴포넌트의 기능을 정의하는 인터페이스로 수정한다.<br />
Bank 인터페이스를 구현한 구현체로 ShinhanBank라는 클래스를 만들 것이다.<br />
먼저 기존의 Bank.java를 열고 File - Save As... 메뉴를 선택하여 ShinhanBank.java로 저장하고 컴파일 에러를 수정한다.
Bank.java를 다시 열고 아래 내용으로 수정한다.<br /> 

<em class="filename">Bank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.List;

public interface Bank {
	
    //계좌를 생성한다.
    public void addAccount(String accountNo, String name, String kind);

    //계좌를 생성한다.
    public void addAccount(String accountNo, String name, long balance, 
            String kind);

    //계좌번호로 계좌를 찾는다.
    public Account getAccount(String accountNo);

    //소유자명으로 계좌를 찾는다.
    public List&lt;Account&gt; findAccountByName(String name);

    //모든 계좌를 반환한다.
    public List&lt;Account&gt; getAccounts();
  
}
</pre>

강조된 부분을 참고하여 ShinhanBank.java 파일을 수정한다.<br />

<em class="filename">ShinhanBank.java</em>
<pre class="prettyprint">
package net.java_school.bank;

import java.util.ArrayList;
import java.util.List;

public class ShinhanBank <strong>implements Bank</strong> {
	private List&lt;Account&gt; accounts = new ArrayList&lt;Account&gt;();

	<strong>@Override</strong>	
	public void addAccount(String accountNo, String name, String kind) {
		Account account = getAccount(accountNo);
		
		if (account != null) throw new DuplicateAccountException("중복된 계좌입니다.");
		
		if (Account.NORMAL.equals(kind)) {
			accounts.add(new NormalAccount(accountNo, name, kind));
		} else if (Account.MINUS.equals(kind)) {
			accounts.add(new MinusAccount(accountNo, name, kind));
		}
	}
	
	<strong>@Override</strong>
	public void addAccount(String accountNo, String name, long balance, String kind) {
		Account account = getAccount(accountNo);
		
		if (account != null) throw new DuplicateAccountException("중복된 계좌입니다.");
		
		if (Account.NORMAL.equals(kind)) {
			accounts.add(new NormalAccount(accountNo, name, balance, kind));
		} else if (Account.MINUS.equals(kind)) {
			accounts.add(new MinusAccount(accountNo, name, balance, kind));
		}
			
	}

	<strong>@Override</strong>
	public Account getAccount(String accountNo) {
		int totalAccount = accounts.size();
		
		for (int i = 0; i &lt; totalAccount; i++) {
			if (accountNo.equals(accounts.get(i).getAccountNo())) {
				return accounts.get(i);
			}
		}

		return null;
	}

	<strong>@Override</strong>
	public List&lt;Account&gt; findAccountByName(String name) {
		List&lt;Account&gt; matched = new ArrayList&lt;Account&gt;();
		int totalAccount = accounts.size();
		
		for (int i = 0; i &lt; totalAccount; i++) {
			if (name.equals(accounts.get(i).getName())) {
				matched.add(accounts.get(i));
			}
		}
		
		return matched;
	}

	<strong>@Override</strong>
	public List&lt;Account&gt; getAccounts() {
		return accounts;
	}

}
</pre>

테스트의 메인 메서드는 아랫부분만 수정하면 테스트할 수 있다.<br />

<em class="filename">Test.java</em>
<pre class="prettyprint">
Bank bank = <strong>new ShinhanBank();</strong>
</pre>