<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.8.4</div>

<h1>로깅</h1>

프로젝트에 자카르타의 commons-logging을 사용하고, 로깅 구현체로 log4j를 사용하기로 한다.<br />
<a href="http://commons.apache.org/proper/commons-logging/download_logging.cgi">http://commons.apache.org/proper/commons-logging/download_logging.cgi</a>
에서 Binary 파일을 내려받는다. <br />
또는 <a href="http://www.apache.org">http://www.apache.org</a>로 방문해서 Projects 중에 <strong>commons</strong>을 선택한다.
<a href="http://commons.apache.org">http://commons.apache.org</a>로 이동하는데 여기서 <strong>Logging</strong>을 선택하면 찾을 수 있다.<br />
압축을 풀고 commons-logging-1.2.jar 파일을 찾아 /WEB-INF/lib에 복사한다.<br />
<br />
log4j 바이너리 파일을 내려받는다.<br /> 
<a href="http://logging.apache.org/log4j/1.2/download.html">http://logging.apache.org/log4j/1.2/download.html</a><br />
압축을 풀고 log4j-1.2.17.jar 파일을 찾아 /WEB-INF/lib에 복사한다.<br />
<br /> 
log4j 설정 파일을 작성한다.<br />
아래 내용으로 log4j.xml 이름으로 /WEB-INF/classes에 복사한다.<br />
이클립스에서 작업한다면 src 폴더에 log4j.xml 파일을 만들면 자동으로 /WEB-INF/classes에 log4j.xml 파일이 만들어진다.<br /> 

<em class="filename">log4j.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8" ?&gt;
&lt;!DOCTYPE log4j:configuration SYSTEM "log4j.dtd" &gt;
&lt;log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/"&gt;
    &lt;appender name="console" class="org.apache.log4j.ConsoleAppender"&gt;
        &lt;layout class="org.apache.log4j.SimpleLayout"/&gt;
    &lt;/appender&gt;
	
    &lt;appender name="file" 
    	class="org.apache.log4j.DailyRollingFileAppender"&gt;
        &lt;param name="File" 
        	value="<strong>C:/www/JSPProject/WebContent/WEB-INF/debug.log"</strong> /&gt;
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

자카르타 commons-logging 설정 파일을 만든다.<br />
commons-logging.properties라는 파일을 아래 내용으로 만들고 WEB-INF/classes에 복사한다.<br />
이클립스에서 작업한다면 src 폴더에 파일을 복사한다.<br />

<em class="filename">commons-logging.properties</em>
<pre class="prettyprint">
org.apache.commons.logging.Log = org.apache.commons.logging.impl.Log4JLogger
</pre>

<h3>로깅 테스트</h3>
아래 예제는 웹 애플리케이션이 아닌 일반 자바 파일이다.<br />
따라서 콘솔에 출력하는 로그 메시지를 톰캣의 로그 파일에서 찾으려 해서는 안 된다.<br />
이클립스에서 테스트하면 Console 뷰에 로그가 출력된다.<br />
/WEB-INF/debug.log 파일에도 로그가 쌓인다.<br />

<em class="filename">LogTest.java</em>
<pre class="prettyprint">
package net.java_school.logtest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class LogTest {
	private Log log = LogFactory.getLog(LogTest.class);
	// 또는 private Log log = LogFactory.getLog(this.getClass());
	
	public void x() {
		if (log.isDebugEnabled()) {
			log.debug("debug message");
		}
	}
  
	public static void main(String[] args) {
		LogTest test = new LogTest();
		test.x();
	}
}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="/java/Logging">http://www.java-school.net/java/Logging.php</a></li>
	<li><a href="http://seosh81.info/?tag=common-logging">http://seosh81.info/?tag=common-logging</a></li>
	<li><a href="http://www.hanb.co.kr/network/view.html?bi_id=668">http://www.hanb.co.kr/network/view.html?bi_id=668</a></li>
</ul>

