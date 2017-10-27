<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2014.3.26</div>

<h1>팩키지와 접근자</h1>

팩키지는 말 그대로 꾸러미이다.<br />
쓰레기 분류 수거할 때에 사용하는 꾸러미를 생각해 보라.<br />
자바는 비슷한 기능이나 비슷한 성격을 가진 클래스들을 관리하기 위해서 팩키지를 제공한다.<br />
자바 API는 모두 특정 팩키지에 속해있다.(주로 java로 시작하는 이름의 팩키지이다.)<br />
이제 우리가 만들 클래스가 특정 팩키지에 속하도록 하는 방법을 알아본다.<br />

<em class="filename">Account.java</em>
<pre class="prettyprint">
<strong>package javabank;</strong>

public class Account {
	private String accountNum;
	private long balance;
	
	public void deposit(long amount) {
		balance = balance + amount;
	}
	
	public void withdraw(long amount) {
		balance = balance - amount;
	}
	
	public long getBalance() {
		return balance;
	}
	
	public static void main(String[] args) {
		System.out.println("팩키지 테스트");
	}
}
</pre>

첫번째 라인의 <strong>package javabank;</strong> 의해서 Account 클래스는 
javabank팩키지에 속하게 된다.<br />
팩키지를 선언한 자바 소스를 컴파일 할 때는 반드시 -d 다음에 한칸 띄고 바이트 코드가 생성될 
디렉토리를 지정해 주어야 한다. 만일 -d 옵션을 생략한다면 바이트 코드는 팩키지가 적용되지 않는다.<br />
예제를 실행하기전에 아래 그림과 같은 디렉토리 구조를 갖도록 하고 Account.java소스 파일도 
아래처럼 C:/javaApp/bank/src/javabank 디렉토리에 생성한다.<br />

<img src="images/javabank_src_bin.gif" alt="팩키지 예제 디렉토리 구조" /><br />

bin디렉토리는 바이트 코드가 위치할 디렉토리이다.<br />
src디렉토리는 자바 소스 파일이 위치할 디렉토리인데 만약 클래스에 팩키지가 선언되어 있다면 src에 팩키지명으로 
서브 디렉토리를 만들고 해당 소스를 그곳에 위치하도록 한다.(대부분 이렇게 소스를 관리한다.)<br />

<dl class="note">
<dt>팩키지 이름은 도메인 이름의 역순으로 짓는것이 일반적이다.</dt>
<dd>
팩키지명은 도메인 이름의 역순으로 짓는 것이 일반적이며 
이름에는 .(도트)가 2개 이상 포함되는 것이 바람직하다.<br />
팩키지가 적용된 자바 소스 파일을 파일 시스템에서 제대로 관리하려면 어떻게 해야 할까?<br />
만일 Log라는 클래스에 net.java_school.commons 이라는 팩키지가 적용됬다면 src디렉토리 
아래 .(도트)마다 서브 디렉토리를 만들고 마지막 서브 디렉토리 commons에 Log.java 소스를 
위치시키면 된다.<br />
<pre style="margin-left: 40px;">
src
 └── net
      └── java_school
              └── commons
</pre>
</dd>
</dl>

다시 Account.java로 돌아오자.<br />
모든 준비가 되었다면 소스 파일이 있는 C:/javaApp/bank/src/javabank로 이동한 후 아래와 같이 
컴파일한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\javaApp\bank\src\javabank&gt;javac -d C:/javaApp/bank/bin Account.java
</pre>

-d 옵션다음의 경로 구분자는 윈도우 시스템이라도 /(슬래시)를 사용할 수 있다.<br />
물론 윈도우 시스템의 경로 구분자 \(역슬래시)도 사용할 수 있다.<br />
컴파일 후 C:/javaApp/bank/bin 디렉토리로 이동해서 Account의 바이트 코드가 생겼는지 
확인한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\javaApp\bank\bin&gt;dir
2008-03-07  오후 12:06    &lt;DIR&gt;          javabank
</pre>

bin디렉토리에는 Account.class파일이 보이지 않고 대신 javabank라는 디렉토리가 보일 것이다.<br />
Account.class파일은 javabank 서브 디렉토리에서 찾을 수 있다.<br />
Accont.java를 컴파일할 때 -d 옵션으로 C:/javaApp/bank/bin 디렉토리를 지정하게 되면
C:\javaApp\bank\bin디렉토리에는 팩키지로 설정한 이름과 같은 서브 디렉토리(javabank)가 생기고 
그 안에 바이트 코드(Account.class)가 만들어 진다.<br />

<div class="dtree">
	<script type="text/javascript">
		<!--
		var javabank = new dTree('javabank');
		javabank.add(0,-1,'C:\\javaApp');
		javabank.add(1,0,'bank','javascript:void(0);');
		javabank.add(2,1,'bin','javascript:void(0);');
		javabank.add(3,2,'javabank','javascript:void(0);');
		javabank.add(4,3,'Account.class','src/Account.class');
		javabank.add(5,1,'src','javascript:void(0);');
		javabank.add(6,5,'javabank','javascript:void(0);');
		javabank.add(7,6,'Account.java','src/Account.java');
		document.write(javabank);
		javabank.openAll();
		//-->
	</script>
</div>

JVM은 C:/javaApp/bank/bin디렉토리에 javabank.Account클래스가 있다고 이해한다.<br />
팩키지가 적용된 클래스는 팩키지명.클래스명이 완전한 클래스명(Fully Qualified Class Name:FQCN)이다.<br />
("길동"이 아닌 "홍길동"이 완전한 이름이듯이)<br />
다른 클래스에서 Account클래스를 사용하려면 코드에서 javabank.Account로 써야 한다.<br />
(자바 문서에서 "클래스"란 용어는 문맥에 따라 바이트 코드를 의미할 때가 있고 클래스 소스 파일을 의미할 때가 있다.)<br /> 
클래스를 실행할 때도 마찬가지이다.<br />
Account클래스를 실행하기 위해서는 C:/javaApp/javabank/bin디렉토리에서 
java javabank.Account로 실행해야 한다.
다시 한번 강조해서, JVM은 bin디렉토리에 javabank.Accont클래스가 있다고 이해하기 때문이다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\javaApp\bank\bin&gt;java javabank.Account
팩키지 테스트
</pre>

만약 클래스가 없는 디렉토리에서 실행하려면 어떻게 해야 할까?<br />
이 경우 JVM에게 바이트 코드가 어디에 위치하는지 알려주어야 하는데,
자바 인터프리터(java.exe)의 classpath<a href="#comments"><sup>1</sup></a>옵션을 사용하면 된다.<br />
아래는 C:/Program Files 디렉토리에서 javabank.Account를 실행하는 방법을 보여주고 있다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\Program Files&gt;java -classpath C:/javaApp/bank/bin javabank.Account
팩키지 테스트
</pre>

-classpath다음에 한 칸 띄고 실행할 바이트 코드가 있는 곳을 절대 경로 또는 상대 경로로 지정한다.<br />
위에서는 classpath 값을 절대 경로로 지정하고 있는데 상대 경로로 지정한다면 다음과 같다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\Program Files&gt;java -classpath ../javaApp/bank/bin javabank.Account
팩키지 테스트
</pre>

.은 현재 디렉토리이고 ..은 한단계 위의 디렉토리를 의미한다.<br />
<br />
자바 컴파일러인 javac.exe도 classpath<a href="#comments"><sup>2</sup></a>옵션은 가지고 있다.<br />
자바 컴파일러에서 이 옵션을 사용하는 경우는 클래스(컴파일하려는 자바 소스)에서 
다른 사용자가 만든 클래스(바이트 코드)를 사용하는 코드가 있는 경우이다.<br />
만일 다른 사용자가 만든 클래스(바이트 코드)가 C:/javaApp/commons/bin에 있다면 이 경로를 
자바 컴파일러에게 알려주어야 한다.<br />
왜냐하면 자바 컴파일러는 바이트 코드를 만들기 전에 소스에서 사용하는 클래스(바이트 코드)들을 
제대로 사용되고 있는지 모두 검사하기 때문이다.<br />
위 설명에 대한 예를 만들어 볼 것이다.<br />
예를 위해서 새로운 클래스를 만들어야 하는데 아래와 같은 디렉토리 구조를 가지도록 하겠다.<br />

<div class="dtree">
	<script type="text/javascript">
		<!--
		var classpath = new dTree('classpath');
		classpath.add(0,-1,'C:\\javaApp');
		classpath.add(1,0,'commons','javascript:void(0);');
		classpath.add(2,1,'bin','javascript:void(0);');
		classpath.add(3,2,'net','javascript:void(0);');
		classpath.add(4,3,'java_school','javascript:void(0);');
		classpath.add(5,4,'commons','javascript:void(0);');
		classpath.add(6,5,'Log.class','javascript:void(0)');
		classpath.add(7,1,'src','javascript:void(0);');
		classpath.add(8,7,'net','javascript:void(0);');
		classpath.add(9,8,'java_school','javascript:void(0);');
		classpath.add(10,9,'commons','javascript:void(0);');
		classpath.add(11,10,'Log.java','javascript:void(0)');
		document.write(classpath);
		classpath.openAll();
		//-->
	</script>
</div>

다음은 새로 만들 Log클래스<a href="#comments"><sup>3</sup></a>이다.<br />
<em class="filename">Log.java</em>
<pre class="prettyprint">
package net.java_school.commons;

public class Log {
	public static void out(String msg) {
		System.out.println(new java.util.Date() + " : " + msg);
	}
}
</pre>

Log.java를 컴파일한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">C:\javaApp\commons\src\net\java_school\commons&gt;javac -d ^
C:\javaApp\commons\bin Log.java</pre>

다음으로 기존 Accont클래스가 Log클래스를 사용하도록 수정한다.<br />
Log클래스는 net.java_school.commons 란 팩키지가 적용되었으므로 FQCN은 
net.java_school.commons.Log 이므로 소스에서도 그대로 써야 한다.<br />

<pre class="prettyprint">
public void deposit(long amount) {
	balance = balance + amount;
	<strong>net.java_school.commons.Log.out(amount + "원이 입금되었습니다.");
	net.java_school.commons.Log.out("잔고는" + this.getBalance() + "원입니다.");</strong>
}

public void withdraw(long amount) {
	balance = balance - amount;
	<strong>net.java_school.commons.Log.out(amount + "원이 출금되었습니다.");
	net.java_school.commons.Log.out("잔고는 " + this.getBalance() +"원입니다.");</strong>
}

public static void main(String[] args) {
	<strong>Account hong = new Account();
	hong.deposit(10000);
	hong.withdraw(500);</strong>
}
</pre>

Account.java를 수정했으니 다시 컴파일한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">C:\javaApp\bank\src\javabank&gt;javac -d C:\javaApp\bank\bin ^
-classpath C:\javaApp\commons\bin Account.java</pre>

javabank.Account 클래스를 실행한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">C:\javaApp\bank\bin&gt;java -classpath .;C:\javaApp\commons\bin ^
javabank.Account</pre>

우리가 만든 자바 프로그램은 모두 2개의 클래스로 구성되어 있다.<br />
javabank.Account와 net.java_school.commons.Log 클래스가 그것이다.<br />
이 두 클래스의 위치가 다르므로 자바 인터프리터의 classpath옵션으로 두 클래스의 위치를 지정해야 한다.<br />
classpath옵션이 사용되면 JVM은 관련 클래스를 classpath로 설정된 곳에서만 찾는다.<br />
그래서 현재 디렉토리를 의미하는 .(도트)가 클래스 패스에 포함된 것이다.<br />

<h3>외부 자바 라이브러리를 자신의 프로그램에 추가하는 방법</h3>
대부분 외부 자바 클래스는 jar형태의 압축파일로 제공된다.<br />
Log클래스를 다른 자바 프로그래머가 사용하도록 배포하려면 jar.exe 를 이용한다.<br />
Log바이트 코드가 있는 디렉토리로 이동하여 다음 멸령을 수행한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">C:\javaApp\commons\bin&gt;jar cvf java-school-commons.jar .</pre>

탐색기를 이용하여 commons에 생성된 java-school-commons.jar파일을 잘라내기 하여 
C:\devLibs에 붙여넣는다.
javabank.Account클래스를 실행하는데 이번에는 C:\devLibs에 있는 java-school-commons.jar파일속에 
있는 Log클래스가 이용될 수 있도록 실행한다.

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">C:\javaApp\bank\bin&gt;java -classpath ^
.;C:\devLibs\java-school-commons.jar javabank.Account</pre> 

이전과는 달리 jar파일명까지의 경로를 classpath에 지정해줘야 한다.<br /> 

<h2>접근자</h2>
접근자는 외부에서 접근할 수 있는지 여부를 결정한다.<br />  
접근자는 2단계 접근 제어를 제공한다.<br />
1단계 접근 제어는 접근자가 클래스 선언부에 쓰일 때이다.<br />

<h3>public 접근자가 Account의 클래스 선언부에 쓰인 경우</h3>

<pre class="prettyprint">
package javabank;

<strong>public</strong> class Account {
	// 구현부
} 
</pre>

<h3>디폴트 접근자가 Account의 클래스 선언부에 쓰인 경우</h3>

<pre class="prettyprint">
package javabank;

class Account {
	// 구현부
} 
</pre>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" colspan="2">1단계 접근 제어 : 접근자가 클래스 선언부에 쓰일 경우</th>
</tr>
<tr>
	<td class="table-in-article-td">public</td>
	<td class="table-in-article-td">
	모든 팩키지의 클래스에서 참조할 수 있다.<br /> 
	</td>
</tr>
<tr>
	<td class="table-in-article-td">default</td>
	<td class="table-in-article-td">
	같은 팩키지에 있는 클래스에서만 참조할 수 있다.<br />
	</td>
</tr>
</table>

public 접근자가 적용된 Account의  클래스를 팩키지가 다른 클래스에서 Account 를 참조한 예이다.<br />

<pre class="prettyprint">
<strong>package example;</strong>//Account에 적용된 javabank와 다른 팩키지인 것에 주목!

public class BankSystem {

	//javabank.Account타입의 매개변수를 선언할 수 있다.
	public void deposit(<strong>javabank.Account</strong> account, long amount) {
		account.deposit(amount);//deposit()메소드 선언부에 적용된 접근자가 적용된다.
	}

}
</pre>

아래 그림은 javabank 팩키지에 있는 클래스가 모두 클래스 선언부에 public 으로 접근자가 지정되어 있는 경우를 그린 것이다.
(그림에서 +는 public을 의미한다.)<br />

<img src="images/access_test_public.gif" alt="PUBLIC 접근자 그림" style="width: 590px;" /><br />

(Bank, Customer는 아직 없지만 Account와 같이 javabank란 이름의 팩키지로 만들었다고 가정하자.)<br />
Bank, Customer, Account는 어떤 팩키지에 속한 클래스라도 참조할 수 있다.<br />
그림에서 example 팩키지에 있는 BankSystem는 javabank팩키지의 모든 클래스를 접근할 수 있다.<br />
이 말은 위의 BankSystem소스에서 볼수 있듯이 javabank.Account account;와 같이 변수 선언부의 
데이터 타입으로 사용할 수 있고 메소드 매개변수의 타입으로 javabank.Account를 쓸 수 있다는 의미이다.<br />
import문을 이용하면 클래스 바디에서 javabank.Account를 클래스 바디에서 Account로 줄여 쓸 수 있다.<br />

<pre class="prettyprint">
<strong>package example;</strong>

<strong>import javabank.Account;</strong>

public class BankSystem {

	public void deposit(<strong>Account</strong> account, long amount) {
		account.deposit(amount);
	}

}
</pre>

이제는 Bank, Customer, Account의 클래스 선언부에  default접근자로 설정된 경우를 가정해 보자.<br />

<img src="images/access_test_default.gif" alt="Default 접근자 그림" style="width: 590px;" /><br />

이 경우 다른 팩키지에 있는 BankSystem클래스에서는 Bank, Customer, Account를 사용할 수 없다.<br />
그림처럼 보이지 않는다고 생각하면 된다.<br />
BankSystem에서 Bank, Customer, Account클래스를 참조하려 하면 컴파일 에러가 난다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" colspan="2">2단계 접근 제어 : 접근자가 필드나 메소드에 쓰일 경우</th>
</tr>
<tr>
	<td class="table-in-article-td">public</td>
	<td class="table-in-article-td">모든 팩키지에서 접근 가능하다.</td>
</tr>
<tr>
	<td class="table-in-article-td">protected</td>
	<td class="table-in-article-td">
	같은 팩키지에서만 접근 가능하다.<br />
	단, 다른 팩키지에 속해있는 자식 클래스에서 부모클래스의 protected접근자로 지정된 멤버는 접근 가능하다.
	</td>
</tr>
<tr>
	<td class="table-in-article-td">default</td>
	<td class="table-in-article-td">같은 팩키지에서만 접근 가능하다.</td>
</tr>
<tr>
	<td class="table-in-article-td">private</td>
	<td class="table-in-article-td">외부에서 접근할 수 없다.</td>
</tr>
</table>

자바에서 필드(Fields)란 클래스 바디에서 선언된 메소드가 아닌 모든 것을 의미한다.<br />
멤버(members)는 객체의 속성을 저장하는 변수나 객체의 행위에 해당하는 메소드를 의미한다.<br />
위의 표를 이해하기 쉽게 풀어 설명하도록 한다.<br />
필드나 메소드에 적용되는 가장 쉬운 접근자는 public과 private이다.<br />
public이면 모든 팩키지에서 접근할 수 있다.<br />
private이면 외부에서 접근할 수 없다.<br />
디폴트 접근자는 같은 팩키지에서만 접근할 수 있다.<br />
protected는 디폴트 접근자보다 접근 허용범위가 더 넓다.<br />
(사실 protected에 대해서는 상속을 공부한 후에 아래 설명을 다시 보는 것이 좋다.)<br />
일단 디폴트 접근자처럼 같은 팩키지에서 접근할 수 있다.<br />
여기에 추가하여, 부모와 팩키지가 다른 자식 클래스에서 부모클래스의 protected멤버는 접근할 수 있다.<br />
(굳이 필드가 아닌 멤버라고 한 것을 주목해야 한다. 그림에서 #는 protected을 의미한다.)<br />

<img src="images/access_test_protected.png" alt="Protected 접근자 예 그림" style="width: 590px;" /><br /> 

<h2>캡슐화 : 객체의 자료에 접근하려면 메소드를 통해야만 접근하도록 한다.</h2>
클래스를 설계할 때는 아래 사항은 객체 지향 프로그래밍의 기본이므로 지키도록 한다.<br />
이를 캡슐화라고 하는데 외부에서 볼 때 객체의 꼭 필요한 부분만 볼 수 있도록 해준다.<br />

<ol>
	<li>멤버변수를 private로 선언한다.</li>
	<li>private 선언된 멤버변수에 대한 setter, getter를 만든다.</li>
</ol>

(getter,setter은 아래 예제를 보고 이해하자.)<br />
만약 웹사이트의 회원 클래스를 캡슐화하여 구현한다면 아래와 같을 것이다.<br />

<em class="filename">User.java</em>

<pre class="prettyprint">
package net.java_school.user;

public class User {
	private String username; //유저이름
	private String password; //패스워드
	private String fullName; //성명
	private String email; //이메일
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFullName() {
		return FullName;
	}
	public void setFullName(String fullName) {
		FullName = fullName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
</pre>

<h2>이클립스 설치</h2>
다음장부터는 메모장이나 에디트플러스와 같은 에디터는 더 이상 사용하지 않을 것이다.<br />
이후 모든 장의 예제는 이클립스를 사용하기로 한다.<br />
이클립스를 사용하면 위에서 실습했던 디렉토리 구조로 소스를 관리하게 되면서
클래스 패스에 대해서도 크게 신경쓰지 않아도 된다.<br />

<a href="http://www.eclipse.org/downloads/">http://www.eclipse.org/downloads/</a>
에서 Eclipse IDE for Java EE Developers 선택하여 다운로드한다.<br />
압축을 풀면 생기는 eclipse 폴더를 원하는 곳에 복사하는 것으로 설치가 끝난다.<br />
여기서는 eclipse 폴더를 C:/ 에 붙여넣기했다고 가정하고 설명한다.<br />

<h3>실행</h3>

C:/eclipse/eclipse.exe를 더블클릭하면 이클립스가 실행된다.<br />
실행되면 먼저 이클립스는 워크스페이스(workspace)를 어디로 지정할 것인지를 묻는다.<br />

<img src="https://lh6.googleusercontent.com/-KuW40dO62II/TjJ6CM4LOrI/AAAAAAAAAX0/yXp6FWCapbM/workspace_launcher.gif" alt="workspace launcher" /><br />

워크스페이스(workspace)는 작업장이다.<br />
이클립스에서 워크스페이스는 하나 이상의 프로젝트들을 담는 그룻이다.<br />
위 그림과 같이 워크스페이스를 디폴트로 보여지는 디렉토리로 선택하지 않도록 한다.<br />
또한 Use this as the default and do not ask again 에 체크 하지 말고 그대로 둔다.<br />
서로 다른 성격의 프로젝트를 관리하려면 워크스페이스를 여러개 두면 편리한 경우가 있을 수 있기 때문이다.<br />
여기서는 워크스페이스를 C:/javawork 로 지정했다.<br />
지정을 하고 OK 버튼을 클릭하면 다음과 같은 환영메시지를 볼 수 있다.<br />

<img src="https://lh5.googleusercontent.com/-Ewvv_Kxiuis/TjJ6B5bj7FI/AAAAAAAAAXs/fulrpOzQ58I/welcome.gif" alt="welcome" /><br />

환영 페이지에서 보이는 메뉴로<br />
이클립스 소개, 튜토리얼, 샘플, 새로운 릴리즈에 추가된 내용을 볼 수 있다.<br />
참고로 이 글은 환영 페이지의 튜토리얼을 정리한 것이다.<br />
환영 페이지를 닫는다.<br />
환영 페이지를 닫으면 아래와 같은 워크벤치(WorkBench)가 나타난다.<br />

<img src="https://lh5.googleusercontent.com/-lHZAcz_vsOU/TjJ6Byjr2BI/AAAAAAAAAXw/6Gk1YbZ1ytk/workbench.gif" alt="workbench" />

<h3>이클립스 용어</h3>

<strong>워크벤치(workbench)</strong><br />
<p style="padding-left: 14px;">
이클립스에서 보이는 윈도우 전체를 말한다.<br />
윈도우는 크게 4개로 나뉘어지는데 이 분리된 영역을 뷰(view)라고 부른다.<br />
</p>

<strong>perspective</strong><br />
<p style="padding-left: 14px;">
사전적 의미는 "관점"이다.<br />
뷰를 모두 포함해서 퍼스펙티브(perspective)라고 부른다.<br />
위 화면은 Java 퍼스펙티브이다.<br />
이 퍼스펙티브는 자바 프로그램을 개발할 때 필요한 뷰들로 구성된다.<br />
퍼스펙티브를 변경하려면 오른쪽 상단의 Open Perspective 메뉴바 버튼을 이용한다.<br />
</p>

<strong>Package Explorer 뷰</strong><br />
<p style="padding-left: 14px;">
왼쪽 상단의 뷰로 Java 프로젝트에 속한 리소스(패키지, 클래스, 외부 라이브러리)를 보여준다.<br />
</p>

<strong>Hierarchy 뷰</strong><br />
<p style="padding-left: 14px;">
왼쪽 상단의 뷰로 Java의 상속구조 보여준다.<br />
</p>

<strong>Outline 뷰</strong><br />
<p style="padding-left: 14px;">
오른쪽 상단의 뷰로 현재 에디터에 열려 있는 소스 파일의 구조를 보여준다.<br />
</p>

<strong>Editor 뷰</strong><br />
<p style="padding-left: 14px;">
화면중앙에 위치하는 뷰로 소스 코드를 편집하는 데 사용된다.<br />
</p>

<strong>problems 뷰</strong><br />
<p style="padding-left: 14px;">
하단에 위치한 뷰로 컴파일 에러나 경고 표시한다.<br />
</p>


<strong>Javadoc 뷰</strong><br />
<p style="padding-left: 14px;">
하단에 위치한 뷰로 Package Explorer나 Outline 뷰에서 선택한 부분에 대한 
Javadoc 주석를 보여준다.<br />
</p>

<strong>Declaraion 뷰</strong><br />
<p style="padding-left: 14px;">
하단의 위치한 뷰로 에디터에서 선택된 부분이 어떻게 선언됐는지 간략히 보여준다.<br />
</p>	

뷰의 위치는 마우스로 원하는 위치로 변경할 수 있다.<br />
하지만 익숙해 질때까지는 그대로 두는 것이 좋다.<br />


<h3>자바 예제</h3>

본 예제는 이클립스 환영 페이지의 샘플 메뉴의 내용을 편집한 것이다.<br />
먼저 Java Perspective 인지 확인한다.<br />
이클립스에서는 자바 소스는 반드시 프로젝트에 속해야만 한다.<br />
자바 프로젝트를  생성하려면 메뉴바에서 File &gt; New &gt; Java Project 선택하거나<br /> 
툴바 메뉴에서 가장 왼쪽을 클릭한다.<br />
<img src="https://lh5.googleusercontent.com/-5W4KIyzc7G8/TjJ6Bg9McGI/AAAAAAAAAXo/p2kJo0YJEv4/toolbar.gif" alt="toolbar" style="width: 73px;" /><br />

프로젝트 이름을 HelloWorld 로 지정한다.<br />
그 외 설정은 특별히 지정하지 않아도 된다.<br /> 
이클립스는 소스는 src, 컴파일된 바이너리 파일은 bin 디렉토리에 저장하여 관리한다.<br />
입력 후 Finish 클릭하면 HelloWorld 프로젝트가 생성되고 Package Explorer 에 표시된다<br />

<img src="https://lh4.googleusercontent.com/-8Tx99HODIdg/TjJ6A_ribLI/AAAAAAAAAXc/5xSvGBauvwc/s576/project_wizard.gif" alt="project wizard" /><br />

아래 툴바 메뉴에서 두번째를 클릭한다.<br /> 
<img src="https://lh5.googleusercontent.com/-5W4KIyzc7G8/TjJ6Bg9McGI/AAAAAAAAAXo/p2kJo0YJEv4/toolbar.gif" alt="toolbar" style="width: 73px;" /><br />

팩키지 이름에 net.java_school.example 라고 입력하고 Finish 를 클릭한다.<br />
이제 Package Explorer 뷰에서 팩키지가 보이게 된다.<br />

<img src="https://lh4.googleusercontent.com/-B5K99iKod5g/TjJ6AgcfJsI/AAAAAAAAAXY/yJU3KnGQQIU/package_wizard.gif" alt="package wizard" /><br />

마우스로 Package Explorer 에서 net.java_school.example 팩키지를 선택한 상태에서 아래 툴바 메뉴 중 오른쪽 마지막 버튼을 클릭한다.<br />

<img src="https://lh5.googleusercontent.com/-5W4KIyzc7G8/TjJ6Bg9McGI/AAAAAAAAAXo/p2kJo0YJEv4/toolbar.gif" alt="toolbar" style="width: 73px;" /><br />

클래스 이름으로 HelloWorld 라고 입력한다.<br />
메인 메소드가 필요하므로 public static void main(String[] args)에 체크한다.<br />

<img src="https://lh5.googleusercontent.com/-zy_swhmGj48/TjJ6AklwKJI/AAAAAAAAAXQ/-GWHhhwRugA/class_wizard.gif" alt="class wizard" /><br />

Finish 를 클릭한 후 에디터에서 main메소드를 아래와 같이 구현한다.<br />

<em class="filename">HelloWorld.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class HelloWorld {

   public static void main(String[] args) {
      <strong>System.out.println("Hello World !");</strong>
   }

}
</pre>

저장하면 컴파일을 따로 할 필요가 없다.<br />
이클립스가 백그라운드에서 계속해서 컴파일을 해주기 때문이다.<br />
에디터에서 바로 컴파일 에러를 확인할 수 있는 이유가 여기에 있다.<br />
실행하려면 Package Explorer 에서 HelloWorld 클래스를 선택한 상태에서 오른쪽 마우스를 클릭하고
컨텍스트 메뉴를 띄운 후 아래 그림처럼 선택한다.<br />

<img src="https://lh4.googleusercontent.com/-GQgOXNx6En4/TjJ6BuiXmTI/AAAAAAAAAXk/k3fGHc_rrYs/run.gif" alt="run" /><br />

console 뷰가 생기면서 Hello World !가 출력된다.<br />

<img src="https://lh5.googleusercontent.com/-xC4-RE1ObLk/TjJ6Atp4agI/AAAAAAAAAXU/9fcwiLYVlH4/console_view.gif" alt="console view" />

<span id="comments">주석</span>
<ol>
	<li>자바 인터프리터(java)를 실행하면 클래스 로더(Class Loader)가
	classpath에서 자바 프로그램을 구성하는 모든 클래스 정보를 찾아 메모리 공간에 로드(load)한다.
	이때 단 하나의 클래스라도 못 찾는다면 실행에 실패하고 클래스를 못 찾았다는 에러 메시지를 출력한다.
	classpath 옵션를 지정하지 않으면 클래스 로더는 현재 디렉토리에서 사용자가 만든 클래스를 찾는다.
	java.lang.String 클래스나 java.lang.System 클래스와 같은 자바 API의 경로는 클래스 로더가 이미 알고 있으니 
	classpath에 지정해 주지 않는다.</li>
	<li>javac나 java의 classpath 옵션은 cp 옵션으로 대신할 수 있다.</li>
	<li>Log 클래스에 대한 설명은 따로 하지 않는다. Log 클래스의 out 메소드는 static 메소드로 static 키워드에 대한 설명은 
	<a href="Static">static</a>에서 다룬다.</li>
</ol>