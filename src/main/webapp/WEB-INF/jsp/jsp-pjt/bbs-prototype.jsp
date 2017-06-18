<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.6.20</div>

<h1>프로토타입(prototype)</h1>

프로토타입이란 개발 초기에 만드는 일종의 모형이다.<br />
웹 애플리케이션의 프로토타입은 화면에 해당하는 JSP 페이지를 위주로 작성한다.<br />
이때 프로그램 로직은 명확한 것만 프로토타입에 넣는다.<br />
<br />
게시판 프로젝트를 위한 프로토타입을 작성할 것이다.<br />
프로토타입에 로그인 로직을 포함하려 한다.<br />
프로젝트 초반에 로그인 정책을 정하는 것이 바람직하다고 생각하기 때문이다.<br />

<h2>메인 페이지, 서브 페이지</h2>
웹사이트 프로토타입을 만들 때 첫 번째로 해야 할 작업은 메인 페이지와 서브 페이지를 디자인하는 것이다.<br />
메인 페이지는 웹사이트를 방문할 때 처 보이는 페이지를 말하는데, 홈페이지라고도 한다.<br />
서브 페이지는 메인 페이지 외의 모든 페이지를 말한다.<br />
다음은 메인 페이지와 서브 페이지 위치를 보여주고 있다.<br />

<pre>
DocumentBase: 메인 페이지(홈페이지), 에러 페이지
   └── css: screen.css
   └── images: Images
   └── inc: 공통 인클루드 JSP
   └── bbs: 게시판
   └── users: 회원 
   └── java: index.jsp(서브 페이지)    
   └── WEB-INF: web.xml
         └── classes: 자바 바이트 코드
         └── lib: 자바 아카이브 파일
</pre>

위 디렉터리 구조를 가지고 프로젝트를 진행할 것이니 css, images, inc, bbs, users, java 폴더를 
도큐먼트 베이스에 생성한다.<br />
여기서 도큐먼트 베이스(DocumentBase)는 이전 절에서 설정대로라면 <em class="path">C:\www\JSPProject\WebContent</em>이다.<br />


<h3>스타일 시트과 이미지</h3>
프로젝트에 필요한 스타일 시트와 이미지 파일은 CSS 포지셔닝에서의 것을 그대로 갖다 쓴다.<br />
CSS 포지셔닝에서의 스타일 시트와 이미지 파일을 css와 images 폴더에 복사한다.<br />
CSS 포지셔닝에서 작업했던 모든 JSP 파일 역시 복사하여 도큐먼트 베이스에 복사한다.<br />

<h3>메인 페이지</h3>
디자인은 메인 페이지부터 작성하는 것이 순서이다.<br />
프로토타입에 로그인 기능을 넣기로 했으므로 디자인을 해야 하는 이 시점에 다음 자바빈즈가 필요하다.<br />

<em class="filename">User.java</em>
<pre class="prettyprint">package net.java_school.user;

public class User {
    private String email;
    private String passwd;
    private String name;
    private String mobile;
    
    public User() {}

    public User(String email, String passwd) {
        this.email = email;
        this.passwd = passwd;
    }
    
    public User(String email, String passwd, String name, String mobile) {
        this.email = email;
        this.passwd = passwd;
        this.name = name;
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswd() {
        return passwd;
    }
    
    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getMobile() {
        return mobile;
    }
    
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

}
</pre>

특별한 것은 User.java에 ID가 없다는 것이다.<br />
email을 ID 대신 사용할 것이다.<br />
<br />
로그인을 구현하기 위해선 로그인 정책을 먼저 정해야 한다.<br />
로그인이 필요한 페이지에 로그인하지 않은 사용자가 방문하면 사용자를 로그인 페이지로 보낸다.<br />
이때 처음 방문하려던 url을 로그인 페이지로 전달되도록 한다.<br />
로그인이 성공하면 url로 이동한다.<br />
로그인이 필요 없는 페이지에서 로그인하면 정해진 페이지로 이동한다.<br />
이 페이지는 자유 게시판의 목록의 첫 번째 페이지로 정하겠다.<br />
로그아웃하면 홈페이지로 이동한다.<br />
<br />

write_form.html를 열고 이클립스의 File - Save As... 메뉴를 선택하여 index.jsp라는 이름의 새 파일을 도큐먼트 베이스에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/index.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;<strong>
&lt;%@ page import="net.java_school.user.User" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="<strong>메인 페이지</strong>" /&gt;
&lt;meta name="Description" content="<strong>메인 페이지</strong>" /&gt;
&lt;title&gt;<strong>메인 페이지</strong>&lt;/title&gt;
&lt;link rel="stylesheet" href="css/screen.css" type="text/css" /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;h1 <strong>style="float: left; width: 150px;"</strong>&gt;&lt;a href=<strong>"./</strong>"&gt;&lt;img src="images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
        <strong>&lt;div id="memberMenu" style="float: right; position: relative; top: 7px;"&gt;
&lt;%
User loginUser = (User) session.getAttribute("user");
if (loginUser == null) {
%&gt;   
            &lt;input type="button" value="로그인" onclick="location.href='./users/login.jsp'" /&gt;
            &lt;input type="button" value="회원 가입" onclick="location.href='./users/signUp.jsp'" /&gt;
&lt;%
} else {
%&gt;
            &lt;input type="button" value="로그아웃" onclick="location.href='./users/logout_proc.jsp'" /&gt;
            &lt;input type="button" value="내 정보 수정" onclick="location.href='./users/editAccount.jsp'" /&gt;
&lt;%
}
%&gt;
        &lt;/div&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;ul id="nav"&gt;&lt;!-- 이전 메뉴와 다르다. --&gt;<strong>
            &lt;li&gt;&lt;a href="java/"&gt;Java&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="jdbc/"&gt;JDBC&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="jsp/"&gt;JSP&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="css-layout/"&gt;CSS Layout&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="jsp-project/"&gt;JSP Project&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="spring/"&gt;Spring&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="javascript/"&gt;JavaScript&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="bbs/list.jsp?boardCd=free&amp;page=1"&gt;BBS&lt;/a&gt;&lt;/li&gt;</strong>&lt;!-- 자유 게시판 첫 페이지 --&gt;
        &lt;/ul&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Main&lt;/div&gt;
            
&lt;h1&gt;수정&lt;/h1&gt;
&lt;h2&gt;JSP Project 전반적인 내용 수정 2014.9.26&lt;/h2&gt;
프로토타입을 만든 후에 진행하는 것으로 내용 수정&lt;br /&gt;
프로토타입에 로그인 구현&lt;br /&gt;

&lt;h2&gt;CSS Layout 수정 2014.9.26&lt;/h2&gt;
카테고리 정리&lt;br /&gt;
스타일 시트 파일 체계적으로 갱신&lt;br /&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Main&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;a href="http://www.youtube.com"&gt;&lt;img src="images/youtube.png" alt="youtube.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.twitter.com"&gt;&lt;img src="images/twitter.png" alt="twitter.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.facebook.com"&gt;&lt;img src="images/facebook.png" alt="facebook.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.gmail.com"&gt;&lt;img src="images/gmail.png" alt="gmail.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.java-school.net"&gt;&lt;img src="images/java-school.png" alt="java-school.net" /&gt;&lt;/a&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="#"&gt;이용약관&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;개인정보보호정책&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;이메일무단수집거부&lt;/a&gt;&lt;/li&gt;
            &lt;li id="company-info"&gt;전화 : 02-123-5678, FAX : 02-123-5678&lt;br /&gt;
            people@ggmail.org&lt;br /&gt;
            Copyright java-school.net All Rights Reserved.&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;찾아오시는 길&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/div&gt;

&lt;/div&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

작성한 index.jsp가 홈페이지(메인 페이지)가 되도록 CSS 포지셔닝의 산출물인 index.html을 도큐먼트 베이스에서 삭제한다.<br />
 
<h3>서브 페이지</h3>
홈페이지 /index.jsp를 열고 Save As... 메뉴를 이용하여 index.jsp라는 이름으로 새 파일을 java 디렉터리에 만든 후 아래와 같이 수정한다.
홈페이지와 비교하여 서브 디렉터리에 있으므로 상대 경로에 주의한다.<br />
    
<em class="filename">/java/index.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;    
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="자바 홈" /&gt;
&lt;meta name="Description" content="자바 홈" /&gt;
&lt;title&gt;자바 홈&lt;/title&gt;
&lt;link rel="stylesheet" href="<strong>../</strong>css/screen.css" type="text/css"  /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;h1 style="float: left; width: 150px;" &gt;&lt;a href="<strong>../</strong>"&gt;&lt;img src="<strong>../</strong>images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
        &lt;div id="memberMenu" style="float: right; position: relative; top: 7px;"&gt;
&lt;%
User loginUser = (User) session.getAttribute("user");
if (loginUser == null) {
%&gt;   
            &lt;input type="button" value="로그인" onclick="location.href='<strong>../users/login.jsp</strong>'" /&gt;
            &lt;input type="button" value="회원 가입" onclick="location.href='<strong>../users/signUp.jsp</strong>'" /&gt;
&lt;%
} else {
%&gt;
            &lt;input type="button" value="로그아웃" onclick="location.href='<strong>../users/logout_proc.jsp'</strong>" /&gt;
            &lt;input type="button" value="내 정보 수정" onclick="location.href='<strong>../users/editAccount.jsp</strong>'" /&gt;
&lt;%
}
%&gt;
        &lt;/div&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;ul id="nav"&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>java/"&gt;Java&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>jdbc/"&gt;JDBC&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>jsp/"&gt;JSP&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>css-layout/"&gt;CSS Layout&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>jsp-project/"&gt;JSP Project&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>spring/"&gt;Spring&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>javascript/"&gt;JavaScript&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>../</strong>bbs/list.jsp?boardCd=free&amp;page=1"&gt;BBS&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/div&gt;


    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Java Home&lt;/div&gt;
            
&lt;h1&gt;JDK 설치&lt;/h1&gt;
&lt;p&gt;
www.oracle.com을 방문하여 JDK를 내려받는다.&lt;br /&gt;
설치는 다음 버튼을 클릭하는 것만으로 완료할 수 있다.&lt;br /&gt;  
설치 후 PATH 환경 변수에 JDK의 bin 디렉터리를 추가한다.&lt;br /&gt;
PATH의 기존 설정값 제일 뒤에 윈도 환경 변수의 구분자 ;를 추가하고 JDK의 bin까지의 경로를 붙여넣는다.&lt;br /&gt;
이때 기존값은 지우지 않도록 주의한다.&lt;br /&gt; 
&lt;/p&gt;

&lt;h2&gt;PATH&lt;/h2&gt;
&lt;p&gt;
PATH는 운영체제가 실행 프로그램을 찾을 때 참조하는 환경 변수이다.&lt;br /&gt;
명령 프롬프트에서 &lt;strong&gt;echo %PATH%&lt;/strong&gt;를 실행하면 PATH의 설정값을 확인할 수 있다.&lt;br /&gt;
PATH에 JDK의 bin디렉터리를 추가하는 이유는 어느 디렉터리에서나 JDK의 bin에 있는 
실행 프로그램(javac.exe,java.exe,jar.exe 등)을 실행할 수 있도록 하기 위해서이다.&lt;br /&gt;
&lt;/p&gt;

&lt;h2&gt;테스트&lt;/h2&gt;
&lt;p&gt;
아래 내용을 메모장에 작성하고 파일명을 Test.java로 저장한다.&lt;br /&gt;
&lt;/p&gt;

&lt;pre&gt;
public class Test {
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
}
&lt;/pre&gt;

&lt;ol&gt;
    &lt;li&gt;명령 프롬프트에서 Test.java 파일이 있는 디렉터리로 이동한다.&lt;/li&gt;
    &lt;li&gt;javac Test.java로 컴파일한다. Test.class가 현재 디렉터리에 만들어진다.&lt;/li&gt;
    &lt;li&gt;java Test로 실행한다.&lt;/li&gt;
&lt;/ol&gt;

&lt;pre&gt;
C:\&gt;javac Test.java

C:\&gt;java Test
Hello World!
&lt;/pre&gt;

&lt;!-- 본문 끝 --&gt;
        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Java&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;a href="http://www.youtube.com"&gt;&lt;img src="<strong>../</strong>images/youtube.png" alt="youtube.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.twitter.com"&gt;&lt;img src="<strong>../</strong>images/twitter.png" alt="twitter.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.facebook.com"&gt;&lt;img src="<strong>../</strong>images/facebook.png" alt="facebook.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.gmail.com"&gt;&lt;img src="<strong>../</strong>images/gmail.png" alt="gmail.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.java-school.net"&gt;&lt;img src="<strong>../</strong>images/java-school.png" alt="java-school.net" /&gt;&lt;/a&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="#"&gt;이용약관&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;개인정보보호정책&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;이메일무단수집거부&lt;/a&gt;&lt;/li&gt;
            &lt;li id="company-info"&gt;전화 : 02-123-5678, FAX : 02-123-5678&lt;br /&gt;
            people@ggmail.org&lt;br /&gt;
            Copyright java-school.net All Rights Reserved.&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;찾아오시는 길&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

홈페이지와 서브 페이지의 디자인은 같다. 
하지만 대부분의 웹사이트는 그렇지 않다.<br />

<h3>공통으로 인클루드되는 JSP 페이지</h3>
서브 페이지들은 화면 배치가 같으므로 JSP 인클루드 지시어를 사용하여 코드를 분리할 수 있다.<br />
페이지를 분리하면 유지 보수가 편해진다.<br />
#header에 있는 로고와 로그인/로그아웃 버튼, #main-menu의 메인 메뉴, #extra의 외부 링크, #footer의 글로벌 메뉴는 모든 페이지에서 공통이다.<br />
inc 서브 디렉터리에 다음 JSP 파일을 생성한다.<br />
/java/index.jsp에서 해당 부분을 찾아 복사하여 붙여넣기하면서 만든다.

<em class="filename">/inc/header.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;h1 style="float: left; width: 150px;"&gt;&lt;a href="../"&gt;&lt;img src="../images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
&lt;div id="memberMenu" style="float: right; position: relative; top: 7px;"&gt;
&lt;%
User loginUser = (User) session.getAttribute("user");
if (loginUser == null) {
%&gt;
    &lt;input type="button" value="로그인" onclick="location.href='../users/login.jsp'" /&gt;
    &lt;input type="button" value="회원 가입" onclick="location.href='../users/signUp.jsp'" /&gt;
&lt;%
} else {
%&gt;   
    &lt;input type="button" value="로그아웃" onclick="location.href='../users/logout_proc.jsp'" /&gt;
    &lt;input type="button" value="내 정보 수정" onclick="location.href='../users/editAccount.jsp'" /&gt;
&lt;%
}
%&gt;
&lt;/div&gt;
</pre>

<em class="filename">/inc/main-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;ul id="nav"&gt;
    &lt;li&gt;&lt;a href="../java/"&gt;Java&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../jdbc/"&gt;JDBC&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../jsp/"&gt;JSP&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../css-layout/"&gt;CSS Layout&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../jsp-project/"&gt;JSP Project&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../spring/"&gt;Spring&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../javascript/"&gt;JavaScript&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="../bbs/list.jsp?boardCd=free&amp;page=1"&gt;BBS&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
</pre>

<em class="filename">/inc/extra.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;a href="http://www.youtube.com"&gt;&lt;img src="../images/youtube.png" alt="youtube.com" /&gt;&lt;/a&gt;
&lt;a href="http://www.twitter.com"&gt;&lt;img src="../images/twitter.png" alt="twitter.com" /&gt;&lt;/a&gt;
&lt;a href="http://www.facebook.com"&gt;&lt;img src="../images/facebook.png" alt="facebook.com" /&gt;&lt;/a&gt;
&lt;a href="http://www.gmail.com"&gt;&lt;img src="../images/gmail.png" alt="gmail.com" /&gt;&lt;/a&gt;
&lt;a href="http://www.java-school.net"&gt;&lt;img src="../images/java-school.png" alt="java-school.net" /&gt;&lt;/a&gt;
</pre>

<em class="filename">/inc/footer.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;ul&gt;
    &lt;li&gt;&lt;a href="#"&gt;이용약관&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="#"&gt;개인정보보호정책&lt;/a&gt;&lt;/li&gt;
    &lt;li&gt;&lt;a href="#"&gt;이메일무단수집거부&lt;/a&gt;&lt;/li&gt;
    &lt;li id="company-info"&gt;전화 : 02-123-5678, FAX : 02-123-5678&lt;br /&gt;
    people@ggmail.org&lt;br /&gt;
    Copyright java-school.net All Rights Reserved.&lt;/li&gt;
    &lt;li&gt;&lt;a href="#"&gt;찾아오시는 길&lt;/a&gt;&lt;/li&gt;
&lt;/ul&gt;
</pre>


여기까지가 공통으로 포함(include)되는 파일이다.<br />
주의할 점은 포함하는 페이지와 포함되는 페이지는 페이지 지시어의 contentType 속성이 같아야 한다는 것이다.<br />
같지 않다면 서블릿으로 변환되지 않는다.<br />
아랫부분이 일치해야 한다.<br />

<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
</pre>


<h3>공통 인클루드 파일을 이용하여 서브 페이지 수정</h3>

<em class="filename">/java/index.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="자바 홈" /&gt;
&lt;meta name="Description" content="자바 홈" /&gt;
&lt;title&gt;자바 홈&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;<strong>
        &lt;%@ include file="../inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;<strong>
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Java Home&lt;/div&gt;
            

&lt;!--..중간 생략..--&gt;


&lt;!-- 본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Java&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;<strong>
        &lt;%@ include file="../inc/extra.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="footer"&gt;<strong>
        &lt;%@ include file="../inc/footer.jsp" %&gt;</strong>
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

홈페이지까지 인클루드 지시어를 이용하여 분리하려는 생각은 좋은 생각이 아니다.<br />
대부분 홈페이지는 서브 페이지와 디자인이 다르며 또한 하나만 존재하기 때문이다.<br />
게다가 지금 만든 파일은 상대 경로 문제로 홈페이지에서 인클루드 할 수 없다.<br />
<br />
웹 브라우저로 홈페이지와 서브 페이지 /java/index.jsp를 방문하여 테스트한다.<br />

<h2>로그인 폼, 로그인 처리, 로그아웃 처리 페이지 생성</h2>
로그인 테스트를 위해 로그인 폼, 로그인 처리, 로그아웃 처리 페이지를 생성한다.<br />
먼저 로그인 폼 페이지가 인클루드하는 notLoginUsers-menu.jsp를 /users 디렉터리에 만든다.<br />
이 페이지는 로그인 하지 않은 사용자가 사용할 수 있는 회원 메뉴(로그인, 회원 가입, ID 찾기, 비밀번호 찾기)를 보여준다.<br />

<em class="filename">/users/notLoginUsers-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;회원&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="login.jsp"&gt;로그인&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="signUp.jsp"&gt;회원 가입&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;ID 찾기&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="#"&gt;비밀번호 찾기&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

로그인 폼 페이지를 만든다.<br />
/java/index.jsp를 연 상태에서 Save As... 메뉴를 이용하여 login.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/users/login.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;<strong>
&lt;%
request.setCharacterEncoding("UTF-8");
String url = request.getParameter("url");
if (url == null) url = "";
%&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="로그인" /&gt;
&lt;meta name="Description" content="로그인" /&gt;
&lt;title&gt;로그인&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css" /&gt;<strong>
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("loginForm");
    //TODO 유효성 검사
    return true;
}        

//]]&gt; 
&lt;/script&gt;</strong>
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        <strong>&lt;%@ include file="../inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        <strong>&lt;%@ include file="../inc/main-menu.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;로그인&lt;/h1&gt;
&lt;form id="loginForm" action="login_proc.jsp" method="post" onsubmit="return check()"&gt;
&lt;p style="margin: 0; padding: 0;"&gt;
<strong>&lt;input type="hidden" name="url" value="&lt;%=url %&gt;" /&gt;</strong>
&lt;/p&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td style="width: 200px;"&gt;Email&lt;/td&gt;
    &lt;td style="width: 390px"&gt;&lt;input type="text" name="email" style="width: 99%;" value="captain@heist.com" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" style="width: 99%;" value="1111" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-top: 15px;"&gt;
    &lt;input type="submit" value="확인" /&gt;
    &lt;input type="button" value="회원 가입" onclick="location.href='signUp.jsp'" /&gt;
&lt;/div&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;<strong>
        &lt;%@ include file="notLoginUsers-menu.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;<strong>
        &lt;%@ include file="../inc/extra.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="footer"&gt;<strong>
        &lt;%@ include file="../inc/footer.jsp" %&gt;</strong>
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

로그인을 처리하는 페이지를 만든다.<br />

<em class="filename">/users/login_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User"%&gt;
&lt;%
String url = request.getParameter("url");
String email = request.getParameter("email");
String passwd = request.getParameter("passwd");

session.setAttribute("user", new User(email, passwd, "홍길동", "010-1234-5678"));
if (url != null &amp;&amp; !url.equals("")) {
    response.sendRedirect(url);
} else {
    response.sendRedirect("../bbs/list.jsp?boarCd=free&amp;page=1");
}
%&gt;
</pre>

로그아웃을 처리하는 페이지를 만든다.<br />
로그아웃 후 홈페이지로 이동하도록 구현한다.<br />

<em class="filename">/users/logout_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
session.removeAttribute("user");

response.sendRedirect("../");
%&gt;
</pre>

웹 브라우저로 로그인과 로그아웃을 테스트한다.<br />
로그인하면 아직 만들지 않은 게시판으로 이동하여 404 에러를 보게 된다.<br />
다시 상단의 로고를 클릭하여 홈페이지로 이동, 
홈페이지에서 Java 메인 메뉴를 클릭하여 서브 페이지로 이동한 후 로그아웃하면 홈페이지로 이동한다.<br />

<h2>JSP 에러 핸들링</h2>
web.xml 파일을 열고 &lt;/web-app&gt; 직전에 다음을 추가한다.<br />

<em class="filename">web.xml</em>
    <pre class="prettyprint">&lt;error-page&gt;
    &lt;error-code&gt;403&lt;/error-code&gt;
    &lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
    &lt;error-code&gt;404&lt;/error-code&gt;
    &lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
    &lt;error-code&gt;500&lt;/error-code&gt;
    &lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
&lt;error-page&gt;
    &lt;exception-type&gt;java.lang.Throwable&lt;/exception-type&gt;
    &lt;location&gt;/error.jsp&lt;/location&gt;
&lt;/error-page&gt;
</pre>

주요 에러를 모두 /error.jsp가 담당하도록 하는 설정이다.<br />

<h3>에러 페이지</h3>
홈페이지를 연 상태에서 Save As... 메뉴를 이용하여 error.jsp라는 새 파일을 도큐먼트 베이스에 만든 후 아래와 같이 수정한다.<br />
    
<em class="filename">/error.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.User" %&gt;
&lt;%
<strong>String contextPath = request.getContextPath();</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="Error" /&gt;
&lt;meta name="Description" content="Error" /&gt;
&lt;title&gt;Error&lt;/title&gt;
&lt;link rel="stylesheet" href="<strong>&lt;%=contextPath %&gt;</strong>/css/screen.css" type="text/css" /&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
//Analyze the servlet exception
Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
String servletName = (String) request.getAttribute("javax.servlet.error.servlet_name");

if (servletName == null) {
    servletName = "Unknown";
}

String requestUri = (String) request.getAttribute("javax.servlet.error.request_uri");

if (requestUri == null) {
    requestUri = "Unknown";
}
%&gt;
&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;h1 style="float: left; width: 150px;"&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>"&gt;&lt;img src="<strong>&lt;%=contextPath %&gt;</strong>/images/ci.gif" alt="java-school" /&gt;&lt;/a&gt;&lt;/h1&gt;
        &lt;div id="memberMenu" style="float: right; position: relative; top: 7px;"&gt;
&lt;%
User loginUser = (User) session.getAttribute("user");
if (loginUser == null) {
%&gt;
    &lt;input type="button" value="로그인" onclick="location.href='<strong>&lt;%=contextPath %&gt;</strong>/users/login.jsp'" /&gt;
    &lt;input type="button" value="회원 가입" onclick="location.href='<strong>&lt;%=contextPath %&gt;</strong>/users/signUp.jsp'" /&gt;
&lt;%
} else {
%&gt;   
    &lt;input type="button" value="로그아웃" onclick="location.href='<strong>&lt;%=contextPath %&gt;</strong>/users/logout_proc.jsp'" /&gt;
    &lt;input type="button" value="내 정보 수정" onclick="location.href='<strong>&lt;%=contextPath %&gt;</strong>/users/editAccount.jsp'" /&gt;
&lt;%
}
%&gt;
        &lt;/div&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;ul id="nav"&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/java/"&gt;Java&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/jdbc/"&gt;JDBC&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/jsp/"&gt;JSP&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/css-layout/"&gt;CSS Layout&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/jsp-project/"&gt;JSP Project&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/spring/"&gt;Spring&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/javascript/"&gt;JavaScript&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="<strong>&lt;%=contextPath %&gt;</strong>/bbs/list.jsp?boardCd=free&amp;page=1"&gt;BBS&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 820px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;Error&lt;/div&gt;
            
&lt;h1&gt;Error Page&lt;/h1&gt;
&lt;%
if(statusCode != 500){
    out.write("&lt;h3&gt;Error Details&lt;/h3&gt;");
    out.write("&lt;strong&gt;Status Code&lt;/strong&gt;:" + statusCode + "&lt;br&gt;");
    out.write("&lt;strong&gt;Requested URI&lt;/strong&gt;:"+requestUri);
}    
if (throwable != null) {
    out.write("&lt;h3&gt;Exception Details&lt;/h3&gt;");
    out.write("&lt;ul&gt;&lt;li&gt;Servlet Name:" + servletName + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Name:" + throwable.getClass().getName() + "&lt;/li&gt;");
    out.write("&lt;li&gt;Requested URI:" + requestUri + "&lt;/li&gt;");
    out.write("&lt;li&gt;Exception Message:" + throwable.getMessage() + "&lt;/li&gt;");
    out.write("&lt;/ul&gt;");
}
%&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Error&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;a href="http://www.youtube.com"&gt;&lt;img src="<strong>&lt;%=contextPath %&gt;</strong>/images/youtube.png" alt="youtube.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.twitter.com"&gt;&lt;img src="<strong>&lt;%=contextPath %&gt;</strong>/images/twitter.png" alt="twitter.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.facebook.com"&gt;&lt;img src="<strong>&lt;%=contextPath %&gt;</strong>/images/facebook.png" alt="facebook.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.gmail.com"&gt;&lt;img src="<strong>&lt;%=contextPath %&gt;</strong>/images/gmail.png" alt="gmail.com" /&gt;&lt;/a&gt;
        &lt;a href="http://www.java-school.net"&gt;&lt;img src="<strong>&lt;%=contextPath %&gt;</strong>/images/java-school.png" alt="java-school.net" /&gt;&lt;/a&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="./inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

error.jsp 소스에서 컨텍스트 패스를 구해 모든 경로를 재지정해 주어야 하는데, 
이렇게 하지 않으면 상대 경로 문제를 겪게 된다.<br />
다시 로그인을 시도한다. 아직 만들지 않는 페이지를 방문하는 것이다.<br />
에러 페이지가 작동하는지 확인한다.<br />
<br />

<h2>게시판</h2>

게시판 관련 페이지를 작성한다.<br />

<h3>게시판 메뉴(bbs-menu.jsp) 페이지</h3>
게시판 모듈에서 화면을 담당하는 모든 페이지가 인클루드해야 하는 페이지부터 작성한다.<br />
도큐먼트 베이스에 bbs라는 서브 디렉터리를 만들고, /bbs에 bbs-menu.jsp 파일을 만든다.<br />
bbs-menu.jsp 파일은 게시판에 대한 링크를 제공한다.<br />

<em class="filename">/bbs/bbs-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;게시판&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="list.jsp?boardCd=free&amp;page=1"&gt;자유 게시판&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="list.jsp?boardCd=qna&amp;page=1"&gt;QnA게시판&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="list.jsp?boardCd=data&amp;page=1"&gt;자료실&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

<h3>로그인 체크(loginCheck.jsp) 페이지</h3>
이 페이지는 사용자가 로그인했는지를 검사하고, 로그인하지 않은 사용자는 로그인 페이지로 리다이렉트시킨다.<br />
이때 로그인 후 다시 사용자가 요청한 원래 페이지로 이동하기 위해 url 정보를 로그인 페이지에 전달한다.<br />
공통 인클루드 파일 디렉터리인 /inc에 loginCheck.jsp 파일을 만든다.<br />
이 파일을 공통 인클루드 파일 디렉터리에 생성하는 이유는 게시판 모듈 외에도 사용될 수 있기 때문이다.<br />
    
<em class="filename">/inc/loginCheck.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.user.*"%&gt;
&lt;%@ page import="java.net.URLEncoder"%&gt;
&lt;%   
User user = (User) session.getAttribute("user");
if (user == null) {
    //로그인 후 되돌아갈 URL를 구한다.
    String uri = request.getRequestURI();
    String query = request.getQueryString();
    String url = uri;
    if (query != null) url += "?" + query;
    //로그인 페이지로 리다이렉트
    String contextPath= request.getContextPath();
    url = URLEncoder.encode(url, "UTF-8");
    response.sendRedirect(contextPath + "/users/login.jsp?url=" + url);
    return;
}
%&gt;
</pre>

<h3>목록 페이지</h3>
게시판 목록을 보여주는 페이지를 만든다.<br />
CSS 포지셔닝에서의 만든 list.html 파일을 연 상태에서 Save As... 메뉴를 이용하여 list.jsp라는 이름의 새 파일을 /bbs 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/bbs/list.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ include file="../inc/loginCheck.jsp" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 목록" /&gt;
&lt;meta name="Description" content="게시판 목록" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="<strong>../</strong>css/screen.css" type="text/css" /&gt;<strong>
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
           
function goList(page) {
    var form = document.getElementById("listForm");
    form.page.value = page;
    form.submit();
}

function goView(articleNo) {
    var form = document.getElementById("viewForm");
    form.articleNo.value = articleNo;
    form.submit();
}

function goWrite() {
    var form = document.getElementById("writeForm");
    form.submit();
}

//]]&gt;
&lt;/script&gt;</strong>           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        <strong>&lt;%@ include file="../inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        <strong>&lt;%@ include file="../inc/main-menu.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" <strong>style="min-height: 800px;"</strong>&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
            
&lt;h1&gt;자유 게시판&lt;/h1&gt;
&lt;div id="bbs"&gt;
    &lt;table&gt;
    &lt;!--  게시판 목록 머리말 --&gt;
    &lt;tr&gt;
        &lt;th style="width: 60px"&gt;NO&lt;/th&gt;
        &lt;th&gt;TITLE&lt;/th&gt;
        &lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
        &lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
    &lt;/tr&gt;
    &lt;!--  반복 구간 시작 --&gt;
    &lt;tr&gt;
        &lt;td style="text-align: center;"&gt;11&lt;/td&gt;
        &lt;td&gt;
            &lt;a href="<strong>javascript:goView('1')"</strong>&gt;제목&lt;/a&gt;
            &lt;img src="<strong>../</strong>images/attach.png" alt="첨부 파일" /&gt;
            &lt;span class="bbs-strong"&gt;[5]&lt;/span&gt;
        &lt;/td&gt;
        &lt;td style="text-align: center;"&gt;2011.11.15&lt;/td&gt;
        &lt;td style="text-align: center;"&gt;4555&lt;/td&gt;
    &lt;/tr&gt;
    &lt;!--  반복 구간 끝 --&gt;
    &lt;/table&gt;
        
    &lt;div id="paging"&gt;
        &lt;a href="<strong>javascript:goList('5')"</strong>&gt;[이전]&lt;/a&gt;
        &lt;span class="bbs-strong"&gt;6&lt;/span&gt;
        &lt;a href="<strong>javascript:goList('7')</strong>"&gt;7&lt;/a&gt;
        &lt;a href="<strong>javascript:goList('8')</strong>"&gt;8&lt;/a&gt;
        &lt;a href="<strong>javascript:goList('9')</strong>"&gt;9&lt;/a&gt;
        &lt;a href="<strong>javascript:goList('10')</strong>"&gt;10&lt;/a&gt;
        &lt;a href="<strong>javascript:goList('11')</strong>"&gt;[다음]&lt;/a&gt;  
    &lt;/div&gt;

    &lt;div id="list-menu"&gt;
        &lt;input type="button" value="새 글쓰기" <strong>onclick="goWrite()"</strong> /&gt;
    &lt;/div&gt;

    &lt;div id="search"&gt;
        &lt;form action="list.jsp" method="get"&gt;
            &lt;p style="margin: 0;padding: 0;"&gt;
                &lt;input type="hidden" name="boardCd" value="free" /&gt;
                &lt;input type="hidden" name="page" value="1" /&gt;
                &lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
                &lt;input type="submit" value="검색" /&gt;
            &lt;/p&gt;
        &lt;/form&gt;
    &lt;/div&gt;
    
&lt;/div&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        <strong>&lt;%@ include file="bbs-menu.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        <strong>&lt;%@ include file="../inc/extra.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        <strong>&lt;%@ include file="../inc/footer.jsp" %&gt;</strong>
    &lt;/div&gt;

&lt;/div&gt;
<strong>
&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="listForm" action="list.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="writeForm" action="write_form.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;
</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>글쓰기 폼 페이지</h3>
다음은 게시판 글쓰기 폼 페이지를 작성한다.<br />
CSS 포지셔닝에서 만든 write_form.html 파일을 연 상태에서 Save As... 메뉴를 이용하여 write_form.jsp라는 이름의 새 파일을 /bbs 디렉터리에 만든 후 아래와 같이 수정한다.<br />
    
<em class="filename">/bbs/write_form.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;<strong>
&lt;%@ include file="../inc/loginCheck.jsp" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="글쓰기 화면" /&gt;
&lt;meta name="Description" content="글쓰기 화면" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="<strong>../</strong>css/screen.css" type="text/css" /&gt;
<strong>&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
           
function check() {
    //var form = document.getElementById("writeForm");
    //유효성 검사 로직 추가
    return true;
}

function goList() {
    var form = document.getElementById("listForm");
    form.submit();
}

function goView() {
    var form = document.getElementById("viewForm");
    form.submit();
}
//]]&gt;                    
&lt;/script&gt;</strong>           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        <strong>&lt;%@ include file="../inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        <strong>&lt;%@ include file="../inc/main-menu.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;
        
&lt;!--  본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;자유 게시판&lt;/h1&gt;

&lt;div id="bbs"&gt;
&lt;h2&gt;글쓰기&lt;/h2&gt;
&lt;form id="writeForm" action="write_proc.jsp" method="post" enctype="multipart/form-data" <strong>onsubmit="return check();"</strong>&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
&lt;input type="hidden" name="boardCd" value="free" /&gt;
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;&lt;/textarea&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;첨부 파일&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="전송" /&gt;
    <strong>&lt;input type="button" value="목록" onclick="goList()" /&gt;
    &lt;input type="button" value="상세보기" onclick="goView()" /&gt;</strong>
&lt;/div&gt;
&lt;/form&gt;
&lt;/div&gt;
&lt;!-- 본문 끝 --&gt;

        &lt;/div&gt;
    &lt;/div&gt;
    
    &lt;div id="sidebar"&gt;
        <strong>&lt;%@ include file="bbs-menu.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        <strong>&lt;%@ include file="../inc/extra.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        <strong>&lt;%@ include file="../inc/footer.jsp" %&gt;</strong>   
    &lt;/div&gt;

&lt;/div&gt;
<strong>
&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="listForm" action="list.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;   
&lt;/div&gt;
</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>글쓰기 처리 페이지</h3>
글쓰기 처리 페이지를 작성한다.<br />
이 페이지는 글쓰기 폼에서 전달받는 파라미터로 실제로 데이터베이스에 인서트를 담당한다.<br />

<em class="filename">/bbs/write_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
새 게시글을 등록하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
로그인 사용자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
로그인 체크를 통과하면
boardCd, title, content, attachFile 파라미터를 가지고 새 글을 인서트한다.

form의 enctype 속성이 "multipart/form-data"인 경우 request.getParameter();로 파라미터의 값을 얻을 수 없다.
이 경우 프로그래밍을 손쉽게 하려면 아파치 commons-fileupload 또는 cos와 같은 외부 라이브러리를 이용한다.

새 글을 등록한 후 목록의 첫 번째 페이지로 되돌아가야 한다.
*/
response.sendRedirect("list.jsp?boardCd=free&amp;page=1");
%&gt;
</pre>

<h3>상세보기 페이지</h3>
목록에서 제목을 클릭하면 보이게 되는 게시글 상세보기 페이지를 만든다.<br />
CSS 포지셔닝에서 만든 view.html 파일을 연 상태에서 Save As... 메뉴를 이용하여 view.jsp 이름의 새 파일을 /bbs 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/bbs/view.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ include file="../inc/loginCheck.jsp" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 상세보기" /&gt;
&lt;meta name="Description" content="게시판 상세보기" /&gt;
&lt;title&gt;BBS&lt;/title&gt;
&lt;link rel="stylesheet" href="<strong>../</strong>css/screen.css" type="text/css" /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function modifyCommentToggle(articleNo) {
    var p_id = "comment" + articleNo;
    var form_id = "modifyCommentForm" + articleNo;
    var p = document.getElementById(p_id);
    var form = document.getElementById(form_id);
    var p_display;
    var form_display;
    
    if (p.style.display) {
        p_display = '';
        form_display = 'none';
    } else {
        p_display = 'none';
        form_display = '';
    }
    
    p.style.display = p_display;
    form.style.display = form_display;
}
<strong>
function goList(page) {
    var form = document.getElementById("listForm");
    form.page.value = page;
    form.submit();
}

function goView(articleNo) {
    var form = document.getElementById("viewForm");
    form.articleNo.value = articleNo;
    form.submit();
}

function goWrite() {
    var form = document.getElementById("writeForm");
    form.submit();
}

function goModify() {
    var form = document.getElementById("modifyForm");
    form.submit();
}

function goDelete() {
    var check = confirm("정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("delForm");
        form.submit();
    }
}

function deleteAttachFile(attachFileNo) {
    var check = confirm("첨부 파일을 정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("deleteAttachFileForm");
        form.attachFileNo.value = attachFileNo;
        form.submit();
    }
}

function deleteComment(commentNo) {
    var check = confirm("댓글을 정말로 삭제하시겠습니까?");
    if (check) {
        var form = document.getElementById("deleteCommentForm");
        form.commentNo.value = commentNo;
        form.submit();
    }
}
</strong>
//]]&gt;
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        <strong>&lt;%@ include file="../inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        <strong>&lt;%@ include file="../inc/main-menu.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
&lt;h1&gt;자유 게시판&lt;/h1&gt;

&lt;div id="bbs"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 37px;text-align: left;vertical-align: top;"&gt;TITLE&lt;/th&gt;
    &lt;th style="text-align: left;color: #555;"&gt;무궁화꽃이피었습니다&lt;/th&gt;
&lt;/tr&gt; 
&lt;/table&gt;
&lt;div id="gul-content"&gt;
    &lt;span id="date-writer-hit"&gt;<strong>edited 2014-10-09 17:55:30 by 홍길동 hit 1330</strong>&lt;/span&gt;
    &lt;p&gt;
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다&lt;br /&gt;
    무궁화꽃이피었습니다무궁화꽃이피었습니다무궁화꽃이피었습니다&lt;br /&gt;
    &lt;/p&gt;
    <strong>&lt;p id="file-list" style="text-align: right"&gt;
        &lt;a href="#"&gt;abc.zip&lt;/a&gt;
        &lt;a href="javascript:deleteAttachFile('23')"&gt;x&lt;/a&gt;
    &lt;/p&gt;</strong>
&lt;/div&gt;

&lt;!--  댓글 반복 시작 --&gt;
&lt;div class="comments"&gt;
    &lt;span class="writer"&gt;xman&lt;/span&gt;
    &lt;span class="date"&gt;2011.12.11 12:14:32&lt;/span&gt;
    &lt;span class="modify-del"&gt;
        &lt;a href="javascript:modifyCommentToggle('5')"&gt;수정&lt;/a&gt;
         | &lt;a href="javascript:deleteComment('5')"&gt;삭제&lt;/a&gt;
    &lt;/span&gt;
    &lt;p id="comment5"&gt;무궁화꽃이피었습니다&lt;/p&gt;
    &lt;form id="modifyCommentForm5" class="modify-comment" action="updateComment_proc.jsp" method="post" style="display: none;"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="articleNo" value="12" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;div class="fr"&gt;
            &lt;a href="javascript:document.forms.modifyCommentForm5.submit()"&gt;수정하기&lt;/a&gt;
            | &lt;a href="javascript:modifyCommentToggle('5')"&gt;취소&lt;/a&gt;
    &lt;/div&gt;
    &lt;div&gt;
        &lt;textarea class="modify-comment-ta" name="memo" rows="7" cols="50"&gt;무궁화꽃이 피었습니다.&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;/form&gt;
&lt;/div&gt;
&lt;!--  댓글 반복 끝 --&gt;

&lt;form id="addCommentForm" action="addComment_proc.jsp" method="post"&gt;
    &lt;p style="margin: 0; padding: 0;"&gt;
        &lt;input type="hidden" name="articleNo" value="5"/&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;div id="addComment"&gt;
        &lt;textarea name="memo" rows="7" cols="50"&gt;&lt;/textarea&gt;
    &lt;/div&gt;
    &lt;div style="text-align: right;"&gt;
        &lt;input type="submit" value="댓글 남기기" /&gt;
    &lt;/div&gt;
&lt;/form&gt;

&lt;div id="next-prev"&gt;
    &lt;p&gt;다음 글 : &lt;a href="<strong>javascript:goView('6')"</strong>&gt;무궁화꽃이 피었습니다.&lt;/a&gt;&lt;/p&gt;
    &lt;p&gt;이전 글 : &lt;a href="<strong>javascript:goView('4')"</strong>&gt;무궁화꽃이 피었습니다.&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

&lt;div id="view-menu"&gt;
    &lt;div class="fl"&gt;
        &lt;input type="button" value="수정" <strong>onclick="goModify()</strong>" /&gt;
        &lt;input type="button" value="삭제" <strong>onclick="goDelete()</strong>"/&gt;
    &lt;/div&gt;
    &lt;div class="fr"&gt;
        &lt;input type="button" value="다음 글" <strong>onclick="goView('6')"</strong> /&gt;
        &lt;input type="button" value="이전 글" <strong>onclick="goView('4')"</strong> /&gt;
        &lt;input type="button" value="목록" <strong>onclick="goList('1')"</strong> /&gt;
        &lt;input type="button" value="새 글쓰기" <strong>onclick="goWrite()"</strong> /&gt;
    &lt;/div&gt;
&lt;/div&gt;

&lt;!-- 목록 --&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;th style="width: 60px"&gt;NO&lt;/th&gt;
    &lt;th&gt;TITLE&lt;/th&gt;
    &lt;th style="width: 84px;"&gt;DATE&lt;/th&gt;
    &lt;th style="width: 60px;"&gt;HIT&lt;/th&gt;
&lt;/tr&gt;
    
&lt;tr&gt;
    &lt;td style="text-align: center;"&gt;<strong>&lt;img src="../images/arrow.gif" alt="현재 글" /&gt;</strong>&lt;/td&gt;
    &lt;td&gt;
        &lt;a href="<strong>javascript:goView('1')"</strong>&gt;제목&lt;/a&gt;
        &lt;img src="<strong>../</strong>images/attach.png" alt="첨부 파일" /&gt;
        &lt;span class="bbs-strong"&gt;[5]&lt;/span&gt;
    &lt;/td&gt;
    &lt;td style="text-align: center;"&gt;2011.11.15&lt;/td&gt;
    &lt;td style="text-align: center;"&gt;4555&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
    
&lt;div id="paging"&gt;
    &lt;a href="<strong>javascript:goList('5')"</strong>&gt;[이전]&lt;/a&gt;
    &lt;span class="bbs-strong"&gt;6&lt;/span&gt;
    &lt;a href="<strong>javascript:goList('7')"</strong>&gt;7&lt;/a&gt;
    &lt;a href="<strong>javascript:goList('8')"</strong>&gt;8&lt;/a&gt;
    &lt;a href="<strong>javascript:goList('9')"</strong>&gt;9&lt;/a&gt;
    &lt;a href="<strong>javascript:goList('10')"</strong>&gt;10&lt;/a&gt;
    &lt;a href="<strong>javascript:goList('11')"</strong>&gt;[다음]&lt;/a&gt;
&lt;/div&gt;

&lt;div id="list-menu"&gt;
    &lt;input type="button" value="새 글쓰기" <strong>onclick="goWrite()"</strong> /&gt;
&lt;/div&gt;

&lt;div id="search"&gt;
    &lt;form action="list.jsp" method="get"&gt;
        &lt;p style="margin: 0;padding: 0;"&gt;
            &lt;input type="hidden" name="boardCd" value="free" /&gt;
            &lt;input type="hidden" name="page" value="1" /&gt;
            &lt;input type="text" name="searchWord" size="15" maxlength="30" /&gt;
            &lt;input type="submit" value="검색" /&gt;
        &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;
    
&lt;/div&gt;&lt;!-- bbs 끝 --&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        <strong>&lt;%@ include file="bbs-menu.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        <strong>&lt;%@ include file="../inc/extra.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        <strong>&lt;%@ include file="../inc/footer.jsp" %&gt;</strong>
    &lt;/div&gt;

&lt;/div&gt;
<strong>
&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="listForm" action="list.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="writeForm" action="write_form.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="12" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="modifyForm" action="modify_form.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="delForm" action="del_proc.jsp" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
    &lt;form id="deleteCommentForm" action="deleteComment_proc.jsp" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="commentNo" /&gt;
        &lt;input type="hidden" name="articleNo" value="12" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;   
    &lt;form id="deleteAttachFileForm" action="deleteAttachFile_proc.jsp" method="post"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="attachFileNo" /&gt;
        &lt;input type="hidden" name="articleNo" value="23" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;       
&lt;/div&gt;
</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>댓글 쓰기 처리 페이지</h3>
댓글 쓰기 처리 페이지는 상세보기 페이지에서 새 댓글을 쓰고 확인을 클릭하면 실제 댓글을 데이터베이스에 인서트 하는 페이지이다.<br />

<em class="filename">/bbs/addComment_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
새로운 댓글을 인서트하는 페이지로 모델 2에서는 삭제해야 할 페이지이다.
-구현-
로그인 사용자가 아니면 
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
로그인 체크를 통과하면 
먼저 요청의 캐릭터 셋을 UTF-8로 설정한다.
boardCd, articleNo, page, searchWord, memo 파라미터를 받아서 댓글을 인서트한다.
댓글을 인서트한 후 상세보기를 돌아가기 위해선
검색어 searchWord를 URLEncoder의 encode 메서드로 UTF-8로 인코딩해야 한다.
*/
response.sendRedirect("view.jsp?articleNo=5&amp;boardCd=free&amp;page=1&amp;searchWord=무궁화꽃");
%&gt;
</pre>

<h3>댓글 수정 처리 페이지</h3>
이 페이지는 상세 보기에서 댓글의 작성자가 자신의 댓글 내용을 수정한 후 확인을 클릭하면 데이터베이스에 있는 댓글의 내용을 수정하는 페이지이다.<br />

<em class="filename">/bbs/updateComment_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
댓글 업데이트를 실행하는 페이지로 모델 2에서는 삭제해야 할 페이지이다.
-구현-
작성자인지를 검사하여 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Authentication Failed"); return;
작성자 체크를 통과하면
요청의 캐릭터 셋을 UTF-8로 설정한다.
commentNo, boardCd, articleNo, page, searchWord, memo 파라미터를 받아서
댓글을 업데이트한다.
댓글을 업데이트 처리한 후 상세보기를 돌아가기 위해선
검색어 searchWord를 URLEncoder의 encode 메서드로 UTF-8로 인코딩해야 한다.
*/
response.sendRedirect("view.jsp?articleNo=5&amp;boardCd=free&amp;page=1&amp;searchWord=무궁화꽃");
%&gt;
</pre>

<h3>댓글 삭제 처리 페이지</h3>
이 페이지는 상세 보기에서 댓글 삭제를 클릭하면 데이터베이스에 있는 해당 댓글을 삭제하는 페이지이다.<br />

<em class="filename">/bbs/deleteComment_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
댓글 삭제를 실행하는 페이지로 모델 2에서는 삭제해야 할 페이지이다.

-구현-
작성자인지를 검사하여 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "작성자가 아닙니다"); return;
요청의 캐릭터 셋을 UTF-8로 설정해야 한다.
요청에서 참조해야 하는 파라미터는
commentNo, boardCd, articleNo, page, searchWord 이다.
댓글을 삭제 후 상세보기를 돌아가기 위해선
searchWord를 URLEncoder의 encode 메서드로 UTF-8로 인코딩한다.
*/
response.sendRedirect("view.jsp?articleNo=5&amp;boardCd=free&amp;page=1&amp;searchWord=무궁화꽃");
%&gt;
</pre>

<h3>첨부 파일 삭제 처리 페이지</h3>
이 페이지는 상세 보기에서 첨부 파일 옆의 x 링크를 클릭하면 데이터베이스에 있는 첨부 파일을 삭제하는 페이지이다.<br />
파일시스템의 파일은 삭제하지 않는다.<br />

<em class="filename">/bbs/deleteAttachFile_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
첨부 파일 삭제를 실행하는 페이지로 모델 2에서는 삭제해야 할 페이지이다.

-구현-
작성자인지를 검사하여 작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "작성자가 아닙니다"); return;
요청의 캐릭터 셋을 UTF-8로 설정해야 한다.
요청에서 참조해야 하는 파라미터는
attachFileNo,articleNo,boardCd,page,searchWord 이다.
첨부 파일를 삭제 후 상세보기를 돌아가기 위해선
searchWord를 URLEncoder의 encode 메서드로 UTF-8로 인코딩한다.
*/
response.sendRedirect("view.jsp?articleNo=5&amp;boardCd=free&amp;page=1&amp;searchWord=무궁화꽃");
%&gt;
</pre>

<h3>게시글 삭제 처리 페이지</h3>
이 페이지는 상세보기 페이지에서 게시글을 삭제하는 삭제 버튼을 클릭하면 실제 게시글을 데이터베이스에서 삭제 처리한다.<br />

<em class="filename">/bbs/del_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
게시글을 삭제하는 페이지로 모델 2에서는 삭제해야 할 페이지이다.
-구현-
작성자가 아니면 
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Authentication Failed"); return;
작성자 체크를 통과하면
요청의 캐릭터 셋을 UTF-8로 설정한다.
articleNo, boardCd, page, searchWord 파라미터를 받고
articleNo로 게시글을 삭제한다.
게시글 삭제 후 목록를 돌아가기 위해선
검색어 searchWord를 URLEncoder의 encode 메서드로 UTF-8로 인코딩해야 한다.
*/
response.sendRedirect("list.jsp?boardCd=free&amp;page=1&amp;searchWord=무궁화꽃");
%&gt;
</pre>

<h3>게시글 수정 폼 페이지</h3>
글 소유자가 자신의 글을 수정하기 위한 페이지를 만든다.<br />
CSS 포지셔닝에서 만든 write_form.jsp 파일을 연 상태에서 Save As... 메뉴를 이용하여 modify_form.jsp라는 이름의 새 파일을 /bbs 폴더에 만든 후 아래와 같이 수정한다.<br /> 

<em class="filename">/bbs/modify_form.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %&gt;
<strong>&lt;%
User user = (User) session.getAttribute("user");
if (user == null) {
    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login User");
    return;
}
request.setCharacterEncoding("UTF-8");
int articleNo = Integer.parseInt(request.getParameter("articleNo"));
String boardCd = request.getParameter("boardCd");
String page = request.getParameter("page");
String searchWord = request.getParameter("searchWord");
//TODO articleNo로 게시글 객체를 얻어서 현재 로그인된 사용자가 글 소유자인지를 검사한다.</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="게시판 수정하기 폼" /&gt;
&lt;meta name="Description" content="게시판 수정하기 폼" /&gt;
&lt;title&gt;자유 게시판&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("writeForm");
    //유효성 검사 로직 추가
    return true;
}

function goView() {
    var form = document.getElementById("viewForm");
    form.submit();
}

//]]&gt;
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;BBS&lt;/div&gt;
            
&lt;h1&gt;자유 게시판&lt;/h1&gt;
&lt;div id="bbs"&gt;
&lt;h2&gt;수정&lt;/h2&gt;
&lt;form id="writeForm" action="<strong>modify_proc.jsp</strong>" method="post" enctype="multipart/form-data" onsubmit="return check();"&gt;
&lt;p style="margin: 0;padding: 0;"&gt;
<strong>&lt;input type="hidden" name="articleNo" value="5" /&gt;</strong>
&lt;input type="hidden" name="boardCd" value="free" /&gt;
<strong>&lt;input type="hidden" name="page" value="1" /&gt;
&lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;</strong>
&lt;/p&gt;
&lt;table id="write-form"&gt;
&lt;tr&gt;
    &lt;td&gt;제목&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="title" style="width: 90%;" value="무궁화꽃" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;
        &lt;textarea name="content" rows="17" cols="50"&gt;무궁화꽃이피었습니다&lt;/textarea&gt;
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;첨부 파일&lt;/td&gt;
    &lt;td&gt;&lt;input type="file" name="attachFile" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="전송" /&gt;
    &lt;input type="button" value="상세보기" onclick="goView()" /&gt;
&lt;/div&gt;
&lt;/form&gt;
&lt;/div&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="bbs-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;div id="form-group" style="display: none"&gt;
    &lt;form id="viewForm" action="view.jsp" method="get"&gt;
    &lt;p&gt;
        &lt;input type="hidden" name="articleNo" value="5" /&gt;
        &lt;input type="hidden" name="boardCd" value="free" /&gt;
        &lt;input type="hidden" name="page" value="1" /&gt;
        &lt;input type="hidden" name="searchWord" value="무궁화꽃" /&gt;
    &lt;/p&gt;
    &lt;/form&gt;
&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>게시글 수정 처리 페이지</h3>
게시글 수정 폼에서 전달받은 파라미터를 가지고 실제로 게시글 수정을 처리하는 페이지이다.<br />

<em class="filename">/bbs/modify_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
게시글을 수정하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
작성자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Authentication Failed"); return;
articleNo, boardCd, page, searchWord, title, content, attachFile 파라미터를 받고
게시글을 수정한다.
form의 enctype 속성이 "multipart/form-data"인 경우 request.getParameter()로 파라미터의 값을 얻을 수 없다.
쉽게 프로그래밍하기 위해 아파치 commons-fileupload 또는 cos와 같은 외부 라이브러리를 이용한다.
게시글을 수정한 후 상세보기를 돌아가기 위해 searchWord를 URLEncoder의 encode 메서드를 이용해 UTF-8로 인코딩한다.
*/
response.sendRedirect("view.jsp?articleNo=5&amp;page=1&amp;boardCd=free&amp;searchWord=무궁화꽃");
%&gt;
</pre>

게시판 관련 프로토타입 작업을 완료했다.<br />
충분히 테스트해야 한다.<br />
테스트 후 회원 관련 프로토타입을 작업한다.<br />

<h2>회원</h2>
회원 관련 페이지를 작성한다.<br />

<h3>로그인 사용자를 위한 회원 메뉴 페이지</h3>
이미 로그인하지 않은 사용자가 사용할 수 있는 회원 메뉴 페이지인 notLoginUsers-menu.jsp는 작성했다.<br />
로그인 사용자가 이용할 수 있는 회원 메뉴 페이지인 loginUsers-menu.jsp 파일을 아래와 같이 작성한다.<br />

<em class="filename">/users/loginUsers-menu.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;h1&gt;회원&lt;/h1&gt;
&lt;ul&gt;
    &lt;li&gt;
        &lt;ul&gt;
            &lt;li&gt;&lt;a href="logout_proc.jsp"&gt;로그아웃&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="editAccount.jsp"&gt;내 정보 수정&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="changePasswd.jsp"&gt;비밀번호 변경&lt;/a&gt;&lt;/li&gt;
            &lt;li&gt;&lt;a href="bye.jsp"&gt;탈퇴&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
    &lt;/li&gt;
&lt;/ul&gt;
</pre>

<h3>회원 가입 폼 페이지</h3>
회원 가입 폼 페이지를 만든다.<br />
CSS 포지셔닝에서 만든 singUp.html 파일을 연 상태에서 Save As... 메뉴를 이용하여 signUp.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/users/signUp.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="회원 가입" /&gt;
&lt;meta name="Description" content="회원 가입" /&gt;
&lt;title&gt;회원 가입&lt;/title&gt;
&lt;link rel="stylesheet" href="<strong>../</strong>css/screen.css" type="text/css" /&gt;
<strong>&lt;script type="text/javascript"&gt;
//&lt;![CDATA[ 

function check() {
    //var form = document.getElementById("signUpForm");
    //TODO 유효성 검사
    return true;
}

//]]&gt; 
&lt;/script&gt;</strong>           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        <strong>&lt;%@ include file="../inc/header.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        <strong>&lt;%@ include file="../inc/main-menu.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
&lt;h1&gt;회원 가입&lt;/h1&gt;
&lt;form id="signUpForm" action="signUp_proc.jsp" method="post" <strong>onsubmit="return check()"</strong>&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td style="width: 200px;"&gt;이름(Full Name)&lt;/td&gt;
    &lt;td style="width: 390px"&gt;&lt;input type="text" name="name" style="width: 99%;" <strong>value="홍길동"</strong> /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" style="width: 99%;" <strong>value="1111"</strong> /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2" style="text-align: center;font-weight: bold;"&gt;
    Email이 아이디로 쓰이므로 비밀번호는 Email 계정 비밀번호와 같게 하지 마세요.
    &lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호 확인(Confirm)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="confirm" style="width: 99%;" <strong>value="1111"</strong> /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;Email&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="email" style="width: 99%;" <strong>value="captain@heist.com"</strong> /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;이동전화(Mobile)&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="mobile" style="width: 99%;" <strong>value="010-1234-5678"</strong> /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;div style="text-align: center;padding-bottom: 15px;"&gt;
    &lt;input type="submit" value="확인" /&gt;
&lt;/div&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        <strong>&lt;%@ include file="notLoginUsers-menu.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        <strong>&lt;%@ include file="../inc/extra.jsp" %&gt;</strong>
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        <strong>&lt;%@ include file="../inc/footer.jsp" %&gt;</strong>
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>회원 가입 처리 페이지</h3>
실제로 회원 가입을 처리하는 페이지이다.<br />
회원을 데이터베이스에 등록 후 환영 페이지(welcome.jsp)로 이동하게 구현했다.<br />

<em class="filename">/users/signUp_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
회원 가입을 처리하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
자동으로 로그인하지 않는다.
회원 가입이 완료되면 환영페이지로 이동한다.
*/
response.sendRedirect("welcome.jsp");
%&gt;
</pre>

<h3>회원 가입 환영 페이지</h3>
이 페이지의 목적은 사용자에게 회원 가입이 성공했음을 알려주는 것이다.<br />
실제 회원 가입이 되지 않았는데 이 페이지를 보게 해서는 안 된다.<br />
signUp.jsp 파일을 연 상태에서 Sava As.. 메뉴를 이용하여 welcome.jsp라는 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />
 
<em class="filename">/users/welcome.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="회원 가입 환영" /&gt;
&lt;meta name="Description" content="회원 가입 환영" /&gt;
&lt;title&gt;회원 가입이 완료되었습니다.&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;
        
&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;
<strong>
&lt;h1&gt;환영합니다.&lt;/h1&gt;
회원 가입시 입력한 Email이 아이디로 사용됩니다.&lt;br /&gt;
&lt;input type="button" value="로그인" onclick="javascript:location.href='login.jsp'" /&gt;</strong>
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;h1&gt;Welcome&lt;/h1&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>내 정보 수정 폼 페이지</h3>
로그인한 사용자가 자신의 정보를 수정할 수 있도록 양식을 보여주는 페이지이다.<br />
signUp.jsp 파일을 연 상태에서 Save As... 메뉴를 이용하여 editAccount.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/users/editAccount.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ include file="../inc/loginCheck.jsp" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="내 정보 수정" /&gt;
&lt;meta name="Description" content="내 정보 수정" /&gt;
&lt;title&gt;내 정보 수정&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[

function check() {
    //var form = document.getElementById("editAccountForm");
    //TODO 유효성 검사
    return true;
}

//]]&gt; 
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;내 정보 수정&lt;/h1&gt;
&lt;p&gt;
비밀번호외의 자신의 계정 정보를 수정할 수 있습니다.&lt;br /&gt;
비밀번호는 &lt;a href="changePasswd.jsp"&gt;비밀번호 변경&lt;/a&gt;메뉴를 이용하세요.&lt;br /&gt;
&lt;/p&gt;
&lt;form id="editAccountForm" action="editAccount_proc.jsp" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;이름(Full Name)&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="name" value="&lt;%=user.getName() %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;이동전화(Mobile)&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="mobile" value="&lt;%=user.getMobile() %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;현재 비밀번호(Password)&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="전송" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>내 정보 수정 처리 페이지</h3>
내 정보 수정 폼 페이지에서 전달된 정보로 회원정보를 실제로 수정하는 페이지이다.<br />

<em class="filename">/users/editAccount_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
회원정보를 수정하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
로그인되어 있지 않으면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
회원정보를 수정한 후 다시 로그인하고 비밀번호 변경화면으로 이동한다.
비밀번호 변경 화면에서는 비밀번호 외에 회원정보를 모두 볼 수 있기 때문이다.
*/
response.sendRedirect("changePasswd.jsp");
%&gt;
</pre>

<h3>비밀번호 변경 폼 페이지</h3>
비밀번호를 변경하는 페이지를 만든다.<br />
editAccount.jsp 파일을 연 상태에서 Save As... 메뉴를 이용하여 changePasswd.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/users/changePasswd.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ include file="../inc/loginCheck.jsp" %&gt;</strong>
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="비밀번호 변경" /&gt;
&lt;meta name="Description" content="비빌번호 변경" /&gt;
&lt;title&gt;비밀번호 변경&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
<strong>           
function check() {
    var form = document.getElementById("changePasswordForm");
    if (form.newPasswd.value == form.confirm.value) {
        return true;    
    } else {
        alert("[변경 비밀번호]와 [변경 비밀번호 확인] 값이 같지 않습니다.");
        return false;
    }
}
</strong>
//]]&gt; 
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;비밀번호 변경&lt;/h1&gt;
&lt;%=user.getName() %&gt;&lt;br /&gt;
이동전화 &lt;%=user.getMobile() %&gt;&lt;br /&gt;
&lt;form id="changePasswordForm" action="<strong>changePasswd_proc.jsp</strong>" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;현재 비밀번호&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="currentPasswd" /&gt;&lt;/td&gt;   
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;변경 비밀번호&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="newPasswd" /&gt;&lt;/td&gt;   
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;변경 비밀번호 확인&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="confirm" /&gt;&lt;/td&gt; 
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="확인" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>비밀번호 변경 처리 페이지</h3>
비밀번호 변경 폼 페이지에서 전달된 비밀번호로 회원 테이블의 비밀번호를 수정하는 페이지이다.<br />

<em class="filename">/users/changePasswd_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
비밀번호를 변경하는 페이지로 모델 2에서는 삭제해야 할 페이지다.
-구현-
로그인 사용자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
비밀번호 변경 후 비밀번호 변경 확인 페이지로 이동한다.
*/
response.sendRedirect("changePasswd_confirm.jsp");
%&gt;
</pre>

<h3>비밀번호 변경 확인 페이지</h3>
비밀번호 변경이 완료되었음을 알려주는 역할만을 담당하는 페이지를 만든다.<br />
비밀번호 변경이 실패했는데 이 페이지가 보여서는 안 된다.<br />
welcome.jsp 파일을 연 상태에서 Save As... 메뉴를 이용하여 changePasswd_confirm.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />
    
<em class="filename">/users/changePasswd_confirm.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="비밀번호 변경 확인" /&gt;
&lt;meta name="Description" content="비밀번호 변경 확인" /&gt;
&lt;title&gt;비밀번호 변경 확인&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;비밀번호가 변경되었습니다.&lt;/h1&gt;
변경된 비밀번호로 다시 로그인하실 수 있습니다.&lt;br /&gt;<strong>
&lt;input type="button" value="로그인" onclick="javascript:location.href='login.jsp'" /&gt;</strong>
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        <strong>&lt;%@ include file="loginUsers-menu.jsp" %&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>회원 탈퇴 폼 페이지</h3>
회원 탈퇴를 위한 이메일과 비밀번호 폼을 보여주는 페이지를 만든다.<br />
editAccount.jsp 파일을 연 상태에서 Save As... 메뉴를 이용하여 bye.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/users/bye.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ include file="../inc/loginCheck.jsp" %&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="탈퇴" /&gt;
&lt;meta name="Description" content="탈퇴" /&gt;
&lt;title&gt;탈퇴&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;script type="text/javascript"&gt;
//&lt;![CDATA[
           
function check() {
    //var form = document.getElementById("byeForm");
    //유효성 검사
    return true;
}

//]]&gt; 
&lt;/script&gt;           
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        &lt;%@ include file="../inc/header.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;탈퇴&lt;/h1&gt;
&lt;form id="byeForm" action="bye_proc.jsp" method="post" onsubmit="return check()"&gt;
&lt;table&gt;
&lt;tr&gt;
    &lt;td&gt;이메일&lt;/td&gt;
    &lt;td&gt;&lt;input type="text" name="email" /&gt;&lt;/td&gt;   
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td&gt;비밀번호&lt;/td&gt;
    &lt;td&gt;&lt;input type="password" name="passwd" /&gt;&lt;/td&gt;  
&lt;/tr&gt;
&lt;tr&gt;
    &lt;td colspan="2"&gt;&lt;input type="submit" value="확인" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;

    &lt;div id="sidebar"&gt;
        &lt;%@ include file="loginUsers-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>회원 탈퇴 처리 페이지</h3>
회원 탈퇴를 처리하는 페이지를 만든다.<br />

<em class="filename">/users/bye_proc.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
/*
회원탈퇴를 처리하는 페이지로 모델 2에서는 삭제해야 한다.
-구현-
로그인 사용자가 아니면
response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not Login"); return;
회원테이블에서 회원정보를 지운다.
세션을 지운다.
탈퇴 확인 페이지로 이동한다.
*/
response.sendRedirect("bye_confirm.jsp");
%&gt;
</pre>

<h3>회원 탈퇴 확인 페이지</h3>
회원 탈퇴가 완료되었음을 확인시켜주는 페이지를 만든다.<br />
welcome.jsp 파일을 연 상태에서 Save As... 메뉴를 이용하여 bye_confirm.jsp라는 이름의 새 파일을 /users 디렉터리에 만든 후 아래와 같이 수정한다.<br />

<em class="filename">/users/bye_confirm.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html lang="ko"&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;meta name="Keywords" content="탈퇴 확인" /&gt;
&lt;meta name="Description" content="탈퇴 확인" /&gt;
&lt;title&gt;탈퇴 확인&lt;/title&gt;
&lt;link rel="stylesheet" href="../css/screen.css" type="text/css"  /&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;div id="wrap"&gt;

    &lt;div id="header"&gt;
        
    &lt;/div&gt;

    &lt;div id="main-menu"&gt;
        &lt;%@ include file="../inc/main-menu.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="container"&gt;
        &lt;div id="content" style="min-height: 800px;"&gt;

&lt;!-- 본문 시작 --&gt;
&lt;div id="url-navi"&gt;회원&lt;/div&gt;

&lt;h1&gt;회원 탈퇴 확인&lt;/h1&gt;
회원님의 모든 정보가 삭제되었습니다.&lt;br /&gt;
&lt;!--  본문 끝 --&gt;

        &lt;/div&gt;&lt;!-- content 끝 --&gt;
    &lt;/div&gt;&lt;!--  container 끝 --&gt;
    
    &lt;div id="sidebar"&gt;
        <strong>&lt;h1&gt;Goodbye&lt;/h1&gt;</strong>
    &lt;/div&gt;
    
    &lt;div id="extra"&gt;
        &lt;%@ include file="../inc/extra.jsp" %&gt;
    &lt;/div&gt;

    &lt;div id="footer"&gt;
        &lt;%@ include file="../inc/footer.jsp" %&gt;
    &lt;/div&gt;

&lt;/div&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

게시판 화면에 해당하는 페이지는 list.jsp, view.jsp, write_form.jsp, modify_form.jsp이다.<br />
이 중에 modify_form.jsp를 제외하고 모두 loginCheck.jsp 파일을 인클루드하는데, 
modify_form.jsp 만 빠진 이유는 로그인뿐 아니라 글 소유자인지 검사하는 로직이 필요하기 때문이다.<br />
이것은 구현 단계에서 할 작업으로 남겨 두었다.<br />
<br />
회원 페이지 중 editAccount.jsp, changePasswd.jsp, bye.jsp는 loginCheck.jsp 파일을 인클루드한다.<br />
<br />
화면을 보여주지 않고 처리만을 담당하는 페이지는 파일명에 _proc를 붙여서 구별했다.<br />

<h2>로그인 정책 정리</h2>
구현에 앞서 로그인 정책을 다시 확인한다.<br />

<ol>
	<li>게시판과 관련된 모든 페이지는 로그인이 필요하다.</li>
	<li>회원 모듈에서 내 정보 수정, 비밀번호 변경, 탈퇴는 로그인이 필요하다.</li>
	<li>로그인이 성공하면 /bbs/list.jsp?boardCd=free&amp;page=1로 이동한다.</li>
	<li>로그인하지 않고 로그인이 필요한 페이지를 방문하면 로그인 페이지로 이동하고, 로그인이 성공하면 원래 방문하려 했던 페이지로 이동한다.</li>
	<li>로그아웃하면 홈페이지로 이동한다.</li>
</ol>

이로써 프로토타입을 완성했다.<br />
이 프로토타입은 과정 마지막까지 쓰인다.<br />    
			