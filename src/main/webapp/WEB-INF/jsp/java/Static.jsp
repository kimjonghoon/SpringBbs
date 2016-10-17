<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="last-modified">Last Modified : 2015.5.6</div>

<h1>static</h1>

static 키워드는 클래스 차원의 변수와 메소드를 만들 때 사용한다.<br />
정적(static)이란 클래스가 로딩될 때 결정된 메모리 공간이 변하지 않음을 의미한다.<br />
static 변수와 메소드는 객체를 생성하지 않고도 아래와 같이 사용할 수 있다.<br />

<ul>
	<li>클래스명.static변수</li>
	<li>클래스명.static메소드()</li>
</ul>

메인 메소드가 static 메소드이다.<br />
프로그램을 실행하면 클래스 로더가 관련 클래스를 클래스 패스에서 찾아서 메모리에 로딩한다.<br />
그다음 JVM이 java 다음에 나오는 시작 클래스에서 메인 메소드를 실행한다.

자바 프로그램이 실행되기 위해서는 클래스가 우선 메모리에 로딩되어야 한다.<br />
클래스 로더(Class Loader)가 클래스를 찾아서 메모리에 로딩한다.<br />
클래스가 로딩되는 메모리 공간과 객체가 활동하는 메모리 공간은 다르다.<br />

객체가 할당되는 공간은 JVM의 힙heap 메모리 영역이다. new가 실행될 때마다 힙 메모리에 객체의 인스턴스 변수를 위한 공간이 할당된다.
클래스가 메모리에 로딩될 때 static 변수와 static 메소드를 위한 공간이 할당된다.<br />
한번 메모리에 공간이 할당되면 인스턴스 변수와 달리 객체가 생성될 때마다 메모리 공간이 할당되지 않는다.<br />
static 메소드 안에서는 인스턴스 변수를 쓸 수 없다. 만들지도 않는 객체의 속성을 참조한다는 것은 말이 되지 않기 때문이다.<br />

학생 클래스에 메인 메소드를 추가하고 다음과 같이 구현하면 컴파일 에러를 만나게 된다.<br />
<pre>
public static void main(String[] args) {
    absentNum++;
}
</pre>
그 반대의 경우인 인스턴스 메소드 내에서 static 변수나 static 메소드를 쓰는 것은 문제가 없다.<br />
결석, 지각, 조퇴하면 벌금을 내도록 했다고 가정하자.<br />
학생은 결석 3천원, 지각이나 조퇴는 천원의 벌금을 벌금통에 넣어야 한다.<br />
여기서 벌금통을 코드로 어떻게 구현하면 되겠는가?<br />
벌금통은 학생 한명당 하나씩 있는 것이 아니다.<br />
단 하나이면서 모든 학생이 공유한다.<br />
벌금통이라는 클래스를 새로 만들고 이 클래스에 싱글톤 패턴을 적용해도 된다.<br />
더 좋은 방법은 벌금통을 모든 객체가 공유하는 변수인 static 변수로 만드는 것이다.<br />

<pre>
public class Student {
    <strong>static</strong> int penaltyBin; //벌금통

    public void absent() {
        this.absent++;
        <strong>Student.penaltyBin</strong> += 3000;
    }
    //..중간 생략..
}    
</pre>

<h3>정적 변수 예제</h3>
<pre class="prettyprint">
package net.java_school.user;

public class User {

    public <strong>static</strong> int total; //접속된 회원 수
    private String id;
    
    public User(String id) {
        this.id = id;
        total++;
    }

    public static void main(String[] args) {
        User user1 = new User("hong1440");
        User user2 = new User("im1562");
        User user3 = new User("jang1692");
        
        System.out.println("접속된 회원수 : " + <strong>User.total</strong>);
    }

}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">접속된 회원수 : 3</pre>

<h3>싱글톤 패턴(Singleton pattern)</h3>
객체가 단 하나만 만들어져야 할 때 사용하는 디자인 패턴이 싱글턴 패턴이다.<br />
static 변수가 초기화되는 시점은 클래스가 로딩될 때이다.<br />
<br />
싱글톤 패턴을 적용한 예제를 만들어 보겠다.<br />
가정집에는 식탁이 하나만 있어야 한다.<br />
식탁이 여러개 있어서 각자 식사 한다면 이상적인 가정에 방해가 될 수 있다.<br />
식탁 테이블을 싱글톤 패턴으로 객체가 하나만 생성되도록 클래스를 설계한다.<br />

<pre class="prettyprint">
package net.java_school.house;

public class CookTable {

    private <strong>static CookTable</strong> instance = new CookTable();
    
    public static CookTable getInstance() {
        return instance;
    }
    
    <strong>private</strong> CookTable() {}
    
    //..중간 생략..
  
}
</pre>

클래스 정보가 클래스 로더에 의해 로딩될 때 static 변수는 초기화 된다.<br />
CookTable 의 static 변수 instance 가 초기화 되기 위해<br />
CookTable 객체가 힙에 생성되고 참조값은 instance 에 할당된다.<br />
이 값은 공개된 getInstance() 를 통해 얻을 수 있다.<br />
하나뿐인 생성자의 접근자를 private 로 지정하여 외부에서 생성자를 호출 못하게 한다.<br />
이렇게 구현하면 프로그램 종료시까지 CookTable 인스턴스는 하나로 유지된다.<br />

<h3>초기화 순서</h3>
변수는 메모리 공간이 할당될 때 초기화된다.<br />
이때 초기값이 없다면 불린형은 false, 숫자형은 0 에 준하는 값으로, 레퍼런스 형은 null로 초기화된다.<br />
static 이 아닌 멤버 변수가 초기화되는 시점은 객체가 생성될 때이다.<br />
<br />
초기화 순서는 <em class="path">static 변수 -&gt; 인스턴스 변수 -&gt; 생성자</em> 이다.<br />
static 변수와 static 블록은 같은 레벨이다. 먼저 나온 것이 먼저 초기화된다.<br />
인스턴스 블록의 경우 컴파일러가 인스턴스 블록의 구현부를 모든 생성자의 마지막 라인에 추가한다.<br />
다음 문제의 결과를 예측해본다.<br />

<em class="filename">A.java</em>
<pre class="prettyprint">
package net.java_school.classvar;

public class A {

    public A() {
        System.out.println("A() 생성자 실행");
    }
        
}
</pre>

<em class="filename">B.java</em>
<pre class="prettyprint">
package net.java_school.classvar;

public class B {
    private A a = new A();
    
    {
        System.out.println("B 인스턴스 블록 실행");
    }
    
    static {
        System.out.println("B static 블록 실행");
    }
    
    private static B b = new B();

    private B() {
        System.out.println("B() 생성자 실행");
    }
    
    public B(int a) {
        System.out.println("B(int) 생성자 실행");
    }

    public static void main(String[] args) {
        new B();
        new B(1);
    }
        
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
B static 블록 실행
A() 생성자 실행
B 인스턴스 블록 실행
B() 생성자 실행
A() 생성자 실행
B 인스턴스 블록 실행
B() 생성자 실행
A() 생성자 실행
B 인스턴스 블록 실행
B(int) 생성자 실행
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/tutorial/java/javaOO/classvars.html">http://docs.oracle.com/javase/tutorial/java/javaOO/classvars.html</a></li>
	<li><a href="http://www.guru99.com/java-stack-heap.html">http://www.guru99.com/java-stack-heap.html</a></li>
</ul>