<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.11.20</div>
			
<h1>키워드, 식별자, 주석</h1>

<h2>키워드</h2>
키워드는 프로그래밍 언어에서 특별한 용도를 위해 미리 예약해 놓은 단어를 말한다.<br />

<h2>식별자</h2>
자바에서 식별자(Identifier)는 클래스, 변수, 상수, 메소드, 팩키지 이름을 말한다.<br />

<h3>식별자를 만들 때 지켜야 하는 문법</h3>
<ol>
	<li>공백이 없어야 한다.</li>
	<li>특수문자는 _와 $만 가능하다.</li>
	<li>숫자로 시작해선 안된다.</li>
	<li>키워드는 사용할 수 없다.</li>
</ol>

자바는 2바이트 유니코드를 사용하므로 어느 국가의 문자든 상관없이 식별자를 만들 수 있다.<br />
예들 들어, <strong>public void 결석하다();</strong>는 문법에 맞다.<br />
public void 결석하다();가 문법에 맞다 하더라도 이 코드는 한국 사람 외에는 사용하기 불편하다.<br />
결국 보편적으로 좋은 코드가 아니다.<br />
좋은 코드를 작성하기 위해서 자바 프로그래머가 꼭 지켜야 하는 관례가 있다.<br />

<h3>식별자를 만들 때 지켜야 하는 "관례"</h3> 
<ol>
	<li>클래스 이름은 영어 대문자로 시작한다.(예, BankAccount)</li>
	<li>변수나 메소드 이름은 영어 소문자로 시작한다.(예, accountNo, getName())</li>
	<li>의미가 나뉘어지는 두번째 단어부터 단어의 첫 글자는 영어 대문자로 작성한다.</li>
	<li>상수는 영어 대문자와 _로만 구성한다.(예, MAX_NUM)</li>
</ol>

아래 소스 파일에서 클래스 이름, 변수 이름, 메소드 이름이 관례대로 지어졌는지 확인한다.<br />

<pre class="prettyprint">
//도메인명은 java-school 이지만 -(대시)는 식별자로 사용할 수 없다.
package net.java_school.bank;

public class Account {
	private String accountNo; 
	private long balance;
	
	public String getAccountNo() { 
		return accountNo;
	}
	
	public void setAccountNo(String accountNo) { 
		this.accountNo = accountNo;
	}

	public long getBalance() { 
		return balance;
	}
}
</pre>

위 소스 파일에서 식별자와 키워드를 구분해 본다.<br />

<h2>주석 (Comment)</h2>
주석은 코드에 설명을 붙이기 위해 사용되는 것으로 프로그램 실행과는 상관없다.<br />
자바 인터프리터(java.exe)는 이 부분을 해석하지 않고 지나간다.<br /> 
한줄 주석, 여러 줄 주석, 문서화 주석이 있다.

<h3>한줄 주석 //</h3>
// 부터 그 줄의 끝까지 위치한 모든 문자를 주석으로 처리

<h3>여러 줄 주석 /*  */</h3>
줄 수와 상관없이 /* 부터 */ 표시전까지의 모든 문자를 주석으로 처리

<h3>문서화 주석 /**  */</h3>
줄 수와 상관없이 /** 부터 */ 표시 전까지의 모든 문자를 주석으로 처리<br />
javadoc.exe 프로그램을 이용하면 이 주석으로부터 HTML 형태의 도움말 문서를 생성할 수 있다.