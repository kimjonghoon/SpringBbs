<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.7.14</div>

<h1>우분투 개발환경 세팅</h1>

<h2>Ubuntu 설치</h2>
<a href="http://www.ubuntu.com/download/desktop">http://www.ubuntu.com/download/desktop</a>에서
15.04 버전을 내려받는다.<br />

<h3>USB에 ISO 파일 만들기</h3>
주의! 다음 과정은 USB 기존 데이타를 모두 제거한다.<br />
USB를 꼽고 USB 디바이스를 확인한다.<br />

<pre class="shell-prompt">
sudo ls -l /dev/disk/by-id/*usb*
</pre> 
sdb, sdb1, sdb2가 함께 보이면, 뒤에 숫자가 붙는 것이 아닌 sdb가 USB 디바이스다.<br />
다운로드 폴더로 이동하여 아래를 수행한다.<br /> 
filename.iso 대신 내려받은 우분투 파일명 입력하고, of=다음엔 USB 디바이스를 입력한다.<br />
 
<pre class="shell-prompt">
sudo dd if=<strong>filename.iso</strong> of=<strong>/dev/sdb</strong> bs=4M; sync
</pre>

15.04부터 한글에 관한 특별한 설정이 필요없다.<br /> 
설치 화면에서 국가는 한국, 키보드 배치에서 한국어 - 한국어를 선택하여 진행한다.<br />
주의! 한국어 - 한국어(101/104키 호환)를 선택하지 않도록 한다.<br />

<!-- 
<h3>한영키 설정</h3>
<figure style="margin: 0;">
  <figcaption>우분투 시스템 설정 - 키보드 선택</figcaption>
  <img src="https://lh3.googleusercontent.com/-ChW275MHIGA/VZYsdNrPm6I/AAAAAAAACls/8L3Vfm3C5cU/s848/ubuntu-system-setting.png" alt="우분투 시스템 설정 선택" />
</figure>

<figure style="margin: 0;">
  <figcaption>자판입력 - 구성키 - 오른쪽 Alt 선택</figcaption>
  <img src="https://lh3.googleusercontent.com/-0MZcwmbEmnE/VZYscmWRU0I/AAAAAAAAClg/KQZldvp7M64/s849/system-keyboard-right-alt.png" alt="자판입력 - 구성키 - 오른쪽 Alt 선택" />
</figure>

<figure style="margin: 0;">
  <figcaption>ibus 설정 - 추가 버튼 클릭</figcaption>
  <img src="https://lh3.googleusercontent.com/-kfIdWxeannY/VZYscGzSdsI/AAAAAAAAClo/jNo_13YvmbY/s416/ibus-setting.png" alt="ibus 설정 - 추가 버튼 클릭" />
  <img src="https://lh3.googleusercontent.com/-2A2UEvTbvQs/VZYscNA9XCI/AAAAAAAAClQ/SZ1QrFAycIo/s629/ibus-haneng-key.png" alt="" />
</figure>

<figure style="margin: 0;">
  <figcaption>한영키를 눌렀을 때 Hangul이 나오면 취소, 다른 키가 나오면 확인 - 적용</figcaption>
  <img src="https://lh3.googleusercontent.com/-pdd8P7AckV8/VZYscEDOYRI/AAAAAAAAClc/sOR6-iAH2So/s644/ibus-haneng-key-cancel.png" alt="한영키를 눌렀을 때 Hangul이 나오면 취소, 다른 키가 나오면 확인 - 적용" />
</figure>
-->

 
<h2>Oracle 11g XE 설치</h2>
다음 링크에서 참조했음.<br />
<a href="http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html">http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html</a>
<br />
<a href="http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html">http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html</a>
에서 오라클 11g XE를 내려받은 후 다운로드 폴더로 이동하여 다음 명령을 수행한다.<br />

<pre class="shell-prompt">
unzip oracle-xe-11.2.0-1.0.x86_64.rpm.zip
sudo apt-get install alien libaio1 unixodbc
sudo alien --scripts -d oracle-xe-11.2.0-1.0.x86_64.rpm
</pre>

/sbin/chkconfig 파일을 만든다.

<pre class="shell-prompt">
sudo nano /sbin/chkconfig
</pre>

다음을 복사하여 파일에 붙여넣는다.

<pre class="prettyprint">
#!/bin/bash
# Oracle 11gR2 XE installer chkconfig hack for Ubuntu
file=/etc/init.d/oracle-xe
if [[ ! `tail -n1 $file | grep INIT` ]]; then
echo >> $file
echo '### BEGIN INIT INFO' >> $file
echo '# Provides: OracleXE' >> $file
echo '# Required-Start: $remote_fs $syslog' >> $file
echo '# Required-Stop: $remote_fs $syslog' >> $file
echo '# Default-Start: 2 3 4 5' >> $file
echo '# Default-Stop: 0 1 6' >> $file
echo '# Short-Description: Oracle 11g Express Edition' >> $file
echo '### END INIT INFO' >> $file
fi
update-rc.d oracle-xe defaults 80 01
</pre>

파일을 저장하고 실행 권한을 부여한다.

<pre class="shell-prompt">
sudo chmod 755 /sbin/chkconfig
</pre>

커널 파라미터를 설정한다.

<pre class="shell-prompt">
sudo nano /etc/sysctl.d/60-oracle.conf
</pre>

다음 내용을 복사하여 파일에 붙인다.

<pre class="prettyprint">
# Oracle 11g XE kernel parameters  
fs.file-max=6815744  
net.ipv4.ip_local_port_range=9000 65000  
kernel.sem=250 32000 100 128 
kernel.shmmax=2066743296
</pre>

마지막 줄 kernel.shmmax 값은 시스템에 설치된 램 메모리 1/2을 할당한다.<br />
<pre class="shell-prompt">
free -m
</pre>

결과가 다음과 같으면
<pre class="shell-prompt">
             total       used       free     shared    buffers     cached
Mem:          3942       3809        133        947         50       1571
-/+ buffers/cache:       2186       1756
Swap:         4083        378       3705
</pre>

3942 * 1024 * 1024 * 0.5 = 2066743296<br />
<br />
검증한다.<br />

<pre class="shell-prompt">
sudo cat /etc/sysctl.d/60-oracle.conf
</pre>

새로운 커널 파라미터를 올린다.

<pre class="shell-prompt">
sudo service procps start
</pre>

검증한다.
<pre class="shell-prompt">
sudo sysctl -q fs.file-max
</pre>

다음을 실행한다.<br />

<pre class="shell-prompt">
sudo ln -s /usr/bin/awk /bin/awk
sudo mkdir /var/lock/subsys
sudo touch /var/lock/subsys/listener
</pre>

Disk1 폴더로 이동하여 설치를 시작한다.
  
<pre class="shell-prompt">
sudo dpkg --install oracle-xe_11.2.0-2_amd64.deb
sudo /etc/init.d/oracle-xe configure
</pre>

설정에서 Oracle Application Express의 포트는 톰캣이 쓰는 8080을 피해 정한다.<br />
그외는 디폴트 값을 선택하면 된다.<br />

<pre class="shell-prompt">
Oracle Database 11g Express Edition Configuration
-------------------------------------------------
This will configure on-boot properties of Oracle Database 11g Express 
Edition.  The following questions will determine whether the database 
should be starting upon system boot, the ports it will use, and 
the passwords that will be used for database accounts.  
Press Enter to accept the defaults. 
Ctrl-C will abort.

Specify the HTTP port that will be used 
	for Oracle Application Express [8080]:<strong>8989</strong>

Specify a port that will be used for the database listener [1521]:

Specify a password to be used for database accounts.
Note that the same password will be used for SYS and SYSTEM.
Oracle recommends the use of different passwords 
for each database account.
This can be done after 
initial configuration:
Confirm the password:

Do you want Oracle Database 11g Express Edition to be started 
on boot (y/n) [y]:

Starting Oracle Net Listener...Done
Configuring database...Done
Starting Oracle Database 11g Express Edition instance...Done
Installation completed successfully.
</pre>


환경변수를 추가한다.

<pre class="shell-prompt">
gedit ~/.bashrc
</pre>

아래를 복사하여 .bashrc 가장 아래에 붙여넣는다.

<pre class="prettyprint">
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export ORACLE_SID=XE
export NLS_LANG=`$ORACLE_HOME/bin/nls_lang.sh`
export ORACLE_BASE=/u01/app/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
export PATH=$ORACLE_HOME/bin:$PATH
</pre>

<pre class="shell-prompt">
source ~/.bashrc
</pre>
 
오라클을 시작한다.
<pre class="shell-prompt">
sudo service oracle-xe start
</pre>


<h3>SCOTT 계정 만들기</h3>

<pre class="shell-prompt">
sqlplus sys as sysdba

SQL*Plus: Release 11.2.0.2.0 Production on 월 6월 29 12:04:33 2015

Copyright (c) 1982, 2011, Oracle.  All rights reserved.

Enter password: 

Connected to:
Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production

SQL> <strong>@/u01/app/oracle/product/11.2.0/xe/rdbms/admin/utlsampl.sql</strong>
</pre>

<h2>JDK 설치</h2>
<pre class="shell-prompt">
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
</pre>

<h3>JDBC 테스트</h3>

<script src="https://gist.github.com/kimjonghoon/ea49c337a11dfa5dd08c.js"></script>

GetEmp.java 파일을 생성하고 GetEmp.java 파일이 있는 디렉터리에서 다음을 수행한다.<br />
(유닉스에서 환경변수 구분자는 : 이다.)

<pre class="shell-prompt">
javac GetEmp.java
java -classpath \
.:/u01/app/oracle/product/11.2.0/xe/jdbc/lib/ojdbc6.jar GetEmp
</pre>

<h2>이클립스 설치</h2>
<a href="https://eclipse.org/downloads/">https://eclipse.org/downloads/</a>에서 
Eclipse IDE for Java EE Developers를 내려받는다.<br />
파일을 opt 디렉터리로 옮긴 후 압축을 푼다.<br />

<pre class="shell-prompt">
sudo mv eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz /opt/
cd /opt
sudo tar -xvf eclipse-jee-mars-R-linux-gtk-x86_64.tar.gz
</pre>

<h3>eclipse.desktop 파일 생성</h3>

/usr/share/applications/ 폴더에 eclipse.desktop 파일을 생성한다.

<pre class="shell-prompt">
cd /usr/share/applications/
sudo nano eclipse.desktop
</pre>

다음을 복사하여 파일에 입력한다.

<pre class="prettyprint">
[Desktop Entry]
Name=Eclipse
Type=Application
Exec=/opt/eclipse/eclipse
Terminal=false
Icon=/opt/eclipse/icon.xpm
Comment=Integrated Development Environment
NoDisplay=false
Categories=Development;IDE
Name[en]=eclipse.desktop
</pre>


eclipse를 검색하여 실행한 후 런처에 고정한다.


<h2>톰캣 설치</h2>

<pre class="shell-prompt">
sudo apt-get install tomcat7 tomcat7-admin
</pre>


http://localhost:8080으로 방문하여 톰캣이 실행중인지 확인한다.<br />
It works !

<h2>SpringBbs 설치</h2>

<h3>메이븐 설치</h3>
<a href="https://maven.apache.org/download.cgi">https://maven.apache.org/download.cgi</a>에서
바이너리 파일을 내려받는다.<br />
적당한 디렉터리에 압축을 풀고, 

<pre class="shell-prompt">
tar xzvf apache-maven-3.3.3-bin.tar.gz
</pre>

apache-maven-3.3.3/bin 디렉터리를 PATH에 추가한다.<br />
생성한 디렉터리가 /home/kim/apache-maven-3.3.3 이라면 

<pre class="shell-prompt">
gedit ~/.bashrc
</pre>

.bashrc 파일에 다음을 추가한다.<br />

<pre class="prettyprint">
export PATH=$PATH:/home/kim/apache-maven-3.3.3/bin
</pre>

<pre class="shell-prompt">
source ~/.bashrc
</pre>


<h3>Git 설치</h3>
<pre class="shell-prompt">
sudo apt-get install git
</pre>

메이븐 프로젝트 워크스페이스로 이동하여 다음을 수행한다.<br />
/home/kim/Lab/maven가 워크 스페이스라면 워크 스페이스로 이동하여 다음을 수행한다.

<pre class="shell-prompt">
git clone https://github.com/kimjonghoon/SpringBbs.git
</pre>

이클립스를 열고 워크 스페이스를 선택한 후 SpringBbs 메이븐 프로젝트를 임포트한다.<br /> 

<img alt="컨텍스트 메뉴에서 Import" src="https://lh3.googleusercontent.com/-VjWpQCEiqes/VYYV3b2GPFI/AAAAAAAACh0/-KoRbgI8nn0/s590/maven-project-import.png"><br />

<img alt="이클립스에서 메이븐 프로젝트 Import" src="https://lh3.googleusercontent.com/-uDuAOI41Aj4/VYYV3Pmo4qI/AAAAAAAAChw/m4HA61kOVbE/s610/eclipse-with-maven.png"><br />

pom.xml과 이클립스를 동기화한다.<br />
Package Explorer 뷰에서 프로젝트를 선택하고 마우스 오른쪽 버튼으로 컨텍스트 메뉴를 연다.<br />
Maven - Update Project Configuration을 차례로 선택한다.<br />

<h3>테이블</h3>
system 계정으로 접속해 다음 SQL문을 실행한다.<br />

<script src="https://gist.github.com/kimjonghoon/4ad45823c45c1d60b15c.js"></script>

<h3>디렉터리 수정</h3>
이클립스 프로젝트 뷰에서 Resource의 log4j.xml파일을 열고
로그 파일의 위치를 자신의 시스템에 맞게 수정한다.
로그 파일 위치가 /home/kim/upload/SpringBbs.log라면 
upload 폴더를 해당 위치에 만들고, 기타가 파일을 쓸 수 있도록 폴더 권한을 수정한다.<br />
net.java_school.commons.WebContants.java 파일을 열고
업로드 디렉터리를 자신의 시스템에 맞게 수정한다.
업로드 디렉터리는 기타에 읽기 쓰기 실행 권한 모두를 준다.

<h3>컴파일</h3>
시스템에 설치한 자바 버전을 확인한다.<br />

<pre class="shell-prompt">
java -version
</pre>

버전이 1.8이면 pom.xml을 열고 properties 부분에서 jdk 버전을 1.8로 수정한다.<br />

<pre class="prettyprint">
&lt;jdk.version&gt;1.8&lt;/jdk.version&gt;
</pre>   

메이븐 프로젝트의 루트 디렉터리에서 다음 명령을 실행한다.<br />
<pre class="shell-prompt">
mvn clean compile war:inplace
</pre>

<h3>톰캣 컨테스트 파일 생성</h3>
<pre class="shell-prompt">
cd /etc/tomcat7/Catalina/localhost
sudo nano ROOT.xml
</pre>

아래를 복사하여 파일에 붙여 넣는다.

<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="/home/kim/Lab/maven/SpringBbs/src/main/webapp"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>

<h3>오라클 JDBC 드라이버를 /usr/share/tomcat7/lib에 복사</h3>
<pre class="shell-prompt">
cd /u01/app/oracle/product/11.2.0/xe/jdbc/lib
sudo cp ojdbc6.jar /usr/share/tomcat7/lib/
</pre>

톰캣 재실행을 하고,
<pre class="shell-prompt">
sudo service tomcat7 restart
</pre>

http://localhost:8080에 방문하여 스프링 MVC 게시판 애플리케이션이 동작하는지 확인한다.

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://crunchbang.org/forums/viewtopic.php?id=23267">http://crunchbang.org/forums/viewtopic.php?id=23267</a></li>
	<li><a href="http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html">http://meandmyubuntulinux.blogspot.kr/2012/05/installing-oracle-11g-r2-express.html</a></li>
</ul>