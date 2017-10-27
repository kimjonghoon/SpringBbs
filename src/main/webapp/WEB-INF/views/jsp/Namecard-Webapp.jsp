<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.7.9</div>

			
<h1>명함관리 웹 애플리케이션</h1>

본격적으로 서블릿/JSP를 공부하기 전에 JDBC에서 예제로 다루었던 명함관리를 웹 애플리케이션으로 바꾸는 실습을 한다.
이 실습믜 목표는 순수 자바 애플리케이션과 웹 애플리케이션의 차이에 대한 이해와 웹 환경 체험이다.<br />
실습에 대한 자세한 설명은 이어지는 과정에서 빠짐없이 다룰 것이니 여기서는 목표에 충실하자.<br /> 

<h2>명함관리를 웹 애플리케이션으로 바꾸기 위한 준비작업</h2>

<h3>1. 오라클 JDBC 드라이버를 {톰캣홈}/lib 에 복사한다.</h3>
JDBC 드라이버는 특별한 이유<sup><a href="#comments">1</a></sup> 때문에 웹 애플리케이션의 WEB-INF/lib 가 아닌 {톰캣홈}/lib 에 있어야 한다.<br />
다시 말해, WEB-INF/lib 에는 JDBC 드라이버가 없어야 한다.<br />
오라클 JDBC 드라이버인 ojdbc6.jar 파일을 {톰캣홈}/lib 에 복사한다.<br />

<h3>2. 웹 애플리케이션을 위한 디렉토리 구조를 마련한다.</h3>
C:/www/namecard 를 명함관리 웹 애플리케이션의 최상위 디렉토리로 정했다면<br />
C:/www/namecard 아래 다음과 같은 서브 디렉토리를 만들어야 한다.<br />

<ul>
	<li>WEB-INF</li>
	<li>WEB-INF/classes</li>
	<li>WEB-INF/lib</li>
</ul>

<h3>3. web.xml 파일을 WEB-INF 디렉토리에 만든다.</h3>
{톰캣홈}/webapps/ROOT/WEB-INF/web.xml 을 복사하여 C:/www/namecard/WEB-INF/에 붙여넣는다.<br />
복사한 후 C:/www/namecard/WEB-INF/web.xml 파일을 편집기로 열고
web-app 엘리먼트 안에 있는 모든 내용을 지운다.<br />

<pre class="prettyprint">
&lt;?xml version="1.0" encoding="ISO-8859-1"?&gt;
&lt;!--
 Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--&gt;

&lt;web-app xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee
                      http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0"
  metadata-complete="true"&gt;

&lt;/web-app&gt;
</pre>

<h3>4. namecard.xml 컨텍스트 파일 만든다.</h3>
아래 내용대로 namecard.xml 파일을 만든 다음 {톰캣홈}/conf/Catalina/localhost 로 옮긴다.<br />

<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="C:/www/namecard"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>

<h2>명함관리 웹 애플리케이션 테스트</h2>

<h3>첫번째 테스트</h3>
<a href="/jdbc/Namecard">명함관리</a>에서 실습했던 명함관리 Namecard와 NamecardDao 바이트코드를 WEB-INF/classes 에 복사한다.<br />
<pre>
C:/www/namecard/WEB-INF/classes
                           └── net
                               └── java_school
                                       └── namecard - Namecard.class
                                                    - NamecardDao.class
						
</pre>

C:/www/namecard(DocumentBase)에 모든 JSP파일을 만들 것이다.<br />
list.jsp을 아래 내용으로 만든다.<br />
이클립스가 아닌 일반 에디터로 작업한다.<br />

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;    
&lt;!DOCTYPE html&gt;
&lt;%
NamecardDao dao = new NamecardDao();
ArrayList&lt;Namecard&gt; list = dao.selectAll();
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함목록&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;table border="1"&gt;
&lt;tr&gt;
	&lt;td&gt;번호&lt;/td&gt;
	&lt;td&gt;이름&lt;/td&gt;
	&lt;td&gt;손전화&lt;/td&gt;
	&lt;td&gt;이메일&lt;/td&gt;
	&lt;td&gt;회사&lt;/td&gt;
&lt;/tr&gt;
&lt;%
int size = list.size();
for(int i = 0;i &lt; size;i++) {
	Namecard card = list.get(i);
%&gt;	
&lt;tr&gt;
	&lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getCompany() %&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;%
}
%&gt;	
&lt;/table&gt;
&lt;p&gt;
&lt;input type="button" value="추가" onclick="location.href='write.jsp'" /&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

톰캣을 재실행한다.<br />
http://localhost:8989/namecard/list.jsp를 방문하여 테스트한다.<br />

<h3>두번째 테스트</h3>
첫번째 테스트처럼 자바 클래스 소스를 웹 애플리케이션이 위치한 곳과 전혀 상관없는 곳에 두어도 된다.<br />
현재 소스는 "JDBC"에서 실습한 디렉토리(이를테면 C:/java/namecard/src)에 있을 것이다.<br />
하지만 이 경우, 시간이 지나면 소스의 위치를 잊을 수 있으며 소스를 지우는 실수를 할 수 있다.<br />
두번째 테스트는 소스를 웹 애플리케이션의 영역안에 옮기고 그 소스를 컴파일하는 테스트이다.<br />
먼저 자바 소스를 어디에 두어야 할지를 정해야 하는데,
WEB-INF 아래에 두면 웹브라우저로 직접 접근할 수 없으니 소스디렉토리를 WEB-INF/src 로 정하겠다.<br />
이제 JDBC에서 실습했던 명함관리 src 디렉토리를 복사하여 WEB-INF 에 붙여 넣는다.<br />
다음으로 명령프롬프트에서 <em class="path">C:\www\namecad\WEB-INF\src\net\java_school\namecard</em>
로 이동하여 다음과 같이 컴파일을 수행한다.<sup><a href="#comments">2</a></sup><br />
<pre>
javac -d C:/www/namecard/WEB-INF/classes *.java
</pre>
http://localhost:8989/namecard/list.jsp를 방문하여 테스트한다.<br />

<h3 id="3rd-Test">세번째 테스트</h3>
이클립스를 이용해서 작업하는 방법을 설명한다.<br />
이클립스를 실행한다.<br />
워크스페이스를 C:/www로 선택한다.<br />

<img src="https://lh3.googleusercontent.com/IKyinX03RhUGCgM2UXV1rcy6PgiQZMLtUK7SBoyyIcLG9IAUddCxyqosX8_tznIkvmO96XMp90QaOzlhMSGLTR8AArjj4OcRGgmVE0dj0tDIyLvGjjdLM1IlyNaA--wcuImwen9tP6C50cDponp7favwxI6kU9iShzPRqyvqgMcvrN260PkS8WyAaTDssP6S0hX3ChjitBXmfSxbMBjmAQJ2vKIEPRCQyAthEB1mRYF6zlgQX8776kG9Fv-XuUgEzUyCOePC5oBvOnkVBoYqC1MbSLn1-ZzuBnTY2-deytdkTdMhbp54NUdYwJA20bEM16jnXJsJlRQrWLMA_9SmwrcDx1ilShm3BhS5NnhvVT7FFtnX8IrRspfmh45jkajqTCeNtil4a3lVMh6kiAKSxQ02O9O940KpQ8vpY8bveZQVXun9-OH8ZAQZYeQOCHKZx5gbM-mEn9EO0eDHHzaH6hGi3z44fGiTPmCYiZbbwWSD-4r9ArnxRO5D4wHFT_GRFbWxO3O4NERdpZDnHIBgIsD0DtxGlgG1qVer_gnSji4WC1P70f6pqtBt8TdbZNfueLiA6qT4BpJSPVGuFZW_R60xem49n7U=w590-h240-no" alt="워크스페이스를 C:/www로 선택한다." /><br />

퍼스펙티브가 java<sup><a href="#comments">3</a></sup> 인 상태에서 File - New - Java Project 메뉴를 차례로 선택하여 새로운 자바 프로젝트를 namecard란 이름으로 만든다.<br />

<img src="https://lh3.googleusercontent.com/gz6IYM1VWQg-AryU3iLP67krrEaGk1koEVh5eomxiuZpWsTdENLVQclTMSvHzAhfZ_w22W3XwqMPCvhe8ozrYThbAWFxgfprKFarEwTcgKyQVVB2io-wk8hySf-i2jK8XAekuMkgxqkBeh034iAfFf6Pf_esheptOaNYzSW3Mu0UWcaTU24s41wzOb-IIlUzAuP25j5oBXhK7rAVYRo-NMSgdoHeZJe1wMlxUKNMMoJRAuG6snFjzcTvROsDXvn4bFcHuuIUrlQJODcCaPopiMFpvUCY2t-1BAsmnhja5TCRouLk3w28iM_JXikyJ6tp8P0ndLw-yF6sZ97dAmNPfQ0kEnaKu6t3ngXrbvR8v9fZ88ddjrUEhcsNUWcXVaJ0cfmbprZxL2A__5fmm7mFdhW54MgqLkLfzGFTDaWlr5fe6r3YDnW_ewgUZDChoG6TmVZbcNzKohm2blW-JT9-lF6U5go27XrU_qgr4eDB7Dxq3BRQnw71rg9zDfe62d7qRgAgGdes0-jdh6ot4FUhfkxMUZ2kiKszKBSeWGdqsJHkPI-XS6w0caLJm52rUUdyMgnjldzGlhn_k__GNw8x3KCsxHg47W8=w685-h240-no" alt="Java 퍼스펙티브가 선택된 상태에서 Java Project 를 만든다." /><br />

우리는 순수 자바 애플리케이션 아닌 웹 애플리케이션을 작성하고 있으므로 이클립스가 디폴트로 셋팅해준 src와 bin를 그대로 사용해서는 안된다.<br />
프로젝트에 마우스를 선택한 상태에서 마우스 오른쪽 버튼을 클릭한다.<br />
Build Path - Configure Build Path..를 선택한다.<br />
Source탭에서 Source folder 는 WEB-INF/src 를 선택한다.<br />
Default output folder 는 WEB-INF/classes 를 선택해야 한다.<br />

<img src="https://lh3.googleusercontent.com/hdOeSeR3J580eLgxeKl8xBocFLITj7wlHehSMF0FXnGuHmFObh1ncA50xxnWOtacTnXHHLYtJiDA5nPoXAuQKNkcEU0Sht53dTU_P_l-ZRcrQlZfEhXLRnRMXKSKA3Nq1QmtuEgMZgSnmRUa5np3rIImB0hFIBokg14g4KLUrYlUs8iGIYoqamDqtGbuoXoL40L9AbiWoXv6BCOdwEyUezv6BywgzjRwxIFAx0Nw0qv9mHaLpQx1qGeMPPU_gsn2jA-aiH3ABXOeyVsUWUbJRpigX3wZLWTCc0-UcM4z6aPCG4-gOc2FV20ECFf_BSjyGFEQTDWTafDd9meU27-nlzATDFLRdv2UcOYtlUK0WQaOay_tM1a19FBpzexA7FmqQt6OhsCfkx4YNAyvZYYvf9GZh3Kg9NclPmtTyfDSdVUxTMnFkCmimXoxLUP1WM0gP05kgJsD9lQ9GTgpD9ua2ekXYgZygywH64w1wTMZ1RtHu69kL2QGdK-e8Dv2DVZ3-5ErXgpCE8zXGGQyzqZUAejQZZhpkd-QDWZ7L9fjEh6ePl0_nvmJBXZICbmMX9ARM9sJyCWqSYIM9y6rJqa-VQCpnvm0b1g=w675-h534-no" alt="명함관리 웹 APP 이클립스 소스 폴더와 Output 폴더 설정" /><br />

이제 이클립스에서 소스를 수정하면 따로 컴파일하지 않아도 바이트 코드가 WEB-INF/classes에 생길 것이다.<br />
http://localhost:8989/namecard/list.jsp를 방문하여 테스트한다.<br />
테스트가 성공했다면 명함을 등록하는 JSP파일을 C:/www/namecard 에 만든다.<br />
먼저 이클립스의 JSP 템플릿의 캐릭터셋을 EUC-KR 에서 UTF-8로 변경한다.<br />
이클립스에서 Windows - Preferences - Web - JSP Files 선택하고 인코딩 박스에서 UTF-8를 선택하고 Apply 클릭한다.<br />

<img src="https://lh3.googleusercontent.com/dBM6wFehnOmep_aL4pISPNUBW5OgFZ_gGRkBRJtuDIs4qteLYLoPxuCt8n5F9J2zIqUgzvzhVZ2n9OcP48k1VI2ijYe9PpPIY_K8dWgDWXXLhTpYFZ7GKGzuRIfBrc7x8u6d-hRoVLN14Y4T85gRsdycFliLY7O-yR1i7bMECsdrLYhZRUZ1aNIKFxFsH5z4o9Pbx3vH_pgOgvZyDPxsud3x7b7DicRdYzxko-ZP8B6MG3oFGp0W9N4WaUwx6zv3iPz07HRFgcowhwnT5areu1AG4OSMrf5-6rQ12jGUr8eNLSHTvYTaGnAzj2PJREzHZMEbUolkuh4jR2x--IYRwQUquHEkbxgGVIFc9eNo7SPTHLBX4SUdzIBreXpZD6omt74-o2tJYA3SV-3PzTiFj8i6mLoSzcjyDOsJI-Uv2lZZwCGN2KFKXsqSoZcOj_us32bVgPuAfw6x-rfNd3hdxWvWVfk2Na_NXtMgCWIqLpJHC9hxTu-qecCMWZKENT6ovL4wf4zrmdhsg86jTRQDwjvLYJGfJu9ZWIl9Xt66axA8GBWLWJksrI1fqhyb1rJzttSbaCvF3qRc2WaFBlfP_Is6EYmIVds=w625-h535-no" alt="JSP 파일인코딩 UTF-8로 " /><br />

아래 write.jsp 소스에서 강조된 부분이 여러분이 직접 입력해야 하는 부분이다.<br />
 
<em class="filename">/write.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>명함 추가</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>&lt;h1&gt;명함 추가하기&lt;/h1&gt;
&lt;form action="write_proc.jsp" method="post"&gt;
이름 : &lt;input type="text" name="name" /&gt;&lt;br /&gt;
손전화 : &lt;input type="text" name="mobile" /&gt;&lt;br /&gt;
이메일 : &lt;input type="text" name="email" /&gt;&lt;br /&gt;
회사 : &lt;input type="text" name="company" /&gt;&lt;br /&gt;
&lt;input type="submit" value="확인" /&gt;
&lt;input type="button" value="취소" onclick="location.href='list.jsp'" /&gt;
&lt;/form&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

다음은 write_proc.jsp 파일을 만든다.<br />
이 페이지는 write.jsp 에서 전송받은 값으로 명함을 추가한다.<br />
아래 소스에서 강조된 부분이 여러분이 직접 입력해야 하는 부분이다.<br />

<em class="filename">/write_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String company = request.getParameter("company");
Namecard namecard = new Namecard(name,mobile,email,company);
NamecardDao dao = new NamecardDao();
dao.insert(namecard);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>명함 추가</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>명함이 추가되었습니다.&lt;a href="list.jsp"&gt;목록&lt;/a&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

http://localhost:8989/namecard/list.jsp를 방문한다.<br />
명함목록에서 등록버튼을 클릭하여 새로운 명함 등록을 추가하는 테스트를 한다.<br />
다음은 삭제기능을 구현한다.<br />
먼저 list.jsp 에서 아래를 참조해서 테이블의 열를 추가한다.<br />

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
.. 중간 생략 ..

    &lt;td&gt;번호&lt;/td&gt;
    &lt;td&gt;이름&lt;/td&gt;
    &lt;td&gt;손전화&lt;/td&gt;
    &lt;td&gt;이메일&lt;/td&gt;
    &lt;td&gt;회사&lt;/td&gt;
    <span class="emphasis">&lt;td&gt;관리&lt;/td&gt;</span>

.. 중간 생략 ..

    &lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getCompany() %&gt;&lt;/td&gt;
    <span class="emphasis">&lt;td&gt;&lt;a href="delete.jsp?no=&lt;%=card.getNo() %&gt;"&gt;삭제&lt;/a&gt;&lt;/td&gt;</span>

.. 중간 생략 ..	
</pre>

다음은 delete.jsp 작성한다.<br />
delete.jsp 는 list.jsp에서 명함의 Primary key 에 해당하는 값을 전달받아 삭제를 수행한다.<br />
아래 소스에서 강조된 부분이 직접 입력해야 하는 부분이다.<br />

<em class="filename">/delete.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
int no = Integer.parseInt(request.getParameter("no"));
NamecardDao dao = new NamecardDao();
dao.delete(no);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>명함 삭제</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>명함이 삭제되었습니다.&lt;a href="list.jsp"&gt;목록&lt;/a&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

http://localhost:8989/namecard/list.jsp를 방문한다.<br />
명함을 삭제하는 테스트를 수행한다.<br />
다음으로 수정기능 구현한다.<br />
NamecardDao.java 에 수정을 담당하는 메소드는 아래와 같다.<br />

<em class="filename">NamecardDao.java</em>
<pre class="prettyprint">
public void update(Namecard card) {
	String sql = "UPDATE namecard " +
			"SET name = ? " +
			",mobile = ? " +
			",email = ? " +
			",company = ? " +
			"WHERE no = ?";
			
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, card.getName());
		pstmt.setString(2, card.getMobile());
		pstmt.setString(3, card.getEmail());
		pstmt.setString(4, card.getCompany());
		pstmt.setInt(5, card.getNo());
		pstmt.executeUpdate();
		
.. 중간 생략 ..
</pre>

list.jsp 파일에서 수정양식을 보여주는 페이지로 이동하는 링크를 삭제링크 옆에 작성한다.<br />
아래를 참고한다.<br />

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;td&gt;
	&lt;a href="delete.jsp?no=&lt;%=card.getNo() %&gt;"&gt;삭제&lt;/a&gt;
	<strong>&lt;a href="modify.jsp?no=&lt;%=card.getNo() %&gt;"&gt;수정&lt;/a&gt;</strong>
&lt;/td&gt;
</pre>

다음은 modify.jsp 파일을 작성한다.<br />
참고로 modify.jsp 는 사용자 UI 통일성을 주기 위해서 wirte.jsp 소스를 copy &amp; paste 한후
약간의 추가 작업을 하여 만들었다.<br />

<em class="filename">/modify.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
int no = Integer.parseInt(request.getParameter("no"));
NamecardDao dao = new NamecardDao();
Namecard card = dao.selectOne(no);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>명함 수정</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>&lt;h1&gt;명함 수정하기&lt;/h1&gt;
&lt;form action="modify_proc.jsp" method="post"&gt;
<span class="emphasis">&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;</span>
이름 : &lt;input type="text" name="name" value="&lt;%=card.getName() %&gt;" /&gt;&lt;br /&gt;
손전화 : &lt;input type="text" name="mobile" value="&lt;%=card.getMobile() %&gt;" /&gt;&lt;br /&gt;
이메일 : &lt;input type="text" name="email" value="&lt;%=card.getEmail() %&gt;" /&gt;&lt;br /&gt;
이메일 : &lt;input type="text" name="company" value="&lt;%=card.getCompany() %&gt;" /&gt;&lt;br /&gt;
&lt;input type="submit" value="확인" /&gt;
&lt;input type="button" value="취소" onclick="location.href='list.jsp'" /&gt;
&lt;/form&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

<span class="emphasis">&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;</span>
이 부분이 폼태그에 반드시 있어야 한다.<br />
다음은 modify_proc.jsp 파일을 작성한다.<br />
이 페이지는 modify.jsp에서 전송된 값으로 명함을 수정하는 페이지이다.<br />

<em class="filename">modify_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
<strong>&lt;%@ page import="net.java_school.namecard.*" %&gt;</strong>
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
<strong>&lt;%
request.setCharacterEncoding("UTF-8");
int no = Integer.parseInt(request.getParameter("no"));
String name = request.getParameter("name");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String company = request.getParameter("company");
Namecard card = new Namecard();
card.setNo(no);
card.setName(name);
card.setMobile(mobile);
card.setEmail(email);
card.setCompany(company);
NamecardDao dao = new NamecardDao();
dao.update(card);
%&gt;</strong>
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;<strong>명함 수정</strong>&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
<strong>명함이 수정되었습니다. &lt;a href="list.jsp"&gt;목록&lt;/a&gt;</strong>
&lt;/body&gt;
&lt;/html&gt;
</pre>

http://localhost:8989/namecard/list.jsp를 방문하여 수정을 테스트한다.<br /><br />
다음으로 list.jsp 에 검색기능을 추가한다.<br />
list.jsp 열고 &lt;/body&gt; 전에 다음 폼을 추가한다.<br />

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" name="keyword" /&gt;
	&lt;input type="submit" value="검색" /&gt;
&lt;/form&gt;
</pre>

검색을 위해서 NamecardDao.java 에 selectByKeyword(String keyword) 메소드를 추가한다.<br />

<em class="filename">NamecardDao.java</em>
<pre class="prettyprint">
public ArrayList&lt;Namecard&gt; selectByKeyword(String keyword) {
	keyword = "%" + keyword + "%";
	ArrayList&lt;Namecard&gt; matched = new ArrayList&lt;Namecard&gt;();
		
	String sql ="SELECT no,name,mobile,email,company " + 
				"FROM namecard " +
			"WHERE name LIKE ? " +
				"OR mobile LIKE ? " +
				"OR email LIKE ? " + 
				"OR company LIKE ? " +
			"ORDER BY no DESC";
			
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, keyword);
		pstmt.setString(2, keyword);
		pstmt.setString(3, keyword);
		pstmt.setString(4, keyword);
		rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int no = rs.getInt("no");
			String sname = rs.getString("name");
			String mobile = rs.getString("mobile");
			String email = rs.getString("email");
			String company = rs.getString("company");
			Namecard namecard = new Namecard(no,name,mobile,email,company);
			matched.add(namecard);
		}
	} catch (SQLException e) {
		e.printStackTrace();
		System.out.println(sql);
	} finally {
		close(rs,pstmt,con);
	}
	
	return matched;
}
</pre>

검색을 테스트하기 위해 list.jsp 을 방문하면 null로 검색이 되는 버그가 있다.<br />
list.jsp 를 웹브라우저의 주소창에서 처음 방문할 때는 keyword 가 null 이 되기 때문이다.<br />
그리고 list.jsp 파일에서 검색필드에 아무런 값도 넣지 않고 검색 버튼을 클릭했다면 keyword 는 ""(공백문자)이다.<br />
list.jsp 을 열고 아래 코드를 참고하여 수정한다.<br />

<em class="filename">/list.jsp</em>
<pre class="prettyprint">
&lt;%
//기존 코드는 주석처리한다.
//NamecardDao dao = new NamecardDao();
//ArrayList&lt;Namecard&gt; list = dao.selectAll();

request.setCharacterEncoding("UTF-8");
String keyword = request.getParameter("keyword");

NamecardDao dao = new NamecardDao();
ArrayList&lt;Namecard&gt; list = null;

if (keyword == null) {
	keyword = "";
}
if (keyword.equals("")) {
	list = dao.selectAll();
} else {
	list = dao.selectByKeyword(keyword);
}
%&gt;
</pre>

모두 작성했다면 
http://localhost:8989/namecard/list.jsp를 방문하여 테스트한다.<br />

<span id="comments">주석</span>
<ol>
	<li>각각의 웹 애플리케이션의 WEB-INF/lib 에 JDBC 드라이버 파일을 두면 메모리 누수문제가 일어날 수 있다.</li>
	<li>만약 NamecardDao 클래스가 커넥션 풀을 이용한다면 커넥션풀관련 클래스를 앞서 컴파일 해야한다.</li>
	<li>이와는 달리 대부분이 책에서 퍼스펙티브가 Java EE 에서 Dynamic Web Project 로 프로젝트를 생성하는 방법을 설명한다.
	본 사이트에서 제공하는 기초 과정을 모두 공부한 다음이 아니고, 이클립스보다 서블릿/JSP에 초점을 맞추려면 본 사이트에서 제시한 방법이 더 낫다.</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://stackoverflow.com/questions/6981564/why-jdbc-driver-must-been-put-in-tomcat-home-lib-folder">http://stackoverflow.com/questions/6981564/why-jdbc-driver-must-been-put-in-tomcat-home-lib-folder</a></li>
</ul>
