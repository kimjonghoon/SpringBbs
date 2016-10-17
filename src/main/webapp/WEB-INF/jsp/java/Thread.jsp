<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2015.5.26</div>
	
<h1>스레드</h1>

프로그램은 위에서 아래로 왼쪽에서 오른쪽으로 순차적으로 실행된다.<br />
처리되는 코드를 연필로 따라 줄 그어 나간다면 실타래처럼 보일 것이다.<br />
그래서 프로그램의 실행 흐름을 스레드라 한다.<br />
지금까지 우리는 실이 한 가닥인 단일 스레드 프로그램만을 보아 왔다.<br />
이번 과정은 실타래가 2가닥 이상인(멀티 스레드) 프로그램을 만드는 방법을 소개한다.<br />

<h3>멀티 스레드 프로그램을 만드는 방법</h3>
<ol>
	<li>Thread 클래스를 상속</li>
	<li>Runnable 인터페이스를 구현</li>
</ol>

<h2>단일 스레드 프로그램과 멀티 스레드 프로그램의 비교</h2>

<h3>단일 스레드 예제</h3>

<em class="filename">SingleThread.java</em>
<pre class="prettyprint">
package net.java_school.thread.test;

public class SingleThread {
	
	public void doA() {
		char[] alphabet = {'A','B','C','D','E','F','G','H','I','J'};
		int length = alphabet.length;
		for ( int i=0; i &lt; length; i++ ) {
			System.out.print(alphabet[i]);
		}
	}

	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
		}
	}
	
	public static void main(String[] args) {
		SingleThread st = new SingleThread();
		st.doA();
		st.doB();
	}

}
</pre>

doA() 와 doB()는 같은 스레드에서 실행된다.<br />
따라서 호출된 순서인 doA()가 끝난 후 doB()가 실행된다.<br />

<h3>멀티 스레드 예제</h3>
방금 한 예제를 멀티 스레드 예제로 바꾸어 본다.<br />

<h4>Thread 클래스를 상속하여 만드는 멀티 스레드 프로그램</h4>
doA()와 doB()가 각각 다른 스레드에서 실행하게 구현할 것이다.<br />
Thread를 상속하는 방법을 택했는데 객체 생성 후 start() 메서드를 호출하면 다른 스레드가 생성되고 
doA()는 새로 생긴 스레드에서 실행되게 된다.<br />

<em class="filename">MultiThread1.java</em>
<pre class="prettyprint">
package net.java_school.thread.test;

public class MultiThread1 extends Thread {

	public void doA() {
		char[] alphabet = {'A','B','C','D','E','F','G','H','I','J'};
		int length = alphabet.length;
		for ( int i = 0; i &lt; length; i++ ) {
			System.out.print(alphabet[i]);
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void run() {
		doA();
	}
	
	public static void main(String[] args) {
		MultiThread1 mt1 = new MultiThread1();
		<strong>mt1.start();</strong>
		mt1.doB();
	}
}
</pre>

<h4>Runnable 인터페이스를 구현하여 만드는 멀티 스레드 프로그램</h4>

강조된 부분은 메인 메서드에서 자신 자신의 객체를 생성하고 Runnable 인터페이스 타입의 
레퍼런스를 인자 값으로 받는 Thread 생성자에 호출하여 자기 자신의 레퍼런스를 전달하고 있다.<br /> 

<em class="filename">MultiThread2.java</em>
<pre class="prettyprint">
package net.java_school.thread.test;

public class MultiThread2 implements Runnable {

	public void doA() {
		char[] alphabet = {'A','B','C','D','E','F','G','H','I','J'};
		int length = alphabet.length;
		for ( int i = 0; i &lt; length; i++ ) {
			System.out.print(alphabet[i]);
			
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	public void doB() {
		for (int i = 0; i &lt; 10; i++) {
			System.out.print(i);
			
			try {
				// 테스트가 되기 위해 0.01초 쉬어 다른 쓰레드가 제어권을 갖도록 한다.
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public void run() {
		doA();
	}
	
	public static void main(String[] args) {
		MultiThread2 mt2 = new MultiThread2();
		<strong>Thread t = new Thread(mt2);</strong>
		<strong>t.start();</strong>
		mt2.doB();
	}
}
</pre>


<h3>임계 영역(Critical Section) 테스트</h3>

임계 영역이란 공유된 자원을 접근하는 코드 부분을 말한다.
임계 영역을 제대로 다루지 않을 경우 발생하는 문제점을 예제를 통해 살펴보려 한다.<br />
은행 예제에서 NormalAccount의 withdraw() 메서드를 아래와 같이 변경한다.<br />
변경하는 이유는 일반 계좌의 잔고가 마이너스가 되는 확률을 높이기 위해서다.<br />

<pre class="prettyprint">
@Override
public void withdraw(long amount)  {
	<strong>try {
		Thread.sleep(5);
	} catch (InterruptedException e) {
		e.printStackTrace();
	}</strong>
	
	if (amount &lt;= balance) {
		Transaction transaction = new Transaction();
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
		transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
		transaction.setAmount(amount);
		transaction.setKind(Account.WITHDRAW);
		<strong>balance = balance - amount;</strong>
		transaction.setBalance(this.balance);
		transactions.add(transaction);
	} else {
		throw new InsufficientBalanceException("잔고가 부족합니다.");	
	}
	
}
</pre>

테스트를 위한 클래스를 작성한다.<br />

<pre class="prettyprint">
package net.java_school.bank;

public class ThreadTest extends Thread {
	private Bank bank = new ShinhanBank();
	private Account account;
	
	public ThreadTest() {
		bank.addAccount("101", "홍길동", Account.NORMAL);
		account = bank.getAccount("101");
		account.deposit(1000);
	}
	
	public void withdrawTest() {
		int i = 0;
		do {
			i++;
			try {
				account.withdraw(100);
			} catch (InsufficientBalanceException e) {}

			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		} while (i &lt; 100);

	}

	public void run() {
		withdrawTest();
	}
	
	public static void main(String[] args){
		ThreadTest t = new ThreadTest();
		t.start();
		t.withdrawTest();
		Account account = t.bank.getAccount("101");
		System.out.println(account);
	}
}
</pre>

여러 번 테스트해 보면 일반 계좌에서 잔고가 마이너스가 되는 경우가 생긴다.

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|홍길동|0|일반
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|홍길동|0|일반
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
101|홍길동|0|일반
C:\java\Bank\bin&gt;java net.java_school.bank.ThreadTest
<span class="prompt-selection">101|홍길동|-100|일반</span>
</pre>

이런 문제가 발생하는 원인은 아래 그림과 같이 스레드가 진행하기 때문이다.<br />

<img src="https://lh3.googleusercontent.com/MwhSL_Ef-p5eWrpHbL-BjlPAEgJCuMB_9HMyJ3T0UpBkPCN3bVyeY0P6PvpPhxdpTg2uOzi7VNGmX0Trjgwn0AJHMFU1_KUgEiCmBdSm5r6GIgAJQYQySw2ZQ6zAq7mAkK3CVRrrHgFK0nVcJ7GuhYerYdC0AlHH1XfdRRkcQ5e_BxVLmY4ffKmZTA-rL33JvzBMnO-zv4MAa28RPcPCPq9j543_lvSJvzIw6L-g7kL_fx9m1WvFRmAaAlRdyQ5RAsPK91vr7quknjxOYqVt3dkpiAwfEVwztxLBCmtKY-Aw8WikUVVZM5r8toPaBdLj9qx9IpxzQj3kGVr9Mgz1r3uITaiq07R5Saa2PHvyw9tEDHMC2sIQKcVYIP66gChHT-bKnq7lIB1eUDDA-WuwXS_EMxsDId7aBh5ZHUcmeuJDZH7RMAFeb36YPcu62Nh-hXC6j8DQYNcK9riQ198E2qQ_GuoheHAyVak_hRCQLBs0ELv1id8G4C3eOLzwN9wE2UGpvXApxrEfZ50lJZn7Iafw7RJTJIhEV0HawQp2YpERdr_SQ4e68SDpSuW9tyZRTfCzcRO1ktkC_8o5dHjKsS_SVBtAsRA=w609-h496-no" alt="이 그림은 첫번째 스레드가 잔고를 수정하기 전에 두번째 스레드가 출금액과 잔고를 비교하는 로직을 통과하여 문제를 발생한다는 예를 보여주고 있다." /><br />
 
문제점을 해결하기 위해서 withdraw() 메서드에 synchronized 키워드를 적용한다.<br />
메서드에 synchronized를 적용하면 메서드에 진입한 스레드가 메서드 밖으로 나갈 때까지 다른 스레드가 진입하지 못한다.<br />

<pre class="prettyprint">
@Override
public <strong>synchronized</strong> void withdraw(long amount)  {
	.. 기존 코드와 같다 ..
}
</pre>


여러 번 테스트해 보고 더 이상 일반 계좌의 잔고가 마이너스가 되는 경우가 생기지 않는다는 것을 확인한다.<br />
아래 그림과 같이 첫 번째 진입한 스레드가 메서드 밖으로 나갈 때까지 두 번째 스레드는 메서드에 진입하지 못한다.<br />

<img src="https://lh3.googleusercontent.com/zQolAfHS5MxUwPQsS_S4hYKFfnyBiQWN_kZidiQoCbMPnQl2wfp9tjo_qhparU6EsOSabuLxQGF9NKZkhiAoMYSoGS9L5tY2lfvgCDu7n9uachTntQXIs4S65WNdcZOJGCRx5UAJnncVZI0j6Wt5cQTOWUMKylK-4iOM-qY3RqxflJ4ezgqiuyJqgCMMu6cV6mV6WjkJAP3vtAy6wJxeXxLpA-K8FYWqwuZ8aoro9zFVuSqfkljfRRRbftvrtVnq5ZpV6kzv_0krCMPX_bYoPsUvgE82FO0ApPH_j4RTxVq_4sRvhCrpeYTX5QJn5kyB5hUno1FCuWG-IRbw0N0iqrfstZfTziieiRBeKSRpQCnBOXq_XiP-4ClehkWPB4XQ6YBCeJT4dFrp-ebAbsPJlF08PfHtT6yaO5GK52JywamG_Qk8Svb6sAAxb8d0rU7XFbkCNXPHRjCgr6CfroW8HPHece8nArZXPt5evnGfKxAec-_xtTui2_gzo81z2_ac_v8Svnavgk07bUkZx1RSQmkb3tWSMfwZ8r_6WEY6AYvh1Kq89-RTgu0iI550buAxbPTgm5CRlU0YLrF-Z5CB9I58pBZfKEI=w609-h496-no" alt="그림은 첫번째 스레드가 임계영역에 들어왔고 두번째 스레드가 임계영역 바로 앞까지 진행되는 것을 보여준다." /><br />
<img src="https://lh3.googleusercontent.com/hhtq6w80lrOtT7EX5TKe267GA0dJbhOd5ERB9qClvPayNmOvONUvAUSg3H7rjBS9pfsoIpTlhdfHzmgr4_DtHu51DNj1TbOcBS2jUpG9ClUm3Cec_zXcd_5l-aDoNI6U6y3Zolo-aPCwiaU4UrShyUMNWIVyo9XePcxHdc0sXW-fsXj6c27Hg2a13l3cBv0u3aec7JN6uzWk_7LgtQ7nnLfQBrPlxKU-B_ZLRAQUDPdPF7LAd0v0zwR1xiTGOpY1Atlqts4cBotcjiOH-zTxKlVDbEaivqnxXgcF7rL_lk1Liir1dsGSQNtjiQx_ruetCYNINxpig0L43wuV88cKfDfC1vAOA1uOc3yBgTbYPt75a94iWb5ktHwVPRqhNIyvHNhw1kh8li12Ozw7UbD3_bEou8VduYJ1FL85zwqWA27i5HqT6bxUnsaqIN-A7-vuYO2UuMqiEu5YH79StgTUNnkH9MjpkFacMLC-Qaaol1Eq7lgZPZXl1e12C_YNh0xO6KYJHqdgzYPpZt-47qBFa3Jf1ZSEAwC0AudNJtqygcWT6RtADm3EjC_BytAivXyl91-X6v_nSs4ZxFkcbtBBaSdX2mt1ugE=w609-h496-no" alt="그림은 첫번째 스레드가 임계영역에서 거의 통과하고 있는데 두번째 스레드는 아직 임계영역에 진입하지 못하는 것을 보여준다." /><br />
<img src="https://lh3.googleusercontent.com/RpM7vCNN_fpVS1EyoEhbvWy02u-XJVfmztVORc8GVON8wUYvP7-isTfkRM4gXyi2RzwRgGeW7QNoAu-mIG9Do8548zw5dGfxVrSId5oKarGu5g1o6Uk-q-lAPwxZ3TrHRzS_dYFBDU4HfhIf9_cXUdnyTG8RMqrxjTQdjYQYJMOGFK-kbQ8nszkybxlVtZfShk5Yxre-9k4ysZytc3T2sF4RqzfVNg6dzdEKKhfeD6chCPB64df0biLkOFHjVT-E3TeQXEuSHlEDO2FGxNwfFzyinDnQcDW5wT10isuTgE0bv6DXGxpzg3T7szWAbL0oDfrWZHBcU2TDZjtHA6RfAChiF4LKwcwZBBPxdIJU0UNTsjE5cso47jxl0H6WGZ7Jf6h_7eGlqn87wLwgiYV98tLCOG6B9sQOY6eWimz2tt8ZGis0udmOtjWTmFg0SloIDe7WVYNawQGsdkvh2tTzCkY-Yu5txd44IXFNVSRPDTXP8u2O_XTwvTaZJlflpg7vRH_pAOtXayg-2RQLgU9DkccdYscIQ3t9VJs1_9SsKpBDp1HczjRon3-MfG7kdIydsx_S6sxxL6lCdGci0eanQ2461gWjQgE=w609-h496-no" alt="그림은 첫번째 스레드가 임계영역을 막 통과하기 전이고 두번째 스레드는 아직 임계영역에 진입하지 못하고 있는 것을 보여준다." /><br />

첫 번째 스레드가 메서드 밖으로 나가면 대기하고 있던 스레드가 메서드에 진입하게 된다.<br />
<img src="https://lh3.googleusercontent.com/jDmbIC-ZFfSeXE7x_Vs07FMrDhLH8KscresIfauyJtkYeC2UI2tqxuN0QVEqz_oJbNjsnAlAQPt_VKlh6gUZ9oQZsCMJ49Prsy1pamGwbeHgoM_R9ve98Yln9hikQG0lMEz4Qr6sHntU4fZmIsBMQ5SDzN6LasjU9vPXSzMnnJizH-DFEpsIpZMrk35GtS5BxmqxJHClFa7DGnZ9uaViLyfg1nUUBUdYkQFUXa6OgJW0kc85Obs0LoTGvdwy1ZYEkvig6Ibf1OQT5mvLPEEXjKVDSSrb5PLfCZF7RuIFnwSH29JcYeWdDGJvjkfOZyfQOFaGbGUnJByqn2mqNx0PzLGUSNG5Hj1VQCimsmZi0TJi4nwohebtLIGeqqrKk9RlHrdi9H5nnl8IZ3nqPd7WPn0my6Df8g-2AmbYYBhoZIqCvraYB0XBF6CEA3mr0Zj9d2ZgLWWqgBXaU_dcF-WgfYW-ovQmOokxKD-8pAP5gNGf7JGo6IkH5Kzhl_4fvMNKijjVKD2ACFQ2pK14zaAps8mSRmGGyByvCL5zK1sAklGd3IRoVOD8CRrGBgwZmDX3VWBzN_Osd8ZYXDmKPbK5tcNkqI7vEhM=w609-h496-no" alt="그림은 첫번째 스레드가 임계영역을 통과했고 이제야 두번째 스레드가 임계영역에 진입한 것을 보여준다." /><br />

withdraw() 메서드를 아래와 같이 되돌려 놓는다.<br />

<pre class="prettyprint">
@Override
public synchronized void withdraw(long amount)  {
	<strong>if (amount &gt; balance) {
		throw new InsufficientBalanceException("잔고가 부족합니다.");	
	}
	balance = balance - amount;</strong>
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
</pre>

deposit() 메서드에도 synchronized 키워드를 적용한다.<br />

<pre class="prettyprint">
public <strong>synchronized</strong> void deposit(long amount) {
	//.. 기존 코드와 같다..
}
</pre>

컬렉션에서 Vector는 '스레드 안전' 한데 ArrayList는 그렇지 않다고 했다.<br />
Vector의 모든 메서드는 synchronize가 적용되어 있다.<br />
