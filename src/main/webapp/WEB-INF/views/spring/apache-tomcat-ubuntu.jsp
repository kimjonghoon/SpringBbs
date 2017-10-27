<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.3.22</div>

<h1>최종 프로젝트를 아파치와 연동시키기</h1>

테스트 환경은 Ubuntu 14.04 LTS이다.<br />
아파치와 톰캣은 이미 설치했다고 가정한다.<br />
이미지, CSS, 자바스크립트와 같은 정적인 컨텐츠는 앞단에서 아파치가 처리하도록 설정하는 것이 목표이다.<br />

<h2>아파치 가상 호스트 설정</h2>
디폴트 가상 호스트 설정 파일을 복사하여 새로운 가상 호스트 파일을 만든다.<br />
<pre class="commandLine">
cd /etc/apache2/sites-available/
sudo cp 000-default.conf gildong.hong.conf
</pre>
 

/home/kim/www/SpringBbs/src/main/webapp 디렉토리가 도큐먼트베이스라면
gildong.hong.conf에서 아래 강조된 부분을 참고하여 수정한다.<br />
<pre class="commandLine">gksudo gedit /etc/apache2/sites-available/gildong.hong.conf</pre>

<pre class="prettyprint">
&lt;VirtualHost *:80&gt;
	# The ServerName directive sets the request scheme, hostname and port that
	# the server uses to identify itself. This is used when creating
	# redirection URLs. In the context of virtual hosts, the ServerName
	# specifies what hostname must appear in the request's Host: header to
	# match this virtual host. For the default virtual host (this file) this
	# value is not decisive as it is used as a last resort host regardless.
	# However, you must set it for any further virtual host explicitly.

	ServerName <strong>gildong.hong</strong>
	ServerAdmin admin@gildong.hong
	DocumentRoot <strong>/home/kim/www/SpringBbs/src/main/webapp</strong>

	# Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
	# error, crit, alert, emerg.
	# It is also possible to configure the loglevel for particular
	# modules, e.g.
	#LogLevel info ssl:warn
	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined

	# For most configuration files from conf-available/, which are
	# enabled or disabled at a global level, it is possible to
	# include a line for only one particular virtual host. For example the
	# following line enables the CGI configuration for this host only
	# after it has been globally disabled with "a2disconf".
	#Include conf-available/serve-cgi-bin.conf

&lt;/VirtualHost&gt;

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
</pre>

우분투는 디폴트로 /var/www 나 /usr/share 디렉토리에 있지 않은 파일로의 접근을 허용하지 않는다.<br />
접근 허용을 추가하려면 /etc/apache2/apache2.conf 파일을 편집해야 한다.<br />
(/var/www 이나 /usr/share 아래에 파일을 두더라도 권한 설정은 필요하다.)<br />


스프링 게시판 프로젝트의 도큐먼트베이스를 도큐먼트 루트 디렉토리로서 추가한다.<br />

<pre class="commandLine">gksudo gedit /etc/apache2/apache2.conf</pre>

<pre class="prettyprint">
<strong>&lt;Directory /home/kim/www/SpringBbs/src/main/webapp/&gt;
	Options Indexes FollowSymLinks
	AllowOverride None
	Require all granted
&lt;/Directory&gt;</strong>
</pre>

/etc/hosts을 편집한다.<br />

<pre class="commandLine">gksudo gedit /etc/hosts</pre>

<pre class="prettyprint">
127.0.0.1 localhost
<strong>127.0.0.1 gildong.hong</strong>
</pre>

새로운 설정 파일을 활성화한다.<br />
<pre class="commandLine">sudo a2ensite gildong.hong.conf</pre>

도큐먼트 루트 디렉토리(/home/kim/www/SpringBbs/src/main/webapp)에 index.html 파일을 만든다.<br />
<pre class="commandLine">gedit /home/kim/www/SpringBbs/src/main/webapp/index.html</pre>

<pre class="prettyprint">
&lt;html&gt;
&lt;body&gt;
gildong.hong Working!
&lt;/body&gt;
&lt;/html&gt;
</pre>

아파치를 재실행한다.<br />
<pre class="commandLine">sudo service apache2 restart</pre>

http://gildong.hong 을 방문하여 테스트한다.<br />
gildong.hong Working! 을 보면 가상 호스트 설정이 성공한 것이다.<br />


<h2>아파치 톰캣 연동을 위한 작업</h2>

<h3>mod_jk 설치</h3>

<pre class="commandLine">sudo apt-get install libapache2-mod-jk</pre>

<h3>server.xml 파일을 열고 아래 강조된 부분의 주석을 제거한다.</h3>
<pre class="commandLine">sudo gedit /etc/tomcat7/server.xml</pre>

<pre class="prettyprint">
<strong>&lt;Connector port="8009" protocol="AJP/1.3" redirectPort="8443" /&gt;</strong>
</pre>

<h3>/etc/apache2/workers.properties 파일을 생성한다.</h3>
<pre class="commandLine">sudo gedit /etc/apache2/workers.properties</pre>

<pre class="prettyprint">
<strong>worker.list=worker1
worker.worker1.type=ajp13
worker.worker1.host=gildong.hong
worker.worker1.port=8009</strong>
</pre>

<h3>jk.conf 파일에서 JkWorkersFile의 경로를 아래처럼 수정한다.</h3>
<pre class="commandLine">sudo gedit /etc/apache2/mods-available/jk.conf</pre>

<pre class="prettyprint">
JkWorkersFile <strong>/etc/apache2/workers.properties</strong>
</pre>

<h3>server.xml에 새로운 Host를 추가한다.</h3>
<pre class="commandLine">sudo gedit /etc/tomcat7/server.xml</pre>

<pre class="prettyprint">
<strong>&lt;Host name="gildong.hong" appBase="<strong>/home/kim/webapps</strong>"
	unpackWARs="true" autoDeploy="true"&gt;
        &lt;!-- 이하는 기존 Host 엘리먼트의 컨텐츠와 같게 복사한다. --/&gt;
&lt;/Host&gt;</strong>
</pre>

appBase는 게시판 프로젝트의 도큐먼트베이스와 상관없는 적당한 디렉토리를 선택한다.<br />
(appBase로 설정한 /home/kim/webapps 디렉토리는 존재해야 한다.)<br />
<br />
톰캣을 다시 시작한다.<br />

<pre class="commandLine">sudo service tomcat7 restart</pre>

/etc/tomcat7/Catalina/gildong.hong 디렉토리가 생성되는 것을 확인한다.<br />

<h3>톰캣매니저 복사</h3>
<pre class="commandLine">sudo cp /etc/tomcat7/Catalina/localhost/manager.xml /etc/tomcat7/Catalina/gildong.hong/</pre>

<h3>ROOT.xml 생성</h3>
<pre class="commandLine">sudo gedit /etc/tomcat7/Catalina/gildong.hong/ROOT.xml</pre>
<pre class="prettyprint">
<strong>&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="<strong>/home/kim/www/SpringBbs/src/main/webapp</strong>"
    reloadable="true"&gt;
&lt;/Context&gt;</strong>
</pre>

<h3>가상 호스트 파일인 gildong.hong.conf 편집</h3>

<pre class="commandLine">gksudo gedit /etc/apache2/sites-available/gildong.hong.conf</pre>
gildong.hong.conf 의 &lt;/VirtualHost&gt; 바로 위에 다음을 추가한다.<br />
<pre class="prettyprint">
# ..중간 생략 ..
<strong>
JkMount / worker1
JkMount /bbs/* worker1
JkMount /users/* worker1
JkMount /j_spring_security* worker1
JkUnMount /images/* *
JkUnMount /css/* *
JkUnMount /js/* *
</strong> 
&lt;/VirtualHost&gt;
</pre>

<h3>/etc/tomcat7/server.xml를 열고 아래 강조된 부분을 추가한다.</h3>
<pre class="prettyprint">
&lt;Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               <strong>URIEncoding="UTF-8"</strong>
               redirectPort="8443" /&gt;
               
&lt;Connector port="8009" protocol="AJP/1.3" redirectPort="8443" <strong>URIEncoding="UTF-8"</strong> /&gt;
</pre>

<h3>테스트</h3>
<pre class="commandLine">
sudo service tomcat7 restart
sudo service apache2 restart
</pre>

아래 주소를 방문한다.<br />
http://gildong.hong:8080<br />
http://gildong.hong<br />
http://gildong.hong:8080/manager<br />
http://gildong.hong/index.html<br />
<br />
마지막 테스트는 404 에러를 만나는 것이 정상이다.<br />

<span id="refer">참고</span>
<ul id="references">
	<li><a href="https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-14-04-lts">How To Set Up Apache Virtual Hosts on Ubuntu 14.04 LTS</a></li>
	<li><a href="http://tomcat.apache.org/tomcat-7.0-doc/virtual-hosting-howto.html">Virtual Hosting and Tomcat</a></li>
	<li><a href="http://tomcat.apache.org/connectors-doc/reference/apache.html">The Apache Tomcat Connector - Reference Guide</a></li>
</ul>
