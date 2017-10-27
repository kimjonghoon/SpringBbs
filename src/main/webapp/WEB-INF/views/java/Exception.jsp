<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2014.4.11</div>

<h1>예외</h1>

예외(exception)란 일반적이지 않는 것을 의미한다.<br />
예를 들어 "에스컬레이터가 갑자기 중간에서 멈춘다면 예외적인 상황이다."라고 할 때 그 예외이다.<br />
자바는 자바 API를 사용하는 중에 발생할 수 있는 모든 예외 상황마다 예외 클래스를 만들어 놓았다.<br />
그리하여 실행 도중에 예외가 발생하면 JVM은 그것에 해당하는 예외 클래스로부터 객체를 생성하여 
예외를 발생시킨 코드에 던진다.<br />
예외 객체를 생성하여 던지는 것까지 예외가 발생했을 때 JVM이 책임져야 할 부분이다.<br />
발생한 예외 객체를 어떻게 핸들링할지는 프로그래머의 몫이다.<br />
프로그래머는 생성된 예외 객체를 try, catch와 finally블럭<a href="#comments"><sup>1</sup></a>을 적절히 사용하여 컨트롤 할 수 있다.<br />
자바 프로그래밍 세계에서 에스컬레이터 객체가 갑자기 중간에서 멈추면 catch블록에서 사람 객체를 걷도록
프로그래밍하면 된다.<br />

<dl class="note">
<dt>자바 프로그램에서 에러(error)란?</dt>
<dd>
예외도 엄밀하게 에러이지만 자바에서는 예외와 에러를 구별한다.<br />
자바에서 에러는 "프로그램적으로 컨트롤 할 수 없는 에러"라고 보면 된다.<br />
에러가 발생하면 프로그램은 종료된다.<br />
에러가 발생하면 프로그래머가 할 수 있는 일이 거의 없다.<br />
</dd>
</dl>

<h2>예외를 컨트롤하는 코드</h2>

예외 클래스들은 계층적인 구조를 가지는데, 이중 Exception클래스는 모든 예외 클래스의 최상위 클래스이다.
다음은 예외를 다루는 예이다.<br />

<pre class="prettyprint">
try {
   //A,B라는 예외가 발생할 수 있는 코드
   //여기서 A는 계층적으로 B보다 위에 있다고 가정
} catch (B익셉션클래스 e) { //e는 B익셉션 객체의 레퍼런스
   //B예외가 발생했을 때 실행되는 코드
} catch (A익셉션클래스 e) {
   //A예외가 발생했을 때 실행되는 코드
} finally {
   //예외가 발생하던 안하던 무조건 실행되는 코드
}
</pre>

<dl class="note">
<dt>try블록</dt>
<dd>
예외가 발생할 수 있는 코드를 감싸는 블록으로 단독으로 쓸 수 없다.<br />
catch블록이나 finally블록과 함께 사용해야 한다.<br />
</dd>
<dt>catch블록</dt>
<dd>
에러와 마찬가지로 예외 역시 아무런 조치가 없다면 프로그램은 멈추게 된다.<br />
try블록에서 발생한 예외를 핸들링하려면 catch블록을 코드내에 적절하게 사용해야 한다.<br />
catch블록은 위에서처럼 여러개를 사용하여 발생한 익셉션에 따라 섬세한 컨트롤이 가능하다.<br />
</dd>
<dt>finally블록</dt>
<dd>
익셉션이 발생하든 발생하지 않든 무조건 실행되는 블록이다.<br />
finally블록은 없거나 하나이다.<br />
</dd>
</dl>

<h2>예외 매커니즘</h2>

아래와 같이 메소드1에서 메소드2를 호출, 메소드2에서 메소드3를 호출한다고 가정한다.<br />

<img src="https://lh3.googleusercontent.com/-e9lY9rAqJ3s/VYEg9RM3gqI/AAAAAAAACO4/DrD7J9FkFsk/s600-Ic42/exception-mechanism.gif" alt="익셉션 매커니즘" /><br />

메소드3에서 익셉션이 발생했고 메소드3에서 발생한 익셉션을 잡는 catch문이 있다면 프로그램은 멈추지 않고 계속 진행된다.<br />
메소드3에서 해당 익셉션을 잡는 catch문이 없다면 발생한 익셉션은 메소드3를 호출한 메소드2에 전달된다.<br />
메소드2에서 해당 익셉션을 잡는 catch문이 없다면 메소드2를 호출한 메소드1으로 익셉션이 전달된다.<br />
메인 메소드를 호출한 JVM까지 익셉션이 전달되면 프로그램은 종료된다.<br />
이와같은 종료를 비정상적인 종료라 한다.<br />

<h3>익셉션 클래스 계층 구조</h3>

<img src="https://lh3.googleusercontent.com/-UKDWi65X4sRbRXolBLM9k1_vmUwPbTnOKUbl8z-z_jikNv49nsUz3C0ZG3qCTWSfxk5BsSu9jnYtEGH8HBobtqvBkWLRj2Msrsb9V6Rhiqld0InAAwKxc1Diqh7UT26dlZhncbimcfICGq9jV9OmZOsYq-7UZdoA33t79BUSi1rxOXLiWn3Yy9zRCmgpkejxBb6_9VtPe5AH_JaRMhBmFENZ6LgbZNNFEgv17MmRu1-CrjWG71TyIKWbPRkILuResDiCmTUHhyK6zG23_e6V5cf70_G3pOGPCpuS20CymlSQXtHEc0AEWAE6Prskk9omwPo7CSfM2zMAzLBv-CQmnkUjR6vxNwY3LKuQE4Sy0UzAKZ923rD9BzGiEoyL3WiIW_O3CTuqQvr2FqXQugM-Nqe1XgRywFtSsolCBy3xPfePCFwXAJa7Ya1MBWiah-HaRFXACypZ3s3ZdIrVuKj1SL15GT4DoGSboZ68hsHswcdKo9_EGkeCq6-gaMEMPeupsg5nyExUAQcpU6m2uu6-2lZ8E_EmQXfyJMF2-b6HKHgkNMWpLHaD26Solx9lcj6flomXeGuzx_I6AVbrAf8k8L8pEsOquM=w390-h141-no" alt="Exception API" /><br />

<h3>자주 발생하는 익셉션</h3>
<table class="table-in-article">
<tr>
	<th class="table-in-article-th">발생하는 익셉션</th>
	<th class="table-in-article-th">예</th>
</tr>
<tr>
	<td class="table-in-article-td">ArithmeticException</td>
	<td class="table-in-article-td">int a = 12/0;</td>
</tr>
<tr>
	<td class="table-in-article-td">NullPointerException</td>
	<td class="table-in-article-td">Integer d = null;<br />
	int val = d.intValue();
	</td>
</tr>
<tr>
	<td class="table-in-article-td">NegativeArraySizeException</td>
	<td class="table-in-article-td">int arr = new int[-1];</td>
</tr>
<tr>
	<td class="table-in-article-td">ArrayIndexOutOfBoundException</td>
	<td class="table-in-article-td">
	int[] arr = new int[2];<br />
	arr[2] = 1;
	</td>
</tr>
</table>

<h3>메소드 선언부에 <em>throws 익셉션클래스</em> 가 쓰인 경우</h3>

메소드의 코드에서 throws다음에 나오는 익셉션이 발생할 수 있다는 것을 명시하는 것이다.<br />
외부에서 이 메소드를 호출할 때 throws다음에 정의된 익셉션을 적절히 처리하는 코드를 추가하지 않으면 컴파일 에러를 만나게 된다.<br />
적절히 익셉션을 처리하는 하는 방법은 다음과 같다.<br />
첫번째 방법은,<br />
이 메소드를 호출하는 메소드는 메소드 선언부에 throws키워드를 사용하여 전달받은 익셉션을 다시 자신을 호출한 메소드에 전달하도록 처리하는 것이다.<br />
두번째 방법은,<br />
전달받은 익셉션을 자신의 메소드 몸체에서 try ~ catch구문을 사용하여 직접 처리하는 것이다.<br />
첫번째와 두번째 방법 그 어느것도 사용하지 않는다면 컴파일 에러가 만나게 된다.<br />
여기에도 예외가 있는데, 발생하는 익셉션이 RuntimeException의 서브 클래스인 경우 메소드 선언부에 throws를 사용하지 않아도 컴파일이 된다.<a href="#comments"><sup>2</sup></a><br />

<h3>익셉션 예제</h3>

지금까지의 설명을 토대로 예제를 숙지한다.<br/>
unchecked 익셉션 예부터 본다.<br/>
다음과 같이 예제를 만든다.

<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
        
	public static void method2() {
		method3();
	}

	public static void method3() {
		<strong>int a = 12 / 0;</strong>
		System.out.println(a);
	}
        
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

예제를 실행한다.<br/>
이 예제는 ArithmeticException 익셉션 객체가 JVM까지 도달했다.<br/>
JVM은 아래처럼 익셉션이 발생한 스택을 위에서부터 차례로 출력한다.<br/>
중요한 것은 정상적인 종료가 아니라는 사실이다.<br/>
정상적인 종료라면 메인메소드 마지막 줄에 실행되어 "정상종료"라고 콘솔에 출력되어야만 한다.
    
<pre class="console"><strong class="console-result">Exception in thread "main" java.lang.ArithmeticException: / by zero
	at net.java_school.exception.Test.method3(Test.java:14)
	at net.java_school.exception.Test.method2(Test.java:10)
	at net.java_school.exception.Test.method1(Test.java:6)
	at net.java_school.exception.Test.main(Test.java:19)</strong></pre>

이번에는 method3()에서 try ~ catch문을 사용하여 익셉션을 핸들링하는 코드이다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}

	public static void method2() {
		method3();
	}

	public static void method3() {
		<strong>try {</strong>
			int a = 12 / 0;
			System.out.println(a);
		<strong>} catch (ArithmeticException e) {
			System.out.println(e.getMessage());
		}</strong>
	}

	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");	
	}

}
</pre>

    System.out.println(e.getMessage());에 의해 / by zero 가 출력된다.
    
    
<pre class="console"><strong class="console-result">/ by zero
정상종료
</strong></pre>



코드를 되돌리고 method2()에서 try ~ catch블록으로 익셉션을 잡도록 수정한다.

<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		<strong>try {</strong>
			method3();
		<strong>} catch (ArithmeticException e) {
			System.out.println(e.getMessage());
		}</strong>
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

    method3()에서 발생한 익셉션 객체가 method2()까지 전달된다.<br/>
    반환값이 있는 메소드가 반환값을 반환하는것과 비슷하다.<br/>
    
    <pre class="console"><strong class="console-result">/ by zero
정상종료
</strong></pre>

    코드를 되돌리고 이번에는 method1()에서 익셉션을 잡는다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		<strong>try {</strong>
			method2();
		<strong>} catch (ArithmeticException e) {
			System.out.println(e.getMessage());
		}</strong>
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

   콘솔의 결과는 같지만 발생한 익셉션이 method1()까지 전달되고 method1()에서 익셉션을 제대로 잡았기 때문에 비정상적인 종료를 피할 수 있었다.
    <pre class="console"><strong class="console-result">/ by zero
정상종료
</strong></pre>

    코드를 되돌리고 이번에는 메인 메소드에서 익셉션을 핸들링한다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		<strong>try {</strong>
			method1();
		<strong>} catch (ArithmeticException e) {
			System.out.println(e.getMessage());
		}</strong>
	
		System.out.println("정상종료");
	}

}
</pre>

콘솔의 결과는 같지만 메인까지 익셉션이 전달되었고 메인에서 익셉션을 잡았기에 정상종료될 수 있었다.

<pre class="console"><strong class="console-result">/ by zero
정상종료
</strong></pre>

try블록과 대부분 같이 쓰이지만 catch블록은 필수는 아니다.<br/>
    하지만 익셉션 객체를 잡을려면 반드시 필요하다.<br/>
    다음 예제는 catch블록을 제거해 보았다.<br/>
    try블록은 단독으로 쓰일 수 없으므로 대신 finally블록을 함께 사용했다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		try {
			method1();
		} <strong>finally</strong> {
			System.out.println("finally블록 실행");
		}
		
		System.out.println("정상종료");
	}

}
</pre>

finally블록은 실행되는 것이 보장된다.<br/>
    하지만 catch블록이 없으니 익셉션 객체는 JVM까지 전달되게 되고 프로그램은 비정상적으로 종료된다.<br/>
    실행하여 콘솔 화면에서 finally블록이 실행되고 익셉션이 JVM까지 전달되는 것을 확인한다.
    
<pre class="console"><strong class="console-result">finally블록 실행
Exception in thread "main" java.lang.ArithmeticException: / by zero
        at net.java_school.exception.Test.method3(Test.java:14)
        at net.java_school.exception.Test.method2(Test.java:10)
        at net.java_school.exception.Test.method1(Test.java:6)
        at net.java_school.exception.Test.main(Test.java:20)
</strong></pre>

다시 catch블록을 사용했는데 이번에는 익셉션의 최상위에 있는 Exception타입으로 catch블록이 만들었다.<br/>
    이러면 try블록안의 어떠한 익셉션이 발생해도 이 catch블록이 모두 잡을 수 있다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		try {
			method1();
		} catch (<strong>Exception</strong> e) {
			System.out.println(e.getMessage());
		} finally {
			System.out.println("finally블록 실행");
		}
		
		System.out.println("정상종료");
	}

}
</pre>

익셉션이 발생했기에 catch블록이 실행되고 finally블록이 실행된다.<br/>
    catch블록에서 발생한 익셉션을 잡았기 때문에 익셉션은 더 이상 어디에도 전달되지 않는다.
    
<pre class="console"><strong class="console-result">/ by zero
finally블록 실행
정상종료
</strong></pre>

catch블록이 마치 if ~ else if문처럼 겹겹이 쓸 수 있다.<br/>
    하지만 이때 익셉션 클래스의 계층관계에 주의해야 한다.<br/>
    다음 코드는 컴파일이 되지 않는다.<br/>
    익셉션이 try블록에서 발생하면 위에서 아래로 순서대로 catch블록이 해당 익셉션을 잡으려 하는데 먼저 나오는 익셉션이 나중에 나오는 익셉션에 비해 계층적으로 위에 있다면 아래까지 코드가 진행될 이유가 없다는 컴파일 에러이다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		try {
			method1();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} catch (<strong>ArithmeticException</strong> e) { 
			System.out.println(e.getMessage());
		} finally {
			System.out.println("finally블록 실행");
		}
		
		System.out.println("정상종료");
	}

}
</pre>

catch블록의 순서를 아래처럼 바꾸면 컴파일이 된다.

<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		int a = 12 / 0;
		System.out.println(a);
	}
	
	public static void main(String[] args) {
		try {
			method1();
		} catch (<strong>ArithmeticException</strong> e) {
			System.out.println(e.getMessage());
		} catch (<strong>Exception</strong> e) {
			System.out.println(e.getMessage());
		} finally {
			System.out.println("finally블록 실행");
		}
		
		System.out.println("정상종료");
	}

}
</pre>

실행하면 catch(ArithmeticException e) {.. }블록이 실행되고 이 블록의 e.getMessage()가 표준출력메소드를 통해 콘솔에 출력된다.<br/>
    그 다음 finally블록이 실행되고 메인의 마지막 라인이 실행된다.
    
<pre class="console"><strong class="console-result">/ by zero
finally블록 실행
정상종료
</strong></pre>

같은 예제를  checked 익셉션 예제로 아래와 같이 수정한다.<br/>
    강조된 부분에서 컴파일 에러가 날 것이다.<br/>
    이클립스에서 확인하면 컴파일 에러 메시지는 Unhandled exception type ClassNotFoundException이다.<br/>
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		<strong>Class.forName("java.lang.Boolean");</strong>
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

Class.forName("문자열");은 새로운 자바문법이 아니다.<br/>
    Class란 클래스가 있고 이 클래스의 forName()이라는 static메소드가 있는 것이다.<br/>
    forName()메소드는 문자열을 인자로 받는데 이 문자열은 클래스 로더가 찾을 수 있는 곳에 있는 자바 클래스의 전체 이름이 온다.(FQCN)<br/>
    forName()메소드는 문자열에 해당하는 클래스를 클래스 로더로 하여금 클래스 정보가 로딩하도록 한다.<br/>
    만약 그와같은 클래스가 없다면 JVM은 ClassNotFoundException객체가 생성하고 Class.forName("");라인에 던질 것이다.<br/>
    예제에서 forName()에 전달한 문자열인 java.lang.Boolean은 랩퍼 클래스로 자바API에 속한 클래스이니 별도의 환경설정 없이도 클래스 로더가 이 클래스를 찾을 수 있다.<br/>
    이 예제에서 이 클래스의 용도는 중요하지 않다.<br/>
    예제에서 중요한 얘기를 하자.<br/>
    forName()이라는 메소드는 throws ClassNotFoundException이라고 선언되어 있고 이 ClassNotFoundException은 RuntimeException을 상속하지 않은 checked익셉션이므로<br/>
    forName()을 호출하는 메소드는 이 익셉션을 핸들링하는 코드를 구현하지 않으면 컴파일 에러를 만나게 된다.<br/>
    직접 핸들링 할 수 있겠지만 이클립스의 코드 어시스트 기능을 이용하자.<br/>
    Class.forName()에 커서를 올리면 이클립스가 해결책을 제시하는데 두번째 방법을 클릭하면 코드는 아래와 같이 바뀌면서 컴파일 에러는 사라진다.<br/>
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		method3();
	}
	
	public static void method3() {
		<strong>try {
			Class.forName("java.lang.Boolean");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}</strong>
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

실행하면 어떠한 익셉션도 발생하지 않고 정상종료된다.<br/>
    왜냐하면 java.lang.Boolean라는 클래스가 자바API에 존재하기 때문이다.
    
<pre class="console"><strong class="console-result">정상종료
</strong></pre>

코드를 되돌려서 이번에는 이클립스가 제시하는 첫번째 방법으로 익셉션을 핸들링한다.<br/>
    그러면 method2()에서 method3();에 컴파일 에러가 발생할 것이다.<br/>
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	public static void method2() {
		<strong>method3();</strong>
	}
	
	public static void method3() <strong>throws ClassNotFoundException</strong> {
		Class.forName("java.lang.Boolean");
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

 이클립스에서 컴파일 에러메시지를 확인하면 Unhandled exception type ClassNotFoundException이다.<br/>
    method3()가 throws ClassNotFoundException로 선언되었기 때문에 method3()을 호출하는 메소드는 반드시 ClassNotFoundException을 핸들링해야 한다. <br/>
    이번에도 컴파일 에러가 나는 부분에 커서를 두고 이클립스가 제시하는 해결책 중 두번째 방법을 클릭한다.<br/>
    그러면 소스는 아래처럼 변경되고 컴파일 에러는 사라진다.<br/>
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		method2();
	}
	
	<strong>public static void method2() {
		try {
			method3();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}</strong>
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean");
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

코드를 되돌리고 이번에는 이클립스가 제시하는 첫 번째 방법을 클릭한다.<br/>
    그러면 소스는 아래처럼 변경되는데 method1()메소드의 method2();에서 컴파일 에러가 발생한다.<br/>
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		<strong>method2();</strong>
	}
	
	public static void method2() <strong>throws ClassNotFoundException</strong> {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean");
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

커서를 컴파일 에러가 발생하는 곳에 두고 이클립스가 제시하는 해결책 중 두번째 방법을 클릭한다.<br/>
    코드는 아래처럼 변경된다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() {
		<strong>try {
			method2();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}</strong>
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean");
	}
	
	public static void main(String[] args) {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

어떤 익셉션도 발생하지 않고 정상적으로 종료되는 것을 확인할 수 있다.

<pre class="console"><strong class="console-result">정상종료
</strong></pre>

코드를 되돌리고 method1()의 method2();에 커서를 대고 첫번째 방법을 클릭하면 다음과 같이 코드가 변경될 것이다.<br/>
    소스가 아래처럼 변경되면서 메인 메소드에서 컴파일 에러가 생긴다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() <strong>throws ClassNotFoundException</strong> {
		method2();
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean");
	}
	
	public static void main(String[] args) {
		<strong>method1();</strong>
		System.out.println("정상종료");
	}

}
</pre>

이번에는 메인 메소드에서 컴파일 에러가 발생하는 곳에 커서를 두고 첫번째 방법을 클릭한다.<br/>
    그러면 소스는 다음과 같이 변경될 것이다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() throws ClassNotFoundException {
		method2();
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean");
	}
	
	public static void main(String[] args) throws ClassNotFoundException {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

실행하면 어떤 익셉션도 없이 정상적으로 종료되는 것을 확인할 수 있다.

<pre class="console"><strong class="console-result">정상종료
</strong></pre>

코드를 익셉션이 발생하도록 수정하겠다.<br/>
    java.lang.Boolean2라는 클래스는 자바API에 존재하지 않기 때문이다.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() throws ClassNotFoundException {
		method2();
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("<strong>java.lang.Boolean2</strong>");
	}
	
	public static void main(String[] args) throws ClassNotFoundException {
		method1();
		System.out.println("정상종료");
	}

}
</pre>

실행하면 익셉션 객체가 메인까지 도달하고 메인에서도 익셉션을 잡지 않으므로 결국 JVM까지 전달된다.<br/>
    그 결과 비정상적으로 프로그램은 종료된다.
    
<pre class="console"><strong class="console-result">Exception in thread "main" java.lang.ClassNotFoundException: java.lang.Boolean2
        at java.net.URLClassLoader$1.run(URLClassLoader.java:217)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(URLClassLoader.java:205)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:323)
        at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:294)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:268)
        at java.lang.Class.forName0(Native Method)
        at java.lang.Class.forName(Class.java:190)
        at net.java_school.exception.Test.method3(Test.java:13)
        at net.java_school.exception.Test.method2(Test.java:10)
        at net.java_school.exception.Test.method1(Test.java:6)
        at net.java_school.exception.Test.main(Test.java:18)
</strong></pre>

메인에서 익셉션을 잡는 코드로 변경한다.

<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() throws ClassNotFoundException {
		method2();
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean2");
	}
	
	<strong>public static void main(String[] args) {
		try {
			method1();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("정상종료");
	}</strong>

}
</pre>

실행하면 e.printStackTrace();메소드가 콘솔에 다음과 같이 출력되는 것을 확인할 있다.<br/>
    이 메시지가 JVM이 출력해주는것과 같다고 해서 비정상적인 종료라고 오해해서는 안된다.<br/>
    
<pre class="console"><strong class="console-result">java.lang.ClassNotFoundException: java.lang.Boolean2
        at java.net.URLClassLoader$1.run(URLClassLoader.java:217)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(URLClassLoader.java:205)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:323)
        at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:294)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:268)
        at java.lang.Class.forName0(Native Method)
        at java.lang.Class.forName(Class.java:190)
        at net.java_school.exception.Test.method3(Test.java:14)
        at net.java_school.exception.Test.method2(Test.java:10)
        at net.java_school.exception.Test.method1(Test.java:6)
        at net.java_school.exception.Test.main(Test.java:19)
정상종료
</strong></pre>

메인에서 다음과 같이 catch블록을 제거하면 컴파일 에러를 만난다.<br/>
    ClassNotFoundException은 checked익셉션으로 익셉션을 잡는 catch블록이나 아니면 메소드를 throws 익셉션클래스로 선언하는 것 중 하나를 선택하지 않으면 컴파일 에러를 만나게 된다.<br/>
    여기서 메소드 밖으로 checked익셉션이 나올려면 메소드가 throws 해당 익셉션 클래스로 선언되지 않으면 나올 수 없다는 사실을 기억하자.
    
<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() throws ClassNotFoundException {
		method2();
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean2");
	}
	
	public static void main(String[] args) {
		try {
			<strong>method1();</strong>
		} finally {
			System.out.println("finally블록 실행");
		}
		System.out.println("정상종료");
	}

}
</pre>

코드에 다시 catch블록을 넣어 컴파일 에러를 피하도록 한다.<br/>

<pre class="prettyprint">
package net.java_school.exception;

public class Test {

	public static void method1() throws ClassNotFoundException {
		method2();
	}
	
	public static void method2() throws ClassNotFoundException {
		method3();
	}
	
	public static void method3() throws ClassNotFoundException {
		Class.forName("java.lang.Boolean2");
	}
	
	public static void main(String[] args) {
		try {
			method1();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			System.out.println("finally블록 실행");
		}
		System.out.println("정상종료");
	}

}
</pre>

실행하면 java.lang.Boolean2란 클래스는 없으므로 ClassNotFoundException익셉션이 발생하고 catch블록에서 e.printStackTrace();가 실행되고 finally블록이 실행되고 메인의 마지막 라인이 실행된다.

<pre class="console"><strong class="console-result">java.lang.ClassNotFoundException: java.lang.Boolean2
        at java.net.URLClassLoader$1.run(URLClassLoader.java:217)
        at java.security.AccessController.doPrivileged(Native Method)
        at java.net.URLClassLoader.findClass(URLClassLoader.java:205)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:323)
        at sun.misc.Launcher$AppClassLoader.loadClass(Launcher.java:294)
        at java.lang.ClassLoader.loadClass(ClassLoader.java:268)
        at java.lang.Class.forName0(Native Method)
        at java.lang.Class.forName(Class.java:190)
        at net.java_school.exception.Test.method3(Test.java:14)
        at net.java_school.exception.Test.method2(Test.java:10)
        at net.java_school.exception.Test.method1(Test.java:6)
        at net.java_school.exception.Test.main(Test.java:19)
finally블록 실행
정상종료
</strong></pre>

e.printStackTrace();가 출력하는 이런 형태의 메시지는 자주 보게 될 것이다.<br/>
    이럴 때는 당황하지 말고 기본적인 자바 문법을 가지고 추측하면 대부분의 문제가 풀릴 것이다.<br/>
    ClassNotFoundException은 클래스를 클래스 패스에서 클래스 로더가 찾지 못한다는 것이다.<br/>
    경우에 따라서는 구글링이 답일 수 있다.
    
<h3>사용자 정의 익셉션</h3>

익셉션이 발생할 상황이 되면 JVM이 자바 API의 익셉션 클래스로부터 익셉션 객체를 생성하고 익셉션이 발생한 코드에 던진다고 했다.
그런데 이런 익셉션 클래스를 프로그래머가 필요에 따라 만들 수 있다.
이를 "사용자 정의 익셉션" 이라고 부른다.
아래 예는 사용자 정의 익셉션의 구현 방법이다.
은행 프로그램에서 잔고가 부족한 예외 상황에서 사용될 익셉션이다.<a href="#comments"><sup>3</sup></a>

<pre class="prettyprint">
package net.java_school.bank;

public class InsufficientBalanceException extends Exception {

	public InsufficientBalanceException() {
		super();
	}
	
	public InsufficientBalanceException(String message, Throwable cause,
		boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
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

사용자 정의 익셉션은 JVM이 객체를 만들어 던지지 않는다.
그러므로 사용자 정의 익셉션은 코드로서 명시적으로 익셉션을 발생시켜야 한다.
사용자 정의 익셉션으로 부터 익셉션 객체를 만들어 던지는 코드는 다음과 같다.

<pre class="prettyprint">
throw new InsufficientBalanceException("잔액이 부족합니다.");
</pre>

<h3>문제</h3>
아래와 같이 실행되는 클래스를 작성한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Exception\bin&gt;java net.java_school.bank.Test
1000원 입금: java net.java_school.bank.Test d 1000
1000원 출금: java net.java_school.bank.Test w 1000

C:\java\Exception\bin&gt;java net.java_school.bank.Test d 2100
최대 잔고액을 넘게 입금할 수 없습니다.
잔고는 1000

C:\&gt;java net.java_school.bank.Test w 2100
잔액이 부족합니다.
잔고는 1000
</pre>

메인메소드를 완성하시오.<br />

<pre class="prettyprint">
package net.java_school.bank;

public class Test {
	public static void main(String[] args) {
		int MAX_BALANCE = 3000; //최대 잔고금액
		int balance = 1000; //초기 잔고
		int amount = 0; //입금액 또는 출금액
		
		if (args.length &lt; 2) {
		System.out.println("1000원 입금: java net.java_school.bank.Test d 1000");
		System.out.println("1000원 출금: java net.java_school.bank.Test w 1000");
		return;
	}
	
	//구현부

}        
</pre>

위의 문제에서 적절한 사용자 익셉션 클래스를 만들고 적용하시오.

<span id="comments">주석</span>
<ol>
	<li>블록이란 {로 시작해서 }로 끝나는 코드 단위를 의미한다.<br />
	자바에선 블록안에서 선언된 변수는 블록안에서만 유효하다.</li>
	<li>RuntimeException과 그 서브 클래스를 unchecked익셉션, 그 외 익셉션을 checked익셉션이라고 부른다.</li>
	<li>InsufficientBalanceException사용자 정의 익셉션 클래스를 작성할 때 이클립스의 코드 어시스트 기능을 이용하면 쉽게 작성할 수 있다.<br />
	팩키지와 클래스 선언부를 위에서처럼 작성한 후에 클래스 바디에 아무것도 없는 상황에서 클래스 바디에 커서를 위치하고 오른쪽 마우스를 클릭한 후 나타난 메뉴에서
	Source, Generate constructor from superclass...를 차례로 선택하면 위와 같은 코드를 얻을 수 있다.<br />
	</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://java.sun.com/docs/books/tutorial/essential/exceptions/definition.html">http://java.sun.com/docs/books/tutorial/essential/exceptions/definition.html</a></li>
</ul>