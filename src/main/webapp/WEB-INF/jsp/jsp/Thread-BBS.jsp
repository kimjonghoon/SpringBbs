<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.7.15</div>
			
<h1>계층형 게시판</h1>

<strong>오라클은 다른 DBMS와 달리 계층형 쿼리를 지원한다.<br />
계층형 쿼리를 이용하면 간단하게 계층형 게시판을 구현할 수 있을 것이다.<br />
먼저 오라클뿐 아니라 어떤 DBMS 에서도 통용되는 방법에 대해서 알아본다.<br />
끝부분에 오라클의 계층형 쿼리를 이용하는 방법을 알아본다.</strong><br />
<br />
계층형 게시판이란 원글이 있고 그에 대한 답변글이 계층적으로 보이는 게시판을 말한다.<br />
여기서 원글이란 <strong>새글쓰기</strong>를 통해 등록된 글로 아래 예에서는 <em>질문1, 질문2, 질문3, 질문4</em>가 원글이다.<br />
반면, 답변글은 <strong>답변쓰기</strong>를 통해서 작성된 글을 의미한다.

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">번호(no)</th>
	<th class="table-in-article-th">제목</th>
	<th class="table-in-article-th">작성자</th>
	<th class="table-in-article-th">작성일</th>
</tr>
<tr>
	<td class="table-in-article-td">29</td>
	<td class="table-in-article-td"><em>질문4</em></td>
	<td class="table-in-article-td">홍길동</td>
	<td class="table-in-article-td">2007/12/09</td>
</tr>
<tr>
	<td class="table-in-article-td">27</td>
	<td class="table-in-article-td"><em>질문3</em></td>
	<td class="table-in-article-td">홍길동</td>
	<td class="table-in-article-td">2007/11/27</td>
</tr>
<tr>
	<td class="table-in-article-td">32</td>
	<td class="table-in-article-td"><span style="padding-left: 14px;">ㄴ 질문3의 답변</span></td>
	<td class="table-in-article-td">장길산</td>
	<td class="table-in-article-td">2007/12/22</td>
</tr>
<tr>
	<td class="table-in-article-td">26</td>
	<td class="table-in-article-td"><em>질문2</em></td>
	<td class="table-in-article-td">임꺽정</td>
	<td class="table-in-article-td">2007/11/25</td>
</tr>
<tr>
	<td class="table-in-article-td">30</td>
	<td class="table-in-article-td"><span style="padding-left: 14px;">ㄴ 질문2의 답변(두번째)</span></td>
	<td class="table-in-article-td">홍길동</td>
	<td class="table-in-article-td">2007/12/20</td>
</tr>
<tr>
	<td class="table-in-article-td">31</td>
	<td class="table-in-article-td"><span style="padding-left: 28px;">ㄴ 답변에 대한 질문</span></td>
	<td class="table-in-article-td">임꺽정</td>
	<td class="table-in-article-td">2007/12/21</td>
</tr>
<tr>
	<td class="table-in-article-td">33</td>
	<td class="table-in-article-td"><span style="padding-left: 42px;">ㄴ 답변</span></td>
	<td class="table-in-article-td">장길산</td>
	<td class="table-in-article-td">2007/12/23</td>
</tr>
<tr>
	<td class="table-in-article-td">28</td>
	<td class="table-in-article-td"><span style="padding-left: 14px;">ㄴ 질문2의 답변(첫번째)</span></td>
	<td class="table-in-article-td">장길산</td>
	<td class="table-in-article-td">2007/12/01</td>
</tr>
<tr>
	<td class="table-in-article-td">25</td>
	<td class="table-in-article-td"><em>질문1</em></td>
	<td class="table-in-article-td">허균</td>
	<td class="table-in-article-td">2007/11/20</td>
</tr>
</table>

여기서 <strong>번호</strong>는 게시글의 고유번호로 board 테이블의 no 컬럼이다.<br />


<h2>계층형 게시판을 위해 추가할 필드</h2>

계층형 게시판을 구현하기 위해서 각 게시글은 아래와 같은 정보를 가지고 있어야 한다.<br />

<ol>
	<li>게시글은 어떤 그룹에 속해있는지에 대한 정보를 가지고 있어야 한다.</li>
	<li>게시글은 가장 상위의 원글로부터 아래로의 순서가 어떠한지에 대한 정보를 가지고 있어야 한다.</li>
	<li>게시글은 계층적으로 보이도록 얼마나 들여써야 하는지에 대한 정보를 가지고 있어야 한다.</li>
</ol>

1를 위해서 새로운 컬럼 family 를 추가한다.<br />
2를 위해서 새로운 컬럼 depth 를 추가한다.<br />
3를 위해서 새로운 컬럼 indent 를 추가한다.<br />
 
<table class="table-in-article">
<tr>
	<th class="table-in-article-th">컬럼명</th>
	<th class="table-in-article-th">데이터 타입</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">family</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">그룹번호</td>
</tr>
<tr>
	<td class="table-in-article-td">depth</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">맨위 원글로부터 순서</td>
</tr>
<tr>
	<td class="table-in-article-td">indent</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">들여쓰기 수준</td>
</tr>
</table>

이것으로 충분한 것처럼 보인다.<br />
답변이 있는 글을 삭제할 때를 생각해 보자.<br />
30번 글을 삭제할려고 할때 31번 글은 어떻게 하면 좋을까?<br />
만일 30번 글이 삭제되었는데 31번 글이 삭제가 되지 않는다면 사용자는 게시판의 버그라고 생각할 수 있다.<br />
31번 글도 같이 삭제가 되어야 한다면 family, depthy, indent 만 가지고서는 답이 나오지 않는다.<br />
따라서 부모글이 무엇인지에 대한 정보를 저장하는 컬럼이 추가적으로 필요하다.<br />
이 컬럼명을 parent 라고 하겠다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">번호(no)</th>
	<th class="table-in-article-th">부모글<br />(parent)</th>
	<th class="table-in-article-th">제목</th>
	<th class="table-in-article-th">작성자</th>
	<th class="table-in-article-th">작성일</th>
</tr>
<tr>
	<td class="table-in-article-td">29</td>
	<td class="table-in-article-td">29</td>
	<td class="table-in-article-td">질문4</td>
	<td class="table-in-article-td">홍길동</td>
	<td class="table-in-article-td">2007/12/09</td>
</tr>
<tr>
	<td class="table-in-article-td">27</td>
	<td class="table-in-article-td">27</td>
	<td class="table-in-article-td">질문3</td>
	<td class="table-in-article-td">홍길동</td>
	<td class="table-in-article-td">2007/11/27</td>
</tr>
<tr>
	<td class="table-in-article-td">32</td>
	<td class="table-in-article-td">27</td>	
	<td class="table-in-article-td">&nbsp;&nbsp;ㄴ 질문3의 답변</td>
	<td class="table-in-article-td">장길산</td>
	<td class="table-in-article-td">2007/12/22</td>
</tr>
<tr>
	<td class="table-in-article-td">26</td>
	<td class="table-in-article-td">26</td>
	<td class="table-in-article-td">질문2</td>
	<td class="table-in-article-td">임꺽정</td>
	<td class="table-in-article-td">2007/11/25</td>
</tr>
<tr style="background: #999;font-weight: bold;">
	<td class="table-in-article-td">30</td>
	<td class="table-in-article-td">26</td>
	<td class="table-in-article-td">&nbsp;&nbsp;ㄴ 질문2의 답변(두번째)</td>
	<td class="table-in-article-td">홍길동</td>
	<td class="table-in-article-td">2007/12/20</td>
</tr>
<tr style="background: #999;font-weight: bold;">
	<td class="table-in-article-td">31</td>
	<td class="table-in-article-td">30</td>
	<td class="table-in-article-td">&nbsp;&nbsp;&nbsp;&nbsp;ㄴ 답변에 대한 질문</td>
	<td class="table-in-article-td">임꺽정</td>
	<td class="table-in-article-td">2007/12/21</td>
</tr>
<tr style="background: #999;font-weight: bold;">
	<td class="table-in-article-td">33</td>
	<td class="table-in-article-td">31</td>
	<td class="table-in-article-td">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴ 답변</td>
	<td class="table-in-article-td">장길산</td>
	<td class="table-in-article-td">2007/12/23</td>
</tr>
<tr>
	<td class="table-in-article-td">28</td>
	<td class="table-in-article-td">26</td>
	<td class="table-in-article-td">&nbsp;&nbsp;ㄴ 질문2의 답변(첫번째)</td>
	<td class="table-in-article-td">장길산</td>
	<td class="table-in-article-td">2007/12/01</td>
</tr>
<tr>
	<td class="table-in-article-td">25</td>
	<td class="table-in-article-td">25</td>
	<td class="table-in-article-td">질문1</td>
	<td class="table-in-article-td">허균</td>
	<td class="table-in-article-td">2007/11/20</td>
</tr>
</table>

위와 같이 부모글에 대한 정보를 parent 필드가 가지고 있다면<br />
30번 글을 삭제할 때 30 글이 부모글인 게시글인 31번 글을 삭제하고, 이어서  31번 글이 
부모글인 33번 글을 삭제하는 식으로 삭제를 하면 답변글이 있는 글에 대한 삭제가 
가능하게 된다.<br />
게시판의 정책이 답변글이 있는 게시글에 대해서는 삭제를 하지 못하는 것이라도 마찬가지이다.<br />
삭제하고자 하는 게시글이 부모인 글이 있다면 삭제를 하지 못하도록 하면 된다.<br />
결론적으로 계층형 게시판을 위해서 추가되어야 하는 필드는 아래와 같다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">컬럼명</th>
	<th class="table-in-article-th">데이터 타입</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">family</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">그룹번호</td>
</tr>
<tr style="font-weight: bold;">
	<td class="table-in-article-td">parent</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">부모글</td>
</tr>
<tr>
	<td class="table-in-article-td">depth</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">맨위 원글로부터 순서</td>
</tr>
<tr>
	<td class="table-in-article-td">indent</td>
	<td class="table-in-article-td">number</td>
	<td class="table-in-article-td">들여쓰기 수준</td>
</tr>
</table>

<h2>계층형 게시판 알고리즘</h2>

<h3>새글쓰기</h3>
원글을 입력할때는 해당 필드에 아래와 같이 추가되도록 한다.

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">Field</th>
	<th class="table-in-article-th">Value</th>
</tr>
<tr>
	<td class="table-in-article-td">family</td>
	<td class="table-in-article-td">시퀀스로 결정되는 고유번호(no)와 같게</td>
</tr>
<tr>
	<td class="table-in-article-td">parent</td>
	<td class="table-in-article-td">0</td>
</tr> 
<tr>
	<td class="table-in-article-td">depth</td>
	<td class="table-in-article-td">0</td>
</tr>
<tr>
	<td class="table-in-article-td">indent</td>
	<td class="table-in-article-td">0</td>
</tr>
</table>

<h3>답변글 쓰기</h3>
아래와 같은 값으로 인서트한다.
<table class="table-in-article">
<tr>
	<th class="table-in-article-th">Field</th>
	<th class="table-in-article-th">Value</th>
</tr>
<tr>
	<td class="table-in-article-td">family</td>
	<td class="table-in-article-td">원글의 family 와 같게</td>
</tr>
<tr>
	<td class="table-in-article-td">parent</td>
	<td class="table-in-article-td">부모글의 글번호</td>
</tr>
<tr>
	<td class="table-in-article-td">depth</td>
	<td class="table-in-article-td">(부모글의 depth) + 1</td>
</tr>
<tr>
	<td class="table-in-article-td">indent</td>
	<td class="table-in-article-td">(부모글의 indent ) + 1</td>
</tr>
</table>

<h3>계층형 게시판을 위한 board 테이블 변경</h3>

<pre class="prettyprint">
alter table board 
add (family number, parent number, depth number, indent number)
/

update board set family = no, parent = 0, depth = 0, indent = 0
/
</pre>

<h3>기존 게시판을 계층형 게시판으로 수정하기</h3>
목록부터 작업한다.
list.jsp 를 열고 레코드를 가져오는 쿼리문을 아래와 같이 수정한다.

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT no,family,parent,depth,indent,title,wdate " +
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,family,parent,depth,indent,title,wdate FROM board " + 
		"ORDER BY family DESC, depth ASC) A) " +
		"WHERE R BETWEEN ? AND ?";
} else {
	sql = "SELECT no,family,parent,depth,indent,title,wdate " +
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,family,parent,depth,indent,title,wdate FROM board " +
		"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%' " + 
	    "ORDER BY family DESC, depth ASC) A) " + 
		"WHERE R BETWEEN ? AND ?";
}
</pre>

<pre>
ORDER BY <span class="emphasis">family</span> DESC, <span class="emphasis">depth</span> ASC
</pre>

게시글을 가져오는 쿼리에서 그룹핑과 그룹내 정렬이 되도록 하는 쿼리문이다.<br />
family 필드로 내림차순으로 정렬을 하고 depth 로 오름차순으로 2차 정렬한다.<br />
indent 필드값을 이용해서 들여쓰기를 구현한다.

<pre class="prettyprint">
while (rs.next()) {
	int no = rs.getInt("no");
	String title = rs.getString("title");
	Date wdate = rs.getDate("wdate");
	int indent = rs.getInt("indent");
	for (int i = 0; i &lt; indent; i++) {
		out.println("&amp;nbsp;&amp;nbsp;");
	}
	if(indent != 0) {
		out.println("ㄴ");
	}
	
	//.. 중간 생략 ..

</pre>

위 코드를 보면 indent 만큼 &amp;nbsp;&amp;nbsp; 를 추가하여 들여쓰기를 한 다음 
원글이 아니면(즉, indent != 0 이면) "ㄴ" 를 제목앞에 추가하고 있다.<br />
아직 답변글이 없지만 목록이 정상적으로 출력되어야 한다.<br />
여기까지 수정한다음 목록을 방문하여 테스트한다.<br />
아직까지 답변글이 없기에 기존 목록과 같이 보여야 한다.<br />
<br />
다음으로 새글쓰기 기능을 계층형 게시판에 맞게 수정한다.
BoardWriter.java 서블릿 파일을 열고 아래와 같이 수행 쿼리를 수정한다.

<em class="filename">BoardWriter.java 수정</em>
<pre class="prettyprint">
String sql = "INSERT INTO board (no,title,content,wdate,family,parent,depth,indent) "
	+ "VALUES (board_no_seq.nextval, ?, ?, sysdate, board_no_seq.nextval, 0, 0, 0)";
</pre>

목록을 방문한 후 글쓰기를 클릭하여 새글이 써지는지 확인한다.<br />
<br />
다음으로 view.jsp 파일을 열고 답변쓰기 기능을 추가하기 위해 적절한 위치에 아래 코드를 삽입한다.

<em class="filename">/board/view.jsp 수정</em>
<pre class="prettyprint">
&lt;a href="reply_form.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;답변쓰기&lt;/a&gt;
</pre>

다음으로 사용자에게 답변을 쓰기 위한 양식을 제공하는 JSP 페이지인 reply_form.jsp 을 만든다.<br />
답변쓰기 페이지의 textarea 에 부모글의 내용이 디폴트가 되도록 해야 한다.<br />
이때 부모글과 답변글을 구별할  수 있도록 부모글은 각 행마다 &gt; 를 추가하도록 하겠다.<br />
답변 메시지를 작성후 전송 버튼을 클릭하면 no, family, parent, depth, indent, title, content
파라미터를 BoardReplier 서블릿으로 넘기도록 구현한다.<br />

<em class="filename">/board/reply_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%! static final String LINE_SEPARATOR = System.getProperty("line.separator"); %&gt; 
&lt;%
request.setCharacterEncoding("UTF-8");
Log log = new Log();

int family = 0;
int parent = 0;
int indent = 0;
int depth = 0;

String title = null;
String content = null;
Date wdate = null;

int no = Integer.parseInt(request.getParameter("no"));
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String sql = "SELECT no, family, depth, indent, title, content, wdate " +
        "FROM board " +
        "WHERE no = ?";

try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();

	rs.next();
	no = rs.getInt("no");
	family = rs.getInt("family");
	depth = rs.getInt("depth");
	indent = rs.getInt("indent");
	title = rs.getString("title");
	content = rs.getString("content");

	//부모글을  구별하기 위해 부모글의 각 행마다 &gt;가 추가되도록 한다.
	content = content.replaceAll(LINE_SEPARATOR, LINE_SEPARATOR + "&gt;");
	content = LINE_SEPARATOR + LINE_SEPARATOR +"&gt;" + content;
	wdate = rs.getDate("wdate");
} catch (SQLException e) {
	log.debug("Error Source : board/modify_form.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql );
} finally {
	if (rs != null) {
		try {
			rs.close();
		} catch (SQLException e) {}
	}
	if (stmt != null) {
		try {
			stmt.close();
		} catch (SQLException e) {}
	}
	if (con != null) {
		try {
			con.close();
		} catch (SQLException e) {}
	}
}
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;h1&gt;답변쓰기&lt;/h1&gt;

&lt;form action="../servlet/BoardReplier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
&lt;input type="hidden" name="family" value="&lt;%=family %&gt;" /&gt;
&lt;input type="hidden" name="indent" value="&lt;%=indent %&gt;" /&gt;
&lt;input type="hidden" name="depth" value="&lt;%=depth %&gt;" /&gt;
&lt;input type="hidden" name="page" value="&lt;%=page %&gt;" /&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;" /&gt;
제목 : &lt;input type="text" name="title" size="45" value="&lt;%=title %&gt;" /&gt;&lt;br /&gt;
&lt;textarea name="content" rows="10" cols="60"&gt;&lt;%=content %&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="전송" /&gt;
&lt;input type="reset" value="취소" /&gt;&lt;br /&gt;
&lt;/form&gt;
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;상세보기&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardReplier.java 서블릿 생성</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardReplier extends HttpServlet {
  
	private static final long serialVersionUID = -4670255864421603178L;
	
	OracleConnectionManager dbmgr = null;
	
	//depth 갱신용 쿼리
	String sql1 = "UPDATE board SET depth = depth + 1 " + 
			"WHERE family = ? AND depth &gt; ? ";
	
	//답변쓰기용 쿼리
	String sql2 = "INSERT INTO board " + 
			"(no, family, parent, depth, indent, title, content, wdate) " + 
			"VALUES (board_no_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate)";
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager)sc.getAttribute("dbmgr");
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		Log log = new Log();
		
		// 파라미터를 받는다.
		int parent = Integer.parseInt(req.getParameter("no"));
		int family = Integer.parseInt(req.getParameter("family"));
		int depth = Integer.parseInt(req.getParameter("depth"));
		int indent = Integer.parseInt(req.getParameter("indent"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		String page = req.getParameter("page");
		String keyword = req.getParameter("keyword");
		
		Connection con = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		
		try {
			con = dbmgr.getConnection();
			con.setAutoCommit(false);
			
			stmt1 = con.prepareStatement(sql1);
			stmt1.setInt(1,family);
			stmt1.setInt(2,depth);
			stmt1.executeUpdate();
			
			stmt2 = con.prepareStatement(sql2);
			stmt2.setInt(1, family);
			stmt2.setInt(2, parent);
			stmt2.setInt(3, depth+1);
			stmt2.setInt(4, indent+1);
			stmt2.setString(5, title);
			stmt2.setString(6, content);
			stmt2.executeUpdate();
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			log.debug("Error Source:BoardReplier.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql2);
		} finally {
			if (stmt1 != null) {
				try {
					stmt1.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt2 != null) {
				try {
					stmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			keyword = java.net.URLEncoder.encode(keyword,"UTF-8");
			resp.sendRedirect(path + "/board/list.jsp?page=" + page + "&amp;keyword=" + keyword);
		}

	}
}
</pre>

새로운 서블릿인 BoardReplier 을 만들었으므로 web.xml 파일을 열고 
서블릿의 정의와 매핑설정을 한다.
매핑은 /servlet/BoardReplier 이 되도록 한다.<br />

web.xml파일이 변경되었으니 톰캣을 재실행한다.<br />
목록을 방문한 후 상세보기를 방문하고 답변쓰기를 클릭하여 답변을 작성하는 테스트를 수행한다.<br />

<h2>삭제</h2>
먼저 답변이 있는 글은 삭제가 되지 않도록 구현한다.<br />

<h3>삭제 알고리즘 (답변이 있으면 삭제안됨 )</h3>
<ul>
	<li>파라미터로 넘어온 글의 고유번호(no) 값을 parent 값을 가지는 글이 있는지 검사한다.</li>
	<li>있다면 경고메시지를 보여주고 이전 화면으로 돌아간다.</li>
	<li>없다면 삭제한 후 목록으로 이동한다.</li>
</ul>

<em class="filename">BoardDeleter 서블릿 힌트코드</em>
<pre class="prettyprint">
String sql1 = "SELECT count(*) FROM board WHERE parent = ?";
String sql2 = "DELETE FROM board WHERE no = ?";

boolean check = false;//true 면 삭제,false 면 삭제하지 않음

Connection con = null;
PreparedStatement stmt1 = null;
PreparedStatement stmt2 = null;
ResultSet rs = null;

con = dbmgr.getConnection();
stmt1 = con.prepareStatement(sql1);
stmt1.setInt(1, no);
rs = stmt1.executeQuery();
rs.next();
int num = rs.getInt(1);
if (num == 0) {
	check = true;
}
if (check == true) {
	stmt2 = con.prepareStatement(sql2);
	stmt2.setInt(1, no);
	stmt2.executeUpdate();
}
</pre>

<em class="filename">BoardDeleter 서블릿 수정(전체코드)</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardDeleter extends HttpServlet {

	private static final long serialVersionUID = 664510406708983868L;
	
	private OracleConnectionManager dbmgr;
	
	private static final String SQL1 = "SELECT count(*) FROM board WHERE parent = ?";
	private static final String SQL2 = "DELETE FROM board WHERE no = ?";
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager) sc.getAttribute("dbmgr");
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		Log log = new Log();
		
		int no = Integer.parseInt(req.getParameter("no"));
		String page = req.getParameter("page");
		String keyword = req.getParameter("keyword");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		ResultSet rs = null;
		
		boolean check = false;//true 면 삭제,false 면 삭제하지 않음.
		
		try {
			stmt1 = con.prepareStatement(SQL1);
			stmt1.setInt(1, no);
			rs = stmt1.executeQuery(); //쿼리 실행
			rs.next();
			int num = rs.getInt(1);
			if (num == 0) {
				check = true;
			}
			if (check == true) {
				stmt2 = con.prepareStatement(SQL2);
				stmt2.setInt(1, no);
				stmt2.executeUpdate();
			}
		} catch (SQLException e) {
			log.debug("Error Source : BoardDeleter.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql1 : " + SQL1);
			log.debug("sql2 : " + SQL2);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt1 != null) {
				try {
					stmt1.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt2 != null) {
				try {
					stmt2.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
			log.close();
			String path = req.getContextPath();
			keyword = java.net.URLEncoder.encode(keyword, "UTF-8");
			resp.sendRedirect(path + "/board/list.jsp?page=" + page + "&amp;keyword=" + keyword);
		}
		
	}
	
}
</pre>

<h3>삭제 알고리즘(답변글도 모두 삭제 )</h3>
아래와 같이 게시글이 있다고 가정한다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 100px;">no</th>
	<th class="table-in-article-th">title</th>
</tr>
<tr>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">질문입니다.</td>
</tr>
<tr>
	<td class="table-in-article-td">86</td>
	<td class="table-in-article-td">&nbsp;&nbsp;ㄴ 답변입니다.</td>
</tr>
<tr>
	<td class="table-in-article-td">87</td>
	<td class="table-in-article-td">&nbsp;&nbsp;&nbsp;&nbsp;ㄴ 또다른 질문입니다.</td>
</tr>
<tr>
	<td class="table-in-article-td">88</td>
	<td class="table-in-article-td">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴ 답변입니다.</td>
</tr>
</table>

왼쪽의 번호는 글의 고유번호 no 을 나타낸다.<br />
85번의 글이 원글이다. <br />
원글이면 parent = 0 이고 family 는 no 와 같게 인서트 된다.(즉, family = 85)<br />
86번 글은 85번글에 대한 답변글이다.
그러므로 parent = 85 이고 family = 85 로 저장된다.<br />
87번 글은 86번글에 대한 답변글로 parent = 86 이고 family = 85 이다.<br />
88번 글은 87번글에 대한 답변글로 parent = 87 이고 family = 85 이다.<br />
즉, 아래와 같다.<br />
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 100px;">no</th>
	<th class="table-in-article-th" style="width: 100px;">parent</th>
	<th class="table-in-article-th" style="width: 100px;">family</th>
	<th class="table-in-article-th">title</th>
</tr>
<tr>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">0</td>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">질문입니다.</td>
</tr>
<tr>
	<td class="table-in-article-td">86</td>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">&nbsp;&nbsp;ㄴ 답변입니다.</td>
</tr>
<tr>
	<td class="table-in-article-td">87</td>
	<td class="table-in-article-td">86</td>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">&nbsp;&nbsp;&nbsp;&nbsp;ㄴ 또다른 질문입니다.</td>
</tr>
<tr>
	<td class="table-in-article-td">88</td>
	<td class="table-in-article-td">87</td>
	<td class="table-in-article-td">85</td>
	<td class="table-in-article-td">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ㄴ 답변입니다.</td>
</tr>
</table>

<h3>답변글 삭제 알고리즘</h3>
<ol>
	<li>삭제할 글의 고유번호를 삭제리스트에 추가한다</li>
 	<li>삭제리스트에서 차례로 값을 하나씩 꺼내어 그 값을 parent로 가지고 있는 글을 찾아서 삭제리스트에 추가한다</li>
	<li>삭제리스트에 저장된 글을 삭제한다</li>
</ol>

<em class="filename">답변글 삭제 알고리즘을 수행할 RecursiveDeleter.java</em>
<pre class="prettyprint">
class RecursiveDeleter {
	String sql1 = "SELECT no FROM board WHERE parent = ?";
	String sql2 = "DELETE FROM board WHERE no = ?";
	
	Connection con;
	
	Vector&lt;Integer&gt; v = new Vector&lt;Integer&gt;();//삭제 리스트
	int idx = 1; //삭제리스트에 맨 처음 추가된 것 바로 다음을 재귀호출하도록
	
	public RecursiveDeleter(Connection con) {
		this.con = con;
	}
	
	public void addDeleteList(int no) {
		v.addElement(new Integer(no));
	}
	
	public void getDeleteList(int no) {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = con.prepareStatement(sql1);
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			while (rs.next()) {
				int target = rs.getInt(1);
				v.addElement(new Integer(target));
			}
			if(idx &lt; v.size()) {
				Integer value = (Integer) v.elementAt(idx++);
				getDeleteList(value.intValue());
			}
		} catch (SQLException e) {
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	 
	public void delete() {
		PreparedStatement stmt = null;
		
		try {
			stmt = con.prepareStatement(sql2);
			for(int i = 0; i &lt; v.size(); i++) {
				Integer value = (Integer) v.elementAt(i);
				stmt.setInt(1, value.intValue());
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
		} finally {
			v.removeAllElements();
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				dbmgr.freeConnection(con);
			}
		}
	}
}
</pre>

답변글까지 모두 삭제하기 위해서는 아래와 같이 순서있게 다음 메소드를 호출해야 한다.

<ol>
	<li>addDeleteList(삭제할 게시글의 고유번호);</li>
	<li>getDeleteList(삭제할 게시글의 고유번호);</li>
	<li>delete();</li>
</ol>

86번글을 삭제하려 한다면 addDeleteList() 메소드를 이용해서 우선 86을 삭제리스트에 추가한다.<br />
삭제리스트에 86이라는 값이 저장되면 다음으로 getDeleteList()메소드를 호출한다.<br />
getDeleteList() 메소드는 삭제리스트에서 86을 꺼내어 86을 parent로 가지고 있는 87을 삭제리스트에 추가한다.<br />
다음에 다시 자기 자신을 호출하면서 87을 삭제리스트에서 꺼내어 그 값을 parent 로 가지고 있는 88을 삭제리스트에 추가한다.<br />
다시 자기 자신을 호출하면서 삭제리스트에서 88을 꺼내어 그 값을 parent로 가지고 있는 글을 찾는다.<br />
하지만 88을 parent로 가지고 있는 값이 없으므로 삭제리스트를 완성한다.<br />
이제 delete() 메소드를 이용해서 삭제리스트에 있는 글을 모두 지운다.<br />
<br />
위에서 메소드 내에서 자기 자신을 부르는, 재귀 메소드를 사용했다.<br />
재귀 메소드를 호출할 때 삭제리스트에서 순서대로 차례로 하나씩 값을 꺼내야 한다.
또한 삭제리스트가 완성되면 재귀메소드가 더 이상 호출되지 말아야 한다.<br />
이를 위해서 인덱스idx를 사용했다.<br />
getDeleteList() 재귀메소드를 따라가면서 idx 값이 어떻게 변경되는지 확인한다.<br />

<em class="filename">BoardDeleter 서블릿 (답변글 모두 삭제) 전체코드</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;
import java.net.URLEncoder;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;
import java.util.Vector;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardDeleter extends HttpServlet {
	
	private OracleConnectionManager dbmgr = null;
	
	class RecursiveDeleter {
		String sql1 = "SELECT no FROM board WHERE parent = ?";
		String sql2 = "DELETE FROM board WHERE no = ?";
		
		Connection con;
		
		Vector&lt;Integer&gt; v = new Vector&lt;Integer&gt;();
		int idx = 1; //삭제리스트에 맨 처음 추가된 것 바로 다음을 재귀호출하도록
		
		public RecursiveDeleter(Connection con) {
			this.con = con;
		}

		public void addDeleteList(int no) {
			v.addElement(new Integer(no));
		}
	
		public void getDeleteList(int no) {
			Log log = new Log();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				stmt = con.prepareStatement(sql1);
				stmt.setInt(1, no);
				rs = stmt.executeQuery();
				while (rs.next()) {
					int target = rs.getInt(1);
					v.addElement(new Integer(target));
				}
				if(idx &lt; v.size()) {
					Integer value = (Integer) v.elementAt(idx++);
					getDeleteList(value.intValue());
				}
			} catch (SQLException e) {
				log.debug("Error Source : BoardDeleter.getDeleteList() : SQLException");
				log.debug("SQLState : " + e.getSQLState());
				log.debug("Message : " + e.getMessage());
				log.debug("Oracle Error Code : " + e.getErrorCode());
				log.debug("sql : " + sql1);
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				log.close();
			}
		}
		 
		public void delete() {
			Log log = new Log();
			
			PreparedStatement stmt = null;
			
			try {
				stmt = con.prepareStatement(sql2);
				for(int i = 0; i &lt; v.size(); i++) {
					Integer value = (Integer) v.elementAt(i);
					stmt.setInt(1, value.intValue());
					stmt.executeUpdate();
				}
			} catch (SQLException e) {
				log.debug("Error Source : BoardDeleter.delete() : SQLException");
				log.debug("SQLState : " + e.getSQLState());
				log.debug("Message : " + e.getMessage());
				log.debug("Oracle Error Code : " + e.getErrorCode());
				log.debug("sql : " + sql2);
			} finally {
				v.removeAllElements();
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (con != null) {
					dbmgr.freeConnection(con);
				}
				log.close();
			}
		}
	}
	
	@Override
	public void init() throws ServletException {
		ServletContext sc = getServletContext();
		dbmgr = (OracleConnectionManager)sc.getAttribute("dbmgr");
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		int no = Integer.parseInt(req.getParameter("no"));
		String page = req.getParameter("page");
		String keyword = req.getParameter("keyword");
		
		Connection con = dbmgr.getConnection();
		RecursiveDeleter deleter = new RecursiveDeleter(con);
		deleter.addDeleteList(no);
		deleter.getDeleteList(no);
		deleter.delete();
		
		String path = req.getContextPath();
		keyword = URLEncoder.encode(keyword, "UTF-8");
		resp.sendRedirect(path + "/board/list.jsp?page=" + page + "&amp;keyword=" + keyword);
	}
	
}
</pre>

<h3>오라클 계층형 쿼리(Oracle Hierarchical Query)를 이용하여 계층형 게시판 만들기</h3>
언급했듯이 오라클의 계층형 쿼리를 제공한다.<br />
오라클 계층형 쿼리를 이용한다면 게시판 테이블에서 부모클의 고유번호를 저장할 parent 컬럼만 있으면 된다.<br />

<pre class="prettyprint">
SELECT no, indent, parent, title, wdate FROM 
(SELECT ROWNUM R, A.* 
FROM 
(SELECT no, level as indent, parent, title, wdate FROM board 
START WITH parent = 0 
CONNECT BY PRIOR no = parent 
ORDER SIBLINGS BY no DESC) A) 
WHERE R BETWEEN 1 AND 10
</pre>

start with 절 다음에는 최상위 계층을 찾는 조건이 나온다.<br />
connect by 절은 부모와 자식노드들 간의 관계를 연결한다.<br />
이제 게시판으로 돌아와서, list.jsp 열고 목록 데이터를 구하는 쿼리 문자열은 아래처럼 바꾼 후 목록을 테스트해 보자.<br />

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT no, indent, parent, title, wdate FROM " +
	"(SELECT ROWNUM R, A.* " +
	"FROM " +
	"(SELECT no, level as indent, parent, title, wdate FROM board " +
	"START WITH parent = 0 " +
	"CONNECT BY PRIOR no = parent " +
	"ORDER SIBLINGS BY no DESC) A) " +
	"WHERE R BETWEEN ? AND ?";

} else {
	sql = "SELECT no, indent, parent, title, wdate FROM " +
	"(SELECT ROWNUM R, A.* " +
	"FROM " +
	"(SELECT no, level as indent, parent, title, wdate FROM board " +
	"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%' " +
	"START WITH parent = 0 " +
	"CONNECT BY PRIOR no = parent " +
	"ORDER SIBLINGS BY no DESC) A) " +
	"WHERE R BETWEEN ? AND ?";
}
</pre>

<h3>오라클 계층형 쿼리 이해하기</h3>
scott계정의 emp 테이블을 가지고 간단하게 오라클 계층형 쿼리를 실습해 볼 것이다.<br />
emp 테이블은 사원테이블이다.<br />
mgr 컬럼은 상사의 사번을 저장한다.<br />

<pre class="prettyprint">
SELECT job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR empno = mgr;
</pre>

<pre class="prettyprint">
JOB	       EMPNO ENAME	       MGR
--------- ---------- ---------- ----------
PRESIDENT	7839 KING
MANAGER 	7566 JONES	      7839
ANALYST 	7902 FORD	      7566
CLERK		7369 SMITH	      7902
MANAGER 	7698 BLAKE	      7839
SALESMAN	7499 ALLEN	      7698
SALESMAN	7521 WARD	      7698
SALESMAN	7654 MARTIN	      7698
SALESMAN	7844 TURNER	      7698
CLERK		7900 JAMES	      7698
MANAGER 	7782 CLARK	      7839
CLERK		7934 MILLER	      7782
</pre>

계층형 관계를 쉽게 파악하게 위해 계층형 쿼리에서 사용할 수 있는 level 가상컬럼을 사용해 보자.<br />

<pre class="prettyprint">
SELECT level, job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr;
</pre>

<pre class="prettyprint">
     LEVEL JOB		  EMPNO ENAME		  MGR
---------- --------- ---------- ---------- ----------
	 1 PRESIDENT	   7839 KING
	 2 MANAGER	   7566 JONES		 7839
	 3 ANALYST	   7902 FORD		 7566
	 4 CLERK	   7369 SMITH		 7902
	 2 MANAGER	   7698 BLAKE		 7839
	 3 SALESMAN	   7499 ALLEN		 7698
	 3 SALESMAN	   7521 WARD		 7698
	 3 SALESMAN	   7654 MARTIN		 7698
	 3 SALESMAN	   7844 TURNER		 7698
	 3 CLERK	   7900 JAMES		 7698
	 2 MANAGER	   7782 CLARK		 7839
	 3 CLERK	   7934 MILLER		 7782
</pre>

level 을 이용하여 들여쓰기를 하여 수직적인 관계를 보기 좋게 출력해 본다.<br />

<pre class="prettyprint">
col job format a20;

SELECT LPAD(' ', 2*(LEVEL-1)) || job job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr;
</pre>

<pre class="prettyprint">
JOB			  EMPNO ENAME		  MGR
-------------------- ---------- ---------- ----------
PRESIDENT		   7839 KING
  MANAGER		   7566 JONES		 7839
    ANALYST		   7902 FORD		 7566
      CLERK		   7369 SMITH		 7902
  MANAGER		   7698 BLAKE		 7839
    SALESMAN		   7499 ALLEN		 7698
    SALESMAN		   7521 WARD		 7698
    SALESMAN		   7654 MARTIN		 7698
    SALESMAN		   7844 TURNER		 7698
    CLERK		   7900 JAMES		 7698
  MANAGER		   7782 CLARK		 7839
    CLERK		   7934 MILLER		 7782
</pre>

만일 위 쿼리를 정렬하기 위해 마지막에 ORDER BY empno DESC 를 추가한다면 계층관계가 깨진다.<br />
계층관계가 깨지지 않고 정렬을 하려면 ORDER SIBLINGS BY empno DESC 를 사용한다.<br />

<pre class="prettyprint">
SELECT LPAD(' ', 2*(LEVEL-1)) || job job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr 
ORDER SIBLINGS BY empno DESC;
</pre>

결과에서 강조된 부분이 empno 로 내림차순으로 정렬됨을 확인한다.<br />

<pre class="prettyprint">
JOB			  EMPNO ENAME		  MGR
-------------------- ---------- ---------- ----------
PRESIDENT		   7839 KING
  MANAGER		   7782 CLARK		 7839
    CLERK		   7934 MILLER		 7782
  MANAGER		   7698 BLAKE		 7839
    CLERK		   <strong>7900</strong> JAMES		 7698
    SALESMAN		   <strong>7844</strong> TURNER		 7698
    SALESMAN		   <strong>7654</strong> MARTIN		 7698
    SALESMAN		   <strong>7521</strong> WARD		 7698
    SALESMAN		   <strong>7499</strong> ALLEN		 7698
  MANAGER		   7566 JONES		 7839
    ANALYST		   7902 FORD		 7566
      CLERK		   7369 SMITH		 7902
</pre>

다음 쿼리는 상위 10개의 레코드만 추출한다.<br />

<pre class="prettyprint">
SELECT job, empno, ename,mgr FROM
(SELECT ROWNUM R, A.* 
FROM 
(SELECT LPAD(' ', 2*(LEVEL-1)) || job job, empno, ename, mgr
FROM emp
START WITH mgr is null
CONNECT BY PRIOR  empno = mgr 
ORDER SIBLINGS BY empno DESC) A) 
WHERE R BETWEEN 1 AND 10;
</pre>

<pre class="prettyprint">
JOB			  EMPNO ENAME		  MGR
-------------------- ---------- ---------- ----------
PRESIDENT		   7839 KING
  MANAGER		   7782 CLARK		 7839
    CLERK		   7934 MILLER		 7782
  MANAGER		   7698 BLAKE		 7839
    CLERK		   7900 JAMES		 7698
    SALESMAN		   7844 TURNER		 7698
    SALESMAN		   7654 MARTIN		 7698
    SALESMAN		   7521 WARD		 7698
    SALESMAN		   7499 ALLEN		 7698
  MANAGER		   7566 JONES		 7839
</pre>
