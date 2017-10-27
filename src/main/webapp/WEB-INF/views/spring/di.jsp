<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div id="last-modified">Last Modified : 2015.6.4</div>

<h1>Spring DI(종속객체 주입)</h1>

워크스페이스가 <em class="path">C:\java</em>라고 가정한다.<br />
명령 프롬프트로 <em class="path">C:\java</em>로 이동한다.<br />

<h2>명령 프롬프트에서 메이븐 프로젝트 생성</h2>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java&gt;<span class="prompt-selection">mvn archetype:generate</span>

Choose a number or apply filter 
    (format: [groupId:]artifactId, case sensitive contains): 607: 
    <span class="prompt-selection">maven-archetype-quickstart</span>

Choose a number or apply filter 
    (format: [groupId:]artifactId, case sensitive contains): 1:

Choose org.apache.maven.archetypes:maven-archetype-quickstart version: 
1: 1.0-alpha-1
2: 1.0-alpha-2
3: 1.0-alpha-3
4: 1.0-alpha-4
5: 1.0
6: 1.1
Choose a number: 6: 
Define value for property 'groupId': : <span class="prompt-selection">net.java_school</span>
Define value for property 'artifactId': : <span class="prompt-selection">bank</span>
Define value for property 'version':  1.0-SNAPSHOT: : 
Define value for property 'package':  net.java_school: : 
Confirm properties configuration:
groupId: net.java_school
artifactId: bank
version: 1.0-SNAPSHOT
package: net.java_school
 Y: : 
</pre>

<h2>소스 코드 복사</h2>
<a href="/jdbc/JavaBank">자바은행</a>에서 작성한 소스를 복사하여 다음과 같이 붙여넣는다.

<pre class="code">C:\java\bank
   └── src
        └── main
             └── java
                  └── net
                       └── java_school
                               └── bank: Account.java
                                         Bank.java
                                         BankDao.java
                                         BankUi.java
                                         ShinhanBank.java
                                         ShinhanBankDao.java
                                         Transaction.java
</pre>

자바 소스에서 다음 부분을 수정한다.

<em class="filename">ShinahanBank.java</em>
<pre class="prettyprint">
private BankDao dao;

public void setDao(BankDao dao) {
    this.dao = dao;
}
</pre>

<em class="filename">BankUi.java</em>
<pre class="prettyprint">
//..중간 생략..

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

//..중간 생략..

private Bank bank;

public void setBank(Bank bank) {
    this.bank = bank;
}

//..중간 생략..

public static void main(String[] args) throws Exception {
	ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
	BankUi ui = (BankUi) ctx.getBean("bankUi");
	ui.startWork();
}

</pre>


resources 폴더를 만들고 <a href="/java/Logging#logback-xml-javabank">로깅</a>에서 logback.xml 파일을 복사하여 붙여넣는다.<br />
applicationContext.xml 파일을 만든다.<br />

<pre class="code">C:\java\bank
   └── src
        └── main
             └── java
             └── resources: logback.xml
                            applicationContext.xml
                     
</pre>

<em class="filename">applicationContext.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd"&gt;

    &lt;bean id="bankUi" class="net.java_school.bank.BankUi"&gt;
        &lt;property name="bank" ref="shinhanBank" /&gt;
    &lt;/bean&gt;
    
    &lt;bean id="shinhanBank" class="net.java_school.bank.ShinhanBank"&gt;
        &lt;property name="dao" ref="shinhanBankDao" /&gt;
    &lt;/bean&gt;

    &lt;bean id="shinhanBankDao" class="net.java_school.bank.ShinhanBankDao"&gt;
    &lt;/bean&gt;

&lt;/beans&gt;
</pre>

ojdbc6.jar 파일을 로컬 저장소에 저장한다.<br />
ojdbc6.jar 파일이 있는 디렉토리로 이동한 후에, 명령 프롬프트에서 아래를 실행한다.<br>

<pre>mvn install:install-file -Dfile=ojdbc6.jar -DgroupId=com.oracle ^
-DartifactId=ojdbc6 -Dversion=11.2.0.2.0 -Dpackaging=jar -DgeneratePom=true
</pre>
pom.xml 파일을 아래와 같이 수정한다.<br />

<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
                        http://maven.apache.org/xsd/maven-4.0.0.xsd"&gt;
                        
  &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  &lt;groupId&gt;net.java_school&lt;/groupId&gt;
  &lt;artifactId&gt;bank&lt;/artifactId&gt;
  &lt;version&gt;1.0-SNAPSHOT&lt;/version&gt;
  &lt;packaging&gt;jar&lt;/packaging&gt;

  &lt;name&gt;bank&lt;/name&gt;
  &lt;url&gt;http://maven.apache.org&lt;/url&gt;

  &lt;properties&gt;
    &lt;project.build.sourceEncoding&gt;UTF-8&lt;/project.build.sourceEncoding&gt;
    <strong>&lt;spring.version&gt;4.1.6.RELEASE&lt;/spring.version&gt;
    &lt;jdk.version&gt;1.7&lt;/jdk.version&gt;</strong>
  &lt;/properties&gt;

  &lt;dependencies&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;junit&lt;/groupId&gt;
      &lt;artifactId&gt;junit&lt;/artifactId&gt;
      &lt;version&gt;3.8.1&lt;/version&gt;
      &lt;scope&gt;test&lt;/scope&gt;
    &lt;/dependency&gt;
    <strong>&lt;dependency&gt;
      &lt;groupId&gt;org.slf4j&lt;/groupId&gt;
      &lt;artifactId&gt;slf4j-api&lt;/artifactId&gt;
      &lt;version&gt;1.7.12&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;ch.qos.logback&lt;/groupId&gt;
      &lt;artifactId&gt;logback-classic&lt;/artifactId&gt;
      &lt;version&gt;1.1.3&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-context&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;com.oracle&lt;/groupId&gt;
      &lt;artifactId&gt;ojdbc6&lt;/artifactId&gt;
      &lt;version&gt;11.2.0.2.0&lt;/version&gt;
    &lt;/dependency&gt;</strong>
  &lt;/dependencies&gt;
  <strong>
  &lt;build&gt;
    &lt;finalName&gt;bank&lt;/finalName&gt;
      &lt;pluginManagement&gt;
        &lt;plugins&gt;
          &lt;plugin&gt;
            &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
            &lt;version&gt;3.1&lt;/version&gt;
            &lt;configuration&gt;
              &lt;source&gt;${jdk.version}&lt;/source&gt;
              &lt;target&gt;${jdk.version}&lt;/target&gt;
              &lt;compilerArgument&gt;&lt;/compilerArgument&gt;
              &lt;encoding&gt;UTF-8&lt;/encoding&gt;
            &lt;/configuration&gt;
          &lt;/plugin&gt;
        &lt;/plugins&gt;
      &lt;/pluginManagement&gt;
  &lt;/build&gt;
  </strong>
&lt;/project&gt;
</pre>

<h2>컴파일과 실행</h2>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">C:\java\bank&gt;<span class="prompt-selection">mvn clean compile</span>

C:\java\bank&gt;<span class="prompt-selection">mvn exec:java -Dexec.mainClass=net.java_school.bank.BankUi</span>
</pre>

<h2>이클립스 작업환경 구축</h2>
이클립스를 시작하고 워크스페이스를 <em class="path">C:\java</em>로 선택한다.<br />
Project Explorer 뷰에서 마우스 오른쪽 버튼을 사용하여 컨텍스트 메뉴를 보이게 한다.<br />
Import를 사용하여 spring-bbs 프로젝트를 이클립스로 불러온다.<br />

<img alt="컨텍스트 메뉴에서 Import" src="https://lh3.googleusercontent.com/-VjWpQCEiqes/VYYV3b2GPFI/AAAAAAAACh0/-KoRbgI8nn0/s590/maven-project-import.png"><br />

<img alt="이클립스에서 메이븐 프로젝트 Import" src="https://lh3.googleusercontent.com/-uDuAOI41Aj4/VYYV3Pmo4qI/AAAAAAAAChw/m4HA61kOVbE/s610/eclipse-with-maven.png"><br />

이클립스와 pom.xml을 동기화한다.<br />
Package Explorer에서 프로젝트를 선택한 상태에서 마우스 오른쪽 버튼으로 컨텍스트 메뉴를 연다.<br />
Maven - Update Project Configuration을 차례로 선택한다.<br />
이후 진행하면서 pom.xml이 바뀌면 같은 방법으로 이클립스와 동기화를 해주어야 한다.<br />