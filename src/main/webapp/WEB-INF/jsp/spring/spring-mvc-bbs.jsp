<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.5.19</div>

<h1>Spring MVC 게시판</h1>

게시판 프로젝트 최종 결과물에 Spring MVC를 적용해보자.<br />
기존 모델 2게시판의 코드를 보존하기 위해서 새로운 프로젝트에서 작업하기로 한다.<br />
이클립스를 실행하고 워크스페이스를 <em class="path">C:\www</em>로 선택한다.<br />
File - New - Maven Project을 선택하고 대화상자에서 메이븐 아키타입(Archetype)을 
<em class="path">maven-archetype-webapp</em>로 선택한다.<br />

<img alt="Select maven-archetype-webapp" src="https://lh3.googleusercontent.com/-H52jwWCi_DE/VYZX1o7JiZI/AAAAAAAACjo/ROmvXMnxBrk/s562/archetype-webapp-1.png" /><br />
아래와 같이 정한다.<br />
Group Id : <em class="path">net.java_school</em><br />
Artifact Id : <em class="path">spring-bbs</em><br />

<img alt="Specify Archetype parameters" src="https://lh3.googleusercontent.com/-FnZxo8BBAFY/VYZX1vkqbrI/AAAAAAAACjw/zhApX_EPsaU/s562/archetype-param-2.png" /><br />

메이븐 프로젝트를 생성한 직후에 Marker 뷰에서 에러와 경고 메시지를 보게 된다.<br />
경고 메시지는 pom.xml의 설정과 이클립스 환경 설정과의 차이 때문에 발생한다.<br />
다음 경고 메시지는 이클립스의 메이븐 플러그인이 pom.xml에 자바 관련 설정이 없으면 자바를 1.5라는 
디폴트 값으로 설정하기 때문에 발생한다.<br />

<pre>Build path specifies execution environment J2SE-1.5. 
There are no JREs installed in the workspace that are strictly compatible with this environment.
</pre>

다음 에러 메시지는 프로젝트에 필요한 라이브러리가 추가되지 않았기 때문에 발생한다.<br />

<pre>The superclass "javax.servlet.http.HttpServlet" was not found on the Java Build Path</pre>

pom.xml 파일을 다음과 같이 편집한다.<br />

<em class="filename">pom.xml</em>
<pre class="prettyprint">&lt;project xmlns="http://maven.apache.org/POM/4.0.0" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
    http://maven.apache.org/maven-v4_0_0.xsd"&gt;
    
  &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
  &lt;groupId&gt;net.java_school&lt;/groupId&gt;
  &lt;artifactId&gt;spring-bbs&lt;/artifactId&gt;
  &lt;packaging&gt;war&lt;/packaging&gt;
  &lt;version&gt;0.0.1-SNAPSHOT&lt;/version&gt;
  &lt;name&gt;spring-bbs Maven Webapp&lt;/name&gt;
  &lt;url&gt;http://maven.apache.org&lt;/url&gt;

  &lt;properties&gt;
    &lt;spring.version&gt;4.1.4.RELEASE&lt;/spring.version&gt;
    &lt;jdk.version&gt;1.7&lt;/jdk.version&gt;
  &lt;/properties&gt;
  
  &lt;dependencies&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;junit&lt;/groupId&gt;
      &lt;artifactId&gt;junit&lt;/artifactId&gt;
      &lt;version&gt;3.8.1&lt;/version&gt;
      &lt;scope&gt;test&lt;/scope&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-context&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-webmvc&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework&lt;/groupId&gt;
      &lt;artifactId&gt;spring-jdbc&lt;/artifactId&gt;
      &lt;version&gt;${spring.version}&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- AspectJ --&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.aspectj&lt;/groupId&gt;
      &lt;artifactId&gt;aspectjrt&lt;/artifactId&gt;
      &lt;version&gt;1.8.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- MyBatis --&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.mybatis&lt;/groupId&gt;
      &lt;artifactId&gt;mybatis-spring&lt;/artifactId&gt;
      &lt;version&gt;1.2.2&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;org.mybatis&lt;/groupId&gt;
      &lt;artifactId&gt;mybatis&lt;/artifactId&gt;
      &lt;version&gt;3.2.8&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- commons-dbcp --&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;commons-dbcp&lt;/groupId&gt;
      &lt;artifactId&gt;commons-dbcp&lt;/artifactId&gt;
      &lt;version&gt;1.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- Logging --&gt;                
    &lt;dependency&gt;
      &lt;groupId&gt;log4j&lt;/groupId&gt;
      &lt;artifactId&gt;log4j&lt;/artifactId&gt;
      &lt;version&gt;1.2.17&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- File Upload --&gt; 
    &lt;dependency&gt;
      &lt;groupId&gt;commons-io&lt;/groupId&gt;
      &lt;artifactId&gt;commons-io&lt;/artifactId&gt;
      &lt;version&gt;2.4&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;commons-fileupload&lt;/groupId&gt;
      &lt;artifactId&gt;commons-fileupload&lt;/artifactId&gt;
      &lt;version&gt;1.3.1&lt;/version&gt;
    &lt;/dependency&gt;
    &lt;!-- Servlet and JSP and JSTL--&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;javax.servlet&lt;/groupId&gt;
      &lt;artifactId&gt;javax.servlet-api&lt;/artifactId&gt;
      &lt;version&gt;3.0.1&lt;/version&gt;
      &lt;scope&gt;provided&lt;/scope&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;javax.servlet.jsp&lt;/groupId&gt;
      &lt;artifactId&gt;jsp-api&lt;/artifactId&gt;
      &lt;version&gt;2.2&lt;/version&gt;
      &lt;scope&gt;provided&lt;/scope&gt;
    &lt;/dependency&gt;
    &lt;dependency&gt;
      &lt;groupId&gt;javax.servlet&lt;/groupId&gt;
      &lt;artifactId&gt;jstl&lt;/artifactId&gt;
      &lt;version&gt;1.2&lt;/version&gt;
      &lt;exclusions&gt;
        &lt;exclusion&gt;
          &lt;groupId&gt;javax.servlet&lt;/groupId&gt;
          &lt;artifactId&gt;javax.servlet-api&lt;/artifactId&gt;
        &lt;/exclusion&gt;
      &lt;/exclusions&gt;
    &lt;/dependency&gt;
  &lt;/dependencies&gt;
  
  &lt;build&gt;
    &lt;finalName&gt;spring-bbs&lt;/finalName&gt;
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
    
&lt;/project&gt;
</pre>

pom은 Project Object Model을 뜻한다.<br />
pom.xml 파일에는 프로젝트 정보와 프로젝트를 빌드하기 위해 필요한 설정이 있다.<br />
pom.xml을 변경했으면 이클립스와 동기화해야 한다.<br />
동기화는 Proejct Explorer 뷰에서 프로젝트를 선택 후 마우스 오른쪽 버튼 클릭하여
Maven - Update Project...를 선택하면 된다.<br />

<img alt="Maven Proejct Configuraion Update" src="https://lh3.googleusercontent.com/-xUlDoBv7UF4/VYZX1ihd5jI/AAAAAAAACj0/bQVJW5EnsNk/s640/Maven-Project-Configure-Upd.png" /><br />

Markers 뷰에서 에러와 경고 메시지가 모두 사라질 것이다.<br />
&lt;!-- Servlet and JSP and JSTL--&gt;에서 서블릿 API 의존성을 추가했으므로 
에러 메시지가 사라진 것이다.<br />
<br />
대부분 의존 라이브러리는 최신 배포 버전을 선택하는 것이 좋지만<br /> 
&lt;!-- Servlet and JSP and JSTL--&gt;에는 적절한 버전을 선택해야 하기에 조금 까다롭다.<br />
적절한 버전이 결정되기까지 다음과 같은 과정이 밟았다.<br />

<ol>
  <li>시스템에 설치된 톰캣 버전을 파악한다.</li>
  <li><a href="http://tomcat.apache.org/whichversion.html">http://tomcat.apache.org/whichversion.html</a>에서 설치된 톰캣이 지원하는 서블릿/JSP 스펙을 확인한다.</li>
  <li><a href="http://mvnrepository.com">http://mvnrepository.com</a>방문하여 서블릿과 JSP 그리고 JSTL를 검색하여 의존성 추가 코드를 구한다.</li>
  <li>exclusions 엘리먼트를 사용하여 JSTL이 의존하는 서블릿 API를 저장되지 않도록 한다.</li>
</ol>
    
여기서 exclusions은 불필요한 의존성 전이를 막아야 할 때 사용한다.<br />
JSTL 의존성 설정의 경우, 의존성 전이를 막지 않으면 어떤 버전인지 모를 서블릿 API를 저장한다.<br />
막지 않으면 /WEB-INF/lib에 서블릿 API가 저장되는데 이는 원하는 바가 아니다.<br />
위 과정을 참고하면 다른 버전의 톰캣에 대해서도 의존성 설정을 해결할 수 있을 것이다.<br />
<br />
maven-compiler-plugin은 특정 JDK 버전으로 컴파일할 수 있게 한다.<br />
이 플러그인에 대한 설정이 생략하면, 이클립스는 JDK 1.5를 디폴트로 선택한다.<br />
<br />
디폴트 값으로 결정되는 것이 하나 더 있다.<br />
web.xml의 DTD 버전이 2.3으로 결정된다.<br />
2.3이면 JSTL을 사용할 수 없는 버전이므로 바꾸어야 한다.<br />
바꾸는 방법은 톰캣이 서비스 중인 ROOT 애플리케이션의 web.xml을
<em class="path">C:\www\spring-bbs\src\main\webapp\WEB-INF</em>에 복사하여
기존 파일을 덮어쓴 다음 이클립스 상단 메뉴 <em class="path">Project - Clean</em>과 
컨텍스트 메뉴 <em class="path">Maven - Update Project...</em>을 차례로 실행하면 된다.<br />
<br />
다양한 시스템이 있기에 때에 따라서는 추가적인 작업이 필요할 수 있다.<br />
프로젝트 익스플로러 뷰에서 프로젝트를 선택한 상태에서 마우스 오른쪽 버튼으로 
컨텍스트 메뉴를 보이게 한 후 Properties를 선택하고 나타난 대화창에서 Project Facets를 선택한 후 
Dynamic Web Module의 버전을 수정한다.<br />
web.xml에서 version="3.0"에서 3.0이 버전 번호이다.<br />
<br />
web.xml를 열고 web-app 엘리먼트의 내용을 모두 지우고 아래와 같이 작성한다.<br />

<em class="filename">web.xml</em>
<pre class="prettyprint">&lt;?xml version="1.0" encoding="ISO-8859-1"?&gt;
&lt;web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true"&gt;
  <strong>
  &lt;display-name&gt;Spring BBS&lt;/display-name&gt;
        
  &lt;filter&gt;
    &lt;filter-name&gt;encodingFilter&lt;/filter-name&gt;
    &lt;filter-class&gt;org.springframework.web.filter.CharacterEncodingFilter&lt;/filter-class&gt;
    &lt;init-param&gt;
      &lt;param-name&gt;encoding&lt;/param-name&gt;
        &lt;param-value&gt;UTF-8&lt;/param-value&gt;
      &lt;/init-param&gt;
      &lt;init-param&gt;
      &lt;param-name&gt;forceEncoding&lt;/param-name&gt;
      &lt;param-value&gt;true&lt;/param-value&gt;
    &lt;/init-param&gt;
  &lt;/filter&gt;
        
  &lt;filter-mapping&gt;
    &lt;filter-name&gt;encodingFilter&lt;/filter-name&gt;
    &lt;url-pattern&gt;/*&lt;/url-pattern&gt;
  &lt;/filter-mapping&gt;
    
  &lt;servlet&gt;
    &lt;servlet-name&gt;spring-bbs&lt;/servlet-name&gt;
    &lt;servlet-class&gt;org.springframework.web.servlet.DispatcherServlet&lt;/servlet-class&gt;
    &lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
  &lt;/servlet&gt;
    
  &lt;servlet-mapping&gt;
    &lt;servlet-name&gt;spring-bbs&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/&lt;/url-pattern&gt;
  &lt;/servlet-mapping&gt;
  
&lt;!-- 최종 테스트 전까지 풀지 않는다.
  &lt;error-page&gt;
    &lt;error-code&gt;403&lt;/error-code&gt;
    &lt;location&gt;/WEB-INF/jsp/error.jsp&lt;/location&gt;
  &lt;/error-page&gt;

  &lt;error-page&gt;
    &lt;error-code&gt;404&lt;/error-code&gt;
    &lt;location&gt;/WEB-INF/jsp/error.jsp&lt;/location&gt;
  &lt;/error-page&gt;

  &lt;error-page&gt;
    &lt;error-code&gt;500&lt;/error-code&gt;
    &lt;location&gt;/WEB-INF/jsp/error.jsp&lt;/location&gt;
  &lt;/error-page&gt; 
--&gt;
</strong> 
&lt;/web-app&gt;
</pre>

web.xml에 요청 캐릭터 셋을 UTF-8로 설정하는 필터가 있다.<br />
이 설정으로 JSP나 자바 소스에서 <em class="path">request.setCharacterEncoding("UTF-8");</em>
코드는 필요 없게 된다.<br />
에러 페이지 설정은 최종 테스트 단계에서 하는 것이 좋으므로 주석 처리했다.<br />
 
<h2>CSS, 이미지, JSP 파일 복사</h2>

<em class="path">C:\www\spring-bbs\src\main\webapp</em>가 도큐먼트 베이스다.<br />
도큐먼트 베이스에 모델 2게시판의 css와 images 폴더를 복사하여 붙여넣는다.<br />
WEB-INF 아래 jsp라는 폴더를 만들고 이곳에 홈페이지 index.jsp와 에러 페이지 error.jsp 
그리고 모델 2게시판의 JSP 파일 폴더인 bbs, inc, java, javascript, users를 복사하여 붙여넣는다.<br />
JSP 페이지를 WEB-INF 아래에 두는 이유는 웹 브라우저로 바로 접근하지 못하도록 하기 위해서이다.<br />
스프링 MVC에서는 모든 요청을 디스패처 서블릿을 거쳐 컨트롤러에 전달되도록 하는 것을 권장한다.<br />
JSP를 바로 요청할 수 있으면서 어떤 요청은 디스패처 서블릿을 거치도록 프로그래밍하는 것은 프로그램을 복잡하게 하고 유지 보수에도 좋지 않다.<br />

<h2>자바 소스 복사</h2>

C:/www/spring-bbs/src/main/java에 모델 2에서 구현한 자바 소스를 복사한다.<br />
만약 src/main/java 디렉터리가 없다면 메이븐 프로젝트의 기본 디렉터리이니 만들어야 한다.<br />
<br />
액션 클래스와 컨트롤러 서블릿은 재사용하지 않을 것이므로 삭제한다.<br />
Spring MVC 게시판에서는 업로드 라이브러리를 cos 대신에 아파치의 commons-io와 commons-fileupload를
사용할 것이다.<br />
<br />
옮긴 자바 소스 중 수정해야 하는 부분이 있다.<br />
목록 list.jsp에서의 날짜 형식과 상세보기 view.jsp에서의 날짜 형식이 다르다.<br />
Article.java에 다음을 추가한다.<br />

<em class="filename">Article.java</em>
<pre class="prettyprint">package net.java_school.board;

<strong>import java.text.SimpleDateFormat;</strong>
import java.util.Date;

public class Article {
  <strong>private static final SimpleDateFormat LIST_DATE_FORMAT = 
      new SimpleDateFormat("yyyy.MM.dd");
  private static final SimpleDateFormat VIEW_DATE_FORMAT = 
      new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");</strong>

  //중간 생략
  <strong>
  public String getRegdateForList() {
    return Article.LIST_DATE_FORMAT.format(this.regdate);
  }
  public String getRegdateForView() {
    return Article.VIEW_DATE_FORMAT.format(this.regdate);
  }
  </strong>
}
</pre>

WebContants.java에 첨부 파일이 저장되는 디렉터리의 전체 경로 UPLOAD_PATH를 추가한다.<br />
코드가 간단하므로 전체 코드를 싣는다.<br />

<em class="filename">WebContants.java</em>
<pre class="prettyprint">package net.java_school.commons;

public class WebContants {
  //Session key
  public final static String USER_KEY = "user";
  //Error Message
  public final static String NOT_LOGIN = "Not Login";
  public final static String AUTHENTICATION_FAILED = "Authentication Failed";
  //Line Separator
  public final static String LINE_SEPARATOR = System.getProperty("line.separator");
  //Upload Path
  public final static String UPLOAD_PATH = "C:/www/spring-bbs/upload/";
}
</pre>

모델 2에서는 웹 브라우저로 접근할 수 있는 디렉터리였으나 여기서는 접근할 수 없는 디렉터리를 선택했다.<br />


<h2>JSP 수정</h2>

스프링 컨트롤러가 특별한 확장자를 포함한 요청만이 아니라 모든 요청을 담당하도록 설정할 것이다.<br />
모든 JSP 파일에서 확장자 ".do"를 모두 제거한다.<br />
<br />
"_proc"로 포함된 요청은 "_proc"를 제거한다.<br />
요청에 "_proc"가 포함된 이유는 모델 1에서 처리 과정만을 담는 JSP 파일의 이름 마지막에 "_proc"를 붙이는 이름 규칙을 만들면서 시작되었다.<br />
이런 보편적이지 않은 이름 규칙은 처리 페이지가 필요 없는 모델 2에서도 그대로 사용했지만, 스프링까지 유지할 이유는 없으니
걷어내는 것이다.<br />
일괄적으로 "_proc"가 포함된 요청 문자열에서 "_proc"를 지우면,<br />
회원 가입 폼 signUp.jsp의 폼 엘리먼트의 action 속성은 기존 "signUp_proc.do"에서 "signUp"이 된다.<br />
그러면 회원 가입 폼으로의 요청이 signUp이고 회원 가입 처리로의 요청 역시 signUp으로 같은 이름이 된다.<br />
요청 문자열이 같다 하더라도 HTTP 프로토콜이 GET 방식인지 POST 방식인지를 구별하여 각각의 요청을 핸들링할 수 있다. 사실 이 방법은 모델 2 실습에서도 할 수 있었다.<br />
<br />
로그인 화면 login.jsp에서도 폼 엘리먼트의 액션 속성값이 기존 login_proc.do에서 login으로 된다.<br />
로그인 화면으로의 요청도 login이고 로그인을 처리하는 요청 역시 login이 된다.<br />
이 역시 GET 방식과 POST 방식을 구별하여 각각의 요청을 핸들링하도록 구현하면 된다.<br />
<br />
header.jsp에서 logout_proc는 logout이 된다.<br />
비밀번호 변경 폼 changePasswd.jsp에서 폼 엘리먼트의 액션 속성값은 changePasswd_proc에서 
changePasswd이 된다.<br />
비밀번호 변경 폼으로 요청도 changePasswd이고 비밀번호변경 처리를 위한 요청 역시 changePasswd이다.<br />
<br />
Article.java에서 목록을 위한 날짜 포맷과 상세보기를 위한 날짜 포맷을 지정했다.<br />
list.jsp와 view.jsp 열고 아랫부분을 수정한다.<br />

<pre class="prettyprint">
&lt;!-- 반복 구간 시작 --&gt;
..중간 생략..
&lt;td style="text-align: center;"&gt;${article.regdateForList }&lt;/td&gt;
..중간 생략..
&lt;!-- 반복 구간 끝 --&gt;
</pre>

<h2>첨부 파일을 내려받는 JSP 추가</h2>

기존 상세보기(view.jsp)에서는 첨부 파일을 단순히 링크 거는 것으로 구현했었는데 스프링 MVC에서는 
/WEB-INF/jsp/inc/download.jsp를 이용하는 것으로 수정할 것이다.<br />
이 경우 웹 브라우저가 접근하지 못하는 경로에 첨부 파일이 있어도 상관없다.<br />

<em class="filename">/WEB-INF/jsp/inc/download.jsp</em>
<pre class="prettyprint">&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;	  
    
&lt;%@ page import="java.io.File" %&gt;
&lt;%@ page import="java.net.URLEncoder" %&gt;
&lt;%@ page import="java.io.OutputStream" %&gt;
&lt;%@ page import="java.io.FileInputStream" %&gt;
&lt;%@ page import="java.io.IOException" %&gt;
&lt;%@ page import="org.springframework.util.FileCopyUtils" %&gt;
&lt;%@ page import="net.java_school.commons.WebContants" %&gt;
&lt;%
//request.setCharacterEncoding("UTF-8");//이 작업은 필터가 한다.
String filename = request.getParameter("filename");

File file = new File(WebContants.UPLOAD_PATH + filename);

String filetype = filename.substring(filename.indexOf(".") + 1, filename.length());

if (filetype.trim().equalsIgnoreCase("txt")) {
  response.setContentType("text/plain");
} else {
  response.setContentType("application/octet-stream");
}

response.setContentLength((int) file.length());

boolean ie = request.getHeader("User-Agent").indexOf("MSIE") != -1;
if (ie) {
  filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
} else {
  filename = new String(filename.getBytes("UTF-8"), "8859_1");
}

response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

OutputStream outputStream = response.getOutputStream();
FileInputStream fis = null;

try {
  fis = new FileInputStream(file);
  FileCopyUtils.copy(fis, outputStream);
} finally {
  if (fis != null) {
    try {
      fis.close();
    } catch (IOException e) {}
  }
}

out.flush();
%&gt;
</pre>

<h2>로그 관련 파일 복사</h2>

log4j.xml과 commons-logging.properties 파일을 src/main/resources에 복사한다.<br />
이 폴더가 없다면 만들고 Maven - Update Project... 를 실행한다.<br />
log4j.xml 파일을 열고 로그 파일의 위치를 <em class="path">C:/www/spring-bbs/logs/debug.log</em>로 수정한다.<br />
로그 파일의 위치가 웹 브라우저로 접근할 수 없는 디렉터리임에 주목하자.<br />

<h2>회원</h2>
자바빈즈를 마이바티스와 연동하도록 수정할 것이다.<br />
마이바티스 공식 문서에서 스프링과 마이바티스의 연동에 관한 여러 가지 방법을 소개하고 있다.<br />
여기서는 DAO 패턴을 이용하지 않는 방법을 소개한다.<br />
DAO 패턴에 익숙해 있다면 이상해 보일 수 있다. 마이바티스 공식 문서에는 DAO 패턴을 유지하면서 연동하는 방법도 소개하고 있다.<br />
먼저 회원과 관련된 자바빈즈부터 수정한다.<br />


<em class="filename">UserService.java</em>
UserService.java를 인터페이스로 변경한다.<br />

<pre class="prettyprint">package net.java_school.user;

public interface UserService {
    
  //회원 가입
  public void addUser(User user);

  //로그인
  public User login(String email, String passwd);

  //내 정보 수정
  public int editAccount(User user);

  //비밀번호 변경
  public int changePasswd(String currentPasswd, String newPasswd, String email);

  //탈퇴
  public void bye(User user);

  //회원 찾기
  public User getUser(String email);
    
}
</pre>


net.java_school.mybatis 패키지에 UserMapper.java를 작성한다.<br />
이전 게시판의 UserDao와 일관성을 위해 메서드 명은 될 수 있으면 그대로 유지하기로 한다.<br />

<em class="filename">UserMapper.java</em>
<pre class="prettyprint">package net.java_school.mybatis;

import org.apache.ibatis.annotations.Param;

import net.java_school.user.User;

public interface UserMapper {
    
  public void insert(User user);

  public User login(
    @Param("email") String email, 
    @Param("passwd") String passwd);

  public int update(User user);

  public int <strong>updatePasswd</strong>(
    @Param("currentPasswd") String currentPasswd, 
    @Param("newPasswd") String newPasswd, 
    @Param("email") String email);

  public int delete(User user);

  public User selectOne(String email);
    
}
</pre>

비밀번호 변경을 위한 메서드 명은 UserDao에서의 update가 아닌 updatePasswd로 변경했다.<br />
UserMapper.xml에 UserMapper.java의 메서드 이름으로 id를 설정해야 하는데
update라고 그대로 쓰면 내 정보 수정 update와 이름이 같아져서 id가 중복되기 때문이다.<br />


net.java_school.user 패키지에 UserServiceImpl.java를 만든다.<br />

<em class="filename">UserServiceImpl.java</em>
<pre class="prettyprint">
package net.java_school.user;

import net.java_school.mybatis.UserMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    
  @Autowired
  private UserMapper userMapper;
    
  public void addUser(User user) {
    userMapper.insert(user);
  }

  public User login(String email, String passwd) {
    return userMapper.login(email, passwd);
  }

  public int editAccount(User user) {
    return userMapper.update(user);
  }

  public int changePasswd(String currentPasswd, String newPasswd, String email) {
    return userMapper.updatePasswd(currentPasswd, newPasswd, email);
  }

  public void bye(User user) {
    userMapper.delete(user);
  }

  public User getUser(String email) {
    return userMapper.selectOne(email);
  }
    
}
</pre>




src/main/resources에 net.java_school.mybatis 패키지를 만들고,
이 패키지에 마이바티스 관련 설정 파일인 Congifuration.xml을 만든다.<br />
이 파일은 타입의 별칭과 매퍼 파일의 위치를 설정한다.<br />
메이븐 프로젝트는 소스 디렉터리에 있는 설정을 클래스 패스에 생성하지 않으므로 
설정 파일은 반드시 src/main/resources에 만들어야 한다.<br />

<em class="filename">Configuration.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!DOCTYPE configuration 
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN" 
    "http://mybatis.org/dtd/mybatis-3-config.dtd"&gt;

&lt;configuration&gt; 
    
  &lt;typeAliases&gt;
    &lt;typeAlias type="net.java_school.board.AttachFile" alias="AttachFile" /&gt;
    &lt;typeAlias type="net.java_school.board.Comment" alias="Comment" /&gt;
    &lt;typeAlias type="net.java_school.board.Board" alias="Board" /&gt;
    &lt;typeAlias type="net.java_school.board.Article" alias="Article" /&gt;
    &lt;typeAlias type="net.java_school.user.User" alias="User" /&gt;
  &lt;/typeAliases&gt;

  &lt;mappers&gt;
    &lt;mapper resource="net/java_school/mybatis/BoardMapper.xml" /&gt;
    &lt;mapper resource="net/java_school/mybatis/UserMapper.xml" /&gt;
  &lt;/mappers&gt;

&lt;/configuration&gt;
</pre>




Configuration.xml와 같은 위치에 UserMapper.xml 파일을 만든다.<br />
UserMapper.java의 메서드 이름과 id 값이 일치해야 한다.<br />

<em class="filename">UserMapper.xml</em>
<pre class="prettyprint">&lt;?xml version="1.0" encoding="UTF-8"?&gt;

&lt;!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd"&gt;

&lt;mapper namespace="net.java_school.mybatis.UserMapper"&gt;
    
  &lt;insert id="insert" parameterType="User"&gt;
    INSERT INTO member VALUES (${sharp}{email}, <%="#" %>{passwd}, <%="#" %>{name}, <%="#" %>{mobile})
  &lt;/insert&gt;

  &lt;select id="login" resultType="User"&gt;
    SELECT email, passwd, name, mobile FROM member 
    WHERE email = <%="#" %>{email} AND passwd = <%="#" %>{passwd}
  &lt;/select&gt;

  &lt;update id="update" parameterType="User"&gt;
    UPDATE member SET name = <%="#" %>{name}, mobile = <%="#" %>{mobile} 
    WHERE email = <%="#" %>{email} AND passwd = <%="#" %>{passwd}
  &lt;/update&gt;

  &lt;update id="updatePasswd"&gt;
    UPDATE member SET passwd = <%="#" %>{newPasswd} 
    WHERE passwd = <%="#" %>{currentPasswd} AND email = <%="#" %>{email}
  &lt;/update&gt;

  &lt;delete id="delete"&gt;
    DELETE FROM member 
    WHERE email = <%="#" %>{email}
  &lt;/delete&gt;

  &lt;select id="selectOne" parameterType="string" resultType="User"&gt;
    SELECT email, passwd, name, mobile 
    FROM member
    WHERE email = <%="#" %>{email}
  &lt;/select&gt;
    
&lt;/mapper&gt;
</pre>



net.java_school.user.spring 패키지에 UsersController.java를 작성한다.<br />
이 컨트롤러가 "/users"를 포함하는 모든 요청을 처리하도록 하려면,<br />
클래스를 선언하는 곳 위에 @Controller 어노테이션을 사용하여 이 클래스가 컨트롤러 컴포넌트임을 표시해주고 
@Controller 어노테이션 바로 아래 @RequestMapping("/users") 어노테이션을 사용한다.<br />

<em class="filename">UsersController.java</em>
<pre class="prettyprint">package net.java_school.user.spring;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
<strong>
@Controller
@RequestMapping("/users")</strong>
public class UsersController {
    
  <strong>@Autowired</strong>
  private UserService userService;

  <strong>@RequestMapping(value="/signUp", method=RequestMethod.GET)</strong>
  public String signUp() {
    return "users/signUp";
  }

  @RequestMapping(value="/signUp", method=RequestMethod.POST)
  public String signUp(User user) {
    userService.addUser(user);
    return "<strong>redirect:/users/welcome</strong>";
  }

  @RequestMapping(value="<strong>/welcome</strong>", method=RequestMethod.GET)
  public String welcome() {
    return "users/welcome";
  }

  @RequestMapping(value="/login", method=RequestMethod.GET)
  public String login() {
    return "users/login";
  }
    
  @RequestMapping(value="/login", method=RequestMethod.POST)
  public String login(String email, String passwd, String url, HttpSession session) {
    User user = userService.login(email, passwd);
        
    if (user == null) {
      return "redirect:/users/login?url=" + url + "&amp;msg=Login-Failed";
    } else {
      session.setAttribute(WebContants.USER_KEY, user);
      if (!url.equals("")) {
        return "redirect:" + url;
      }
      
      return "redirect:/";
    }
        
  }
        
  @RequestMapping(value="/editAccount", method=RequestMethod.GET)
  public String editAccount(HttpServletRequest req, HttpSession session) throws Exception {
    User user = (User) session.getAttribute(WebContants.USER_KEY);

    if (user == null) {
      //로그인 후 다시 돌아오기 위해
      String url = req.getServletPath();
      String query = req.getQueryString();
      if (query != null) url += "?" + query;
      //로그인 페이지로 리다이렉트
      url = URLEncoder.encode(url, "UTF-8");
      
      return "redirect:/users/login?url=" + url;
    }

    return "users/editAccount";
  }
    
  @RequestMapping(value="/editAccount", method=RequestMethod.POST)
  public String editAccount(User user, HttpSession session) {
    User loginUser = (User) session.getAttribute(WebContants.USER_KEY);
    if (loginUser == null) {
      throw new AuthenticationException(WebContants.NOT_LOGIN);
    }

    user.setEmail(loginUser.getEmail());
        
    int check = userService.editAccount(user);
    if (check &lt; 1) {
      throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
    }
    
    session.setAttribute(WebContants.USER_KEY, user);

    return "users/changePasswd";
        
  }
    
  @RequestMapping(value="/changePasswd", method=RequestMethod.GET)
  public String changePasswd(HttpServletRequest req, HttpSession session) throws Exception {
    User user = (User) session.getAttribute(WebContants.USER_KEY);
        
    if (user == null) {
      //로그인 후 다시 돌아오기 위해
      String url = req.getServletPath();
      String query = req.getQueryString();
      if (query != null) url += "?" + query;
      //로그인 페이지로 리다이렉트
      url = URLEncoder.encode(url, "UTF-8");
      return "redirect:/users/login?url=" + url;     
    }
        
    return "users/changePasswd";
  }
    
  @RequestMapping(value="/changePasswd", method=RequestMethod.POST)
  public String changePasswd(String currentPasswd, String newPasswd, HttpSession session) {
    String email = ((User)session.getAttribute(WebContants.USER_KEY)).getEmail();
        
    int check = userService.changePasswd(currentPasswd, newPasswd, email);
    if (check &lt; 1) {
        throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
    } 
    
    return "redirect:/users/changePasswd_confirm";
        
  }
    
  @RequestMapping(value="/changePasswd_confirm", method=RequestMethod.GET)
  public String changePasswd_confirm() {
    return "users/changePasswd_confirm";
  }
    
  @RequestMapping(value="/bye", method=RequestMethod.GET)
  public String bye(HttpServletRequest req, HttpSession session) throws Exception {
    User user = (User)session.getAttribute(WebContants.USER_KEY);
        
    if (user == null) {
      //로그인 후 다시 돌아오기 위해
      String url = req.getServletPath();
      String query = req.getQueryString();
      if (query != null) url += "?" + query;
      //로그인 페이지로 리다이렉트
      url = URLEncoder.encode(url, "UTF-8");
      
      return "redirect:/users/login?url=" + url;     
    }
        
    return "users/bye";
  }

  @RequestMapping(value="/bye", method=RequestMethod.POST)
  public String bye(String email, String passwd, HttpSession session) {
    User user = (User)session.getAttribute(WebContants.USER_KEY);

    if (user == null || !user.getEmail().equals(email)) {
      throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
    }
    
    user = userService.login(email, passwd);
    userService.bye(user);
    session.removeAttribute(WebContants.USER_KEY);
    
    return "redirect:/users/bye_confirm";
        
  }
  
  @RequestMapping(value="/bye_confirm", method=RequestMethod.GET)
  public String bye_confirm() {
  
    return "users/bye_confirm";	  
  } 
    
  @RequestMapping(value="/logout", method=RequestMethod.GET)
  public String logout(HttpSession session) {
    session.removeAttribute(WebContants.USER_KEY);

    return "redirect:/";

  }

}
</pre>

메서드 선언 위의 @RequestMapping(value="/signUp", method=RequestMethod.GET)는 
메서드가 GET 방식의 "/users/signUp" 요청을 처리한다는 것을 표시한다.<br />
메서드 선언 위의 @RequestMapping(value="/signUp", method=RequestMethod.POST)는 
메서드가 POST 방식의 "/users/signUp" 요청을 처리한다는 것을 표시한다.<br />
이처럼 요청 문자열이 같더라도 HTTP 메서드로 구분하여 요청을 각각 처리할 수 있다.<br />
POST 방식의 /users/signUp 요청 시 호출되는 메서드는 회원 가입을 처리한 후에는 
return "redirect:/users/welcome";로 리다이렉트한다.<br />
여기서 포워드를 쓴다면 사용자가 F5버튼 등으로 재로딩할때 회원 가입이 똑같은 정보로 다시 시도될 수 있다.
리다이렉트하면 그런 경우는 발생하지 않지만 컨트롤러에 리다이렉트 요청에 대한 매핑을 추가해야 한다.<br />

<em class="path">@RequestMapping(value="/welcome", method="RequestMethod.GET")</em><br />



HomeController은 홈페이지 요청을 담당하는 컨트롤러이다.<br />

<em class="filename">HomeController.java</em>
<pre class="prettyprint">package net.java_school.home.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class HomeController {
    @RequestMapping(method=RequestMethod.GET)
    public String index() {
        return "index";
    }
}
</pre>



JavaController은 "/java"가 포함된 모든 요청을 처리하는 컨트롤러이다.<br />

<em class="filename">JavaController.java</em>
<pre class="prettyprint">package net.java_school.java.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/java")
public class JavaController {

    @RequestMapping(method=RequestMethod.GET)
    public String index() {
        return "java/index";
    }
    
    @RequestMapping(value="/jdk-install", method=RequestMethod.GET)
    public String basic() {
        return "java/jdk-install";
    }

}
</pre>



JavascriptController은 "/javascrit"가 포함된 모든 요청을 처리하는 컨트롤러이다.<br />

<em class="filename">JavascriptController.java</em>
<pre class="prettyprint">package net.java_school.javascript.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/javascript")
public class JavascriptController {

    @RequestMapping(method=RequestMethod.GET)
    public String index() {
        return "javascript/index";
    }
    
}
</pre>



스프링 MVC를 위한 설정 파일을 만들어야 한다.<br />
web.xml에서 DispatcherServlet 이름을 spring-bbs라고 정했으므로<br />
sprng-bbs-servlet.xml라는 이름으로 web.xml과 같은 위치인 WEB-INF에 생성한다.<br />

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;beans xmlns="http://www.springframework.org/schema/beans" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:context="http://www.springframework.org/schema/context"
  xmlns:mvc="http://www.springframework.org/schema/mvc"
  xmlns:p="http://www.springframework.org/schema/p"
  xmlns:mybatis="http://mybatis.org/schema/mybatis-spring"
  xsi:schemaLocation="http://www.springframework.org/schema/beans 
    http://www.springframework.org/schema/beans/spring-beans.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context.xsd
    http://www.springframework.org/schema/mvc
    http://www.springframework.org/schema/mvc/spring-mvc.xsd
    http://mybatis.org/schema/mybatis-spring 
    http://mybatis.org/schema/mybatis-spring.xsd"&gt;
            
  &lt;!-- 스프링의 DispatcherServet에게 정적인 자원을 알려준다.  --&gt;
  &lt;mvc:resources location="/images/" mapping="/images/**" /&gt;
  &lt;mvc:resources location="/css/" mapping="/css/**" /&gt;
        
  &lt;mvc:annotation-driven /&gt;
    
  &lt;context:component-scan
    base-package="net.java_school.home,spring,
      net.java_school.java.spring,
      net.java_school.javascript.spring,
      net.java_school.board,
      net.java_school.board.spring,
      net.java_school.user,
      net.java_school.user.spring" /&gt;

  &lt;mybatis:scan base-package="net.java_school.mybatis" /&gt;

  &lt;bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"&gt;
    &lt;property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/&gt;
    &lt;property name="url" value="jdbc:oracle:thin:@127.0.0.1:1521:XE"/&gt;
    &lt;property name="username" value="java"/&gt;
    &lt;property name="password" value="school"/&gt;
    &lt;property name="maxActive" value="100"/&gt;
    &lt;property name="maxWait" value="1000"/&gt;
    &lt;property name="poolPreparedStatements" value="true"/&gt;
    &lt;property name="defaultAutoCommit" value="true"/&gt;
    &lt;property name="validationQuery" value=" SELECT 1 FROM DUAL" /&gt;
  &lt;/bean&gt;
    
  &lt;bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean"&gt;
    &lt;property name="dataSource" ref="dataSource" /&gt;
    &lt;property name="configLocation" value="classpath:net/java_school/mybatis/Configuration.xml" /&gt;
  &lt;/bean&gt;

  &lt;bean id="multipartResolver"
    class="org.springframework.web.multipart.commons.CommonsMultipartResolver"
    p:maxUploadSize="104857600"
    p:maxInMemorySize="10485760" /&gt;

  &lt;!-- ViewResolver --&gt;
  &lt;bean id="internalResourceViewResolver" 
      class="org.springframework.web.servlet.view.InternalResourceViewResolver"&gt;
    &lt;property name="viewClass"&gt;
      &lt;value&gt;org.springframework.web.servlet.view.JstlView&lt;/value&gt;
    &lt;/property&gt;
    &lt;property name="prefix"&gt;
      &lt;value&gt;/WEB-INF/jsp/&lt;/value&gt;
    &lt;/property&gt;
    &lt;property name="suffix"&gt;
      &lt;value&gt;.jsp&lt;/value&gt;
    &lt;/property&gt;
  &lt;/bean&gt;
  
&lt;!-- 최종 테스트 전까지 주석을 풀지 않는다.
  &lt;bean class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver"&gt;
    &lt;property name="defaultErrorView" value="error" /&gt;
    &lt;property name="exceptionMappings"&gt;
      &lt;props&gt;
        &lt;prop key="net.java_school.exception.AuthenticationException"&gt;
          error
        &lt;/prop&gt;
      &lt;/props&gt;
    &lt;/property&gt;
  &lt;/bean&gt;
--&gt;  
&lt;/beans&gt;
</pre>

<h3>spring-bbs-servlet.xml 설정 설명</h3>

<strong>&lt;mvc:resources location=..</strong><br />
디스패쳐 서블릿에 정적 자원의 위치를 알려준다.<br />

<strong>&lt;context:component-scan base-package=..</strong><br />
자동으로 빈을 스캔하여 빈 컨테이너에 등록하도록 하는 설정이다.<br />
스캔 되는 빈은 스프링 설정 파일에서 bean 엘리먼트를 사용하여 따로 등록하지 않아도 된다.<br />
빈이 자동 스캔 되려면 base-package 패키지에 속하면서 클래스를 선언하는 곳 위에 컴포넌트임을 표시하는 
어노테이션이 있어야 한다.<br />
클래스를 선언하는 곳 위에 @Controller, @Repository 어노테이션이 있는 클래스는 어노테이션의 이름대로 취급된다.<br />
@Repository는 DAO 클래스에 사용한다.<br />
클래스를 선언하는 곳 위에 @Component와 @Service 어노테이션은 클래스가 단지 자동 스캔 대상이라는 사실만을 표시하며, 그 외 특별하게 취급되는 사항은 없다.<br />

<strong>&lt;mvc:annotation-driven /&gt;</strong><br />
어노테이션 기반으로 동작하는 스프링 애플리케이션은 이 설정이 필요하다.<br />

<strong>&lt;mybatis:scan base-package=..</strong><br />
base-package 속성에 매퍼 인터페이스의 패키지를 지정하면, 마이바티스 스프링 연동 빈즈가 스캔된다.<br />
즉, 스프링 설정 파일에서 아래 설정을 하지 않아도 된다.<br />

<pre>&lt;bean id="boardMapper" class="org.mybatis.spring.mapper.MapperFactoryBean"&gt;
  &lt;property name="mapperInterface" value="net.java_school.mybatis.BoardMapper" /&gt;
  &lt;property name="sqlSessionFactory" ref="sqlSessionFactory" /&gt;
&lt;/bean&gt;
</pre>

<strong>&lt;bean id="dataSource" ..</strong><br />
dataSource 정의는 스프링 JDBC를 사용하든지 마이바티스를 사용하든지 상관없이 언제나 필요하다.<br />

<strong>&lt;bean id="sqlSessionFactory" ..</strong><br />
모든 MyBatis 애플리케이션은 SqlSessionFactory 인터테이스 타입의 인스턴스를 사용해야 한다.<br />
마이바티스 스프링 연동모듈에서는 SqlSessionFactoryBean를 사용한다.<br />

<strong>&lt;bean id="multipartResolver" ..</strong><br />
파일 업로드를 위한 설정이다.<br />
파일을 업로드할 때 HttpServletRequest의 래퍼가 컨트롤러에 전달된다.<br />
컨트롤러에서 업로드된 파일을 처리하는 메서드는 래퍼를 MultiPartHttpServletRequest 인터페이스로 
캐스팅해야 서버로 전달된 멀티파트 파일을 다룰 수 있게 된다.<br />

<strong>뷰 리졸버 설정</strong><br />
&lt;!-- ViewResolver --&gt; 아랫부분은 컨트롤러가 반환하는 문자열로부터 뷰를 해석하는 방법이다.<br />

<strong>예외 처리</strong><br />
<em class="path">&lt;bean class="org.springframework.web.servlet.handler.SimpleMappingExceptionResolver" ..</em><br />
스프링 MVC 예외 처리에 대한 설정이다.<br />
스프링 MVC에는 여러 가지 예외 처리 방법이 있다.<br />
이 중에서 SimpleMappingExceptionResolver를 이용하는 것이 가장 사용하기 쉽다.<br />
설정대로라면 AuthenticationException 예외가 발생하면 선택되는 뷰는 error이다.<br />
error 역시 뷰리졸브의 의해 /WEB-INF/jsp/error.jsp로 해석된다.<br />
이 밖의 다른 예외가 발생하면 
<em class="path">&lt;property name="defaultErrorView" value="error" /&gt;</em>설정이 담당한다.<br />
여기서는 각각의 상황에 맞게 에러 페이지를 만들지 않고 error.jsp 하나로 통일했다.<br />
404 HTTP 상태 코드에 대해서는 web.xml에서 error-page 엘리먼트로 설정했다.<br />
web.xml에서 에러 페이지에 대한 경로를 /WEB-INF/jsp/error.jsp라고 지정해야 함에 주의해야 한다.<br />
web.xml의 에러 페이지 설정과 마찬가지로 이 부분 역시 주석으로 처리했다.<br />
최종 테스트 전까지 주석을 제거하지 않는 것이 개발에 도움이 된다.<br /> 

<h2>게시판</h2>
Configuration.xml의 설정대로, BoardMapper.xml 파일을 UserMapper.xml와 같은 위치에 만든다.<br />

<em class="filename">BoardMapper.xml</em>
<pre class="prettyprint">&lt;?xml version="1.0" encoding="UTF-8" ?&gt;

&lt;!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd"&gt;

&lt;mapper namespace="net.java_school.mybatis.BoardMapper"&gt;

    &lt;select id="selectListOfArticles" parameterType="hashmap" resultType="Article"&gt;
    SELECT articleno, title, regdate, hit, name, attachfileNum, commentNum 
    FROM (
        SELECT rownum r,a.* 
            FROM (
                SELECT 
                    a.articleno, a.title, a.regdate, a.hit, m.name,
                    COUNT(DISTINCT(f.attachfileno)) attachfileNum, 
                    COUNT(DISTINCT(c.commentno)) commentNum
                FROM 
                    article a, attachfile f, comments c, member m
                WHERE
                    a.articleno = f.articleno(+)
                    AND a.articleno = c.articleno(+)
                    AND a.email = m.email(+)
                    AND a.boardcd = <%="#" %>{boardCd}
                    &lt;if test="searchWord != null and searchWord != ''"&gt;
                    AND (title LIKE '%${searchWord}%' 
                        OR DBMS_LOB.INSTR(content, '${searchWord}') &gt; 0)
                    &lt;/if&gt;
                GROUP BY a.articleno, title, a.regdate, hit, m.name
                ORDER BY articleno DESC
                ) a
        )
    WHERE r BETWEEN <%="#" %>{start} AND <%="#" %>{end}
    &lt;/select&gt;

    &lt;select id="selectCountOfArticles" parameterType="hashmap" resultType="int"&gt;
        SELECT count(*) FROM article WHERE boardcd = <%="#" %>{boardCd}
            &lt;if test="searchWord != null and searchWord != ''"&gt;
            AND (title LIKE '%${searchWord}%' 
                OR DBMS_LOB.INSTR(content, '${searchWord}') &gt; 0)
            &lt;/if&gt;
    &lt;/select&gt;

    &lt;insert id="insert" parameterType="Article" useGeneratedKeys="true"&gt;
        &lt;selectKey keyProperty="articleNo" resultType="int" order="BEFORE"&gt;
            SELECT seq_article.nextval FROM dual
        &lt;/selectKey&gt;
        INSERT INTO article (articleNo, boardCd, title, content, email, hit, regdate)
        VALUES
        (<%="#" %>{articleNo}, <%="#" %>{boardCd}, <%="#" %>{title}, <%="#" %>{content}, <%="#" %>{email}, 0, sysdate)
    &lt;/insert&gt;

    &lt;insert id="insertAttachFile" parameterType="AttachFile"&gt;
        INSERT INTO attachfile (attachfileno, filename, filetype, filesize, articleno, email)
        VALUES
        (seq_attachfile.nextval, <%="#" %>{filename}, <%="#" %>{filetype}, <%="#" %>{filesize}, <%="#" %>{articleNo}, <%="#" %>{email})
    &lt;/insert&gt;
    
    &lt;update id="update" parameterType="Article"&gt;
        UPDATE article 
        SET title = <%="#" %>{title}, content = <%="#" %>{content} 
        WHERE articleno = <%="#" %>{articleNo}
    &lt;/update&gt;
    
    &lt;delete id="delete" parameterType="int"&gt;
        DELETE FROM article WHERE articleno = <%="#" %>{articleNo}
    &lt;/delete&gt;
    
    &lt;update id="updateHitPlusOne" parameterType="int"&gt;
        UPDATE article SET hit = hit + 1 WHERE articleno = <%="#" %>{articleNo}
    &lt;/update&gt;
    
    &lt;select id="selectOne" parameterType="int" resultType="Article"&gt;
        SELECT 
            articleno, 
            title, 
            content, 
            a.email, 
            NVL(name, 'Anonymous') name, 
            hit, 
            regdate
        FROM article a, member m
        WHERE a.email = m.email(+) AND articleno = <%="#" %>{articleNo}
    &lt;/select&gt;
    
    &lt;select id="selectNextOne" parameterType="hashmap" resultType="Article"&gt;
        SELECT articleno, title
        FROM
            (SELECT rownum r,a.*
            FROM
                (SELECT articleno, title 
                FROM article 
                WHERE 
                    boardCd = <%="#" %>{boardCd} 
                    AND articleno &gt; <%="#" %>{articleNo}
                &lt;if test="searchWord != null and searchWord != ''"&gt;
                    AND (title LIKE '%${searchWord}%' 
                        OR DBMS_LOB.INSTR(content, '${searchWord}') &gt; 0)
                &lt;/if&gt;
                ORDER BY articleno) 
            a)
        WHERE r = 1
    &lt;/select&gt;
    
    &lt;select id="selectPrevOne" parameterType="hashmap" resultType="Article"&gt;
        SELECT articleno, title
        FROM
            (SELECT rownum r,a.*
            FROM
                (SELECT articleno, title 
                FROM article 
                WHERE 
                    boardCd = <%="#" %>{boardCd} 
                    AND articleno &lt; <%="#" %>{articleNo}
                &lt;if test="searchWord != null and searchWord != ''"&gt;
                    AND (title LIKE '%${searchWord}%' 
                        OR DBMS_LOB.INSTR(content, '${searchWord}') &gt; 0)
                &lt;/if&gt; 
                ORDER BY articleno DESC)
            a)
        WHERE r = 1
    &lt;/select&gt;
    
    &lt;select id="selectListOfAttachFiles" parameterType="int" resultType="AttachFile"&gt;
        SELECT 
            attachfileno, 
            filename, 
            filetype, 
            filesize, 
            articleno, 
            email
        FROM attachfile 
        WHERE articleno = <%="#" %>{articleNo} 
        ORDER BY attachfileno
    &lt;/select&gt;
    
    &lt;delete id="deleteFile" parameterType="int"&gt;
        DELETE FROM attachfile WHERE attachfileno = <%="#" %>{attachFileNo}
    &lt;/delete&gt;
    
    &lt;select id="selectOneBoardName" parameterType="string" resultType="string"&gt;
        SELECT boardNm FROM board WHERE boardcd = <%="#" %>{boardCd}
    &lt;/select&gt;
    
    &lt;insert id="insertComment" parameterType="Comment"&gt;
        INSERT INTO comments (commentno, articleno, email, memo, regdate)
        VALUES (seq_comments.nextval, <%="#" %>{articleNo}, <%="#" %>{email}, <%="#" %>{memo}, sysdate)
    &lt;/insert&gt;
    
    &lt;update id="updateComment" parameterType="Comment"&gt;
        UPDATE comments SET memo = <%="#" %>{memo} WHERE commentno = <%="#" %>{commentNo}
    &lt;/update&gt;
    
    &lt;delete id="deleteComment" parameterType="int"&gt;
        DELETE FROM comments WHERE commentno = <%="#" %>{commentNo}
    &lt;/delete&gt;

    &lt;select id="selectListOfComments" parameterType="int" resultType="Comment"&gt;
        SELECT 
            commentno, 
            articleno, 
            c.email, 
            NVL(name,'Anonymous') name, 
            memo, 
            regdate
        FROM comments c, member m
        WHERE 
            c.email = m.email(+)
            AND articleno = <%="#" %>{articleNo}
        ORDER BY commentno DESC
    &lt;/select&gt;

    &lt;select id="selectOneAttachFile" parameterType="int" resultType="AttachFile"&gt;
        SELECT 
            attachfileno, 
            filename, 
            filetype, 
            filesize, 
            articleno, 
            email
        FROM attachfile
        WHERE attachfileno = <%="#" %>{attachFileNo}
    &lt;/select&gt;
    
    &lt;select id="selectOneComment" parameterType="int" resultType="Comment"&gt;
        SELECT 
            commentno,
            articleno,
            email,
            memo,
            regdate 
        FROM comments 
        WHERE commentno = <%="#" %>{commentNo}
    &lt;/select&gt;

&lt;/mapper&gt;
</pre>

<h3>MyBatis에서 인서트 후 고유번호가 반환되게 하는 방법</h3>

<em class="path">&lt;insert id="insert" ..&gt;</em>부분이 새 글을 추가할 때 쓰인다.<br />
모델 2 게시판의 BoardDao.insert() 메서드에서는<br />
<em class="path">INSERT INTO article (articleno, boardcd, title, content, email, hit, regdate)<br />
VALUES (<strong>SEQ_ARTICLE.nextval</strong>, ?, ?, ?, ?, 0, sysdate);</em><br />
문이 성공한 후 첨부 파일이 있으면<br />
<em class="path">INSERT INTO attachfile (attachfileno, filename, filetype, filesize, articleno, email)<br />
VALUES (SEQ_ATTACHFILE.nextval, ?, ?, ?, <strong>SEQ_ARTICLE.currval</strong>, ?)</em><br />
문을 이어서 실행하는 것으로 구현했다.<br />
JDBC를 쓰는 상황에서는 모든 것이 분명하다.<br />
하지만 JDBC 위에서 동작하는 프레임워크를 사용하는 상황에서는 JDBC를 사용할 때 분명해 보이던 것에 대한 
해법을 찾기가 쉽지 않다.<br />
<br />
마이바티스에서 DML은 일반적으로 바뀐 행수가 반환한다.<br />
인서트 문장이 실행된 후 고유번호가 반환되기를 원한다면 useGeneratedKeys="true" 속성이 있어야 하고,<br />
오라클과 같이 자동 증가 칼럼이 없는 경우엔 selectKey 서브 엘리먼트를 사용해야 한다.<br />

<pre>&lt;insert id="insert" parameterType="Article" useGeneratedKeys="true"&gt;
    &lt;selectKey keyProperty="articleNo" resultType="int" order="BEFORE"&gt;
        SELECT seq_article.nextval FROM dual
    &lt;/selectKey&gt;
    INSERT INTO article (articleNo, boardCd, title, content, email, hit, regdate)
    VALUES
    (<%="#" %>{articleNo}, <%="#" %>{boardCd}, <%="#" %>{title}, <%="#" %>{content}, <%="#" %>{email}, 0, sysdate)
&lt;/insert&gt;
</pre>

이외에도 MyBatis와 연동하면서 바뀐 내용은 다음과 같다.<br />
모델 2의 게시글 수정 메서드는<br />
<em class="path">UPDATE article SET title = ?, content = ? WHERE articleno = ?</em><br />
을 실행한 후에 첨부 파일이 있다면<br />
<em class="path">INSERT INTO attachfile<br />
(attachfileno, filename, filetype, filesize, articleno, email)<br />
VALUES (SEQ_ATTACHFILE.nextval, ?, ?, ?, ?, ?)</em><br />
을 연이어 실행하는 구조였으나 Spring MVC 프로젝트에서는 
update()와 insertAttachFile() 메서드의 조합으로 이를 대신했다.<br />
모델 2의 게시글 삭제 메서드는<br />
DELETE FROM comments WHERE articleno = ?<br />
DELETE FROM attachfile WHERE articleno = ?<br />
DELETE FROM article WHERE articleno = ?<br />
을 트랜잭션으로 실행하는 것이었다.<br />
Spring MVC 프로젝트에서는 간단한 구현을 위해<br />
DELETE FROM article WHERE articleno = ?
만 실행하는 것으로 구현한다.<br />


BoardMapper.xml에 맞게 BoardMapper.java를 아래와 같이 만든다.<br />

<em class="filename">BoardMapper.java</em>
<pre class="prettyprint">package net.java_school.mybatis;

import java.util.HashMap;
import java.util.List;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.Comment;

public interface BoardMapper {

  //목록
  public List&lt;Article&gt; selectListOfArticles(HashMap&lt;String, String&gt; hashmap);  

  //총 레코드
  public int selectCountOfArticles(HashMap&lt;String, String&gt; hashmap);

  //글쓰기
  public int insert(<strong>Article article</strong>);   

  <strong>//첨부 파일 추가
  public void insertAttachFile(AttachFile attachFile);</strong>

  //글수정
  public void update(<strong>Article article</strong>);  

  //글삭제
  public void delete(int articleNo);

  //조회 수 증가
  public void updateHitPlusOne(int articleNo);  

  //상세보기
  public Article selectOne(int articleNo);

  //다음 글
  public Article selectNextOne(<strong>HashMap&lt;String, String&gt; hashmap</strong>); 

  //이전 글 
  public Article selectPrevOne(<strong>HashMap&lt;String, String&gt; hashmap</strong>);

  //첨부 파일 리스트  
  public List&lt;AttachFile&gt; selectListOfAttachFiles(int articleNo);    

  //첨부 파일 삭제  
  public void deleteFile(int attachFileNo); 

  //게시판 이름
  public String selectOneBoardName(String boardCd);

  //댓글 쓰기 
  public void insertComment(Comment comment);   

  //댓글 수정 
  public void updateComment(Comment comment);

  //댓글 삭제
  public void deleteComment(int commentNo);

  //댓글 리스트
  public List&lt;Comment&gt; selectListOfComments(int articleNo);

  //첨부 파일 찾기
  public AttachFile selectOneAttachFile(int attachFileNo);

  //댓글 찾기
  public Comment selectOneComment(int commentNo);

} 
</pre>

모델 2의 BoardService.java를 인터페이스로 바꾼다.<br />

<em class="filename">BoardService.java</em>
<pre class="prettyprint">package net.java_school.board;

import java.util.List;

import net.java_school.commons.PagingHelper;

public interface BoardService {

  //목록
  public <strong>List&lt;Article&gt;</strong> getArticleList(String boardCd, String searchWord);

  //총 레코드
  public int getTotalRecord(String boardCd, String searchWord);

  //글쓰기
  public int addArticle(<strong>Article article</strong>);

  <strong>//첨부 파일 추가 
  public void addAttachFile(AttachFile attachFile);</strong>

  //글 수정 
  public void modifyArticle(<strong>Article article</strong>);

  //글 삭제 
  public void removeArticle(int articleNo);

  //조회 수 증가 
  public void increaseHit(int articleNo);

  //상세보기 
  public Article getArticle(int articleNo);

  //다음 글 
  public Article getNextArticle(int articleNo, 
      String boardCd, String searchWord);

  //이전 글 
  public Article getPrevArticle(int articleNo, 
      String boardCd, String searchWord);

  //첨부 파일 리스트 
  public <strong>List&lt;AttachFile&gt;</strong> getAttachFileList(int articleNo);

  //첨부 파일 삭제 
  public void removeAttachFile(int attachFileNo);

  //게시판 이름 
  public String getBoardNm(String boardCd);

  //댓글 쓰기 
  public void addComment(Comment comment);

  //댓글 수정 
  public void modifyComment(Comment comment);

  //댓글 삭제 
  public void removeComment(int commentNo);

  //댓글 리스트 
  public <strong>List&lt;Comment&gt;</strong> getCommentList(int articleNo);

  //첨부 파일 찾기 
  public AttachFile getAttachFile(int attachFileNo);

  //댓글 찾기 
  public Comment getComment(int commentNo);

  public int getListItemNo();

  public int getPrevPage();

  public int getFirstPage();

  public int getLastPage();

  public int getNextPage();

  public void setPagingHelper(PagingHelper pagingHelper);
    
}
</pre>


BoardService 인터페이스의 구현체 BoardServiceImpl.java를 
net.java_school.board 패키지에 만든다.<br />

<em class="filename">BoardServiceImpl.java</em>
<pre class="prettyprint">package net.java_school.board;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.java_school.commons.PagingHelper;
import net.java_school.mybatis.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
  @Autowired
  private BoardMapper boardMapper;
  private PagingHelper pagingHelper; //페이징 처리 유틸리티 클래스

  //목록 
  @Override
  public <strong>List&lt;Article&gt;</strong> getArticleList(String boardCd, String searchWord) {
    Integer startRownum = pagingHelper.getStartRecord();
    Integer endRownum = pagingHelper.getEndRecord();
    HashMap&lt;String, String&gt; hashmap = new HashMap&lt;String, String&gt;();
    hashmap.put("boardCd", boardCd);
    hashmap.put("searchWord", searchWord);
    hashmap.put("start", startRownum.toString());
    hashmap.put("end", endRownum.toString());

    return boardMapper.selectListOfArticles(hashmap);
  }
    
  //총 레코드 
  @Override 
  public int getTotalRecord(String boardCd, String searchWord) {
    HashMap&lt;String,String&gt; hashmap = new HashMap&lt;String,String&gt;();
    hashmap.put("boardCd", boardCd);
    hashmap.put("searchWord", searchWord);
    
    return boardMapper.selectCountOfArticles(hashmap);
  }
    
  //글쓰기 
  @Override
  public int addArticle(Article article) {
    return boardMapper.insert(article);
  }

  //첨부 파일 추가 
  @Override
  public void addAttachFile(AttachFile attachFile) {
    boardMapper.insertAttachFile(attachFile);
  }

  //글 수정 
  @Override
  public void modifyArticle(Article article) {
    boardMapper.update(article);
  }

  //글 삭제
  @Override
  public void removeArticle(int articleNo) {
    boardMapper.delete(articleNo);
  }

  //조회 수 증가 
  @Override
  public void increaseHit(int articleNo) {
    boardMapper.updateHitPlusOne(articleNo);
  }

  //상세보기 
  @Override
  public Article getArticle(int articleNo) {
    return boardMapper.selectOne(articleNo);
  }

  //다음 글 
  @Override
  public Article getNextArticle(int articleNo, String boardCd, String searchWord) {
    HashMap&lt;String, String&gt; hashmap = new HashMap&lt;String, String&gt;();
    Integer no = articleNo;
    hashmap.put("articleNo", no.toString());
    hashmap.put("boardCd", boardCd);
    hashmap.put("searchWord", searchWord);

    return boardMapper.selectNextOne(hashmap);
  }

  //이전 글 
  @Override
  public Article getPrevArticle(int articleNo, String boardCd, String searchWord) {
    HashMap&lt;String, String&gt; hashmap = new HashMap&lt;String, String&gt;();
    Integer no = articleNo;
    hashmap.put("articleNo", no.toString());
    hashmap.put("boardCd", boardCd);
    hashmap.put("searchWord", searchWord);

    return boardMapper.selectPrevOne(hashmap);
  }

  //첨부 파일 리스트 
  @Override
  public <strong>List&lt;AttachFile&gt;</strong> getAttachFileList(int articleNo) {
    return boardMapper.selectListOfAttachFiles(articleNo);
  }

  //첨부 파일 삭제 
  @Override
  public void removeAttachFile(int attachFileNo) {
    boardMapper.deleteFile(attachFileNo);
  }

  //게시판 이름 
  @Override
  public String getBoardNm(String boardCd) {
    return boardMapper.selectOneBoardName(boardCd);
  }

  //댓글 쓰기 
  @Override
  public void addComment(Comment comment) {
    boardMapper.insertComment(comment);
  }

  //댓글 수정 
  @Override
  public void modifyComment(Comment comment) {
    boardMapper.updateComment(comment);
  }

  //댓글 삭제 
  @Override
  public void removeComment(int commentNo) {
    boardMapper.deleteComment(commentNo);
  }

  //댓글 리스트 
  @Override
  public <strong>List&lt;Comment&gt;</strong> getCommentList(int articleNo) {
    return boardMapper.selectListOfComments(articleNo);
  }

  //첨부 파일 찾기 
  @Override
  public AttachFile getAttachFile(int attachFileNo) {
    return boardMapper.selectOneAttachFile(attachFileNo);
  }

  //댓글 찾기 
  @Override
  public Comment getComment(int commentNo) {
    return boardMapper.selectOneComment(commentNo);
  }

  @Override
  public int getListItemNo() {
    return pagingHelper.getListItemNo(); 
  }

  @Override
  public int getPrevPage() {
    return pagingHelper.getPrevPage();
  }

  @Override
  public int getFirstPage() {
    return pagingHelper.getFirstPage();
  }

  @Override
  public int getLastPage() {
    return pagingHelper.getLastPage();
  }

  @Override
  public int getNextPage() {
    return pagingHelper.getNextPage();
  }

  @Override
  public void setPagingHelper(PagingHelper pagingHelper) {
    this.pagingHelper = pagingHelper;
  }
    
}
</pre>


게시판과 관련된 모든 요청을 담당하는 컨트롤러를 만들어야 한다.<br />
BbsController.java 클래스를 net.java_school.board.spring 패키지에 만든다.<br />

<em class="filename">BbsController.java</em>
<pre class="prettyprint">package net.java_school.board.spring;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.java_school.board.Article;
import net.java_school.board.AttachFile;
import net.java_school.board.BoardService;
import net.java_school.board.Comment;
import net.java_school.commons.PagingHelper;
import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
@RequestMapping("/bbs")
public class BbsController {
    
    @Autowired
    private BoardService boardService;
    
    @RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
    public String list(String boardCd, 
            Integer page, 
            String searchWord,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            //로그인 후 되돌아갈 URL을 구한다.
            String url = req.getServletPath();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            //로그인 페이지로 리다이렉트
            url = URLEncoder.encode(url, "UTF-8");
            return "redirect:/users/login?url=" + url;
        }
        
        int numPerPage = 10;
        int pagePerBlock = 10;
        
        int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
        
        PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
        boardService.setPagingHelper(pagingHelper);

        List&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord);
        String boardNm = boardService.getBoardNm(boardCd);
        Integer listItemNo = boardService.getListItemNo();
        Integer prevPage = boardService.getPrevPage();
        Integer nextPage = boardService.getNextPage();
        Integer firstPage = boardService.getFirstPage();
        Integer lastPage = boardService.getLastPage();
        
        model.addAttribute("list", list);
        model.addAttribute("boardNm", boardNm);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        
        return "bbs/list";
        
    }

    @RequestMapping(value="/write", method=RequestMethod.GET)
    public String writeForm(String boardCd,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            //로그인 후 되돌아갈 URL을 구한다.
            String url = req.getServletPath();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            //로그인 페이지로 리다이렉트
            url = URLEncoder.encode(url, "UTF-8");
            return "redirect:/users/login?url=" + url;
        }

        //게시판 이름
        String boardNm = boardService.getBoardNm(boardCd);
        model.addAttribute("boardNm", boardNm);
        
        return "bbs/write";
    }

    @RequestMapping(value="/write", method=RequestMethod.POST)
    public String write(MultipartHttpServletRequest mpRequest,
            HttpSession session) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }
        
        String boardCd = mpRequest.getParameter("boardCd");
        String title = mpRequest.getParameter("title");
        String content = mpRequest.getParameter("content");
        
        Article article = new Article();
        article.setBoardCd(boardCd);
        article.setTitle(title);
        article.setContent(content);
        article.setEmail(user.getEmail());
        
        boardService.addArticle(article);

        //파일 업로드
        Iterator&lt;String&gt; it = mpRequest.getFileNames();
        List&lt;MultipartFile&gt; fileList = new ArrayList&lt;MultipartFile&gt;();
        while (it.hasNext()) {
            MultipartFile multiFile = mpRequest.getFile((String) it.next());
            if (multiFile.getSize() &gt; 0) {
                String filename = multiFile.getOriginalFilename();
                multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
                fileList.add(multiFile);
            }
        }
        
        //파일데이터 삽입
        int size = fileList.size();
        for (int i = 0; i &lt; size; i++) {
            MultipartFile mpFile = fileList.get(i);
            AttachFile attachFile = new AttachFile();
            String filename = mpFile.getOriginalFilename();
            attachFile.setFilename(filename);
            attachFile.setFiletype(mpFile.getContentType());
            attachFile.setFilesize(mpFile.getSize());
            attachFile.setArticleNo(article.getArticleNo());
            attachFile.setEmail(user.getEmail());
            boardService.addAttachFile(attachFile);
        }
        
        return "redirect:/bbs/list?page=1&amp;boardCd=" + article.getBoardCd();
    }

    @RequestMapping(value="/view", method=RequestMethod.GET)
    public String view(Integer articleNo, 
            String boardCd, 
            Integer page,
            String searchWord,
            HttpServletRequest req,
            HttpSession session,
            Model model) throws Exception {

        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            //로그인 후 되돌아갈 URL을 구한다.
            String url = req.getServletPath();
            String query = req.getQueryString();
            if (query != null) url += "?" + query;
            //로그인 페이지로 리다이렉트
            url = URLEncoder.encode(url, "UTF-8");
            return "redirect:/users/login?url=" + url;
        }
        
        /*
        상세보기를 할 때마다 조회 수를 1 증가
        하단에 목록에서 조회 수를 제대로 보기 위해서는
        목록 레코드를 페치하기 전에 조회 수를 먼저 증가시켜야 한다.
        TODO : 사용자 IP와 시간을 고려해서 조회 수를 증가하도록
        */
        boardService.increaseHit(articleNo);
        
        Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
        List&lt;AttachFile&gt; attachFileList = boardService.getAttachFileList(articleNo);
        Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
        Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
        List&lt;Comment&gt; commentList = boardService.getCommentList(articleNo);
        String boardNm = boardService.getBoardNm(boardCd);
        
        //상세보기에서 볼 게시글 관련 정보
        String title = article.getTitle();//제목
        String content = article.getContent();//내용
        content = content.replaceAll(WebContants.LINE_SEPARATOR, "&lt;br /&gt;");
        int hit = article.getHit();//조회 수
        String name = article.getName();//작성자 이름
        String email = article.getEmail();//작성자 ID
        String regdate = article.<strong>getRegdateForView()</strong>;//작성일

        model.addAttribute("title", title);
        model.addAttribute("content", content);
        model.addAttribute("hit", hit);
        model.addAttribute("name", name);
        model.addAttribute("email", email);
        model.addAttribute("regdate", regdate);
        model.addAttribute("attachFileList", attachFileList);
        model.addAttribute("nextArticle", nextArticle);
        model.addAttribute("prevArticle", prevArticle);
        model.addAttribute("commentList", commentList);

        //목록 관련
        int numPerPage = 10;//페이지당 레코드 수
        int pagePerBlock = 10;//블록당 페이지 링크 수
        
        int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
        PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
        boardService.setPagingHelper(pagingHelper);

        List&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord);
        
        int listItemNo = boardService.getListItemNo();
        int prevPage = boardService.getPrevPage();
        int nextPage = boardService.getNextPage();
        int firstPage = boardService.getFirstPage();
        int lastPage = boardService.getLastPage();
        
        model.addAttribute("list", list);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prevPage", prevPage);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        model.addAttribute("nextPage", nextPage);
        model.addAttribute("boardNm", boardNm);
        
        return "bbs/view";
    }
    
    @RequestMapping(value="/addComment", method=RequestMethod.POST)
    public String addComment(Integer articleNo, 
            String boardCd, 
            Integer page, 
            String searchWord,
            String memo,
            HttpSession session) throws Exception {
        
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }

        Comment comment = new Comment();
        comment.setArticleNo(articleNo);
        comment.setEmail(user.getEmail());
        comment.setMemo(memo);
        
        boardService.addComment(comment);
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&amp;boardCd=" + boardCd + 
            "&amp;page=" + page + 
            "&amp;searchWord=" + searchWord;

    }

    @RequestMapping(value="/updateComment", method=RequestMethod.POST)
    public String updateComment(Integer commentNo, 
            Integer articleNo, 
            String boardCd, 
            Integer page, 
            String searchWord, 
            String memo,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        Comment comment = boardService.getComment(commentNo);
        
        //로그인 사용자가 댓글 소유자인지  검사
        if (user == null || !user.getEmail().equals(comment.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        //생성된 Comment 객체를 재사용한다.
        comment.setMemo(memo);
        boardService.modifyComment(comment);
        
        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&amp;boardCd=" + boardCd + 
            "&amp;page=" + page + 
            "&amp;searchWord=" + searchWord;

    }

    @RequestMapping(value="/deleteComment", method=RequestMethod.POST)
    public String deleteComment(Integer commentNo, 
            Integer articleNo, 
            String boardCd, 
            Integer page, 
            String searchWord,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        Comment comment = boardService.getComment(commentNo);
        
        //로그인 사용자가 댓글의 소유자인지 검사
        if (user == null || !user.getEmail().equals(comment.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        boardService.removeComment(commentNo);
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&amp;boardCd=" + boardCd + 
            "&amp;page=" + page + 
            "&amp;searchWord=" + searchWord;

    }

    @RequestMapping(value="/modify", method=RequestMethod.GET)
    public String modifyForm(Integer articleNo, 
            String boardCd,
            HttpSession session,
            Model model) {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        Article article = boardService.getArticle(articleNo);
        
        //로그인 사용자가 글 작성자인지 검사
        if (user == null || !user.getEmail().equals(article.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        //수정페이지에서의 보일 게시글 정보
        String title = article.getTitle();
        String content = article.getContent();
        String boardNm = boardService.getBoardNm(boardCd);
        
        model.addAttribute("title", title);
        model.addAttribute("content", content);
        model.addAttribute("boardNm", boardNm);
        
        return "bbs/modify";
    }
    
    @RequestMapping(value="/modify", method=RequestMethod.POST)
    public String modify(MultipartHttpServletRequest mpRequest,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        
        int articleNo = Integer.parseInt(mpRequest.getParameter("articleNo"));
        Article article = boardService.getArticle(articleNo);
        
        //로그인 사용자가 글 작성자인지 검사
        if (!article.getEmail().equals(user.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        String boardCd = mpRequest.getParameter("boardCd");
        int page = Integer.parseInt(mpRequest.getParameter("page"));
        String searchWord = mpRequest.getParameter("searchWord");
        
        String title = mpRequest.getParameter("title");
        String content = mpRequest.getParameter("content");
        
        //게시글 수정
        article.setTitle(title);
        article.setContent(content);
        article.setBoardCd(boardCd);
        boardService.modifyArticle(article);

        //파일 업로드
        Iterator&lt;String&gt; it = mpRequest.getFileNames();
        List&lt;MultipartFile&gt; fileList = new ArrayList&lt;MultipartFile&gt;();
        while (it.hasNext()) {
            MultipartFile multiFile = mpRequest.getFile((String) it.next());
            if (multiFile.getSize() &gt; 0) {
                String filename = multiFile.getOriginalFilename();
                multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
                fileList.add(multiFile);
            }
        }
        
        //파일데이터 삽입
        int size = fileList.size();
        for (int i = 0; i &lt; size; i++) {
            MultipartFile mpFile = fileList.get(i);
            AttachFile attachFile = new AttachFile();
            String filename = mpFile.getOriginalFilename();
            attachFile.setFilename(filename);
            attachFile.setFiletype(mpFile.getContentType());
            attachFile.setFilesize(mpFile.getSize());
            attachFile.setArticleNo(articleNo);
            attachFile.setEmail(user.getEmail());
            boardService.addAttachFile(attachFile);
        }
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        return "redirect:/bbs/view?articleNo=" + articleNo 
            + "&amp;boardCd=" + boardCd 
            + "&amp;page=" + page 
            + "&amp;searchWord=" + searchWord;

    }

    @RequestMapping(value="/download", method=RequestMethod.POST)
    public String download(String filename, HttpSession session, Model model) {
        //로그인 체크
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        if (user == null) {
            throw new AuthenticationException(WebContants.NOT_LOGIN);
        }

        model.addAttribute("filename", filename);
        return "inc/download";

    }

    @RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
    public String deleteAttachFile(Integer attachFileNo, 
            Integer articleNo, 
            String boardCd, 
            Integer page, 
            String searchWord,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        AttachFile attachFile = boardService.getAttachFile(attachFileNo);
        
        //로그인 사용자가 첨부 파일 소유자인지 검사
        if (user == null || !user.getEmail().equals(attachFile.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        boardService.removeAttachFile(attachFileNo);
        
        searchWord = URLEncoder.encode(searchWord,"UTF-8");
        
        return "redirect:/bbs/view?articleNo=" + articleNo + 
            "&amp;boardCd=" + boardCd + 
            "&amp;page=" + page + 
            "&amp;searchWord=" + searchWord;

    }

    @RequestMapping(value="/del", method=RequestMethod.POST)
    public String del(Integer articleNo, 
            String boardCd, 
            Integer page, 
            String searchWord,
            HttpSession session) throws Exception {
        
        User user = (User) session.getAttribute(WebContants.USER_KEY);
        Article article = boardService.getArticle(articleNo);
        
        //로그인 사용자가 글 작성자인지 검사
        if (user == null || !user.getEmail().equals(article.getEmail())) {
            throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
        }
        
        boardService.removeArticle(articleNo);

        searchWord = URLEncoder.encode(searchWord, "UTF-8");
        
        return "redirect:/bbs/list?boardCd=" + boardCd + 
            "&amp;page=" + page + 
            "&amp;searchWord=" + searchWord;

    }
    
}
</pre>

<h3>BbsController.java에 적용된 어노테이션 설명</h3>
다음은 컨트롤러에 적용된 어노테이션을 정리한 것이다.<br />

<ul>
  <li>@Controller는 클래스가 컨트롤러 컴포넌트임을 표시한다.</li>
  <li>클래스 레벨의 @RequestMapping("/bbs")는 컨트롤러가 "/bbs"를 포함하는 모든 요청을 담당한다는 것을 표시한다.</li>
  <li>메서드 레벨의 @RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})는<br />
  메서드가 GET이나 POST 방식의 "/bbs/list" 요청에 매핑됨을 표시한다.</li>
  <li>멤버 변수에 @Autowired를 적용하면 변수의 접근자가 private이고 공개된 setter가 없어도 종속객체가 주입된다.</li>
</ul>

<h3>목록 요청</h3>
목록 요청 URL은 /bbs/list이다.<br />
컨트롤러에서 이 요청을 메서드에 매핑하려면 메서드 레벨로 @RequestMapping을 사용한다.<br />

<pre>@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})</pre>
클래스 레벨로 @RequestMapping("/bbs")가 있으므로 
이 메서드는 HTTP 프로토콜의 METHOD가 GET이나 POST방식의 /bbs/list 요청에 매핑된다.<br />
목록이라면 GET방식이 맞을 것이다. GET방식의 요청만을 매핑하려면 다음과 같이 고치면 된다.<br />

<pre>@RequestMapping(value="/list", method=RequestMethod.GET)
public String list(String boardCd, Integer page, String searchWord,...</pre>

메서드 아규먼트 리스트 boardCd, page, searchWord에는 요청에 실려 오는 파라미터의 값이 할당된다.<br />
만약 파라미터 이름이 page이고 이 파라미터의 값을 할당받아야 하는 아규먼트 이름이 page라면 다음과 같이 해결한다.<br />
<pre>@RequestParam("page") String page</pre>

컨트롤러 메서드의 아규먼트를 파라미터의 이름과 같게 하면 쉽게 파라미터값을 받을 수 있다.<br />
파라미터 중에서 boardCd와 page는 필수적으로 전달되도록 구현해야 한다.<br />
searchWord는 사용자가 검색해야만 전달된다.<br />
전달되는 파라미터값을 전부 받았음에도 아규먼트 리스트에서 HttpServletRequest가 있는 이유는 
요청 URL을 구하기 위해서다.<br />
메서드 구현부에서 로그인 체크를 통과하지 못하면 로그인 페이지로 리다이렉트하면서 현재 요청 URL을 전달해야 
하기 때문이다.<br />
HttpSession 타입의 아규먼트는 세션에 접근하기 위해서다.<br />

<pre>//로그인 체크
User user = (User) <strong>session</strong>.getAttribute(WebContants.USER_KEY);
if (user == null) {
    //로그인 후 되돌아갈 URL을 구한다.
    String url = <strong>req</strong>.getServletPath();
    String query = <strong>req</strong>.getQueryString();
    if (query != null) url += "?" + query;
    //로그인 페이지로 리다이렉트
    url = URLEncoder.encode(url, "UTF-8");
    return "redirect:/users/login?url=" + url;
}
</pre>
로그인 체크를 통과했다면 뷰로 전달할 데이터를 생산하는 비즈니스 로직이 이어진다.<br />
먼저 페이징 처리를 담당하는 PagingHelper 객체를 생성한 후 BoardService에 주입한다.<br />

<pre>int numPerPage = 10;
int pagePerBlock = 10;
int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
boardService.setPagingHelper(pagingHelper);
</pre>

목록을 구성하는 리스트, 게시판 이름, 목록 아이템의 번호, 이전 링크, 다음 링크, 
첫 번째 페이지, 마지막 페이지 데이터를 생산한다.<br />

<pre>List&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord);
String boardNm = boardService.getBoardNm(boardCd);
Integer listItemNo = boardService.getListItemNo();
Integer prevPage = boardService.getPrevPage();
Integer nextPage = boardService.getNextPage();
Integer firstPage = boardService.getFirstPage();
Integer lastPage = boardService.getLastPage();
</pre>

<h3>글쓰기 폼 요청</h3>
writeForm() 메서드는 GET방식의 /bbs/write 요청에 매핑된다.<br />

<pre>@RequestMapping(value="/write", method=RequestMethod.GET)
public String writeForm(String boardCd,HttpServletRequest req,HttpSession session...</pre>

메서드 아규먼트로는 파라미터값을 받는 boardCd와 목록 메서드와 같은 이유로 req와 session이 있다.<br />
boardCd는 게시판 이름을 만드는 데 필요하다.<br />
page와 searchWord는 포워딩 되므로 아규먼트로 받을 특별한 이유가 없다.<br />
게시판은 로그인 사용자만 이용할 수 있으므로 메서드는 먼저 로그인 체크로 시작하고,
로그인 체크가 통과하면 게시판 이름을 생성하고 write.jsp로 포워딩한다.<br />

<h3>글쓰기 처리 요청</h3>
write() 메서드는 POST방식의 /bbs/write 요청에 매핑된다.<br />

<pre>@RequestMapping(value="/write", method=RequestMethod.POST)
public String write(MultipartHttpServletRequest mpRequest,
        HttpSession session) throws Exception {</pre>

MultipartHttpServletRequest 타입의 mpRequest 아규먼트는 시스템에 전달된 파일에 접근할 수 있다.<br />
<br />
구현은 먼저 로그인 여부를 판단한다.<br />
로그인되어 있지 않다면 AuthenticationException 예외를 발생시킨다.<br />
spring-bbs-servlet.xml에 설정된 예외 리졸브에 의해서 뷰는 /WEB-INF/jsp/error.jsp가 선택된다.<br />

<pre>//로그인 체크
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    throw new AuthenticationException(WebContants.NOT_LOGIN);
}
</pre>

로그인 체크를 통과하면 새 글을 테이블에 삽입한다.<br />
BoardMapper.xml 파일에서 설명했듯이,
boardService.addArticle(article);가 실행되면 인자 article이 가리키는 Article 객체의 setArticleNo()가 호출되어 
게시글 고유번호가 세팅된다.

<pre>String boardCd = mpRequest.getParameter("boardCd");
String title = mpRequest.getParameter("title");
String content = mpRequest.getParameter("content");

Article article = new Article();
article.setBoardCd(boardCd);
article.setTitle(title);
article.setContent(content);
article.setEmail(user.getEmail());

<strong>boardService.addArticle(article);</strong>
</pre>

테이블에 새 글 정보를 삽입한 후, 서버에 전달된 파일을 우리가 원하는 업로드 디렉터리로 옮긴다.<br />
글쓰기 폼 페이지에서는 첨부 파일을 하나만 올릴 수 있지만 메서드는 여러 파일을 올릴 수 있도록 구현했다.<br />

<pre>//파일 업로드
Iterator&lt;String&gt; it = mpRequest.getFileNames();
List&lt;MultipartFile&gt; fileList = new ArrayList&lt;MultipartFile&gt;();
while (it.hasNext()) {
    MultipartFile multiFile = mpRequest.getFile((String) it.next());
    if (multiFile.getSize() &gt; 0) {
        String filename = multiFile.getOriginalFilename();
        multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
        fileList.add(multiFile);
    }
}
</pre>

파일을 업로드 디렉터리에 옮겼다면 첨부 파일 테이블에 파일 정보를 인서트 한다.<br />
article.getArticleNo()로 테이블에 입력된 게시글의 고유번호를 얻을 수 있다.<br />

<pre>//파일데이터 삽입
int size = fileList.size();
for (int i = 0; i &lt; size; i++) {
    MultipartFile mpFile = fileList.get(i);
    AttachFile attachFile = new AttachFile();
    String filename = mpFile.getOriginalFilename();
    attachFile.setFilename(filename);
    attachFile.setFiletype(mpFile.getContentType());
    attachFile.setFilesize(mpFile.getSize());
    attachFile.setArticleNo(<strong>article.getArticleNo()</strong>);
    attachFile.setEmail(user.getEmail());
    boardService.addAttachFile(attachFile);
}
</pre>

파일 업로드를 위한 부분을 다시 살펴본다.<br />
pom.xml에 다음 의존 라이브러리 설정이 필요하다.<br />

<pre>&lt;!-- File Upload --&gt; 
&lt;dependency&gt;
  &lt;groupId&gt;commons-io&lt;/groupId&gt;
  &lt;artifactId&gt;commons-io&lt;/artifactId&gt;
  &lt;version&gt;2.4&lt;/version&gt;
&lt;/dependency&gt;
&lt;dependency&gt;
  &lt;groupId&gt;commons-fileupload&lt;/groupId&gt;
  &lt;artifactId&gt;commons-fileupload&lt;/artifactId&gt;
  &lt;version&gt;1.3.1&lt;/version&gt;
&lt;/dependency&gt;
</pre>

spring-bbs-servlet.xml에 multipartResolver를 설정이 필요하다.<br />

<pre>&lt;bean id="multipartResolver"
  class="org.springframework.web.multipart.commons.CommonsMultipartResolver"
  p:maxUploadSize="104857600"
  p:maxInMemorySize="10485760" /&gt;
</pre>

maxUploadSize는 업로드 파일의 최대 크기로 100M로 설정했다.<br />
maxInMemorySize는 메모리에 저장되는 파일의 크기로 10M로 설정했다.<br />
이 속성을 설정하지 않더라도 디폴트 메모리값이 적용되므로 파일 시스템에 바로 쓰는 일은 일어나지 않는다.<br />
<br />
마지막으로 포워딩이 아닌 리다이렉트로 이동해야 한다.<br />
포워딩하게 되면 문제가 발생할 수 있는데, 사용자가 F5키로 웹 브라우저를 리로딩하면 
똑같은 정보로 글쓰기 처리가 다시 수행될 수 있기 때문이다.<br />
리다이렉트로 이동할 때 게시판 코드와 함께 page=1도 전달해야 한다.<br />

<pre>return "redirect:/bbs/list?<strong>page=1</strong>&amp;boardCd=" + article.getBoardCd();</pre>

글쓰기에서 마이바티스가 게시글의 고유번호를 반환하도록 BoardMapper.xml를 작성했음을 기억하자.<br />
모델 2에서는 서비스의 addArticle(article, attachFile); 메서드 하나로 글쓰기를 구현했지만
여기서는 서버스의 addArticle(article)과 addAttachFile(attachFile) 2개의 메서드를 
사용했다는 점도 기억하자.<br />

<h3>상세보기 요청</h3>

상세보기 요청(/bbs/view)에 매핑되는 메서드는 view()이다.<br />
메서드에 전달되는 파라미터는 articleNo, boardCd, page, searchWord이다.<br />
메서드의 아규먼트로 이들 파라미터의 값을 전달받을 변수를 선언했다.<br />
포워드로 이동하지만 view.jsp에 필요한 데이터를 생산하기 위해 전달되는 파라미터 모두 필요하기 때문이다.<br /> 
그럼에도 HttpServletRequest 타입의 아규먼트 변수가 있는 것은 로그인 체크를 통과 못 했을 때 
요청 URL 정보를 로그인 페이지에 전달하기 위해서다.<br />
HttpSession 타입의 아규먼트는 로그인 체크를 하려면 세션의 저장된 값에 접근해야 하기 때문에 필요하다.<br />

<pre>@RequestMapping(value="/view", method=RequestMethod.GET)
public String view(Integer articleNo, 
        String boardCd, 
        Integer page,
        String searchWord,
        HttpServletRequest req,
        HttpSession session,
        Model model) throws Exception {
</pre>

구현은 먼저 로그인 체크를 한다.<br />
로그인 체크를 통과하면 조회 수를 증가시킨 후에 상세보기 화면에 필요한 데이터를 생산한다.<br />
조회 수 증가는 사용자가 F5로 재로딩하면 계속 증가하는데, 
나중에 IP와 시간을 고려해서 증가하도록 후에 수정해야 할 것이다.<br />
IP와 시간을 고려한 조회 수 증가는 이 책에서는 다루지 않는다.<br />

<pre>/*
상세보기를 할 때마다 조회 수를 1 증가
하단에 목록에서 조회 수를 제대로 보기 위해서는
목록 레코드를 생산하기 전에 조회 수를 먼저 증가시켜야 한다.
TODO : 사용자 IP와 시간을 고려해서 조회 수를 증가하도록
*/
boardService.increaseHit(articleNo);

Article article = boardService.getArticle(articleNo);//상세보기에서 볼 게시글
List&lt;AttachFile&gt; attachFileList = boardService.getAttachFileList(articleNo);
Article nextArticle = boardService.getNextArticle(articleNo, boardCd, searchWord);
Article prevArticle = boardService.getPrevArticle(articleNo, boardCd, searchWord);
List&lt;Comment&gt; commentList = boardService.getCommentList(articleNo);
String boardNm = boardService.getBoardNm(boardCd);

//상세보기에서 볼 게시글 관련 정보
String title = article.getTitle();//제목
String content = article.getContent();//내용
content = content.replaceAll(WebContants.LINE_SEPARATOR, "&lt;br /&gt;");
int hit = article.getHit();//조회 수
String name = article.getName();//작성자 이름
String email = article.getEmail();//작성자 ID
String regdate = article.getRegdateForView();//작성일

model.addAttribute("title", title);
model.addAttribute("content", content);
model.addAttribute("hit", hit);
model.addAttribute("name", name);
model.addAttribute("email", email);
model.addAttribute("regdate", regdate);
model.addAttribute("attachFileList", attachFileList);
model.addAttribute("nextArticle", nextArticle);
model.addAttribute("prevArticle", prevArticle);
model.addAttribute("commentList", commentList);
</pre>

상세보기 화면에도 목록이 있으므로 list() 메서드의 구현과 비슷하다.<br />

<pre>//목록 관련
int numPerPage = 10;//페이지당 레코드 수
int pagePerBlock = 10;//블록당 페이지 링크 수

int totalRecord = boardService.getTotalRecord(boardCd, searchWord);
PagingHelper pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
boardService.setPagingHelper(pagingHelper);

List&lt;Article&gt; list = boardService.getArticleList(boardCd, searchWord);

int listItemNo = boardService.getListItemNo();
int prevPage = boardService.getPrevPage();
int nextPage = boardService.getNextPage();
int firstPage = boardService.getFirstPage();
int lastPage = boardService.getLastPage();

model.addAttribute("list", list);
model.addAttribute("listItemNo", listItemNo);
model.addAttribute("prevPage", prevPage);
model.addAttribute("firstPage", firstPage);
model.addAttribute("lastPage", lastPage);
model.addAttribute("nextPage", nextPage);
model.addAttribute("boardNm", boardNm);

return "bbs/view";
</pre>

<h3>댓글 쓰기 처리 요청</h3>
addComment() 메서드는 POST방식의 /bbs/addComment 요청에 매핑되는 메서드다.<br />

<pre>@RequestMapping(value="/addComment", method=RequestMethod.POST)
public String addComment(Integer articleNo, 
        String boardCd, 
        Integer page, 
        String searchWord,
        String memo,
        HttpSession session) throws Exception {
</pre>

댓글 쓰기 처리 후 상세보기 뷰로 리다이렉트될 것이므로 파라미터값을 저장할 아규먼트가 필요하다.<br /> 
로그인되어 있지 않다면 사용자 정의 인증 예외를 던진다.<br />

<pre>//로그인 체크
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    throw new AuthenticationException(WebContants.NOT_LOGIN);
}
</pre>

로그인 체크를 통과하면 파라미터값으로 댓글을 인서트 한다.<br />

<pre>Comment comment = new Comment();
comment.setArticleNo(articleNo);
comment.setEmail(user.getEmail());
comment.setMemo(memo);

boardService.addComment(comment);
</pre>

마지막으로 다시 상세보기 화면으로 리다이렉트해야 하는데,<br />
이때 검색어 searchWord는 한글일 수 있으므로 인코딩 작업을 한다.<br />

<pre>searchWord = URLEncoder.encode(searchWord,"UTF-8");</pre>

상세보기 뷰로 리다이렉트한다.<br />

<pre>return "redirect:/bbs/view?articleNo=" + articleNo + 
    "&amp;boardCd=" + boardCd + 
    "&amp;page=" + page + 
    "&amp;searchWord=" + searchWord;
</pre>

<h3>댓글 수정 요청</h3>
updateComment() 메서드는 POST 방식의 댓글 수정 요청 /bbs/updateComment에 매핑된다.<br />

<pre>@RequestMapping(value="/updateComment", method=RequestMethod.POST)
public String updateComment(
        Integer commentNo, 
        Integer articleNo, 
        String boardCd, 
        Integer page, 
        String searchWord, 
        String memo,
        HttpSession session) throws Exception {
</pre>

구현은 먼저 로그인 여부와 글 소유자 여부를 동시에 검사한다.<br />
검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>User user = (User) session.getAttribute(WebContants.USER_KEY);

Comment comment = boardService.getComment(commentNo);

//로그인 사용자가 댓글 소유자인지  검사
if (user == null || !user.getEmail().equals(comment.getEmail())) {
    throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

검사를 통과하면 파라미터로 댓글을 수정한다.<br />
댓글 수정은 댓글 내용만을 수정할 수 있다.<br />
즉, 관리자가 댓글을 수정하더라도 댓글의 소유자는 변경되지 않는 거로 구현했다.<br />

<pre>//생성된 Comment 객체를 재사용한다.
comment.setMemo(memo);
boardService.modifyComment(comment);
</pre>

마지막으로 상세보기 화면으로 리다이렉트한다.<br />

<pre>searchWord = URLEncoder.encode(searchWord, "UTF-8");

return "redirect:/bbs/view?articleNo=" + articleNo + 
    "&amp;boardCd=" + boardCd + 
    "&amp;page=" + page + 
    "&amp;searchWord=" + searchWord;
</pre>

<h3>댓글 삭제 요청</h3>
deleteComment() 메서드는 POST방식의 /bbs/deleteComment 요청에 매핑되는 메서드다.<br />

<pre>@RequestMapping(value="/deleteComment", method=RequestMethod.POST)
public String deleteComment(
        Integer commentNo, 
        Integer articleNo, 
        String boardCd, 
        Integer page, 
        String searchWord,
        HttpSession session) throws Exception {
</pre>

구현은 먼저 로그인 여부와 글 소유자 여부를 동시에 검사한다.<br />
검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>User user = (User) session.getAttribute(WebContants.USER_KEY);

Comment comment = boardService.getComment(commentNo);

//로그인 사용자가 댓글의 소유자인지 검사
if (user == null || !user.getEmail().equals(comment.getEmail())) {
    throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

검사를 통과하면 해당 댓글을 삭제한다.<br />
<pre>boardService.removeComment(commentNo);</pre>

마지막으로 상세보기 화면으로 리다이렉트한다.<br />

<pre>searchWord = URLEncoder.encode(searchWord,"UTF-8");

return "redirect:/bbs/view?articleNo=" + articleNo + 
    "&amp;boardCd=" + boardCd + 
    "&amp;page=" + page + 
    "&amp;searchWord=" + searchWord;
</pre>

<h3>글 수정 폼 요청</h3>
modifyForm() 메서드는 GET 방식의 게시글 수정 폼 요청 /bbs/modify에 매핑되는 메서드다.<br />

<pre>@RequestMapping(value="/modify", method=RequestMethod.GET)
public String modifyForm(
        Integer <strong>articleNo</strong>, 
        String <strong>boardCd</strong>,
        HttpSession session,
        Model model) {
</pre>

로그인 검사와 글 소유자 검사를 한다.<br />
검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>User user = (User) session.getAttribute(WebContants.USER_KEY);

Article article = boardService.getArticle(<strong>articleNo</strong>);

//로그인 사용자가 글 작성자인지 검사
if (user == null || !user.getEmail().equals(article.getEmail())) {
    throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

검사를 통과하면 게시글 수정 폼 화면에 필요한 데이터를 생산한다.<br />
마지막으로 게시글 수정 폼으로 포워드 한다.<br />

<pre>//수정 페이지에서의 보일 게시글 정보
String title = article.getTitle();
String content = article.getContent();
String boardNm = boardService.getBoardNm(<strong>boardCd</strong>);
        
model.addAttribute("title", title);
model.addAttribute("content", content);
model.addAttribute("boardNm", boardNm);

return "bbs/modify";
</pre>

<h3>글 수정 처리 요청</h3>
modify() 메서드는 POST 방식의 글 수정 처리 요청 /bbs/modify에 매핑되는 메서드다.<br />

<pre>@RequestMapping(value="/modify", method=RequestMethod.POST)
public String modify(
        MultipartHttpServletRequest mpRequest,
        HttpSession session) throws Exception {
</pre>

글 소유자인지 검사한다.<br />
검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>User user = (User) session.getAttribute(WebContants.USER_KEY);

int articleNo = Integer.parseInt(mpRequest.getParameter("articleNo"));
Article article = boardService.getArticle(articleNo);

//로그인 사용자가 글 작성자인지 검사
if (!article.getEmail().equals(user.getEmail())) {
    throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

전달된 파라미터 정보로 글을 수정한다.<br />

<pre>String boardCd = mpRequest.getParameter("boardCd");
int page = Integer.parseInt(mpRequest.getParameter("page"));
String searchWord = mpRequest.getParameter("searchWord");

String title = mpRequest.getParameter("title");
String content = mpRequest.getParameter("content");

//게시글 수정
article.setTitle(title);
article.setContent(content);
article.setBoardCd(boardCd);//TODO 게시판 종류 변경
boardService.modifyArticle(article);
</pre>

서버에 전달된 파일을 원하는 위치로 옮긴다.<br />

<pre>//파일 업로드
Iterator&lt;String&gt; it = mpRequest.getFileNames();
List&lt;MultipartFile&gt; fileList = new ArrayList&lt;MultipartFile&gt;();
while (it.hasNext()) {
    MultipartFile multiFile = mpRequest.getFile((String) it.next());
    if (multiFile.getSize() &gt; 0) {
        String filename = multiFile.getOriginalFilename();
        multiFile.transferTo(new File(WebContants.UPLOAD_PATH + filename));
        fileList.add(multiFile);
    }
}
</pre>

첨부 파일 데이터를 인서트 한다.<br />
글쓰기와 달리 게시글의 고유번호는 파라미터 articleNo이다.<br />

<pre>//파일데이터 삽입
int size = fileList.size();
for (int i = 0; i &lt; size; i++) {
    MultipartFile mpFile = fileList.get(i);
    AttachFile attachFile = new AttachFile();
    String filename = mpFile.getOriginalFilename();
    attachFile.setFilename(filename);
    attachFile.setFiletype(mpFile.getContentType());
    attachFile.setFilesize(mpFile.getSize());
    attachFile.setArticleNo(<strong>articleNo</strong>);
    attachFile.setEmail(user.getEmail());
    boardService.addAttachFile(attachFile);
}
</pre>

마지막으로 상세보기 화면으로 리다이렉트한다.<br />

<pre>searchWord = URLEncoder.encode(searchWord,"UTF-8");

return "redirect:/bbs/view?articleNo=" + articleNo 
    + "&amp;boardCd=" + boardCd 
    + "&amp;page=" + page 
    + "&amp;searchWord=" + searchWord;
</pre>

<h3>첨부 파일 다운로드 요청</h3>
download() 메서드는 POST 방식의 파일 다운로드 요청 /bbs/download에 매핑되는 메서드다.<br />
사실 다운로드는 게시판이 아닌 다른 모듈에서도 이용될 수 있으므로 파일 다운로드만을 위한 컨트롤러를 
만들어 처리할 수 있다.<br />

<pre>@RequestMapping(value="/download", method=RequestMethod.POST)
    public String download(String filename, HttpSession session, Model model) {
</pre>

구현은 먼저 로그인을 했는지 검사한다.<br />
검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>//로그인 체크
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
    throw new AuthenticationException(WebContants.NOT_LOGIN);
}
</pre>

파일명을 download.jsp에 전달한다.<br />
우리의 프로그램에서는 JSP 페이지가 파일 다운로드를 실행한다.<br />

<pre>model.addAttribute("filename", filename);
return "inc/download";
</pre>

<h3>첨부 파일 삭제 처리 요청</h3>
deleteAttachFile() 메서드는 POST 방식의 첨부 파일 삭제 요청 /bbs/deleteAttachFile에 매핑되는 메서드다.<br />

<pre>@RequestMapping(value="/deleteAttachFile", method=RequestMethod.POST)
public String deleteAttachFile(
        Integer attachFileNo, 
        Integer articleNo, 
        String boardCd, 
        Integer page, 
        String searchWord,
        HttpSession session) throws Exception {
</pre>

첨부 파일의 소유자인지 검사하고 검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>User user = (User) session.getAttribute(WebContants.USER_KEY);
AttachFile attachFile = boardService.getAttachFile(attachFileNo);

//로그인 사용자가 첨부 파일 소유자인지 검사
if (user == null || !user.getEmail().equals(attachFile.getEmail())) {
    throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

검사를 통과하면 첨부 파일을 삭제하고 상세보기 화면으로 리다이렉트한다.<br />

<pre>boardService.removeAttachFile(attachFileNo);

searchWord = URLEncoder.encode(searchWord,"UTF-8");

return "redirect:/bbs/view?articleNo=" + articleNo + 
    "&amp;boardCd=" + boardCd + 
    "&amp;page=" + page + 
    "&amp;searchWord=" + searchWord;
</pre>

<h3>게시글 삭제 처리 요청</h3>
del() 메서드는 POST 방식의 게시글 삭제 처리 요청 /bbs/del에 매핑되는 메서드다.<br />

<pre>@RequestMapping(value="/del", method=RequestMethod.POST)
public String del(
        Integer articleNo, 
        String boardCd, 
        Integer page, 
        String searchWord,
        HttpSession session) throws Exception {
</pre>

글 소유자 검사하고 검사를 통과하지 못하면 사용자 정의 인증 예외를 던진다.<br />

<pre>User user = (User) session.getAttribute(WebContants.USER_KEY);
Article article = boardService.getArticle(articleNo);

//로그인 사용자가 글 작성자인지 검사
if (user == null || !user.getEmail().equals(article.getEmail())) {
    throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

검사를 통과하면 게시글을 삭제하고 목록으로 리다이렉트한다.<br />

<pre>boardService.removeArticle(articleNo);

searchWord = URLEncoder.encode(searchWord, "UTF-8");

return "redirect:/bbs/list?boardCd=" + boardCd + 
    "&amp;page=" + page + 
    "&amp;searchWord=" + searchWord;
</pre>

<h3>view.jsp에서 파일 다운로드 부분 수정</h3>
모델 2와 달리 첨부 파일을 단순히 링크를 거는 것이 아니라 자바의 입출력 클래스를 이용해서 파일을 다운로드하는 것으로 변경했다.<br />
view.jsp에 다음 자바스크립트 함수를 추가한다.<br />

<pre class="prettyprint">function download(filename) {
    var form = document.getElementById("downForm");
    form.filename.value = filename;
    form.submit();
}
</pre>

하단 #form-group에 폼 엘리먼트를 추가한다.<br />

<pre class="prettyprint">&lt;form id="downForm" action="download" method="post"&gt;
&lt;p&gt;
    &lt;input type="hidden" name="filename" /&gt;
&lt;/p&gt;
&lt;/form&gt;
</pre>

파일 다운로드 부분을 아래와 같이 변경한다.<br />

<pre>&lt;a href="javascript:download('${file.filename }')"&gt;${file.filename }&lt;/a&gt;</pre>


<h2>테스트</h2>
sprng-bbs-servlet.xml에서 SimpleMappingExceptionResolver 부분의 주석을 제거한다.<br />
web.xml에서 에러 페이지의 주석을 제거한다.<br />
Proejct Explorer 뷰에서 프로젝트를 선택한다.<br />
마우스 오른쪽 버튼을 클릭하여 Run As - Maven Build... 선택한다.<br />
아래 그림처럼 Goals: 에 compile war:inplace를 입력한다.<br />
Apply 클릭하고 Run을 실행한다.<br />

<img alt="compile war:inplace" src="https://lh3.googleusercontent.com/-1d_39OVIHow/VYZX2ajaXtI/AAAAAAAACkA/epBvFcaPGPY/s718/compile-war_inplace.png" /><br />

참고로 메이븐 프로젝트의 루트 디렉터리에서 명령 프롬프트로 다음과 같이 실행해도 된다.<br />
<pre class="commandLine">mvn clean compile war:inplace</pre>

compile war:inplace은 <em class="path">C:\www\spring-bbs\src\main\webapp\WEB-INF\lib</em>에 
의존 라이브러리를 복사한다.<br />

<img alt="src/main/webapp/WEB-INF/lib" src="https://lh3.googleusercontent.com/-RKZcz8JD6-8/VYZX2ZiAF9I/AAAAAAAACj8/ztoLeQ1gV20/s640/compile-war-result.png" /><br />
톰캣 컨텍스트 파일을 만든다.<br />
WEB-INF의 바로 위인 src/main/webapp가 DocumentBase이다.<br />
메이븐 프로젝트 루트 디렉터리가 C:/www/spring-bbs라면 컨텍스트 파일을 아래와 같이 작성한다.<br />

<em class="filename">spring-bbs.xml</em>
<pre class="prettyprint">&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="C:/www/spring-bbs/<strong>src/main/webapp</strong>"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>

spring-bbs.xml 파일을<br />
C:/Program Files/Apache Software Foundation/Tomcat 7.0/conf/Catalina/localhost에 복사한다.<br />
톰캣을 재실행한 다음<br />
http://localhost:port/spring-bbs/bbs/list?boarCd=free&amp;page=1을 방문하여 테스트한다.<br />
JSP 프로젝트나 모델 2에서 테스트했던 데이터가 있다면 보일 것이다.<br />
데이터가 있다면 한글 검색을 테스트한다.<br />
한글 검색이 되지 않는다면 TOMCAT_HOME/conf/server.xml 파일을 열고 다음 강조된 부분이 있는지 확인한다.<br />

<em class="filename">server.xml</em>
<pre class="prettyprint">&lt;Connector port="8989" protocol="HTTP/1.1"
  connectionTimeout="20000"
  <strong>URIEncoding="UTF-8"</strong>
  redirectPort="8443" /&gt;
</pre>

강조된 부분이 있어야 한글 검색이 된다.<br />
다음은 테스트 실패 시 검사 항목을 정리한 것이다.<br />

<ol>
	<li>/WEB-INF/classes에 바이트 코드가 있는가?</li>
	<li>/WEB-INF/lib에 라이브러리 파일이 있는가?</li>
	<li>TOMCAT_HOME/lib에 ojdbc6.jar 파일이 있는가?</li>
	<li>JSP 파일의 EL이 해석되지 않는다면 web.xml이 DTD 버전이 2.4버전 이상인가?</li>
</ol>

테스트 단계에서는 로그인 화면의 이메일과 비밀번호 입력 필드에 디폴트 값을 주는 것이 좋다.<br />

<h2>Spring MVC 프로젝트에서의 사용자 인증 정리</h2>
스프링 시큐리티를 적용하기 전에 현재 인증 처리를 어떻게 구현했는지 다시 정리해 볼 필요가 있다.<br />
다음은 게시판 컨트롤러의 메서드에 적용된 인증 코드이다.<br />

<h3>목록보기, 상세보기, 글쓰기 폼</h3>
<pre class="prettyprint">//로그인 체크
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
  //로그인 후 되돌아갈 URL을 구한다.
  String url = req.getServletPath();
  String query = req.getQueryString();
  if (query != null) url += "?" + query;
  //로그인 페이지로 리다이렉트
  url = URLEncoder.encode(url, "UTF-8");
  return "redirect:/users/login?url=" + url;
}
</pre>

<h3>글쓰기, 댓글 쓰기</h3>
<pre class="prettyprint">//로그인 체크
User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
  throw new AuthenticationException(WebContants.NOT_LOGIN);
}
</pre>

<h3>댓글 수정, 댓글 삭제</h3>
<pre class="prettyprint">//로그인 사용자가 댓글 소유자인지  검사
if (user == null || !user.getEmail().equals(comment.getEmail())) {
  throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

<h3>수정 폼, 수정하기, 글 삭제</h3>
<pre class="prettyprint">//로그인 사용자가 글 작성자인지 검사
if (user == null || !user.getEmail().equals(article.getEmail())) {
  throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

<h3>첨부 파일 삭제</h3>
<pre class="prettyprint">//로그인 사용자가 첨부 파일 소유자인지 검사
if (user == null || !user.getEmail().equals(attachFile.getEmail())) {
  throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

다음은 회원 컨트롤러에 적용된 사용자 인증 로직이다.<br />
회원 컨트롤러의 대부분의 메서드는 인증 로직을 포함한다.<br />

<h3>로그인</h3>
<pre class="prettyprint">User user = userService.login(email, passwd);
if (user == null) {
  return "redirect:/users/login?url=" + url + "&amp;msg=Login-Failed";
} else {
  session.setAttribute(WebContants.USER_KEY, user);
  if (url != null &amp;&amp; !url.equals("")) {
  return "redirect:" + url;
}

return "redirect:/";
</pre>

<h3>내 정보 수정 폼, 비밀번호 변경 폼, 탈퇴</h3>
<pre class="prettyprint">User user = (User) session.getAttribute(WebContants.USER_KEY);
if (user == null) {
  //로그인 후 다시 돌아오기 위해
  String url = req.getServletPath();
  String query = req.getQueryString();
  if (query != null) url += "?" + query;
  //로그인 페이지로 리다이렉트
  url = URLEncoder.encode(url, "UTF-8");
  return "redirect/users/login?url=" + url;
}

</pre>

<h3>내 정보 수정</h3>
<pre class="prettyprint">User loginUser = (User) session.getAttribute(WebContants.USER_KEY);

if (loginUser == null) {
  throw new AuthenticationException(WebContants.NOT_LOGIN);
}

if (userService.login(loginUser.getEmail(), user.getPasswd()) == null) {
  throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
}
</pre>

<h3>비밀번호 변경</h3>
<pre class="prettyprint">String email = ((User)session.getAttribute(WebContants.USER_KEY)).getEmail();
</pre>

JSP에 사용자 인증 코드를 적용한 부분을 살펴보자.<br />
이 또한 스프링 시큐리티를 적용하면 바뀐다.<br />
상세보기 view.jsp에 있는 사용자 인증 코드가 핵심이다.<br />
JSP는 인증이 적용된 부분을 선별적으로 랜더링할 것이다.<br />

<pre class="prettyprint">&lt;!-- 중략 --&gt;

&lt;p id="file-list" style="text-align: right"&gt;
  &lt;c:forEach var="file" items="${attachFileList }" varStatus="status"&gt;    
  &lt;a href="javascript:download('${file.filename }')"&gt;${file.filename }&lt;/a&gt;
  <strong>&lt;c:if test="${user.email == file.email }"&gt;</strong>
  &lt;a href="javascript:deleteAttachFile('${file.attachFileNo }')"&gt;x&lt;/a&gt;
  <strong>&lt;/c:if&gt;</strong>
  &lt;br /&gt;
  &lt;/c:forEach&gt;
&lt;/p&gt;

&lt;!-- 중략 --&gt;

<strong>&lt;c:if test="${user.email == comment.email }"&gt;</strong>    
&lt;span class="modify-del"&gt;
  &lt;a href="javascript:modifyCommentToggle('${comment.commentNo }')"&gt;수정&lt;/a&gt;
  | &lt;a href="javascript:deleteComment('${comment.commentNo }')"&gt;삭제&lt;/a&gt;
&lt;/span&gt;
<strong>&lt;/c:if&gt;</strong>  

&lt;!-- 중략 --&gt;

<strong>&lt;c:if test="${user.email == email }"&gt;</strong>
&lt;div class="fl"&gt;
  &lt;input type="button" value="수정" onclick="goModify()" /&gt;
  &lt;input type="button" value="삭제" onclick="goDelete()"/&gt;
&lt;/div&gt;
<strong>&lt;/c:if&gt;</strong>
</pre>

다음 장에서 사용자 인증을 스프링 시큐리티를 사용하여 구현할 것이다.<br />
스프링 MVC에서 사용한 인증 코드와 스프링 시큐리티를 적용한 코드를 비교하는 것을 잊지 않도록 한다.<br />
<br />
테스트하면서 발생하는 에러는 log4j.xml에서 설정한 로그 파일이나 
TOMCAT_HOME/logs에 있는 로그 파일을 뒤져서 해결해야 한다.<br />
로그 메시지 전부를 이해하는 사람은 없을 것이다. 로그 메시지 중에 자신이 작성한 클래스의 어느 라인에서 예외가 발생하고 있는지 파악하고 이를 기초로 추론하는 능력을
키워야 한다.<br />
 

<h2>남겨진 과제</h2>
<ol>
	<li>게시글로 유튜브 동영상 소스 코드를 올렸을 때,
동영상를 보면서 댓글은 작성하거나 수정하거나 삭제하면 다시 상세보기 /bbs/view를 요청하므로 
동영상이 중지된다. 
Ajax를 이용하여 동영상을 중지시키지 않으면서 댓글을 등록, 수정, 삭제할 수 있게 한다.</li>
<li>조회 수 증가를 유명 포탈 사이트에서와 같이 구현한다.</li>
</ol>

