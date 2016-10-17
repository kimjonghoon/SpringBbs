<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2016.4.7</div>

<h1>if, switch, loop 문</h1>

<h3>if</h3>

<table class="table-in-article">
<tr>
	<td class="table-in-article-td" style="width: 40%">
<pre>
if (조건) {
  문장1;
}
</pre>
	</td>
	<td class="table-in-article-td detail">조건이 true일때 if 문의 {} 안의 문장1이 실행된다.</td>
</tr>
<tr>
		<td class="table-in-article-td">
<pre>
if (조건) {
  문장1;
} else {
  문장2;
}
</pre>
	</td>
	<td class="table-in-article-td detail">조건이 true이면 문장1이, false이면 문장2이 실행된다.</td>
</tr>
<tr>
		<td class="table-in-article-td">
<pre>
if (조건1) {
  문장1;
} else if (조건2) {
  문장2;
} else {
  문장3;
}
</pre>
	</td>
	<td class="table-in-article-td" valign="top">조건1이 true이면 문장1이 실행된다.<br />
	조건2가 true이면 문장2가 실행된다.<br />
	조건1, 조건2 모두 false이면 문장3이 실행된다.<br />
	</td>
</tr>
</table>

<h3>switch문</h3>
<table class="table-in-article">
<tr>
	<td class="table-in-article-td" style="width: 40%">
<pre>
swicth (정수형 변수) {
  case 값1 :
  문장1;
  break;
  case 값2 :
  문장2;
  break;
  case 값3 :
  문장3;
  break;
  default :
  문장d;
}
</pre>
	</td>
	<td class="table-in-article-td detail">
	정수형 변수의 값이 값1 이면 문장1이 실행,<br />
	정수형 변수의 값이 값2 이면 문장2이 실행,<br />
	정수형 변수의 값이 값3 이면 문장3이 실행,<br />
	정수형 변수의 값이 값1,값2,값3와 같지 않다면 문장d 실행<br />
	JDK 1.6까지는 switch 다음에 오는 변수의 데이터 타입은 byte, short, char, int이어야 했다.<br />
	하지만 JDK 1.7부터는 문자열도 된다.
	</td>
</tr>
</table>

<h3>for문</h3>
<table class="table-in-article">
<tr>
	<td class="table-in-article-td" style="width: 40%">
<pre>
for (초기식; 조건식; 증감식) {
  문장;
}
</pre>
	</td>
	<td class="table-in-article-td detail">
	<ol>
		<li>로직이 for문에 접근하면 초기식을 실행된다.</li>
		<li>조건식을 검사하여 true이면 for의 {}안의 문장을 실행한다.</li>
		<li>증감식을 실행한다.</li>
		<li>2번 조건식으로 분기한다.</li>
	</ol>
	</td>
</tr>
</table>

<h3>while문</h3>
<table class="table-in-article">
<tr>
	<td class="table-in-article-td" style="width: 40%">
<pre>
while (조건식) {
  문장;
}
</pre>
	</td>
	<td class="table-in-article-td detail">
	<ol>
		<li>조건식을 검사하여 true이면 while의 {} 안의 문장을 실행한다.</li>
	</ol>
	</td>
</tr>
</table>

<h3>do ~ while문</h3>
<table class="table-in-article">
<tr>
	<td class="table-in-article-td" style="width: 40%">
<pre>
do {
  문장;
} while (조건식);
</pre>
	</td>
	<td class="table-in-article-td detail">
	<ol>
		<li>문장을 실행한다.</li>
		<li>조건식을 검사하여 true이면 문장을 실행한다.</li>
	</ol>
	</td>
</tr>
</table>

<dl class="note">
<dt>break;</dt>
<dd>
반복문내에서 쓰이면 자신을 감싸고 있는 가장 가까운 반복문을 빠져나온다.<br />
</dd>
<dt>continue;</dt>
<dd>
자신을 감싸고 있는 가장 가까운 반복문의 조건식으로 분기한다.<br /> 
</dd>
<dt>return;</dt>
<dd>
반환값이 있는 메소드에서 사용되는 용도 외에,   
<strong>return;</strong> 이렇게 단독으로 쓰이면 메소드를 종료하고 메소드를 호출한 곳으로 돌아간다.<br />
<strong>return;</strong> 문은 값을 반환하지 않는 메소드안에서만 사용할 수 있다.<br />
</dd>
<dt>for (int i = 0; i &lt; 10; i++) </dt>
<dd>
자바에서는 for 문을 사용할 때 위와 같이 초기식에 변수를 선언할 수 있다.<br />
초기식에서 선언된 변수는 for문의 {}안에서만 유효하다.<br />
이는 {}안에서 선언된 변수는 {}안에서만 유효하다는 자바 문법에 포함된다.<br />
</dd>
</dl>

<em class="filename">OperatorsTest.java</em>
<pre class="prettyprint">
public class OperatorsTest {
	public static void main(String[] args) {
		int a = 1;
		int b = 2;
		int c = 3;
		int d = 4;
		int e = 5;

		System.out.println("a = " + a);
		System.out.println("b = " + b);
		System.out.println("c = " + c);
		System.out.println("d = " + d);
		System.out.println("e = " + e);

		System.out.println("a + b = " + (a + b));
		System.out.println("b - c = " + (b - c));
		System.out.println("c * d = " + (c * d));
		System.out.println("e / b = " + (e / b));
		System.out.println("e % b = " + (e % b));
		
		/*
		++ 또는 --가 변수 앞에 붙을때와 변수 뒤에 붙을 때 
		연산자 우선순의가 극단적으로 차이가 나기 때문에 
		아래 예제와 같은 결과나 나온다.
		*/
		 
		System.out.println("e++ = " + e++);
		System.out.println("++e = " + ++e);

		System.out.println("e-- = " + e--);
		System.out.println("--e = " + --e);
		
		e++; //이렇게 단독으로 사용하면 ++e; 와 같다.
		System.out.println("e = " + e);
		++e; //이렇게 단독으로 사용하면 e++; 와 같다.
		System.out.println("e=" + e);
	}
}
</pre>

예제에 다음 부분을 추가하고 테스트한다.

<pre class="prettyprint">
System.out.println("a &gt; b " + (a &gt; b));
System.out.println("b &gt;= a " + (b &gt;= a));
System.out.println("c &lt; d " + (c &lt; d));
System.out.println("d &lt;= a " + (d &lt;= a));
System.out.println("a == b " + (a == b));
System.out.println("a != b " + (a != b));
</pre>

예제에 다음 코드를 추가하고 테스트한다.

<pre class="prettyprint">
int yr = 2000;
String msg = null;

//msg.length() &gt; 0 조건식은 테스트 용도
msg = yr &gt;= 2001 &amp;&amp; yr &lt;= 2100 &amp;&amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
System.out.println(msg);

msg = null;
msg = yr &gt;= 2001 &amp; yr &lt;= 2100 &amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
System.out.println(msg);
</pre>

예제에서 에러를 발생하는 코드는 아래와 같이 주석처리하고 다음을 추가한 후 테스트한다.

<pre class="prettyprint">
//msg = yr &gt;= 2001 &amp; yr &lt;= 2100 &amp; msg.length() &gt; 0 ? yr+" is 21C" : yr +" is not 21C";
//System.out.println(msg);

boolean signIn = true; //로그인 여부
String id = "hero23"; //유저 아이디
String authority = "ADMIN";//hero23의 권한
String userDetail = "hero45,kildong,01311111111,seoul,#1*23@4";//사용자 정보

/*
사용자 정보에 접근하려면 로그인해야 하고 
유저 아디디와 사용자 정보의 유저 아이디가 같아야 한다.
또는 로그인 유저가 관리자 권한을 가지고 있으면 접근할 수 있다.
*/
boolean check = (signIn &amp;&amp; userDetail.indexOf(id) != -1) || (signIn &amp;&amp; authority.equals("ADMIN"));

if (check) {
	String[] info = userDetail.split(",");
	System.out.println("ID : " + info[0]);
	System.out.println("NAME : " + info[1]);
	System.out.println("MOBILE : " + info[2]);
	System.out.println("ADDR : " + info[3]);
	System.out.println("PASS : " + info[4]);
}

authority = "USER";//hero23의 권한을 변경
check = (signIn &amp;&amp; userDetail.indexOf(id) != -1) || (signIn &amp;&amp; authority.equals("ADMIN"));

if (!check) {
	System.out.println("사용자 정보에 접근할 수 없습니다.");
}
</pre>


<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/tutorial/java/nutsandbolts/switch.html">Using Strings in switch Statements - http://docs.oracle.com/javase/tutorial/java/nutsandbolts/switch.html</a></li>
</ul>