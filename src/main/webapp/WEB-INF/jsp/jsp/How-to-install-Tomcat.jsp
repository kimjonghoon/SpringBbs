<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="last-modified">Last Modified : 2014.7.9</div>

<h1>Tomcat 설치</h1>

<a href="http://tomcat.apache.org/download-70.cgi">http://tomcat.apache.org/download-70.cgi</a> 에서 Tomcat7를 다운로드한다.<br />
 윈도우 시스템이라면 아래 그림에서 강조된 부분을 선택하는 것이 좋다.<br />

<img src="https://lh4.googleusercontent.com/-LL4hbJc9Q9c/TpeuD76h7pI/AAAAAAAAAmU/Vhcsad6zuOg/s580/01_tomcat7_download.png" alt="Tomcat7 download" /><br />
다운로드한 파일을 실행해 설치를 시작한다.<br />

<img src="https://lh6.googleusercontent.com/-LfFj25ITndU/TpeuD5SDHII/AAAAAAAAAmY/sPDEV0Vo8Jc/s505/02_tomcat7_setup.png" alt="Tomcat7 Setup" /><br />

<img src="https://lh6.googleusercontent.com/-PqtrY4uNa5I/TpeuD6VjG-I/AAAAAAAAAnA/pJEFr4XpSy0/s505/03_tomcat7_agreement.png" alt="Tomcat7 Agreement" /><br />

<img src="https://lh4.googleusercontent.com/-0bPszgCrTmU/TpeuELFUyOI/AAAAAAAAAmg/7gtqL9Ypryw/s507/04_tomcat7_choose.png" alt="Tomcat7 Choose Component" /><br />

<img src="https://lh5.googleusercontent.com/-wLZnjAKcYoU/TpeuEQH8q9I/AAAAAAAAAms/JazW6SFHKog/s515/05_tomcat7_configure.png" alt="Tomcat7 Configuration" /><br />
톰캣의 디폴트 포트는 8080이다.<br />
하지만 이 포트를 다른 프로그램이 사용하고 있다면 변경해야 한다.<br />
그림은 8080 대신 8989 로 설정하고 있는데, 8080 은 먼저 설치한 Oracle 11g XE가 사용하고 있기 때문이다.<br />
톰캣 관리자의 사용자명과 비밀번호를 부여한다.<br />
설치후에 설정을 바꾸려면 {톰캣홈}<sup>1</sup>/conf 디렉토리에 위치한  server.xml 과  tomcat-users.xml 파일을 열어 편집하면 된다.<sup>2</sup><br />

<img src="https://lh3.googleusercontent.com/--JmBTPFhJcs/TpeuEvcBEgI/AAAAAAAAAmw/J7HCH-R1jME/s515/06_tomcat7_jvm.png" alt="Tomcat7 JVM select" /><br />
자바 가상 머신(Java Virtual Machine)에 대한 경로를 묻고 있다.<br />
시스템에 JVM이 여러 개 설치 되어 있을 수 있다.<br />
만약 설치 마법사가 선택한 JVM이 사용하지 않는 것이라면 맞는 버전을 찾아 선택한다.<br />

<img src="https://lh5.googleusercontent.com/-laLsXtln7XA/TpeuE14i_5I/AAAAAAAAAm8/yvNGNJ1_N1o/s515/07_tomcat7_location.png" alt="Tomcat7 choose install Location" /><br />
보이는 경로가 톰캣이 설치되는 디렉토리이다.
이를 간단히 {톰캣홈}이라 하겠다.
<br />
설치가 제대로 완료되었는지 확인하기 위해서<br />
http://localhost:8989를 방문한다.<br />
아래처럼 고양이를 볼 수 있다면 설치가 성공한 것이다.<br />
참고로 이 화면은 톰캣의 ROOT 애플리케이션의 화면이다.<br />
ROOT 애플리케이션의 위치는 {톰캣홈}/webapps/ROOT 이다.<br />

<img src="https://lh4.googleusercontent.com/-V0hH4wDSf7U/TpeuFXfvfCI/AAAAAAAAAnI/4GKCTcvWOLs/s1280/08_tomcat7_confirm.png" alt="Tomcat7 Confirm" width="580px" /><br />

톰캣이 서비스를 시작하면 시스템 트레이 메뉴에 Tomcat Monitor 아이콘이 나타난다.<br />
만약 고양이 화면을 보지 못했다면 이 Tomcat Monitor 을 이용해서 톰캣을 실행을 시도해 본다.<sup>3</sup><br />

<img src="https://lh4.googleusercontent.com/-_0v2b0-c3zg/TjJI0vtTM2I/AAAAAAAAAVs/yf6fyEzDRkM/10.gif" alt="Tomcat Monitor Icon" style="width: 20px;" />

<span id="comments">주석</span>
<ol>
	<li>윈도우 시스템인 경우 {톰캣홈}의 전체경로는 다음과 같다.<br />
	<em class="path">C:\Program Files\Apache Software Foundation\Tomcat 7.0</em></li>
	<li>톰캣 설치중 설정한 내용은 설치 후에 변경할 수 있다.<br />
	포트번호는 server.xml, 관리자 사용자명과 비밀번호는 tomcat-users.xml 에서 수정한다.</li>
	<li>포트번호를 디폴트 8080을 그대로 사용하고 http://localhost:8080을 방문했는데<br /> 
	<strong>"인증 필요 서버 http://localhost:8080에 사용자 이름과 비밀번호를 입력해야 합니다.서버메시지:XDB ..."</strong>
	라는 메시지를 보게 된다면 이건 톰캣이 아니라 오라클의 XDB가 반응하는 것이다.<br />
	{톰캣홈}/conf/server.xml 파일에서 8080이 아닌 다른 번호로 바꿔야 한다.<br />본 사이트에는 8989로 진행한다.</li>
</ol>
