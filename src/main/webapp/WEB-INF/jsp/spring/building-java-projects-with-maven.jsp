<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2015.1.9</div>

<h1>Maven을 이용한 Spring 실습</h1>

<p style="clear: both;font-style: italic;font-weight: bold;padding: 10px 30px;font-size: 14px;">
이 글은 <a href="http://spring.io/guides/gs/maven/">http://spring.io/guides/gs/maven/</a>를 번역한 것입니다.<br />
</p>

<h2>Maven 설치</h2>

<a href="http://maven.apache.org/download.cgi">http://maven.apache.org/download.cgi</a>
링크에서 바이너리 파일을 다운로드한다.<br />
적당한 곳에 압축을 푼다.<br />
Maven이 설치된 전체 경로를 값으로 환경 변수 MAVEN_HOME을 만든다.<br />
MAVEN_HOME이 의미하는 디렉터리에는 bin 서브 디렉터리가 있어야 한다.<br />
JDK가 설치된 전체 경로를 값으로 가지는 JAVA_HOME 환경 변수가 있는지 확인하고 없으면 만든다.<br />
JAVA_HOME 환경 변수 설정은 <a href="/java/JDK-Install">Java 설치</a>를 참고한다.<br />
Path 환경 변수에 %MAVEN_HOME%\bin 경로를 추가한다.<br />
명령 프롬프트를 새로 열고 다음 명령으로 메이븐 버전을 확인한다.<br />
<em class="path">mvn -v</em><br />

<h2>메이븐 프로젝트 생성</h2>

아래 예제를 따라 하면서 기본적인 메이븐 사용법을 익힌다.<br />

<h3>메이븐의 기본 구조로 디렉터리를 만든다.</h3>
프로젝트 루트 디렉터리를 생성한다.<br />
C:\maven\HelloWord를 프로젝트 루트 디렉터리라면, HelloWorld에는 아래처럼 서브 디렉터리를 만든다.<br />

<pre class="code">
HelloWorld (프로젝트 루트)
   └── src
        └── main
             └── java
                  └── hello
</pre>

<em class="filename">HelloWorld/src/main/java/hello/HelloWorld.java</em>
<pre class="prettyprint">
package hello;

public class HelloWorld {
    public static void main(String[] args) {
        Greeter greeter = new Greeter();
        System.out.println(greeter.sayHello());
    }
}
</pre>


<em class="filename">HelloWorld/src/main/java/hello/Greeter.java</em>
<pre class="prettyprint">
package hello;

public class Greeter {
    public String sayHello() {
        return "Hello world!";
    }
}
</pre>


프로젝트 루트에 pom.xml 파일을 작성한다.<br />

<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/maven-v4_0_0.xsd"&gt;
                       
	&lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
	&lt;groupId&gt;org.springframework.gs&lt;/groupId&gt;
	&lt;artifactId&gt;gs-maven-initial&lt;/artifactId&gt;
	&lt;version&gt;0.1.0&lt;/version&gt;
	&lt;packaging&gt;jar&lt;/packaging&gt;
	
&lt;/project&gt;
</pre>

&lt;modelVersion&gt; - POM model version으로 언제나 4.0.0<br />
&lt;groupId&gt; - 이 프로젝트의 소유자인 조직이나 기관명으로 대부분 역순 도메인명(예를 들면 net.java_school)<br />
&lt;artifactId&gt; - jar 나 war 파일에 붙여지는 이름<br />
&lt;version&gt; - 빌드 되는 프로젝트 버전 번호<br />
&lt;packaging&gt; - 프로젝트를 어떻게 패키지 할 것인가에 대한 설정. 디폴트는 jar, 웹 애플리케이션은 war<br />
<br />

<h3>빌드</h3>

<h4>mvn compile</h4>
pom.xml 파일이 있는 프로젝트 루트에서 mvn compile 을 실행한다.<br />
이 명령은 메이븐을 실행하고 컴파일 goal 을 실행한다.<br />
작업이 성공했다면 컴파일된 파일을 target/classes 폴더에서 찾을 수 있다.<br />
이 폴더는 컴파일이 수행되면서 만들어진다.<br />

<h4>mvn package</h4>
package goal 은 자바 코드를 컴파일하고 테스트를 수행하고 패키지로 묶어서 target 디렉터리에 복사한다.<br />
패키지 된 파일의 이름은 pom.xml에서 설정한 대로 gs-maven-initial-0.1.0.jar란 이름으로 만들어진다.<br />

<h4>mvn install</h4>
만약에 이 프로젝트의 jar 파일을 로컬 저장소에 설치하기를 원한다면<br /> 
install goal을 수행해야 한다.<br />
install goal은 컴파일하고 테스트한 후 패키지로 만든 파일을 로컬 저장소에 복사한다.<br />

<h4>mvn clean</h4>
clean goal 은 빌드를 통해 생성된 모든 산출물을 삭제한다.<br />

<h4>mvn clean compile</h4>
중복해서 goal를 수행할 수 있다.<br />


<h3>의존 라이브러리 설정을 pom.xml에 추가</h3>
대부분의 애플리케이션이 외부 라이브러리에 의존한다.<br />
우리의 예제도 외부 라이브러리에 의존하도록 바꾸겠다.<br />
<br />
HelloWorld.java를 아래처럼 변경한다.<br />

<em class="filename">HelloWorld/src/main/java/hello/HelloWorld.java</em>
<pre class="prettyprint">
package hello;

import org.joda.time.LocalTime;

public class HelloWorld {
  public static void main(String[] args) {
    LocalTime currentTime = new LocalTime();
    System.out.println("The current local time is: " + currentTime);

    Greeter greeter = new Greeter();
    System.out.println(greeter.sayHello());
  }
}
</pre>

이런 다음 바로 mvn compile 하면 빌드가 실패한다.<br />
왜냐하면 pom.xml에 의존 라이브러리 설정을 추가하지 않았기 때문이다.<br />

다음을 project 엘리먼트 안에 붙여 넣는다.<br />

<pre class="prettyprint">
&lt;dependencies&gt;
    &lt;dependency&gt;
        &lt;groupId&gt;joda-time&lt;/groupId&gt;
        &lt;artifactId&gt;joda-time&lt;/artifactId&gt;
        &lt;version&gt;2.2&lt;/version&gt;
    &lt;/dependency&gt;
&lt;/dependencies&gt;
</pre>

위에서는 빠져있지만 dependency 의 하위 엘리먼트로 scope 엘리먼트가 있다.<br />
scope 엘리먼트의 디폴트 값은 compile이다.<br />
그 외에 중요한 스코프는 아래와 같다.<br />
<br />
provided - 컴파일할 때 필요하지만 런타임에는 컨테이너에 의해 제공되는 것.(Servlet API)<br />
test - 컴파일하고 테스트에는 필요하지만 빌드(컴파일과 배포) 하거나 실행할 때는 필요 없는 것.<br />
<br />

<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/maven-v4_0_0.xsd"&gt;

    &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
    &lt;groupId&gt;org.springframework&lt;/groupId&gt;
    &lt;artifactId&gt;gs-maven&lt;/artifactId&gt;
    &lt;packaging&gt;jar&lt;/packaging&gt;
    &lt;version&gt;0.1.0&lt;/version&gt;
    <strong>
    &lt;dependencies&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;joda-time&lt;/groupId&gt;
            &lt;artifactId&gt;joda-time&lt;/artifactId&gt;
            &lt;version&gt;2.2&lt;/version&gt;
        &lt;/dependency&gt;
    &lt;/dependencies&gt;
	</strong>
&lt;/project&gt;
</pre>


<h3>실행</h3>
빌드에 성공했다면 루트 디렉터리에서 다음과 같이 실행하여 테스트한다.<br />
<em class="path">mvn exec:java -Dexec.mainClass=hello.HelloWorld</em><br />

<h2>스프링 시작하기 강좌 중 <a href="http://projects.spring.io/spring-framework/#quick-start">Quick Start</a> 정리</h2>
먼저 메이븐 프로젝트의 구조에 맞게 디렉토리를 만든다.<br />

<pre class="code">
quick-start
   └── src
        └── main
             └── java
                  └── hello
</pre>

프로젝트 루트(quick-start)에 pom.xml 파일을 만든다.<br />
스프링 프레임워크를 의존 라이브러리 설정에 추가할 때는<br />
http://projects.spring.io/spring-framework/에서 가장 최신 릴리스 버전을 선택한다.<br />
 
<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0
                             http://maven.apache.org/maven-v4_0_0.xsd"&gt;

  &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  &lt;groupId&gt;net.java_school&lt;/groupId&gt;
  &lt;artifactId&gt;quick-start&lt;/artifactId&gt;
  &lt;version&gt;0.0.1-SNAPSHOT&lt;/version&gt;
  &lt;packaging&gt;jar&lt;/packaging&gt;

  &lt;name&gt;quick-start&lt;/name&gt;
  &lt;url&gt;http://maven.apache.org&lt;/url&gt;

  &lt;properties&gt;
    &lt;project.build.sourceEncoding&gt;UTF-8&lt;/project.build.sourceEncoding&gt;
  &lt;/properties&gt;

  &lt;dependencies&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;junit&lt;/groupId&gt;
      &lt;artifactId&gt;junit&lt;/artifactId&gt;
      &lt;version&gt;3.8.1&lt;/version&gt;
      &lt;scope&gt;test&lt;/scope&gt;
    &lt;/dependency&gt;<strong>
    &lt;dependency&gt;
        &lt;groupId&gt;org.springframework&lt;/groupId&gt;
        &lt;artifactId&gt;spring-context&lt;/artifactId&gt;
        &lt;version&gt;4.1.4.RELEASE&lt;/version&gt;
    &lt;/dependency&gt;
  &lt;/dependencies&gt;
  </strong>
&lt;/project&gt;
</pre>

스프링은 빈을 관리하는 빈 컨테이너 기능이 핵심이다.<br />
빈 컨테이너를 기반으로 많은 프로젝트가 발전하고 있다.<br />
지금의 예제는 스프링의 핵심인 빈 컨테이너의 기능에 대해 알아보는 예제이다.<br />
예제를 위해 pom.xml에는 spring-context를 의존성 설정에 추가한다.<br />
메이븐은 빌드 툴로서 많은 기능을 내포하고 있는데, 그 기능 중 지금 예제에서 우리가 알아야 할 기능은 의존성 관리 기능이다.<br />
메이븐의 의존성 관리 기능은 프로젝트가 A라는 라이브러리에 의존하는데 A는 B라는 라이브러리에 의존한다면,
A만의 의존성 설정으로 A뿐 아니라 B 역시 저장소에 저장한다.<br />
spring-context 만을 의존성 설정에 추가했더라도 spring-context 가 의존하는 다른 라이브러리 역시 저장소에 저장된다.
예제를 진행하면서 확인할 수 있다.<br />
명령 프롬프트를 연다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\maven\quick-start\src\main\java\hello&gt;notepad MessageService.java
</pre>

열린 메모장에 아래 코드를 복사하여 저장한 후 메모장을 닫는다.<br />
 
<em class="filename">MessageService.java</em>
<pre class="prettyprint">
package hello;

public interface MessageService {
    String getMessage();
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\maven\quick-start\src\main\java\hello&gt;notepad MessagePrinter.java
</pre>

열린 메모장에 아래 코드를 복사하여 저장한 후 메모장을 닫는다.<br />

<em class="filename">MessagePrinter.java</em>
<pre class="prettyprint">
package hello;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MessagePrinter {

    @Autowired
    private MessageService service;

    public void printMessage() {
        System.out.println(this.service.getMessage());
    }
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\maven\quick-start\src\main\java\hello&gt;notepad Application.java
</pre>

열린 메모장에 아래 코드를 복사하여 저장한 후 메모장을 닫는다.<br />

<em class="filename">Application.java</em>
<pre class="prettyprint">
package hello;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.*;

@Configuration
@ComponentScan
public class Application {

    @Bean
    MessageService mockMessageService() {
        return new MessageService() {
            public String getMessage() {
              return "Hello World!";
            }
        };
    }

  public static void main(String[] args) {
      ApplicationContext context = 
          new AnnotationConfigApplicationContext(Application.class);
      MessagePrinter printer = context.getBean(MessagePrinter.class);
      printer.printMessage();
  }
}
</pre>

mvn compile로 빌드에 성공했다면 프로젝트 루트에서 다음과 실행하여 결과를 확인한다.<br />
<em class="path">mvn exec:java -Dexec.mainClass=hello.Application</em><br />
<br />
이 예제는 DI의 기본적인 예제이다.<br />
MessagePrinter는 MessageService 구현체와 결합되어 있지 않다.<br />
스프링 프레임워크가 묶어주고 있다.<br />
<br />
만일 mvn compile 이 실패했고, 실패 메시지 중에 "annotations are not supported in -source 1.3" 문장이 있다면
pom.xml 파일을 열고 &lt;/project&gt; 바로 위에 다음을 추가한다.<br />

<pre class="prettyprint">
&lt;build&gt;
    &lt;finalName&gt;quick-start&lt;/finalName&gt;
    &lt;pluginManagement&gt;
        &lt;plugins&gt;
            &lt;plugin&gt;
                &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
                &lt;version&gt;3.0&lt;/version&gt;
            &lt;/plugin&gt;
        &lt;/plugins&gt;
    &lt;/pluginManagement&gt;
&lt;/build&gt;
</pre>
 
테스트 실행까지 확인했다면 메이븐의 로컬 저장소에 저장된 어떤 라이브러리가 저장되었는지 확인한다.<br />
참고로 메이븐의 로컬 저장소는 사용자 폴더 안의 .m2 폴더이다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\Users\kim\.m2\repository\org\springframework&gt;cd
C:\Users\kim\.m2\repository\org\springframework

C:\Users\kim\.m2\repository\org\springframework&gt;dir /w

[spring-aop]  [spring-beans]  [spring-context]  [spring-core]  

[spring-expression]

</pre>

spring-context 만 의존성 설정을 했으나 aop beans core expression 도 설치된 것을 확인할 수 있다.<br />
이는 메이븐의 의존성 전이 기능 때문이다.<br />
context 가 의존하는 라이브러리도 저장소에 설치된다.<br />
<br />
여기까지가 스프링 공식 사이트의 "시작하기"에 관한 내용이다.<br />
이후 스프링은 아래 순서로 진행한다.<br />

<ol>
	<li>Spring DI</li>
	<li>Spring AOP</li>
	<li>Spring JDBC</li>
	<li>Spring 트랜잭션</li>
	<li>Spring MVC</li>
	<li>Spring Security</li>
	<li>빈 유효성 검사</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://spring.io/guides/gs/maven/">Building Java Projects with Maven</a></li>
	<li><a href="http://projects.spring.io/spring-framework/#quick-start">http://projects.spring.io/spring-framework/#quick-start</a></li>
<!-- 	
	<li><a href="http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/">http://static.springsource.org/spring/docs/current/spring-framework-reference/pdf/</a></li>
	<li><a href="http://www.springsource.org/download/community">http://www.springsource.org/download/community</a></li>
	<li><a href="http://www.springframework.org/schema/beans/">http://www.springframework.org/schema/beans/</a></li> 
-->
</ul>

