<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="last-modified">Last Modified : 2015.12.4</div>

<h1>객체와 클래스</h1>
<? require('../inc/share.php'); ?>

<h2>객체 (Object)</h2>
OOP는 객체를 이해하는 것이 중요하다.<br />
현실 세계에서 객체의 예를 들어보자.<br /> 
당신 앞에 있는 컵, 당신이 지금 사용하고 있는 컴퓨터, 당신 자신이 현실 세계의 객체이다.<br />
현실 객체는 다음과 같은 3가지 특징을 가진다.<br />

<h3>1. 속성</h3>
모든 객체는 속성을 가진다.<br />
당신의 속성은 이름, 핸드폰 번호, 허리 둘레 등이 될 수 있다.<br />

<h3>2. 행위</h3>
당신은 달린다, 걷는다와 같은 행위를 한다.<br />

<h3>3. 유일성</h3>
객체는 유일하다.<br />
당신은 유일무이하다.<br />

<h3>소프트웨어 객체</h3>
소프트웨어 객체 개념은 현실 세계의 객체와 비슷하다.<br />

<em>객체는 데이터와 그 데이터를 조작하는 함수로 구성된 '독립된 단위'다.</em>

<br /><br />
현실 세계 객체의 속성은 데이터로, 행위는 함수로 매핑된다.<br />

<h2>클래스 (Class)</h2>
클래스는 객체의 주조 금형에 해당한다.<br />
(금형에 쉿물을 부으면 제품이 만들어 지는데, 제품 하나 하나가 객체라고 생각하면 된다.)<br />
자바에서 객체를 생성하려면 먼저 클래스를 만들어야 한다.<br />

<h3>클래스 만드는 법</h3>
출석 관리를 위한 소프트웨어를 개발한다고 가정하자.<br />
학생 객체의 속성과 행위를 다음과 같이 추릴 수 있다.<br />
<br />
<em>속성 : 이름, 총 결석일 수<br />
행위 : 결석하다</em><br />
<br />
이제 학생 클래스를 작성할 수 있다.<br />

<em class="filename">Student.java</em>
<pre class="prettyprint">
<strong>class</strong> Student {
	String name;
	int totalAbsenceDays;
	
	void absent() {
		totalAbsenceDays = totalAbsenceDays + 1;
	}

}
</pre>

<dl class="note">
<dt>class Student {..}</dt>
<dd>
class 키워드 다음에 클래스 이름이 온다.<br />
소스 파일 이름은 클래스 이름과 같게 할 것을 권장한다.<br />
</dd>
<dt>String name;</dt>
<dd>
자바 객체는 자신의 상태를 필드에 저장한다.<br />
상태는 OOP의 속성이라는 개념보다 넓은 개념이다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 50%;">String</th>
	<th class="table-in-article-th">name</th>
</tr>
<tr>
	<td class="table-in-article-td">필드의 데이터 형</td>
	<td class="table-in-article-td">필드 이름</td>
</tr>
</table>

String 클래스는 자바 API에 속한다.<br />
String 클래스는 문자열을 표현할 때 사용된다.<br />
</dd>

<dt>int totalAbsenceDays;</dt>
<dd>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 50%;">int</th>
	<th class="table-in-article-th">totalAbsenceDays</th>
</tr>
<tr>
	<td class="table-in-article-td">필드의 데이터 형</td>
	<td class="table-in-article-td">필드 이름</td>
</tr>
</table>

int는 정수를 위한 데이터 형이다.<br />
</dd>

<dt>void absent() {..}</dt>
<dd>
absent()가 반환하는 값이 없다면 absent() 앞에 void를 붙여야 한다.<br />
absent()가 반환하는 값이 있다면 absent() 앞에 반환하는 값의 데이터 형을 붙여야 한다.<br />
자바에선, absent()를 함수가 아닌 메서드라고 부른다.<br />
</dd>
</dl>

위 Student 클래스를 단독으로 실행할 수 있도록 만들자.<br />
Student.java 파일을 열고, 아래와 같이 메인 메서드를 추가한다.<br />

<em class="filename">Student.java</em>
<pre class="prettyprint">
class Student {
	String name;
	int totalAbsenceDays;
	
	void absent() {
		totalAbsenceDays = totalAbsenceDays + 1;
	}
	<strong>
	public static void main(String[] args) {
		Student tom = null;
		Student will = null;

		tom = new Student();
		tom.name = "Thomas Edison";

		will = new Student();
		will.name = "William Blake";

		tom.absent();
		will.absent();
		tom.absent();

		System.out.println(tom.totalAbsenceDays);
		System.out.println(will.totalAbsenceDays);
	}</strong>
	
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\&gt;javac Student.java

C:\&gt;java Studnet
2
1

C:\&gt;
</pre>

java Student를 명령 프롬프트에서 실행하면 새로운 JVM이 실행되고 Student 클래스의 메인 메서드가 실행된다.<br />
JVM이 실행될 때마다 클래스 로더는 프로그램을 구성하는 자바 클래스 파일(예를 들면, Student, String, System 등)을 메모리에 적재하는 것을 책임진다.<br />
클래스 로더는 자바 API와 관련된 클래스(예를 들면, String, System 등)의 위치는 이미 알고 있다.<br />
Student 클래스는 우리가 그 위치를 클래스로더에게 알려주어야 할 때가 있다.<br />
Student 클래스가 없는 디렉터리에서 Student 클래스를 실행하려면 java의 cp 옵션을 사용하여 Student 클래스의 위치를 알려주어야 한다.<br />

<dl class="note">
<dt>public static void main (String[] args) {..}</dt>
<dd>
메인 메서드는 자바 프로그램의 시작점이다.<br />
시작하는 클래스에 메인 메서드를 만들어야 한다.<br />
</dd>
<dt>Student tom = null;</dt>
<dd>
이 문장은 학생 객체를 참조하게 될 참조형 변수를 선언하고 null로 초기화한다.<br />
참조형 변수는 객체를 접근할 때 사용하는 참조값을 저장한다.<br />
참조형 변수는 객체 그 자체를 저장하지 않는다.<br />
만약 참조형 변수가 어떤 객체도 가리키지 않도록 하려면 null를 할당하면 된다.<br />
null도 값이기에, Student tom;과 Student tom = null;은 완전히 다르다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 50%;">Student tom;</th>
	<th class="table-in-article-th">Student tom = null;</th>
</tr>
<tr>
	<td class="table-in-article-td" >
	tom의 값이 정해지지 않았다.<br />
	(이를 초기화되지 않았다라고 한다.)
	</td>
	<td class="table-in-article-td">
	null은 참조형 변수의 초기화에 사용된다.<br />
	null은 변수가 어떤 객체도 참조하지 않음을 나타내는 값이다.
	</td>
</tr>	
</table>
</dd>
<dt>tom = new Student();</dt>
<dd>
이 문장은 Student형 참조형 변수 tom에 생성한 학생 객체의 참조값을 할당한다.<br />
new Student();는 학생 객체를 힙 메모리 공간에 생성하고, 생성된 학생 객체를 조작하기 위해 필요한 참조값을 반환한다.<br />
</dd>
<dt>tom.name = "Thomas Edison";</dt>
<dd>
이 문장은 변수 tom을 이용해서 학생 객체의 이름을 셋팅한다.<br />
참조형 변수를 사용해서 객체에 접근하려면 변수명 다음에 .(도트)를 쓰고 객체의 필드나 메서드를 표기한다.<br />
</dd>
<dt>tom.absent();</dt>
<dd>
이 문장은 tom이 참조하는 학생 객체의 absent()를 호출한다.<br />
</dd>
</dl>

<h2>System.out.println()</h2>

자바 기초 예제에서는 결과를 보기 위해서 이 메서드를 자주 사용하게 된다.<br />
다음은 이 메서드의 모든 쓰임새를 보여주고 있다.<br />

<em class="filename">StandardOutput.java</em>
<pre class="prettyprint">
class StandardOutput {
    public static void main(String[] args) {
        System.out.println(true);// 불린값을 출력하고 개행
        System.out.println('A');// char 'A'를 출력하고 개행
        char[] x = {'A','B','C'};
        System.out.println(x);//char 형 배열을 출력하고 개행
        System.out.println(99.9);//double 형 자료를 출력하고 개행
        System.out.println();//단순히 줄을 바꾼다(개행한다.)
        System.out.println(99.9F);//float 형 자료를 출력하고 개행
        System.out.println(100);//int 형 자료를 출력하고 개행
        System.out.println(40000000L);//long 형 자료를 출력하고 개행
        System.out.println(System.out);//객체의 데이터형@해시코드를 출력하고 개행
        System.out.println("표준출력메서드");//문자열을 출력하고 개행
    }
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\&gt;javac StandardOutput.java

C:\&gt;java StandardOutput
true
A
ABC
99.9

99.9
100
40000000
java.io.PrintStream@de6ced
표준출력메서드
</pre>

System.out.print()와 System.out.println()의 유일한 차이점은 System.out.print()는 출력 후 라인을 바꾸지 않는다는 것이다.