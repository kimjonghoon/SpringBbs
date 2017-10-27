<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2009.9.19</div>

<h1>Tomcat 설치</h1>

<p style="clear: both;">
JSP 개발을 위한 환경 설정에 관한 글입니다.<br />
테스트에 성공한 프로그램 버전은 아래와 같습니다.<br />
</p>
<ol>
	<li>Apache : Apache HTTP Server 2.0.63 <a href="http://httpd.apache.org/download.cgi"><strong>Download</strong></a></li>
	<!--<li>Ant : apache-ant-1.6.2-bin.zip</li>-->
	<li>Tomcat : apache-tomcat-5.5.27.exe <a href="http://tomcat.apache.org/download-55.cgi"><strong>Download</strong></a></li>
	<li>Tomcat-connectors : mod_jk-1.2.27-httpd-2.0.63.so <a href="http://apache.hoxt.com/tomcat/tomcat-connectors/jk/binaries/win32/"><strong>Download</strong></a></li>
</ol>	
<h3>1. Apache 설치</h3>
<p>
위 링크에서 Apache HTTP Server 2.0.63 이나 Apache HTTP Server 2.0.5x 대의 최신 버전을 다운로드하여 설치를 시작합니다.<br />
2.2 버전 역시 Tomcat 과 연동할 수 있습니다.<br />
2.2 버전의 연동 방법은 아래 문서와 기본적인 내용은 같습니다.<br />
(만약 IIS서버가 가동중인 환경에서는 IIS를 가동을 중단하고 설치해야 합니다.)
</p>
<h5>(1) Server Information</h5>
<p>
Apache 설치 위저드의 첫번째 화면에서 서버의 정보를 기입합니다.<br />
개발용 테스트 웹서버로 사용할 것이므로 아래 그림처럼<br />
Network Domain 에 localhost<br />
Server Name 에 localhost<br />
Administrator's Email Address 에는 자신의 이메일을 입력합니다.<br />

<img src="https://lh4.googleusercontent.com/-lWOH4yRalC8/TjJJavunq5I/AAAAAAAAAWg/mBb_cIHfJRk/1.gif" alt="Server Information" />

</p>
<h5>(2) Setup Type</h5>
<p>
설치중 디폴트로 설치하지 말고 Custom 을 선택합니다.<br />

<img src="https://lh3.googleusercontent.com/-WfNJDFfJl-w/TjJJa6-VoSI/AAAAAAAAAWo/tVtK-6Qyy_4/2.gif" alt="Setup Type" />

</p>
<h5>(3) Custom Setup</h5>
<p>
Change 를 눌러 설치 디렉토리를 변경합니다.<br />

<img src="https://lh4.googleusercontent.com/-IrjnjJo_sRU/TjJJasTj1MI/AAAAAAAAAWk/82O04NCUQbg/3.gif" alt="Custom Setup" />

</p>
<h5>(3)-1 Change Current Destination Folder</h5>
<p>
아래 그림처럼 선택했다면 C:\apps 가 Apache가 설치될 폴더입니다.<br />
2.0 버전대의 Apache는 C:\apps 에 Apache2 라는 폴더가 자동으로 만들어지면서 그 안에 설치가 됩니다.<br />
따라서 C:\apps 에 Apache를 위한 디렉토리를 따로 만들지 않아도 됩니다.<br />

<img src="https://lh4.googleusercontent.com/-J_E6ttdswlI/TjJJazJuXTI/AAAAAAAAAWs/a71pX9Mzi6w/4.gif" alt="Change Current Destination Folder" />

</p>
<h5>(3)-2</h5>
<p>
설치 폴더를 결정했으면 Next &gt; 를 클릭합니다.<br />

<img src="https://lh4.googleusercontent.com/-s--JFnr6IKY/TjJJbNSZWUI/AAAAAAAAAWw/_JKBqrZwBoU/5.gif" alt="Change Current Destination Folder" />

</p>
<h5>(4) Installing Apache HTTP Server</h5>
<p>
설치가 진행됩니다<br />
설치중 중간에 명령 프롬프트가 보이면 일부러 명령 프롬프트를 닫지 마세요<br />

<img src="https://lh3.googleusercontent.com/-sbiMZ1ua3jU/TjJJbEE0UVI/AAAAAAAAAW0/rlzIdEt-gDQ/6.gif" alt="Installing Apache HTTP Server 2.0.xx" />

</p>
<h5>(5) 테스트</h5>
<p>
설치가 완료되면 시스템 트레이 메뉴에 Apache Monitor 를 볼 수 있습니다.<br />
웹브라우저에서 http://localhost 로 방문하여 아래 페이지가 보이는지 확인합니다.<br />

<img src="https://lh6.googleusercontent.com/-4LnsQWQrFcs/TjJJbX-mqFI/AAAAAAAAAW4/HODWQx19yIs/7.gif" alt="Apache Test" />

</p>
<h5>(6) 작업 디렉토리 생성 및 DocumentRoot 변경</h5>
<p>
설치과정에서 설치 폴더를 C:\apps 라고 선택했다면 C:\apps 폴더에 Apache2 라는 서브 폴더가 만들어지고 
이 곳에 Apache가 설치 됩니다.<br />
Apache 설정파일은 C:\apps\Apache2\conf\httpd.conf 에 있습니다.<br />
앞으로 예제를 위한 작업 디렉토리는 C:\www\myproject 입니다.<br />
C:\www\myproject 라는 디렉토리를 만든 다음 아래와 같이 httpd.conf 를 수정합니다.
</p>
<h4>httpd.conf</h4>
<pre>
.. 
228줄
DocumentRoot <span class="emphasis">"C:/www/myproject"</span>
...
253줄
&lt;Directory <span class="emphasis">"C:/www/myproject"</span>&gt;
...
</pre>
<!-- 
<h4>DefaultLanguage</h4>
<p>
한글사이트이므로 DefaultLanguage ko 로 변경합니다.
</p>

<h4>LanguagePriority</h4>
<p>
LanguagePriority 항목은 ko 가 제일 먼저 나오도록 변경합니다.
</p>
 -->
<h3>2. Tomcat 설치</h3>
<p>
Tomcat 5.5 버전 중 최신버전을 설치하도록 합니다.<br />
5.5 버전 부터는 JDK 1.5 이상이 설치되어 있어야 합니다.
</p>
<h5>(1) Setup Wizard</h5>

<img src="https://lh5.googleusercontent.com/-73NA0IA-7Aw/TjJIzIrKofI/AAAAAAAAAVA/j1wclRs1Rqc/01.gif" alt="Setup Wizard" /><br />

<h5>(2) License agreement</h5>

<img src="https://lh6.googleusercontent.com/-VjhPeaHgQkM/TjJIy0gg0NI/AAAAAAAAAU8/Dqp5R07Y8iw/02.gif" alt="License agreement" /><br />

<h5>(3) Choose Components</h5>
<p>
디폴트로 두고 Next 를 클릭합니다.<br />

<img src="https://lh3.googleusercontent.com/-1oRxxH4PfSE/TjJIzKjcTnI/AAAAAAAAAVE/DU3jMsyr08A/03.gif" alt="Choose Components" />

</p>
<h5>(4) Choose Install Location</h5>
<p>
Tomcat 이 설치되는 디렉토리를 선택합니다.<br />
관리의 편의성을 위해 설치 디렉토리를 C:\apps 로 되도록 합니다.<br />
( Apache 는 C:\apps\Apache2 에 설치되어 있습니다. )<br />
Browse... 를 클릭합니다.<br />

<img src="https://lh4.googleusercontent.com/-e23DCvJC4Oc/TjJIzIq9xZI/AAAAAAAAAVI/BHxpYsLVeU0/04.gif" alt="Choose Install Location" />

</p>
<h5>(4)-1 설치 디렉토리 찾기 </h5>
<p>
Apache가 설치되어 있는 C:\apps 폴더를 선택합니다.<br />

<img src="https://lh6.googleusercontent.com/-yInNuw9C8Ac/TjJIzeGmZdI/AAAAAAAAAVM/4dspNh4a_Sc/04_1.gif" alt="Select the folder to install Apache Tomcat in:" />

</p>
<h5>(4)-2 설치 디렉토리 확인 </h5>
<p>
C:\apps 를 선택하면 설치 위저드가 C:\apps\Tomcat 5.5 에 Tomcat를 설치한다고 나타냅니다.<br />

<img src="https://lh6.googleusercontent.com/-9sBDZY4ToD0/TjJIzrSNLWI/AAAAAAAAAVQ/zEGf5BDKilg/04_2.gif" alt="Choose Install Location" /><br />

아래와 같이 설치 디렉토리를 <em>C:\apps\tomcat</em> 로 고치고 Next를 클릭합니다.<br />

<img src="https://lh5.googleusercontent.com/-A_1zwh5JF0k/TjJIzuMk2ZI/AAAAAAAAAVU/5-kftQ5k7uc/04_3.gif" alt="Choose Install Location" />

</p>
<h5>(5) Configuration </h5>
<p>
Http/1.1 Connector Port 는 디폴트 값이 8080 입니다.<br />
만약 8080 포트를 다른 프로그램이 사용하고 있다면 여기서 다른 포트 번호를 부여합니다.<br />
Tomcat admin 의 비밀번호를 부여합니다.<br />

<img src="https://lh3.googleusercontent.com/-zRKQJC4ZnC0/TjJIzvPagkI/AAAAAAAAAVY/ALAa5aPwy44/05.gif" alt="Configuration" />

</p>
<h3>(6) Java Virtual Machine path select</h3>
<p>
Java Virtual Machine 에 대한 경로를 묻고 있습니다.<br />
Java Virtual Machine 이 여러 개 설치 되어 있을 수 있습니다.
만약 사용하고 있는 JVM 버전이 아니라면 맞는 버전을 찾아 선택한 후 Next 를 클릭합니다.<br />
 
<img src="https://lh6.googleusercontent.com/-6Dt4GMfre18/TjJIz-K4pQI/AAAAAAAAAVc/VWb4uVNgn5c/06.gif" alt="Java Virtual Machine path select" />

</p>
<h5>(7) Installing</h5>

<img src="https://lh3.googleusercontent.com/-Av-_KGoHURE/TjJIz8i5ZuI/AAAAAAAAAVg/zA6la1bnPh8/07.gif" alt="Installing" /><br />

<h5>(8) Completing Apache Tomcat Setup Wizard</h5>
<p>
설치가 완료되었습니다. Finish 를 클릭합니다.<br />

<img src="https://lh6.googleusercontent.com/-Qo57TmxsOQw/TjJI0SEmzoI/AAAAAAAAAVo/nspGs1IcMhE/08.gif" alt="Completing Apache Tomcat Setup Wizard" />

</p>
<h5>(9) Tomcat Startup</h5>
<p>
Tomcat 이 startup 합니다.<br />

<img src="https://lh4.googleusercontent.com/-BD_AgmKxUKU/TjJI0WJM2dI/AAAAAAAAAVk/MYtoA3k5hpo/09.gif" alt="Tomcat Startup" />

</p>
<h5>(10) Tomcat Monitor</h5>
<p>
Tomcat이 서비스를 시작하면 시스템 트레이 메뉴에 Tomcat Monitor 아이콘이 나타납니다.<br />

<img src="https://lh4.googleusercontent.com/-_0v2b0-c3zg/TjJI0vtTM2I/AAAAAAAAAVs/yf6fyEzDRkM/10.gif" alt="Tomcat Monitor Icon" />

</p>
<h5>(11) Tomcat Properties</h5>
<p>
Tomcat Monitor 아이콘을 클릭하면 Tomcat 속성 창을 볼 수 있습니다.<br />

<img src="https://lh4.googleusercontent.com/-YXh_zZ4EzZM/TjJI0gOfOeI/AAAAAAAAAVw/aQgQtIn_TvA/11.gif" alt="Tomcat Properties" />

</p>
<h3>3. Apache Tomcat 연동</h3>
<h5>(1) ROOT 애플리케이션 변경</h5>
<p>
먼저 Tomcat 의 ROOT 애플리케이션을 Apache 웹서버 설치 후 DocumentRoot 로 설정한 C:\www\myproject 로 
변경합니다.<br />
변경 방법은 아래 파일을 C:\apps\tomcat\conf\Catalina\localhost 에 복사한 후 Tomcat 을 재시작하면 됩니다.
</p>
<h4>ROOT.xml</h4>
<pre class="brush: xml;">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="C:/www/myproject"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>
<p>
이제 myproject 란 폴더는 자바 웹 애플리케이션을 담고 있어야 합니다.<br />
자바 웹 애플리케이션은 아래와 같은 폴더 구조를 갖추어야 합니다.<br />
myproject 아래를 다음과 같은 서브 폴더를 생성합니다.
</p>
<ul>
	<li>WEB-INF</li>
	<li>WEB-INF/classes</li>
	<li>WEB-INF/lib</li>
</ul>
<p>
마지막으로 WEB-INF 폴더에는 웹 애플리케이션의 설정파일 web.xml 파일이 있어야 합니다.<br />
디폴트 ROOT 애플리케이션의 web.xml 를 myproject\WEB-INF 폴더에 복사한 후 아래와 같이 web-app 엘리먼트만 남도록 편집합니다.
</p>
<h4>web.xml</h4>
<pre class="brush: xml;">
&lt;web-app xmlns="http://java.sun.com/xml/ns/j2ee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
    http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
    version="2.4"&gt;

&lt;/web-app&gt;
</pre>
<h5>(2) mod_jk2.so 복사</h5>
<p>
Apache 웹서버 버전에 맞는 Apache Tomcat 커넥터를 설치합니다.<br />
설치한 Apache 버전이 <em>2.0.63</em> 이므로  
<a href="http://apache.hoxt.com/tomcat/tomcat-connectors/jk/binaries/win32/jk-1.2.27/">윈도우용 jk-1.2.27 Binary Releases</a> 인
mod_jk-1.2.27-httpd-<em>2.0.63</em>.so 를 다운로드 합니다.<br />
만약 위 링크가 깨졌다면 <a href="http://tomcat.apache.org/index.html">http://tomcat.apache.org/index.html</a> 에서 Downloads, Tomcat Connectors 메뉴를 이용하면 됩니다.<br />
다운로드 받은mod_jk-1.2.27-httpd-2.0.63.so 를 C:\apps\Apache2\modules 에 복사하고 이름을 mod_jk.so 라고 바꿉니다.<br />
</p>
<h5>(3) httpd.conf 파일 편집</h5>
<p>
# LoadModule foo_module modules/mod_foo.so 부분의 가장 아래에 다음 코드를 추가합니다.
</p>
<div class="codebox">
LoadModule jk_module modules/mod_jk.so<br />
JkWorkersFile conf/workers.properties<br />
JkLogFile logs/mod_jk.log<br />
JkLogLevel info
</div>
<p>
DocumentRoot 라인(DocumentRoot "C:/www/myproject") 아래에 다음을 추가합니다.
</p>
<div class="codebox">
JkMount /*.jsp tomcat1
</div>
<p>
여기서 <strong>JkMount /*.jsp tomcat1</strong> 은 클라이언트의 요청 중에 확장자가 jsp 인 것은 Tomcat 에게 처리를 
위임한다는 설정입니다.
</p>
<h5>(4) workers.properties 생성</h5>
<p>
C:\apps\Apache2\conf 디렉토리 안에 workers.properties 파일을 아래와 같이 생성합니다.
</p>
<h4>workers.properties</h4>			
<pre>worker.list=tomcat1
worker.tomcat1.port=8009
worker.tomcat1.host=localhost
worker.tomcat1.type=ajp13
</pre>
<h5>(5) 연동 테스트</h5>
<p>
Tomcat을 실행하고 Apache를 실행합니다.<br />
C:\www\myproject 폴더에 test.jsp 파일을 아래와  같은 내용으로 생성합니다.<br />
다음, myproject 폴더에 images 란 서브 폴더를 만들고 test.jpg 란 이름으로 테스트 이미지를 복사합니다.
</p>
<h4>test.jsp</h4>
<pre class="brush: java; html-script: true"> 
&lt;%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitonal.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=EUC-KR" /&gt;
&lt;title&gt;Insert title here&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;p&gt;
안녕하세요&lt;br /&gt;
&lt;img src="images/test.jpg" /&gt;
&lt;/p&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>
<p>
http://localhost/test.jsp 을 방문하여 확인합니다.<br />
Tomcat 의 ROOT 애플리케이션의 test.jsp 페이지가 보인다면 연동에 성공한 것입니다.
</p>
<!-- 
<dl class="note">
<dt>이미지가 나오지 않는 이유</dt>
<dd>
httpd.conf 설정파일에서 아래 코드를 추가했습니다.<br />
<br />
JkMount /*.jsp tomcat1<br />
JkMount /servet/* tomcat1<br />
<br />
여기서 JkMount /*.jsp tomcat1 은  클라이언트의 요청 중에 확장자가 jsp 인 것은 Tomcat 에게 처리를 위임한다는 의미입니다.<br />
요청을 위임받은 Tomcat 은 서비스를 할 웹 애플리케이션을 선택합니다. 그리고 경로에 해당하는 자원을 찾아 클라이언트의 요청에 응답하도록 합니다.
위의 연동 테스트에서는 http://localhost/index.jsp 로 요청했으므로 ROOT 애플리케이션의 루트 디렉토리에 있는 index.jsp 가 
Tomcat 의 호출을 받게 됩니다.<br />
그 결과 http://localhost/index.jsp 의 해석결과가 웹브라우저에서 확인할 수 있었습니다.<br />
다음으로 웹브라우저는 html 문서에 이미지 태그가 있으면 해당 이미지 파일을 웹서버에 요청합니다.<br />
위의 경우는 웹브라우저가 http://localhost/tomcat.gif 로 요청을 보내게 됩니다.<br />
언제나 앞선에는 웹서버가 요청을 먼저 받습니다.<br />
Apache 웹서버의 설정파일에 <strong>JkMount /*.gif tomcat1</strong>와 같이 설정되어 있지 않기 때문에
확장자가 gif 인 것은 Apache 자신이 직접 처리하려고 합니다. 그래서 httpd.conf 에서 DocumentRoot 로 정해진 
디렉토리부터 시작하여 tomcat.gif 이미지 파일의 경로를 찾아서 서비스하려고 시도합니다. 
하지만 D:\www\bbs 디렉토리에는 tomcat.gif 파일이 없습니다. 이것이 그림이 나오지 않는 이유입니다.<br />
확실하게 Apache, Tomcat 연동을 하려면 아래와 같이 설정하면 됩니다. <br />
<ol>
	<li>TOMCAT_HOME/webapps/ROOT 모두 지우고 WEB-INF 폴더를 생성합니다.</li>
	<li>TOMCAT_HOME/webapps/ROOT/WEB-INF/ 에 web.xml 파일을 가장 기본적인 내용으로 만듭니다.</li>
	<li>{Apache 홈}/conf/httpd.conf 파일을 열고 DocumentRoot 부분을  TOMCAT_HOME/webapps/ROOT 으로 설정합니다.</li>
	<li>{Apache 홈}/conf/httpd.conf 파일을 열고 DirectoryIndex 에 index.jsp 를 추가합니다.</li>
	<li>TOMCAT_HOME/webapps/ROOT 에 index.jsp 이름으로 간단한 테스트 파일을 만들고 Tomcat을 시작하고 Apache를 시작하여 테스트 합니다.</li>
</ol>
</dd>
</dl>
 -->
<span id="refer">참고</span>
<p>
<a href="http://raibledesigns.com/tomcat/">http://raibledesigns.com/tomcat/</a>
</p>