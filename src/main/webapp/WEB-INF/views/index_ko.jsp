<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2015.11.11</div>

<h1>JDK 설치</h1>

<h2>JDK Installer 다운로드</h2>

<a href="http://www.oracle.com/technetwork/java/javase/downloads/index.html">http://www.oracle.com/technetwork/java/javase/downloads/index.html</a><br /> 

<img src="https://lh3.googleusercontent.com/-CttJ26edXQ8/Vjq0aKA0REI/AAAAAAAACqc/s8PKICr8Lyc/s533-Ic42/JavaSEDevelopmentKit.png" alt="64bit windows Java SE" /><br />

<strong>64-bit</strong> 윈도 시스템은 위 그림처럼 <strong>Windows x64</strong>를 선택한다.<br />
<strong>32-bit</strong> 윈도 시스템은 <strong>Windows x86</strong>을 선택한다.<br />

<a href="http://bezzera.tistory.com/148">윈도 시스템이 32-bit인지 64-bit인지 알아내는 방법</a><br />
<br />

설치는 설치 화면에서 "Next" 버튼을 계속 클릭하는 것으로 쉽게 완료할 수 있다.<br />
JDK는 <em class="path">C:\Program Files\Java\jdk1.8.0_&lt;version&gt;</em> 디렉터리에서 위치한다.<br />


<h3>환경변수 PATH에 JDK의 bin 디렉터리 추가</h3>

시작을 클릭하고, 제어판, 시스템,
고급, 환경 변수를 차례로 선택한다.<br /> 
시스템 변수(S)에서 Path에 JDK의 bin 폴더를 추가한다.<br />
<br />
윈도 XP를 사용한다면 다음을 따른다.<br />
<img src="https://lh3.googleusercontent.com/-98m_YiFDhwU/V2SxgUU4K7I/AAAAAAAAC64/7KQ8b3Cpdbcuv7OWi746lg9RRkzvxJamACCo/s488/start-My_Computer-Properties.png" alt="시스템 속성 창" /><br />

<img src="https://lh3.googleusercontent.com/-zcZel2n21yk/VYDNqu5CxGI/AAAAAAAACMs/zIwc6Mz6__8optVwJUZnakdVUcAb6ostQCCo/s483/System-Properties_Advanced.png" alt="시스템 속성 창" /><br />

JAVA_HOME이란 이름의 새로운 환경 변수를 만든다.<br />
JAVA_HOME의 값은 JDK 설치 디렉터리이다.<br /> 
정확한 값을 얻기 위해 윈도 탐색기를 이용한다.<br />
<img src="https://lh3.googleusercontent.com/-_Xljvd7jGXM/VYDNqvGT5iI/AAAAAAAACMo/vDRhGTv4oZcPRBUVRFZV0gurvWhWo45TwCCo/s496/add-JAVA_HOME-System-Variable.png" alt="시스템 속청 창" /><br />


환경 변수 Path를 선택하고 편집 버튼을 클릭한다.<br />
Path의 기존 설정 값 맨 뒤에 ;(세미콜론)를 추가한 다음 
<em class="path">%JAVA_HOME%\bin</em>을 추가한다.<br />
<img src="https://lh3.googleusercontent.com/-iOuENrZbFAc/VYDNqqHl9zI/AAAAAAAACMg/BhZ60DJrp1EjfSclW23kNc6-y7fCzcAEgCCo/s493/add-jdk-bin-path.png" alt="%JAVA_HOME%\bin added in Path" /><br />
 
<dl class="note">
<dt>
세미콜론 (;)은 윈도 시스템에서 PATH 환경 변수의 값을 구분할 때 사용된다.
</dt>
<dt>PATH</dt>
<dd>
운영체제는 실행 프로그램을 PATH 디렉터리에서 찾는다.<br />
PATH에 JDK의 bin 폴더를 추가하면 
어느 디렉터리에서나 편리하게 JDK의 bin 폴더에 존재하는 
윈도 실행 프로그램인 javac.exe, java.exe, jar.exe 등을 실행할 수 있게 된다.<br />
만약 PATH에 JDK의 bin 폴더를 추가하지 않는다면 실행 프로그램의 전체 경로를 매번 다음과 같이 입력해야 할 것이다.<br />
<b>C:\Program Files\Java\jdk1.8.0_20\bin&gt;javac C:\Users\kim\Test.java</b><br />
명령 프롬프트에서 <strong>echo %PATH%</strong>를 실행하면 PATH 설정을 확인할 수 있다.<br />
</dd>
</dl>

<h2>테스트</h2>

<em class="filename">Test.java</em>
<pre class="prettyprint">
public class Test {
    public static void main(String[] args) {
        System.out.println("Hello World!");
    }
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\Users\kim&gt;javac Test.java

C:\Users\kim&gt;java Test
Hello World!
</pre>

<dl class="note">
<dt>테스트 예제 실패시 체크 리스트</dt>
<dd>
javac Test.java<br />
<span class="emphasis">'javac'은(는) 내부 또는 외부 명령, 실행할 수 있는 프로그램, 또는 배치 파일이 아닙니다.</span><br />
PATH 환경변수에 JDK의 bin 폴더를 추가하지 않았거나 잘못 추가한 경우이다.<br />
<br />
java Test<br />
<span class="emphasis">Exception in thread "main" java.lang.NoClassDefFoundError: Test</span><br />
Test.class 파일을 찾지 못했다는 메시지이다.<br />
Test.class 파일이 없는 디렉터리에서 java Test를 실행할 때 이런 에러를 만난다.<br />
클래스 파일이 없는 디렉터리에서 실행하려면 java.exe의 -cp 옵션을 사용한다.<br />
<em class="path">C:\javawork&gt;java -cp C:\Users\kim Test</em>
</dd>
</dl>

<h2>에디터</h2>
<a href="/java/Package_Modifiers">팩키지와 접근자</a>까지 
<a href="http://www.editplus.com/kr/">에디트플러스</a>같은 단순한 에디터를 사용하는 것이 낫다.<br />
팩키지와 접근자를 공부한 다음에 이클립스를 설치한다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://windows.microsoft.com/en-us/windows/32-bit-and-64-bit-windows#1TC=windows-7">32-bit and 64-bit Windows: frequently asked questions</a></li>
	<li><a href="http://www.editplus.com">editplus</a></li>
</ul>