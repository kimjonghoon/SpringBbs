<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2012.6.20</div>
			
<h1>명함관리</h1>

JDBC 에서 실습했던 <a href="../jdbc/namecard.php">명함관리</a>를 웹 애플리케이션으로 변경한다.<br />
여러분의 웹 애플리케이션의 최상위 디렉토리에 namecard 란 서브 디렉토리를 생성한다.<br />
앞으로 작성할 JSP파일은 namecard 디렉토리에서 작성할 것이다.<br /> 
오라클 JDBC 드라이버 파일(ojdbc14.jar)를 TOMCAT_HOME/lib 복사한다.<br />
Namecard.java 와 NamecardManager.java 를 웹 애플리케이션에 추가한다.<br />  
namecard 에 list.jsp 를 만든다.<br />
이 페이지는 명함 목록을 보여주어야 한다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;    
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	NamecardManager mgr=new NamecardManager();
	ArrayList&lt;Namecard&gt; list = mgr.getCards();
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
		&lt;td&gt;만난날&lt;/td&gt;
	&lt;/tr&gt;
&lt;%
int size = list.size();
for(int i=0;i &lt; size;i++) {
	Namecard card = list.get(i);
%&gt;	
	&lt;tr&gt;
		&lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
		&lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
		&lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
		&lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
		&lt;td&gt;&lt;%=card.getMdate() %&gt;&lt;/td&gt;
	&lt;/tr&gt;
&lt;%
}
%&gt;	
&lt;/table&gt;
&lt;p&gt;
&lt;input type="button" value="추가" onclick="location.href='write_form.jsp'" /&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
다음은 write_form.jsp 파일을 생성한다.<br />
이 페이지는 명함을 추가하기 위해 사용자로부터 입력을 받는 페이지이다.<br />
사용자가 입력한 후 확인 버튼을 누르면 파라미터명과 입력값의 쌍이 write.jsp 로 전송되도록 구현한다.<br /> 

<em class="filename">write_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함 추가&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;명함 추가하기&lt;/h1&gt;
&lt;form action="write.jsp" method="post"&gt;
이름 : &lt;input type="text" name="name" /&gt;&lt;br /&gt;
손전화 : &lt;input type="text" name="mobile" /&gt;&lt;br /&gt;
이메일 : &lt;input type="text" name="email" /&gt;&lt;br /&gt;
만난날 : &lt;input type="text" name="mdate" /&gt;(2000/01/01 형식으로 입력)&lt;br /&gt;
&lt;input type="submit" value="확인" /&gt;
&lt;input type="button" value="취소" onclick="location.href='list.jsp'" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
다음은 write.jsp 파일을 작성한다.<br />
이 페이지는 write_form.jsp 에서 전송받은 값으로 명함을 추가한다.

<em class="filename">write.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;    
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String mobile = request.getParameter("mobile");
	String email = request.getParameter("email");
	String mdate = request.getParameter("mdate");
	Namecard namecard = new Namecard(name,mobile,email,mdate);
	NamecardManager mgr = new NamecardManager();
	mgr.addCard(namecard);
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함 추가&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
명함이 추가되었습니다.&lt;a href="list.jsp"&gt;목록&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
다음은 삭제기능을 구현한다.<br />
먼저 list.jsp 에서 아래를 참조해서 테이블의 열를 추가한다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
.. 중간 생략 ..

    &lt;td&gt;번호&lt;/td&gt;
    &lt;td&gt;이름&lt;/td&gt;
    &lt;td&gt;손전화&lt;/td&gt;
    &lt;td&gt;이메일&lt;/td&gt;
    &lt;td&gt;만난날&lt;/td&gt;
    <span class="emphasis">&lt;td&gt;관리&lt;/td&gt;</span>

.. 중간 생략 ..

    &lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
    &lt;td&gt;&lt;%=card.getMdate() %&gt;&lt;/td&gt;
    <span class="emphasis">&lt;td&gt;&lt;a href="delete.jsp?no=&lt;%=card.getNo() %&gt;"&gt;삭제&lt;/a&gt;&lt;/td&gt;</span>

.. 중간 생략 ..	
</pre>
다음은 delete.jsp 작성한다.<br />
delete.jsp 는 list.jsp에서 명함의 Primary key 에 해당하는 값을 전달받아 삭제를 수행한다.<br />

<em class="filename">delete.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	int no = Integer.parseInt(request.getParameter("no"));
	NamecardManager mgr = new NamecardManager();
	mgr.deleteCard(no);
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함 삭제&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
명함이 삭제되었습니다.&lt;a href="list.jsp"&gt;목록&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
다음으로 수정기능 구현한다.<br />
먼저 NamecardManager.java 에 수정하는 메소드를 추가해야 한다.<br />

<em class="filename">NamecardManager.java</em>
<pre class="prettyprint">
public void updateCard(Namecard card) {
	String sql = "UPDATE namecards " +
			"SET name = ? " +
			",mobile = ? " +
			",email = ? " +
			",mdate = ? " +
			"WHERE no = ?";
	Connection con = null;
	PreparedStatement pstmt = null;
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, card.getName());
		pstmt.setString(2, card.getMobile());
		pstmt.setString(3, card.getEmail());
		pstmt.setString(4, card.getMdate());
		pstmt.setInt(5, card.getNo());
		pstmt.executeUpdate();
		
.. 중간 생략 ..
</pre>
list.jsp 파일에서 수정양식을 보여주는 페이지로 이동하는 링크를 삭제링크 옆에 작성한다.<br />
아래를 참고한다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
&lt;td&gt;
	&lt;a href="modify_form.jsp?no=&lt;%=card.getNo() %&gt;"&gt;수정&lt;/a&gt;
	&lt;a href="delete.jsp?no=&lt;%=card.getNo() %&gt;"&gt;삭제&lt;/a&gt;
&lt;/td&gt;
</pre>
다음은 modify_form.jsp 파일을 작성한다.<br />
사용자 UI 통일을 위해 wirte_form.jsp 를 copy &amp; paste 하여 만든 후 아래와 같이 수정한다.<br />

<em class="filename">modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	int no = Integer.parseInt(request.getParameter("no"));
	NamecardManager mgr = new NamecardManager();
	Namecard card = mgr.getCard(no);
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함 수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;명함 수정하기&lt;/h1&gt;
&lt;form action="modify.jsp" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
이름 : &lt;input type="text" name="name" value="&lt;%=card.getName() %&gt;" /&gt;&lt;br /&gt;
손전화 : &lt;input type="text" name="mobile" value="&lt;%=card.getMobile() %&gt;" /&gt;&lt;br /&gt;
이메일 : &lt;input type="text" name="email" value="&lt;%=card.getEmail() %&gt;" /&gt;&lt;br /&gt;
이메일 : &lt;input type="text" name="mdate" value="&lt;%=card.getMdate() %&gt;" /&gt;(2000/01/01 형식으로 입력)&lt;br /&gt;
&lt;input type="submit" value="확인" /&gt;
&lt;input type="button" value="취소" onclick="location.href='list.jsp'" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
<em>&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;</em> 이 부분이 폼태그에 반드시 있어야 한다.<br />
다음은 modify.jsp 파일을 작성한다.<br />
이 페이지는 modify_form.jsp에서 전송된 값으로 명함을 수정하는 페이지이다.<br />

<em class="filename">modify.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.namecard.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String name = request.getParameter("name");
	String mobile = request.getParameter("mobile");
	String email = request.getParameter("email");
	String mdate = request.getParameter("mdate");
	Namecard card = new Namecard();
	card.setNo(no);
	card.setName(name);
	card.setMobile(mobile);
	card.setEmail(email);
	card.setMdate(mdate);
	NamecardManager mgr = new NamecardManager();
	mgr.updateCard(namecard);
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함 수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
명함이 수정되었습니다. &lt;a href="list.jsp"&gt;목록&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
다음으로 list.jsp 에 검색기능을 추가한다.<br />
list.jsp &lt;/body&gt; 전에 다음 폼을 추가한다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" name="search" /&gt;
	&lt;input type="submit" value="검색" /&gt;
&lt;/form&gt;
</pre>
검색을 위해서는 NamecardManager.java 의 
findCard(String name) 메소드를 아래와 같이 변경한다.<br />

<em class="filename">NamecardManager.java</em>
<pre class="prettyprint">
public ArrayList&lt;Namecard&gt; findCard(String search) {
	String searchWord = "%" + search + "%";
	ArrayList&lt;Namecard&gt; matchingCard = 
		new ArrayList&lt;Namecard&gt;();
	String sql ="select no,name,mobile,email,to_char(mdate,'YYYY/MM/DD') mdate from namecards " +
			" where name like ? " +
			" or mobile like ? " +
			" or email like ?";
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, searchWord);
		pstmt.setString(2, searchWord);
		pstmt.setString(3, searchWord);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int no = rs.getInt("no");
			String sname = rs.getString("name");
			String mobile = rs.getString("mobile");
			String email = rs.getString("email");
			String mdate = rs.getString("mdate");
			Namecard namecard = new Namecard(no,sname,company,mobile,email,mdate);
			matchingCard.add(namecard);
		}
	} catch (SQLException e) {
		e.printStackTrace();
		System.out.println(sql);
	} finally {
		close(rs,pstmt,con);
	}
	return matchingCard;
}
</pre>
list.jsp 파일을 수정한다.<br />
list.jsp 를 웹브라우저의 주소창에서 처음 방문할 때는 search 가 null 이다.<br />
그런데 list.jsp 파일에서 검색필드에 아무런 값도 넣지 않고 검색 버튼을 클릭했다면 search가 ""(공백문자)이다.<br />

<em class="filename">list.jsp</em>
<pre class="prettyprint">
request.setCharacterEncoding("UTF-8");
String search = request.getParameter("search");

NamecardManager mgr=new NamecardManager();
ArrayList&lt;Namecard&gt; list = null;

if (search == null) {
	search = "";
}
if (search.equals("")) {
	list = mgr.getCards();
} else {
	list = mgr.findCard(search);
}
</pre>
