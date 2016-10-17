<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.6.1</div>
	
<h1>로깅(Logging)</h1>

로그(Log)란 프로그램 개발이나 운영 시 발생하는 문제점을 추적하거나 운영 상태를 모니터링하기 위한 텍스트이다.
로그를 남기기 위한 가장 쉬운 방법은 System.out.println(); 문을 사용하는 것이다.
좀 더 향상된 방법은 로그를 기록하는 클래스를 만들어 사용하는 것이다.

<em class="filename">Log.java</em>
<pre class="prettyprint">
package net.java_school.util;

import java.io.*;
import java.util.Date;

public class Log {
  String logFile = "C:/debug.log";
  FileWriter fw;
  static final String ENTER = System.getProperty("line.separator");
  
  public Log() {
    try {
      fw = new FileWriter(logFile, true);
    } catch (IOException e){}
  }

  public void close() {
    try {
      fw.close();
    } catch (IOException e){}
  }

  public void debug(String msg) {
    try {
      fw.write(new Date()+ " : ");
      fw.write(msg + ENTER);
      fw.flush();
    } catch (IOException e) {
      System.err.println("IOException!");
    }
  }

}
</pre>

아래와 같은 파일을 만들어 테스트한다.

<em class="filename">LogTest1.java</em>
<pre class="prettyprint">
package net.java_school.logtest;

import net.java_school.util.Log;

public class LogTest1 {

	public void xxx() {
		Log log = new Log(); //출력스트림을 얻는다. 
		log.debug("로그 테스트!"); //로그 메시지 남기기
		log.close(); //출력스트림을 닫는다.
	}
  
	public static void main(String[] args) {
		LogTest1 test = new LogTest1();
		test.xxx();
	}
  
}
</pre>

<h2>log4j</h2>
직접 로깅 클래스를 만드는 것보다 로깅 프레임워크를 이용하는 것이 좋다.<br />
프레임워크란 공통적인 작업을 자동화하고, 개발자로 하여금 빨리 애플리케이션을 개발하도록 하기 위한 노력의 산물을 말한다.<br /> 
로깅에 관한 대표적인 프레임워크는 log4j이다.<br />
자바 API에서도 로깅을 위한 클래스를 제공하고 있지만 아파치 그룹의 오픈 소스인 log4j 가 현재 더 많은 호응을 받고 있다.<br /> 
log4j를 사용하기 위해서는 아래 경로에서 log4j 바이너리 파일을 다운로드한다.<br />
<a href="http://logging.apache.org/log4j/1.2/download.html">http://logging.apache.org/log4j/1.2/download.html</a><br />
압축을 푼 후 jar 파일(log4j-1.2.15.jar)을 클래스 패스로 설정되어 있는 경로에 복사하고 아래와 같은 프로퍼티 파일을 
클래스 패스로 설정되어 있는 경로에 생성한다.

<em class="filename">log4j.properties</em>
<pre class="prettyprint">
log4j.rootLogger = INFO,console
log4j.appender.console = org.apache.log4j.ConsoleAppender
log4j.appender.console.layout = org.apache.log4j.SimpleLayout
log4j.appender.file = org.apache.log4j.DailyRollingFileAppender
log4j.appender.file.File = C:/debug.log
log4j.appender.file.DatePattern = '.'yyyy-MM-dd
log4j.appender.file.layout = org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern = [%d]%5p [%t] (%F:%L) - %m%n
log4j.logger.net.java_school = DEBUG,file
</pre>

다음으로 아래와 같이 테스트를 위한 파일을 만들어 테스트해 본다.

<em class="filename">LogTest2.java</em>
<pre class="prettyprint">
package <strong>net.java_school.logtest</strong>;

import org.apache.log4j.Logger;

public class LogTest2 {
	// 로거 얻기
	private Logger log = Logger.getLogger(LogTest2.class);
	//또는 private Logger log = Logger.getLogger(this.getClass());
	
	public void xxx() {
		if (log.isDebugEnabled()) {
			log.debug("debug message");
		}
	}
	
	public void yyy() {
		if (log.isInfoEnabled()) {
			log.info("info message");
		}
	}
  
	public static void main(String[] args) {
		LogTest2 test = new LogTest2();
		test.xxx();
		test.yyy();
	}
  
}
</pre>

<em class="filename">LogTest3.java</em>
<pre class="prettyprint">
package <strong>com.google.logtest</strong>;

import org.apache.log4j.Logger;

public class LogTest3 {
	// 로거 얻기
	private Logger log = Logger.getLogger(LogTest3.class);
	//또는 private Logger log = Logger.getLogger(this.getClass());
	
	public void xxx() {
		if (log.isDebugEnabled()) {
			log.debug("debug message");
		}
	}
	
	public void yyy() {
		if (log.isInfoEnabled()) {
			log.info("info message");
		}
	}
  
	public static void main(String[] args) {
		LogTest3 test = new LogTest3();
		test.xxx();
		test.yyy();
	}
  
}
</pre>

테스트 후 콘솔과 C:/debug.log 파일에 로그 메시지를 확인한다.<br />
LogTest1.java 와 같이 파일에 로그를 남기지만 로그를 남긴 후 출력 스트림을 닫는 코드는 없다.

<h3>log4j.properties 파일의 내용 설명</h3>
log4j는 logger, appender, layout이라는 3 개의 컴포넌트로 이루어져 있고 이들이 협력하여 로그를 기록한다.<br />

<ol>
	<li>Logger : 로그의 주체(로그 파일을 작성하는 클래스)로 로깅 메시지를 Appender에 전달</li>
	<li>Appender : 전달된 로깅 메시지의 출력 대상(목적지)을 지정</li>
	<li>Layout : 어떤 형식으로 출력할 것이지를 결정</li>
</ol>

<dl class="note"> 
<dt>log4j.rootLogger = INFO,console</dt> 
<dd>
rootLogger는 최상위 로거다. 언제나 존재하고 모든 로거들 중 계층적으로 가장 위에 위치한다.<br />
루트 로거의 로그 레벨과 어펜더를 지정하고 있다.<br />
참고로, 여기서는 하나의 어펜더를 지정했지만 어펜더는 여러 개 지정할 수 있다.<br /> 
console은 사용자가 지은 어펜더 이름이다.<br />
로그 레벨은  TRACE &gt; DEBUG &gt; INFO &gt; WARN &gt; ERROR &gt; FATAL인데 INFO로 설정되었으므로 
INFO 이상인 INFO, WARN, ERROR, FATAL 은 기록된다.<br />
</dd>
<dt>log4j.appender.console = org.apache.log4j.ConsoleAppender</dt> 
<dd>
console 이란 이름의 어펜더가 실제 어떤 클래스인지를 나타내고 있다.<br />
org.apaceh.log4j.ConsoleAppdender는 로깅 메시지를 콘솔에 출력하고자 할 때 사용하는 클래스이다.<br />
log4j에서 로그 메시지가 출력될 목적지를 지정하는 것이 어펜더이다.<br />
콘솔, 파일, GUI 컴포넌트, 리모트 소켓 서버, JMS, NT Event 로거, 리모트 UNIX Syslog 데몬에 대한 어펜더가 존재한다. 
</dd>
<dt>log4j.appender.console.layout = org.apache.log4j.SimpleLayout</dt> 
<dd>
console 어펜더는 SimpleLayout으로 출력한다.<br />
</dd>
<dt>log4j.appender.file = org.apache.log4j.DailyRollingFileAppender</dt> 
<dd>
file 은 사용자가 지은 어펜더의 이름이다.<br />
file 어펜더가 org.apache.log4j.DailyRollingFileAppender 클래스임을 나타내고 있다.<br />
DailyRollingFileAppender 클래스는 로그 출력을 파일에 기록할 때 사용하는 클래스이다.<br />
</dd>
<dt>log4j.appender.file.File = C:/debug.log</dt> 
<dd> 
file 어펜더가 지정하는 출력 대상 파일의 절대 경로를 지정하고 있다.<br />
</dd>
<dt>log4j.appender.file.DatePattern = '.'yyyy-MM-dd</dt> 
<dd> 
날짜가 지난 로그는 파일명이 debug.log.2015-08-27 형식으로 저장되도록 지정하고 있다.
</dd>
<dt>log4j.appender.file.layout = org.apache.log4j.PatternLayout</dt> 
<dd> 
file 어펜더는 org.apache.log4j.PatternLayout 을 사용한다는 설정이다.<br />
PatternLayout 을 사용하면 사용자가 정한 패턴에 따라 출력되도록 설정할 수 있다.<br />
</dd>
<dt>log4j.appender.file.layout.ConversionPattern=[%d]%5p [%t] (%F:%L) - %m%n</dt> 
<dd> 
출력 패턴을 지정하고 있다.<br />
</dd>
<dt>log4j.logger.net.java_school = DEBUG,file</dt> 
<dd> 
net.java-school이라는 이름의 새로운 로거를 설정하고 있다.<br />
net.java_school 로거의 로그 레벨은 DEBUG, 어펜더는 file이다.<br />
로거 이름을 net.java_school처럼 패키지 이름으로 설정하면 net.java_school로 시작하는 패키지에 속한  
자바 클래스가 남기는 로그는 이 로거에 의해 기록된다.<br />
</dd>
</dl>

<h3>Log 처리 메시지 및 로그 레벨</h3>
<ol>
	<li>FATAL : 가장 심각한 오류, 콘솔에 출력</li>
	<li>ERROR : 일반적인 오류, 콘솔에 출력</li>
	<li>WARN : 주의를 요하는 경우, 콘솔에 출력</li>
	<li>INFO : 런타임 시 관심 있는 이벤트, 콘솔에 출력</li>
	<li>DEBUG : 시스템 흐름과 관련된 상세정보, 로그 파일로만 출력</li>
	<li>TRACE : 가장 상세한 형태의 정보, 로그 파일로만 출력</li>
</ol>

<h3>log4j Appender 주요 클래스</h3>
<ul>
	<li>ConsoleAppender : 콘솔에 로그 메시지 출력</li>
	<li>FileAppender : 파일에 로그 메시지 기록</li>
	<li>RollingFileAppender : 파일에 로그 메시지 기록하고, 파일 크기가 일정 수준 이상이 되면 다른 이름의 새 파일을 생성하고 기록</li>
	<li>DailyRollingFileAppender : 파일에 로그 메시지 기록하고, 하루 단위로 로그 파일을 변경해서 기록</li>
	<li>SMTPAppender : 로그 메시지를 이메일로 전송</li>
	<li>NTEventAppender : 윈도 시스템 이벤트 로그로 메시지 전송</li>
</ul>

<h3>log4j Layout 클래스</h3>
<ul>
	<li>DateLayout : 로그 메시지를 날짜 중심으로 간단하게 기록</li>
	<li>HTMLLayout : 로그 메시지를 HTML 형식으로 기록</li>
	<li>PatternLayout : 로그 메시지를 사용자 정의 패턴에 따라 기록</li>
	<li>SimpleLayout : 레벨-메시지 형식의 가장 간단하게 로그 기록</li>
	<li>XMLLayout : 로그 메시지를 XML 형식으로 기록</li>
</ul>

<h3>log4j PatternLayout 형식</h3>
<ul>
	<li>%c : 카테고리를 출력</li>
	<li>%p : 로깅 레벨을 출력</li>
	<li>%m : 로그 내용</li>
	<li>%d : 로깅 이벤트가 발생한 시간, yyyy-MM-dd, HH:mm:ss 등 시간 형식을 사용</li>
	<li>%t : 로깅 이벤트를 발생한 스레드의 이름</li>
	<li>%n : 개행</li>
	<li>%C : 클래스 이름</li>
	<li>%F : 로깅이 발생한 파일 이름</li>
	<li>%I : 로깅이 발생한 호출자 정보</li>
	<li>%L : 로깅이 발생한 라인수</li>
	<li>%M : 로깅이 발생한 메서드 이름</li>
	<li>%r : 애플리케이션 시작 이후부터 로깅이 발생한 시점의 시간</li>
	<li>%x : 로깅이 발생한 스레드와 관련된 NDC(Nested Diagnostic Context) </li>
	<li>%X : 로깅이 발생한 스레드와 관련된 MDC(Mapped Diagnostic Context)</li>
</ul>

<h3>log4.xml</h3>
log4j.properties 대신 log4j.xml을 설정 파일로 사용하는 방법을 알아본다.<br />
log4j.properties 파일을 지우고 log4j.xml 파일을 클래스 패스가 걸려있는 경로에 생성한다.<br />

<em class="filename">log4.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8" ?&gt;
&lt;!DOCTYPE log4j:configuration SYSTEM "log4j.dtd" &gt;
&lt;log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/"&gt;
    &lt;appender name="console" class="org.apache.log4j.ConsoleAppender"&gt;
        &lt;layout class="org.apache.log4j.SimpleLayout"/&gt;
    &lt;/appender&gt;
	
    &lt;appender name="file" class="org.apache.log4j.DailyRollingFileAppender"&gt;
        &lt;param name="File" value="C:/debug.log" /&gt;
        &lt;param name="datePattern" value="'.'yyyy-MM-dd" /&gt;
        &lt;layout class="org.apache.log4j.PatternLayout"&gt;
            &lt;param name="ConversionPattern"
                value="[%d]%5p [%t] (%F:%L) - %m%n"/&gt;
        &lt;/layout&gt;
    &lt;/appender&gt;
    
    &lt;logger name="net.java_school"&gt;
        &lt;level value="DEBUG"/&gt;
        &lt;appender-ref ref="file"/&gt;
    &lt;/logger&gt;
    
    &lt;root&gt;
        &lt;level value="INFO"/&gt;
        &lt;appender-ref ref="console"/&gt;
    &lt;/root&gt;

&lt;/log4j:configuration&gt;
</pre>

LogTest2.java, LogTest3.java를 다시 실행하여 테스트한다.

<h2>자카르타 Commons 로깅</h2>
아파치 그룹의 자카르타 commons-logging 패키지는 개발자들에게 공통 로깅 API를 제공하기 위해 만들어진 프레임워크로 
애플리케이션이 특정 로깅 프레임워크에 종속되는 것을 막아준다.<br />
현재 많은 서드 파티 로깅 프레임워크들이 commons-logging 기반으로 구현되어 있다.<br />

<h3>commons-logging 사용법</h3>
<a href="http://commons.apache.org/downloads/download_logging.cgi">http://commons.apache.org/downloads/download_logging.cgi</a>에서 
Binary 파일을 다운로드한다.<br />
위 링크가 깨진다면 <a href="http://www.apache.org">http://www.apache.org</a>에서 
<strong>commons</strong> 선택하고 <a href="http://commons.apache.org">http://commons.apache.org</a>에서 
<strong>Logging</strong>을 선택하면 다운로드 경로를 찾을 수 있다.<br />
다운로드하고 압축을 풀면 서브 폴더에 commons-logging-1.1.1.jar 파일이 있을 것이다.<br />
이 파일을 클래스 패스 경로에 복사한다.<br /> 
commons-logging 은 자체적으로 로깅을 지원한다기보다는 여러 로깅 API를 표준화된 방법으로 사용할 수 있게 해주는 개념이기 때문에,
실제 로깅 처리를 위한 별도의 로깅 구현체가 필요하다.<br /> 
여기서는 로깅 구현체로 log4j를 사용하는 방법을 제시한다.<br />
아래 프로퍼티 파일을 클래스 패스 경로에 만들어 놓는다.

<em class="filename">commons-logging.properties</em>
<pre class="prettyprint">
org.apache.commons.logging.Log = org.apache.commons.logging.impl.Log4JLogger
</pre>
아래와 같은 테스트 파일을 만들어 테스트해 본다.<br />
실습을 위해선 먼저 commons-logging-1.1.1.jar 파일이 클래스 패스에 있어야 함을 주의한다.<br />

<em class="filename">LogTest4.java</em>
<pre class="prettyprint">
package net.java_school.logtest;

/* 이 부분이 log4j를 단독으로 사용할 때와 다르다 */
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class LogTest4 {
	// 로거 얻기 역시 log4j를 단독으로 사용할 때와 다르다 
	private Log log = LogFactory.getLog(LogTest4.class);
	// 또는 private Log log = LogFactory.getLog(this.getClass());
	
	public void xxx() {
		if (log.isDebugEnabled()) {
			log.debug("debug message");
		}
	}
	
	public void yyy() {
		if (log.isInfoEnabled()) {
			log.info("info message");
		}
	}
  
	public static void main(String[] args) {
		LogTest4 test = new LogTest4();
		test.xxx();
		test.yyy();
	}
  
}
</pre>



<h2>slf4j</h2>
간단한 사용법을 소개한다.<br />
<a href="http://www.slf4j.org/download.html">http://www.slf4j.org/download.html</a>에서 최신 릴리스 버전을 다운로드한다.<br />
압축을 풀고 slf4j-api-1.7.12.jar 와 slf4j-simple-1.7.12.jar 파일을 클래스 패스에 추가한다.<br />
다음 에제를 작성하여 테스트한다.<br />

<pre class="prettyprint">
package net.java_school.bank;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Test {
	
	public static void main(String[] args) {
		Logger logger = LoggerFactory.getLogger(Test.class);
		int amount = 1000;
		int balance = 10000;
		logger.info("amount: {}, balance: {}",amount,balance);
	}

}
</pre>

slf4j의 디폴트 레벨은 info이다.<br />
로깅 레벨을 debug로 변경하려면 클래스 패스에 simplelogger.properties 파일을 아래 내용으로 만든다.<br />

<em class="filename">simplelogger.properties</em>
<pre class="prettyprint">
org.slf4j.simpleLogger.defaultLogLevel=DEBUG
</pre>

<h3>로깅 적용</h3>
slf4j-api-1.7.12.jar 와 slf4j-simple-1.7.12.jar 파일을 자바은행 클래스 패스에 추가한다.<br />
Account, NormalAccount, MinusAccount 클래스의 입금과 출금 메서드에 로깅을 적용한다.<br />

<em class="filename">Account.java</em>
<pre class="prettyprint">
package net.java_school.bank;

//..중간 생략..
<strong>
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
</strong>
public abstract class Account implements Serializable {
	<strong>Logger logger = LoggerFactory.getLogger(Account.class);</strong>
	
	//..중간 생략..
	
	public synchronized void deposit(long amount) {
		balance = balance + amount;
		Transaction transaction = new Transaction();
		Calendar cal = Calendar.getInstance();
		Date date = cal.getTime();
		transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
		transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
		transaction.setAmount(amount);
		transaction.setKind(DEPOSIT);
		transaction.setBalance(balance);
		transactions.add(transaction);
		<strong>logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{} NORMAL/MINUS:{}", 
			this.accountNo, amount, Account.DEPOSIT, this.kind);</strong>
	}
	
	//..중간 생략..

}
</pre>

<em class="filename">NormalAccount.java</em>
<pre class="prettyprint">
@Override
public synchronized void withdraw(long amount) {
	if (amount &gt; balance) {
		throw new InsufficientBalanceException("잔액이 부족합니다.");
	}
	balance = balance + amount;
	Transaction transaction = new Transaction();
	Calendar cal = Calendar.getInstance();
	Date date = cal.getTime();
	transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
	transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
	transaction.setAmount(amount);
	transaction.setKind(Account.WITHDRAW);
	transaction.setBalance(balance);
	transactions.add(transaction);
	<strong>logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{} NORMAL/MINUS:{}", 
		this.getAccountNo(), amount, Account.WITHDRAW, this.getKind());</strong>
}
</pre>

<em class="filename">MinusAccount.java</em>
<pre class="prettyprint">
@Override
public synchronized void withdraw(long amount) {
	balance = balance - amount;
	Transaction transaction = new Transaction();
	Calendar cal = Calendar.getInstance();
	Date date = cal.getTime();
	transaction.setTransactionDate(Account.DATE_FORMAT.format(date));
	transaction.setTransactionTime(Account.TIME_FORMAT.format(date));
	transaction.setAmount(amount);
	transaction.setKind(Account.WITHDRAW);
	transaction.setBalance(balance);
	transactions.add(transaction);
	<strong>logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{} NORMAL/MINUS:{}", 
		this.getAccountNo(), amount, Account.WITHDRAW, this.getKind());</strong>
}
</pre>

로그 메시지를 콘솔이 아닌 파일에 출력하기를 원한다면 simplelogger.properties에 아래 설정을 추가한다.<br />

<em class="filename">simplelogger.properties</em>
<pre class="prettyprint">
<strong>org.slf4j.simpleLogger.logFile=C:/java/Bank/javaBank.log</strong>
org.slf4j.simpleLogger.defaultLogLevel=DEBUG
</pre>

simpleLogger는 로그 파일에 로그 메시지를 축적하지 못한다.<br />

<h3>logback</h3>
<a href="http://logback.qos.ch/download.html">http://logback.qos.ch/download.html</a>에서 최신 버전을 내려받는다.<br />
압축을 풀고 logbac-core-1.1.3.jar, logbac-classic-1.1.3.jar, logbac-access-1.1.3.jar 파일을 클래스 패스에 추가한다.<br />
아래 그림을 보고 순서를 조절한다. logback이 slf4j보다 위에 있어야 한다.<br />
<img src="https://lh3.googleusercontent.com/-ZAS5fGPg_Hg/VWveGI3mWfI/AAAAAAAACKE/kflfJ7DC4lc/s590/logback-slf4j-order.png" alt="logback slf4j order" /><br /> 
클래스 패스에 logback.xml 파일을 만든다.<br />

<em class="filename" id="logback-xml-javabank">logback.xml</em>
<pre class="prettyprint">
&lt;configuration&gt;
    &lt;appender name="FILE" class="ch.qos.logback.core.FileAppender"&gt;
        &lt;file&gt;javabank.log&lt;/file&gt;
        &lt;encoder&gt;
            &lt;pattern&gt;%date %level [%thread] %logger{10} [%file:%line] %msg%n&lt;/pattern&gt;
        &lt;/encoder&gt;
    &lt;/appender&gt;

    &lt;appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender"&gt;
        &lt;!-- encoders are assigned the type
            ch.qos.logback.classic.encoder.PatternLayoutEncoder by default --&gt;
        &lt;encoder&gt;
            &lt;pattern&gt;%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n&lt;/pattern&gt;
        &lt;/encoder&gt;
    &lt;/appender&gt;

    &lt;root level="debug"&gt;
        &lt;appender-ref ref="FILE" /&gt;
        &lt;appender-ref ref="STDOUT" /&gt;
    &lt;/root&gt;
&lt;/configuration&gt;
</pre> 

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.slf4j.org/">http://www.slf4j.org/</a></li>
	<li><a href="http://www.slf4j.org/api/org/slf4j/impl/SimpleLogger.html">http://www.slf4j.org/api/org/slf4j/impl/SimpleLogger.html</a></li>
	<li><a href="http://logback.qos.ch/manual/configuration.html">http://logback.qos.ch/manual/configuration.html</a></li> 
</ul>