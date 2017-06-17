<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2016.3.16</div>

<h1>게시판</h1>

지금부터 서블릿과 JSP에서 다룬 내용을 토대로 ROOT 애플리케이션에 간단한 게시판을 만들어 보겠다.
아래를 사용해서 테이블과 시퀀스를 생성한다.

<h2>기본 기능</h2>
게시판이라면 가져야 할 핵심적인 기능을 기본 기능이라 하자.
(기본 기능에서 목록은 한 페이지에 모든 레코드를 출력한다)
아래를 참고하여 테이블과 시퀀스를 생성한다.

<em class="filename">board-schema.sql</em>
<pre class="prettyprint">
-- 게시판 테이블
create table board(
 no number primary key,
 title varchar2(200) not null,
 content varchar2(4000),
 wdate date
)
/
-- 게시판 no 컬럼 값을 위한 시퀀스 
create sequence board_no_seq
start with 1
increment by 1
/
</pre>


board-schema.sql 파일을 이용하려면, scott 계정으로 SQL*PLUS에 접속한 후, @다음에 board-schema.sql 파일의 전체경로를 입력한다.
board-schema.sql 파일이 <em class="path">C:\</em>에 저장했다면 다음과 같이 실행한다.

<pre>
SQL&gt;@C:\board-schema.sql
</pre>

테스트용 데이터를 인서트 하기 위해 100개의 인서트 문을 실행하거나 PL/SQL 문을 실행한다.

<em class="filename">100개의 인서트 문 실행</em>
<pre class="prettyprint">
insert into board values (board_no_seq.nextval, '000001','',sysdate);
..
..
insert into board values (board_no_seq.nextval, '000100','',sysdate);
commit;
</pre>

<em class="filename">PL/SQL를 작성하여 데이터 인서트</em>
<pre class="prettyprint">
DECLARE
  counter INTEGER;
BEGIN
  counter := 1;
  FOR counter IN 1..100 LOOP
    insert into board values (board_no_seq.nextval, LPAD(board_no_seq.currval, 6, 0),'',sysdate); 
  END LOOP;
END;
/
</pre>

다음은 게시판을 구현하기 위해 만들 파일이다. 연습을 위해 서블릿과 JSP를 섞어 놓았다.

<table class="table-in-article">
<caption class="table-in-article-caption">작성할 파일 리스트</caption>
<tr>
	<td class="table-in-article-td">list.jsp</td>
	<td class="table-in-article-td">
	게시물의 목록을 보여주는 페이지<br />
	(페이지분할, 페이지 직접 이동 링크, 검색)
	</td>
</tr>
<tr>
	<td class="table-in-article-td">write_form.jsp</td>
	<td class="table-in-article-td">새글 입력 폼을 제공하는 화면</td>
</tr>
<tr>
	<td class="table-in-article-td">BoardWriter.java</td>
	<td class="table-in-article-td">새글 입력을 처리하는 서블릿</td>
</tr>
<tr>
	<td class="table-in-article-td">view.jsp</td>
	<td class="table-in-article-td">해당 게시물의 상세 정보를 출력하는 페이지</td>
</tr>
<tr>
	<td class="table-in-article-td">modify_form.jsp</td>
	<td class="table-in-article-td">수정 입력 폼 화면</td>
</tr>
<tr>
	<td class="table-in-article-td">BoardModifier.java</td>
	<td class="table-in-article-td">수정을 위해 실제로 DB 테이블을 수정을 행하는 서블릿</td>
</tr>
<tr>
	<td class="table-in-article-td">BoardDeleter.java</td>
	<td class="table-in-article-td">테이블에서 해당 레코드를 삭제하는 서블릿</td>
</tr>
</table>

게시판 프로그램의 흐름은 다음과 같다.

<pre style="line-height: 200%;border: 1px solid grey;">
list.jsp &rarr; write_form.jsp &rarr; BoardWriter.java (insert 실행) &rarr; list.jsp
  └── view.jsp
        └── modify_form.jsp &rarr; BoardModifier.java (update 실행) &rarr; view.jsp
        └── BoardDeleter.java (delete 실행) &rarr; list.jsp
</pre>

ROOT 애플리케이션의 최상위 디렉터리에 board라는 서브 디렉터리로 만든다.
게시판 관련 JSP 파일은 이 디렉터리에 만들 것이다.
이전 절인, <a href="Accessing-database-from-JSP_Servlets">데이터베이스 연동</a>을 실습했다면 커넥션 풀링 바이트 코드가 WEB-INF/classes에 있을 것이다.
(<a href="Accessing-database-from-JSP_Servlets">데이터베이스 연동</a>을 실습해야 아래 코드를 테스트할 수 있다)

<em class="filename">/board/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;목록&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;목록&lt;/h1&gt;
&lt;%
Log log = new Log();

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String sql = "select no, title, wdate from board order by no desc";

try {
	con = dbmgr.getConnection();

	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();

	while (rs.next()) {
		int no = rs.getInt("no");
		String title = rs.getString("title");
		Date wdate = rs.getDate("wdate");
%&gt;
&lt;%=no %&gt; &lt;a href="view.jsp?no=&lt;%=no %&gt;"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
  }
} catch(SQLException e) {
	log.debug("Error Source : board/list.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql);
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
	if (con != null) {
		dbmgr.freeConnection(con);
	}
	log.close();
}
%&gt;
&lt;p&gt;
&lt;a href="write_form.jsp"&gt;글쓰기&lt;/a&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/board/write_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;

&lt;title&gt;글쓰기&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;글쓰기&lt;/h1&gt;
&lt;form action="../servlet/BoardWriter" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50"&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="20" cols="100"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="list.jsp"&gt;목록&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;  
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

글을 DB에 인서트하는 서블릿을 작성한다.

<em class="filename">BoardWriter.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardWriter extends HttpServlet {
	private static final long serialVersionUID = 5698354994510824246L;
	
	OracleConnectionManager dbmgr = null;

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
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt = null;
		//입력 순서: 시퀀스, 제목, 소개글, 본문
		String sql = "insert into board values (board_no_seq.nextval,?,?,sysdate)";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, title); //제목 부분
			stmt.setString(2, content); //본분 부분
			stmt.executeUpdate(); //쿼리 실행
		} catch (SQLException e) {
			log.debug("Error Source : BoardWriter.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
		} finally {
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
			String path = req.getContextPath();
			resp.sendRedirect(path + "/board/list.jsp");
		}
	}

}
</pre>

서블릿이므로 바이트 코드가 /WEB-INF/classes에 생기도록 컴파일한다.
이 서블릿의 URI 매핑이 <strong>/servlet/BoardWriter</strong>가 되도록 web.xml를 편집한다.

<h3>테스트</h3>
<ol>
	<li>web.xml이 바뀌었으므로 톰캣 재실행</li>
	<li>http://localhost:8989/board/list.jsp 방문</li>
	<li>글쓰기 링크를 클릭하여 새글 입력 폼 페이지로 이동</li>
	<li>글을 작성하고 등록되는지 테스트</li>
</ol>

다음은 게시글의 상세내용을 보는 JSP를 작성한다.

<em class="filename">/board/view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;상세보기&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no) {
	location.href="modify_form.jsp?no=" + no;
}

function goDelete(no) {
	var check = confirm('정말로 삭제하시겠습니까?');
	if (check) {
		location.href="../servlet/BoardDeleter?no=" + no;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;상세보기&lt;/h1&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
Log log = new Log();
Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String sql = "select no, title, content, wdate from board where no = ?";
try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();
	
	while (rs.next()) {
		String title = rs.getString("title");
		String content = rs.getString("content");
		Date wdate = rs.getDate("wdate");
		if (content == null) content = "";
%&gt;
&lt;h2&gt;제목: &lt;%=title %&gt;, 작성일: &lt;%=wdate.toString() %&gt;&lt;/h2&gt;
&lt;p&gt;
&lt;%=content = content.replaceAll(System.getProperty("line.separator"), "&lt;br /&gt;") %&gt;
&lt;/p&gt;
&lt;%
	}
} catch (SQLException e) {
	log.debug("Error Source : board/view.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql);
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
	if (con != null) {
		dbmgr.freeConnection(con);
	}
	log.close();
}
%&gt;
&lt;a href="list.jsp"&gt;목록&lt;/a&gt;
&lt;input type="button" value="수정" onclick="javascript:goModify('&lt;%=no %&gt;')"&gt;
&lt;input type="button" value="삭제" onclick="javascript:goDelete('&lt;%=no %&gt;')"&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h3>테스트</h3>
<ol>
	<li>web.xml이 변경되지 않았으므로 톰캣을 재실행할 필요 없음</li>
	<li>목록에서 제목을 클릭하여 상세보기 페이지로 이동하는지 테스트</li>
</ol>

<dl class="note">
<dt>MyServletContextListener.java</dt>
<dd>
<a href="Servlet">서블릿</a> 절에서 OracleConnectionManager 객체를 웹 애플리케이션이 시작될 때 서블릿 컨텍스트에 담도록 하는 예제(MyServletContextListener.java)가 있었다.
이 예제가 지금 ROOT 애플리케이션에서 실행되고 있다면 게시판은 좀 더 훌륭해진다.
</dd>
</dl>

다음은 상세보기 페이지에서 수정 버튼을 클릭하면 보여지는 수정 폼 JSP를 다음 내용으로 작성한다.<br />
 
<em class="filename">/board/modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));

Log log = new Log();

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String title = null;
String content = null;
String sql = "select title, content from board where no = ?";

try {
	con = dbmgr.getConnection();
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, no);
	rs = stmt.executeQuery();
	
	if (rs.next()) {
	    title = rs.getString("title");
	    content = rs.getString("content");
	    if (content == null) content = "";
	}
} catch (SQLException e) {
	log.debug("Error Source : board/modify_form.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql);
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
	if (con != null) {
		dbmgr.freeConnection(con);
	}
	log.close();
}
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;수정&lt;/h1&gt;
&lt;form action="../servlet/BoardModifier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=title %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=content %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;"&gt;상세보기&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

실제로 게시글의 업데이트를 수행하는 서블릿을 만든다.
서블릿을 만든 후 web.xml에 이 서블릿의 URI 매핑이 /servlet/BoardModifier이 되도록 편집한다. 
 
<em class="filename">BoardModifier.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.sql.*;

import net.java_school.db.dbpool.*;
import net.java_school.util.*;

public class BoardModifier extends HttpServlet {
  
	private static final long serialVersionUID = -971206071575571573L;

	OracleConnectionManager dbmgr = null;
	
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
		
		int no = Integer.parseInt(req.getParameter("no"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "update board set title = ?, content = ? where no = ?";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, title); //제목 부분
			stmt.setString(2, content); //본분 부분
			stmt.setInt(3, no); //primary key
			stmt.executeUpdate(); //쿼리 실행
		} catch (SQLException e) {
			log.debug("Error Source : BoardModifier.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
		} finally {
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
			
			String path = req.getContextPath();
			resp.sendRedirect( path + "/board/view.jsp?no=" + no);
		}
		
	}
	
}
</pre>

<h3>테스트</h3>
<ol>
	<li>톰캣 재실행</li>
	<li>목록 방문</li>
	<li>목록에서 제목을 클릭하여 상세보기로 이동</li>
	<li>수정 버튼을 클릭하여 수정 폼 페이지로 이동</li>
	<li>수정 폼에서 제목과 내용을 변경한 후 확인 버튼을 클릭</li>
	<li>이동한 상세보기 페이지에서 제목과 내용이 변경되었는지 확인</li> 
</ol>

게시글을 삭제하는 서블릿을 작성한다.<br />
web.xml에서 이 서블릿의 URI 매핑을 /servlet/BoardDeleter로 한다.<br /> 

<em class="filename">BoardDeleter.java</em>
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
	
	OracleConnectionManager dbmgr = null;
	
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
		Log log = new Log();
		
		int no = Integer.parseInt(req.getParameter("no"));
		
		Connection con = dbmgr.getConnection();
		PreparedStatement stmt = null;
		String sql = "delete board where no = ?";
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, no);
			stmt.executeUpdate(); //쿼리 실행
		} catch (SQLException e) {
			log.debug("Error Source : BoardDeleter.java : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
		} finally {
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
			String path = req.getContextPath();
			resp.sendRedirect(path + "/board/list.jsp");
		}
		
	}
	
}
</pre>

<h3>테스트</h3>
<ol>
	<li>톰캣 재실행</li>
	<li>목록 방문</li>
	<li>목록에서 제목을 클릭하여 상세보기로 이동</li>
	<li>상세보기에서 삭제 버튼을 클릭</li>
	<li>목록에서 해당 게시글이 삭제되었는지 확인</li>
</ol>


<h2>페이지 분할 기능</h2>
게시판의 게시글 레코드가 10,000 개라면 list.jsp 안의 while 문은 10,000번 실행될 것이다.
목록에서 한꺼번에 전체 레코드를 보여 주지 말고 레코드를 그룹으로 묶어서 여러 페이지로 나누어 보여주는 기능이 필요한데,
이 기능을 여기서는<strong>"페이지 분할 기능"</strong>이라고 하겠다.

<h3>레코드를 그룹으로 묶기 위한 쿼리</h3>
다음은 페이지 분할 기능을 위한 오라클 쿼리문으로, 
레코드를 10개씩 묶는다면 각 그룹에 해당하는 레코드를 가져오는 쿼리문이다.

<em class="filename">레코드 그룹 1에 해당하는 레코드</em>
<pre class="prettyprint">
SELECT no,title,wdate FROM (
	SELECT ROWNUM R, A.* FROM (select no, title, wdate
		FROM board ORDER BY no DESC) A)
WHERE R BETWEEN 1 and 10;
</pre>

<em class="filename">레코드 그룹 2에 해당하는 레코드</em>
<pre class="prettyprint">
SELECT no,title,wdate FROM (
	SELECT ROWNUM R, A.* FROM (select no, title, wdate
		FROM board ORDER BY no DESC) A)
WHERE R BETWEEN 11 and 20;
</pre>

<em class="filename">레코드 그룹 3 에 해당하는 레코드</em>
<pre class="prettyprint">
SELECT no,title,wdate FROM (
	SELECT ROWNUM R, A.* FROM (select no, title, wdate
		FROM board ORDER BY no DESC) A)
WHERE R BETWEEN 21 and 30;
</pre>

ROWNUM은 오라클의 가상 컬럼으로 쿼리 문장에서 1부터 시작하여 순차적인 값을 가진다. 
ROWNUM을 WHERE 절의 조건에 쓰면 보여줄 그룹에 해당하는 레코드를 추출할 수 있다. 
list.jsp를 요청할 때 그룹 번호를 파라미터로 넘겨준다면 그룹에 해당하는 시작 레코드 번호와 
마지막 레코드 번호를 구할 수 있을 것이다. 
list.jsp에 전달할 레코드 그룹 번호에 해당하는 파라미터를 page라 한다면 
페이지 분할 기능을 아래처럼 구현 할 수 있다. 
 
 
<em class="filename">/board/list.jsp</em>
<pre class="prettyprint">
&lt;%
// .. 중간생략 ..
<strong>int page = (request.getParameter("page") == null) ? 1 : Integer.parseInt(request.getParameter("page"));</strong>
// 시작 레코드 계산  
<strong>int start = (page - 1) * 10 + 1;</strong>
// 마지막 레코드 계산
<strong>int end = start + 10 - 1;</strong>

// ... 중간 생략 ...

<strong>String sql = "SELECT no,title,wdate FROM (" + 
          	"SELECT ROWNUM R, A.* FROM (SELECT no, title, wdate " +
          	"FROM board ORDER BY no DESC) A) " + 
      	"WHERE R BETWEEN ? AND ?";</strong>
      
stmt = con.prepareStatement(sql);
<strong>stmt.setInt(1, start);</strong>
<strong>stmt.setInt(2, end);</strong>
rs = pstmt.executeQuery();

// ... 중간 생략 ...
%&gt;
</pre>

이제 http://localhost:8989/board/list.jsp?page=1을 요청하면 그룹1의 레코드를 볼 수 있게 되었다.
하지만 주소창에 일일히 쳐가며 방문하는 게시판은 없다.
일반적인 게시판은 페이지를 이동할 수 있는 링크를 제공한다.
<strong>&lt;a href=&quot;list.jsp?page=1&quot;&gt;[1]&lt;/a&gt;</strong><br />
마지막 페이지 번호를 알아낸다면 1부터 마지막 페이지 번호까지 for 문을 이용해 위와 같은 링크를 만들 수 있다. 
마지막 페이지는 어떻게 알 수 있을까?
"마지막 페이지 번호"는 페이지가 1부터 시작하므로 "총 페이지 수"와 같다.
총 페이지 수는 총 레코드 수를, 페이지 당 레코드 수인, 10으로 나누면 계산된다.
이제 총 레코드 수를 계산하면 모든 문제가 풀릴 것이다. 

<h3>총 레코드 수</h3>
list.jsp의 적당한 위치에 아래 코드를 추가한다.

<pre class="prettyprint">
int totalRecord = 0; //총 레코드 수를 저장할 변수
String sql = "SELECT count(*) FROM board";
stmt = con.prepareStatement(sql);
rs = pstmt.executeQuery();
rs.next();
totalRecord = rs.getInt(1);
</pre>

list.jsp에 총 레코드 수 구하는 코드 아래, 적당한 위치에 아래를 추가한다.


<pre class="prettyprint">
int totalPage = 0; //총 페이지 수를 저장할 변수

if (totalRecord != 0) {
   if (totalRecord % 10 == 0) {
      totalPage = totalRecord / 10;
   } else {
      totalPage = totalRecord / 10 + 1;
   }
}
</pre>

이제 총 페이지 수, 즉 마지막 페이지 번호를 구할 수 있다.
여기서 코드를 좀 더 우아하게 해 보자.
페이지 당 레코드 수를 저장하기 위한 변수 numPerPage를 선언하면,
list.jsp의 시작 레코드와 마지막 레코드 번호를 계산하는 코드는 아래와 같이 변경된다.

<pre class="prettyprint">
int numPerPage = 10; //페이지당 레코드 수
int start = (page - 1) * numPerPage + 1; //시작 레코드
int end = start + numPerPage - 1; //마지막 레코드
</pre>

총 페이지를 구하는 코드 역시 변경해야 한다.

<pre class="prettyprint">
int totalPage = 0;
if (totalRecord != 0) {
  if (totalRecord % <strong>numPerPage</strong> == 0) {
    totalPage = totalRecord / <strong>numPerPage</strong>;
  } else {
    totalPage = totalRecord / <strong>numPerPage</strong> + 1;
  }	
}
</pre>

<h3>페이지 직접 이동 링크 생성</h3>

총 페이지 수를 구했으므로 아래와 같이 페이지 직접 이동 링크를 생성하는 코드를 list.jsp에 작성할 수 있다.

<pre class="prettyprint">
&lt;%
for (int i = 1; i &lt;= totalPage; i++) {
%&gt;
   &lt;a href="list.jsp?page=&lt;%=i%&gt;"&gt;[&lt;%=i%&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>

<h3>목록 페이지에 페이지 분할 기능 적용</h3>
다음은 이제까지 구현한 페이지 분할 기능 알고리즘을 정리한 것이다.

<ol>
	<li>총 레코드 수를 구한다.</li>
	<li>페이지당 보일 레코드 수를 결정하고 총페이지 수를 구한다.</li>
	<li>첫번째 레코드 번호와 마지막 레코드 번호를 구하고 레코드를 출력한다.</li> 
	<li>페이지 직접 이동 링크를 만든다.</li> 
</ol>

위 알고리즘을 기존의 list.jsp 파일에 적용한다.

<em class="filename">/board/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;목록&lt;/title&gt;
&lt;/head&gt;
&lt;body style="font-size: 11px;"&gt;
&lt;h1&gt;목록&lt;/h1&gt;
&lt;%
Log log = new Log();

Connection con = null;
PreparedStatement stmt = null;
ResultSet rs = null;

String sql = null;

//1.총레코드 수를 구한다.
int totalRecord = 0;
try {
	con = dbmgr.getConnection();
	sql = "SELECT count(*) FROM board";
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();
	rs.next();
	totalRecord = rs.getInt(1);
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
	if (con != null) {
		dbmgr.freeConnection(con);
	}	
}

//2.페이지당 보일 레코드 수를 결정하고 총 페이지 수를 구한다.
int numPerPage = 10; //한 페이지에서 보일 레코드 수
int totalPage = 0; //총 페이지수
if (totalRecord != 0) {
	if (totalRecord % numPerPage == 0) {
		totalPage = totalRecord / numPerPage;
	} else {
		totalPage = totalRecord / numPerPage + 1;
	}
}

//3.첫번째 레코드 번호와 마지막 레코드 번호를 구한다.
int page = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

//시작 레코드 계산
int start = (page - 1) * numPerPage + 1;
//마지막 레코드 계산
int end = start + numPerPage - 1;
//해당 페이지의 레코드 셋을 구한 후 출력한다.

try {
	con = dbmgr.getConnection();
	sql="SELECT no,title,wdate FROM (" +
	         "SELECT ROWNUM R, A.* FROM (" + 
	          "SELECT no, title, wdate FROM board ORDER BY no DESC) A) " +
	         "WHERE R BETWEEN ? AND ?";
	
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, start);
	stmt.setInt(2, end);
	rs = stmt.executeQuery();

	while (rs.next()) {
		int no = rs.getInt("no");
		String title = rs.getString("title");
		Date wdate = rs.getDate("wdate");
%&gt;
&lt;%=no %&gt; &lt;a href="view.jsp?no=&lt;%=no %&gt;"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
  }
} catch(SQLException e) {
	log.debug("Error Source : board/list.jsp : SQLException");
	log.debug("SQLState : " + e.getSQLState());
	log.debug("Message : " + e.getMessage());
	log.debug("Oracle Error Code : " + e.getErrorCode());
	log.debug("sql : " + sql);
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
	if (con != null) {
		dbmgr.freeConnection(con);
	}
	log.close();
}

//4.각 페이지에 대한 직접 이동 링크를 만든다.
for (int i = 1; i &lt;= totalPage; i++) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=i %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
&lt;p&gt;
&lt;a href="write_form.jsp?page=&lt;%=page %&gt;"&gt;글쓰기&lt;/a&gt;
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

목록을 방문하여, 하단 페이지 직접 이동 링크를 클릭한다.

<dl class="note">
<dt>JSP에서 page란 변수를 쓸 수 없는 이유</dt>
<dd>
JSP에는 page라는 내재객체가 있다.
이것은 JSP가 서블릿으로 변환될 때 서블릿 코드에 다음과 같은 코드가 생성되어 추가되기 때문이다.<br /> 
<strong>Object page = this;</strong><br />
결론적으로 page란 이름의 변수를 JSP에서 사용할 수 없다.
</dd>
</dl>

<h3>Oracle 11g의 rank() 함수</h3>

11g부터 rank()함수를 이용할 수 있다.
이 함수를 이용하면 위의 게시판 목록에 해당하는 쿼리문을 조금 간단하게 줄일 수 있다.
먼저 원리를 알기 위해 쉬운 예제부터 살펴보자.
다음은 scott 계정의 emp 테이블에서 급여순으로 정렬하는 쿼리문이다.

<pre class="prettyprint">
SELECT empno,ename,sal,rank() over (order by sal desc) as rank FROM emp;
</pre>

이제 위의 게시판 목록를 구하는 쿼리문을 rank() 함수를 이용하는 것으로 바꾸어 보자.<br />

<pre class="prettyprint">
SELECT no,title,wdate 
FROM (
	SELECT rank() over (order by no desc) R,no,title,wdate FROM board
) 
WHERE R BETWEEN 1 and 10;
</pre>


<h2>페이지 직접 이동 링크 수 제한 기능</h2>
완벽하게 보이는 페이지 분할 기능은 문제점이 있다.
레코드가 10,000 개이고 numPerPage가 10이라면 하단의 페이지 직접 이동 링크는 [1] [2] [3] ...... [999] [1000]까지 생긴다.
즉 1,000 개의 링크가 만들어진다는 얘기다.
1,000 개의 페이지 직접 이동 링크는 웹 디자이너가 만든 예쁜 디자인을 헤집어 놓을 것이다.
해결책은 레코드를 그룹화한 것과 마찬가지로 페이지를 그룹화하는 것이다.
이 기능을 여기서는 <strong>"페이지 직접 이동 링크 수 제한 기능"</strong>이라고 부르도록 하겠다. 

<h3>페이지를 그룹화하기</h3>
페이지 직접 이동 링크의 수를 제한하기 위해서는 페이지를 그룹으로 나누어야 한다.<sup>1</sup>
만약 그룹당 페이지 수를 5로 정했다면, 다시 말해 페이지 직접 이동 링크수를 5개만 보이도록 제한한다면
하단에 보이는 [1] [2] [3] [4] [5] 링크는 그룹 1에 속한다.
[6] [7] [8] [9] [10]는 그룹 2에 속한다.<br />

<img src="https://lh3.googleusercontent.com/ulUUomivFb4v8w2v9yqoA7VcR48i-adOy48WnNc0dRCoR8FpQ0EuYU9BwRM7sx2C_EeRs_8kM1oh9Rqcf41Bhtw4as9K_9vARuetxuElsNDmdieN2V0jc69S5bskwyyIuRPUF3A6hiIL8g6TPDmLRbEGPw_PL46pJdbawRst6-5hd3JQy7CKcu4gXNrhgGeZ5U5wLEvPaw45x5bmEhHRTvLDf7yYgHa222jjuS9bNmUv_JZRyrLgzXwBMBoq-BvAxw7lFnJrXEGW_ZcVzefsMu1Dkw9WZtywKX_RkhRd-7kXMoHrekLrHLy7QyibSGKzKz-Yy6c9gucJNozBKSpFTuNtERLYXVruYudBe9RhaqTNcjo_cZU1HTdq1ZiLn-sLBzW-jVP34HP07tPjjp8I6XSuHOchTpbdEQ3SDX2n6mPMDHVTFPaBQBlvr5xTqenY9y2x4iqootZhsRYcKhvt_HgSGlo7O76zKPmMDV1QMA4wubW6Bo4H4rvCbW7hAD1iydPgY-s1U0qde4UEFFxSmCju70T9BdrmxzqchK_Mx1g0Kuu8xGADNFoZ8Lanns5lVf1WaKH_Cx_-JYs3EBZWt1JHq1yZpus=w366-h405-no" alt="페이지 링크 그룹화" /><br />

page가 어느 그룹에 속하는지는 다음 코드로 구할 수 있다.
페이지를 그룹화할 때 그룹 번호를 저장할 변수를 block라고 하겠다.
페이지를 그룹으로 묶을 때 묶는 단위를 pagePerBlock라고 하겠다.
즉, block은 페이지 그룹 번호를 저장하고, pagePerBlock은 block 당 페이지 수를 저장한다.<br />

<em class="filename">page가 속한 block 구하기</em>
<pre class="prettyprint">
//페이지 그룹 번호를 저장할 변수 선언과 초기화
int block = 1;

//블록 당 페이지 수를 저장할 변수와 초기화
int pagePerBlock = 5;

if (page % pagePerBlock == 0) {
   block = page / pagePerBlock;
} else {
   block = page / pagePerBlock + 1;
}
</pre>

현재 페이지가 속한 그룹 번호 block을 구했다면 block에 속한 첫 번째 페이지와 마지막 페이지 번호를 다음 코드로 구할 수 있다.

<pre class="prettyprint">
// block 에 속한 첫번째 페이지 계산 
int firstPage = (block - 1) * pagePerBlock + 1;

// block 에 속한 마지막 페이지 계산
int lastPage =  block * pagePerBlock;
</pre>

루프 문을 이용해서 첫번째 페이지부터 마지막 페이지까지 링크를 만든다.

<pre class="prettyprint">
&lt;%
for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
   &lt;a href="list.jsp?page=&lt;%=i%&gt;"&gt;[&lt;%=i%&gt;]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>


위의 코드를 참고하여 기존의 list.jsp를 수정하고 테스트한다.<br />

<img src="https://lh3.googleusercontent.com/XfSjkWt4U17J_pdYXK99COdUsVaPC42hwkmcxsY-qYzphiA9NFUYSwIMUZ6zmQXPOd0kkB5KLqOk24WZOPCIrrRDV4F85p5pprWALpOkndDP9OCjK2VJYEP887ZfKwBh9oVHEjLwJZ3Gw60cIq4JkYaGLDhQtC2kycUzwoBXCYYc6S5eMiurpc7HkWRpiR_Lg2BMQpzfWTu3seffhU41-2iiXa4j_gxpC5YCiuFKFAndmzEWoWxT_vDqoJa_EN5IX94iaV340e67FRwt51cwUfHmbzfYyNYRBt35s6-IUlOy518UXc9fs6QpekveUlwK-yWqkLL4e53e4DRSSnDgrWxHZTJ0tmUkKyVy_xLIX9Sqcr5WrJR-IKS9Z6clKIoxLskojLEG1zCGwcg7jYNwb2qD4qHEB67GGLXm2vA-ts1j8P3b3tJMTFxsuBh_Zxqw9oYp9ItSM7zcJZ6b6r5O4jtkO7Lba_kfPyBwdwBzp9ux85KBMdXPVAM5jFCNf0CusVm9J1-HaqORJABpqx1dmVhdwBA995NjR4cOoSjvxwjyy3i1DfRVdmTz7I5LCzcADVPZfMePnUJ3higcc2KBmbh-B_YlIZk=w363-h393-no" alt="페이지 링크 그룹화" /><br />

현재 페이지가 속한 block을 구해서 그 block에 속한 페이지만 보여주는 것은 성공했다.
하지만 문제가 있는데 블록에서 블록으로 이동할 수 없다는 것이다.
가장 많이 사용되는 해결책은 다음과 같다. 
block이 1 보다 크면 [이전] 링크를 만들어서 firstPage - 1인 페이지로 링크시키고, 
block이 총 블록 수(총 블록 수는 마지막 블록 번호와 같다)보다 작으면 [다음] 링크를 만들고 lastPage + 1인 페이지로 링크시킨다. 
[이전] [다음] 링크를 이용하면 "인접한" 블록으로 이동할 수 있다.

<em class="filename">총 블록 수 구하기 (마지막 블록 구하기)</em>
<pre class="prettyprint">
//총 블록 수를 저장할 변수 선언과 초기화 
int totalBlock = 0;

if (totalPage &gt; 0) { 
  if (totalPage % pagePerBlock == 0) {
    totalBlock = totalPage / pagePerBlock;
  } else {
    totalBlock = totalPage / pagePerBlock + 1;
  }
}
</pre>

<em class="filename">[이전] 링크 생성 코드</em>
<pre class="prettyprint">
&lt;%
//현재 block &gt; 1 면 [이전] 링크를 만들고 firstPage - 1 페이지로 링크
int prevPage = 0;
if(block &gt; 1) {
  prevPage = firstPage - 1;
%&gt;
 &lt;a href="list.jsp?page=&lt;%=prevPage %&gt;"&gt;[이전]&lt;/a&gt;
&lt;%
}
</pre>

<em class="filename">[다음] 링크 생성 코드</em>
<pre class="prettyprint">
&lt;%
//block &lt; totalBlock 면 [다음]링크를 만들고  lastPage + 1 를 페이지번호로 링크 
if(block &lt; totalBlock) {
  int nextPage = lastPage + 1;
%&gt;
  &lt;a href="list.jsp?page=&lt;%=nextPage %&gt;"&gt;[다음]&lt;/a&gt;
&lt;%
}
%&gt;
</pre>

위 코드를 참고하여 list.jsp를 수정한 후 목록을 테스트한다.<br />

<img src="https://lh3.googleusercontent.com/Jn0RxOB1g52tbd0npx3H7x6Vo_2D_DKXvzUexC_QOiztm4STkGvobiOa3tYlWi4jwXpiL4ybvJ1iP-0j35HYei4fKdHy7fJ9gAGBbNeAIktlRzcndHpDSzlojkXNDLvWiVaFaFtgA6Sa68AggeIlwG4cihlWHHfX9G1viLPhpEXe_eDJW7YcH7Bjn4fOsNvCIVm23Zao3vjY6nG8TZHhYeVP2cUG-NOOFdH1ynRLcj2d3J6xTGKxwWsOIXI-duT4SRzxIVpy7LjqHHsdl0DkR2tbrhZ0gr2zGXo4NoI5dochxlJeRI3b7LAzzAgRs5RnxzFAYAxkPmMmVznS3vB1slnxlZFVYFf2fcFiM4k168l68ND_olweCZuF_K3-UBjpny_nVSS2IApf6G2VCyDJgsLrt4wGe9PAG1bk7OoSdgnGxh1ANVH4ac4p07TLmy7oA8zbXRE5II9hMkypSMg_jo5TgRLA7i6r2OKXsrRuBqy4JM7ReJYnLrzZ5a5xczviMUom0lgdj_fxFh7_n3wxd8kXRXEPLVKLYJP-Cf3hDwHmYU_CLYt9-ewK-Nt4z_q-sZiFoItvPZDV9_sy3DQQNq_HU4KLUuA=w364-h400-no" alt="페이지 그룹화" /><br />

[다음] 버튼을 클릭하여 테스트한다.<br />

<img src="https://lh3.googleusercontent.com/p-G8yrws_oJbQ5NTge3FVMreJCaQs6Eg3-hgHm57zhDwGjR-FdAIbjT3L8rNMbkRVzctCshIhNlGwVfH3fxInRG398-9fgazbcZwCBM085lHDgaxS5HctcIAumH9_b-XJoN8SVdovGDK4sKobUXvEBZW9c-mfVXeSTfuc-HfYzntmz5DrnTc0Ff9HNW_IkuZ35Xi5b-S3zSW6HLTtOV-49G6MztqaKv_d7klI6YeYryzCClFm1EwNzm6zT_lLPEXcM2Y5KciPIeeqYDjnNM63knBp5Y3JXJ52my9-PIqUs6KaetyhTUId1L1uVJsQ67PCZR23rk2rPB37-R8RPedaJC4Dxkvo36KKC7fgzHETCjO2or-Wp7nw4BlDWEoYT7LuIMf_9mjlb-96dicbXJFAf0C-jLUsNpNZ4RzWb8rwA141NC7SJOrgZ1zdQUMigMAjHPxhT1WfwCk_VpV08cYmnk7avhIfPgOijoe2qkwhu8TSWTzuZ7lgWWzpoa0Df7LRab6K7I2NWa40qf60bT2tuElxnaSz-SmAQTgXIwDOwBKKsFNfI5kajtl1IMA76EXYdxqj8aDxiu7Mqnaj2wXqf0Z5bL_PbE=w452-h398-no" alt="페이지 그룹화" /><br />

[이전] 버튼을 클릭하여 테스트한다.<br />
<br />

테스트 결과 이상이 없어 보인다.
디자인에 따라서 pagePerBlock을 조절하면 디자인에 영향을 미치지 않게 할 수 있다.
레코드가 101 개가 되도록 한다.
[다음] 링크를 클릭하여 마지막 블록으로 이동한다.
문제가 없는가?<br />

<img src="https://lh3.googleusercontent.com/Zl7usmdCXfNXldDNKC06qpO2HO5jNL2ZiK62v2G89qG3Mx-zio23mi5_6VxVSpSuPfpAgPmD6F9JpDmKDGy-JnPANd7bhuGOInV9-xU2pidupwJYkjx4_WQPKuhnjjt-rVGnLXham9sI5Yizlu_zGwBh26xer5n9Mky2iP6VeKmyF-fvsmIqoUjfdXeXpR-1cWoPGPAgA6nprsSedC_1HRtkbIq5Vko0yPq3bFmJK8pBShFzU09ZrL1ipDecPgxK-C00efQwWT4N-pC04YSVDMCccGinCC4T9KQr728L-BVi8AjLAAb4LWinYHS--HCx9mWA-wjNnX_d4_LGybxBakaGx1h-q-sc7t_pulEUZE-ApRvy0c0epjrKNzHK6ESnBOlOMdT9JGYceue-65laQWa5efW_mDvIq_KyseHDNOC6nagrj8TUBh8oKs5zEV0NB4syzhINIhBffoj6UUkVPyQagtCpi57vF-hmTAy9J-SU1ga6vjcfBn72S3OAUuc_MFC4GPHYPpFo8eGNirOu8bYrFmR3loKDckxOczh0KhFaQyz1FlPVFfNm4AlKzdkMgA2nbuhnSrXs9XBk3xC5QLXVut_7KUw=w452-h174-no" alt="페이지 그룹화" /><br />

마지막 블록에 불필요한 페이지가 생성되어 있는 것을 확인할 수 있다.
레코드가 101 개일때 numPerPage가 10이면 totalPage는 11이 된다.
이때 pagePerBlock가 5라면 totalBlock는 3으로 계산된다.
3 블록에 속하는 마지막 페이지 번호는 15로 계산되어 
3 블록에 실제로 있지 않은 [12] [13] [14] [15] 링크가 만들어지게 된다.
불필요한 페이지 번호가 생성되는 것을 막기 위해서는 
마지막 블록일 때 마지막 페이지 번호는 총 페이지 수로 설정해야 한다.
총 페이지 수는 마지막 페이지 번호와 같기 때문이다.
아래 코드를 페이지 직접 이동 링크를 출력하는 for 문 앞에 추가한다.

<pre class="prettyprint">
if (block &gt;= totalBlock) {
  lastPage = totalPage;
}
</pre>


위 코드를 참고하여 list.jsp를 수정한 후 테스트한다.<br />

<h3>페이지 링크수를 제한하는 알고리즘 정리</h3>
<ol>
	<li>블록당 페이지 직접 이동 링크수를 정한다.</li>
	<li>총 블록 수를 계산하다.</li>
	<li>현재 페이지를 가지고 현재 블록을 계산한다.</li>
	<li>현재 블록에서 링크할 첫번째 페이지와 마지막 페이지를 계산한다.</li>
	<li>현재 블록에 속한 불필요한 페이지를 제거한다.</li>
	<li>block &gt; 1이면 firstPage - 1로 [이전] 링크를 만든다.</li>
	<li>루프 문을 사용해여 첫 번째 페이지부터 마지막 페이지까지 링크를 만든다.</li>
	<li>block &lt; total_blcok이면 lastPage + 1로 [다음] 링크를 만든다.</li>
</ol>

이제는 다른 서버측 컴포넌트(JSP 와 Servlets)와 함께 테스트한다.
list.jsp?page=5에서 view.jsp을 방문한 후 view.jsp의 목록 링크를 클릭하면 list.jsp로 방문하게 된다.
즉, 5 페이지에서 상세보기를 보고 다시 목록으로 돌아오는데 1 페이지로 돌아온 것이다.
이에 대한 정상적인 기대는 목록 5 페이지에서 상세보기를 보고 목록 링크를 클릭하면 5 페이지의 목록으로 돌아가는 것이다.
이 문제를 해결하려면 "새글쓰기 처리 서블릿"을 제외한 게시판 관련된 모든 컴포넌트에 page 파라미터를 전달해야 하고 전달받은 컴포넌트는 
이 page 파라미터를 이용해서 다른 컴포넌트로 이동할 때 이 파라미터를 전달하도록 해야 한다.
/board/list.jsp 파일을 열고 아래를 참고하여 다른 컴포넌트로의 링크 부분을 수정한다.

<em class="filename">list.jsp 에서 view.jsp 로 이동시 page 파라미터 전달</em>
<pre class="prettyprint">
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;
</pre>

<em class="filename">list.jsp 에서 write_form.jsp 로 이동시 page 파라미터 전달</em>
<pre class="prettyprint">
&lt;a href="write_form.jsp?page=&lt;%=page %&gt;"&gt;글쓰기&lt;/a&gt;
</pre>

다음으로 /board/view.jsp 파일을 열고 아래를 참고하여 다른 컴포넌트로의 이동 부분의 코드를 수정한다.

<em class="filename">/board/view.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
<strong>String page = request.getParameter("page");</strong>
%&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;상세보기&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no,<strong>page</strong>) {
	location.href="modify_form.jsp?no=" + no + <strong>"&amp;page=" + page</strong>;
}

function goDelete(no,page) {
	var check = confirm('정말로 삭제하시겠습니까?');
	if (check) {
		location.href="../servlet/BoardDeleter?no=" + no + <strong>"&amp;page=" + page</strong>;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;상세보기&lt;/h1&gt;

..중간 생략 ..

&lt;a href="list.jsp<strong>?page=&lt;%=page %&gt;</strong>"&gt;목록&lt;/a&gt;
&lt;input type="button" value="수정" onclick="javascript:goModify('&lt;%=no %&gt;',<strong>'&lt;%=page %&gt;'</strong>)"&gt;
&lt;input type="button" value="삭제" onclick="javascript:goDelete('&lt;%=no %&gt;',<strong>'&lt;%=page %&gt;'</strong>)"&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

/board/write_form.jsp 파일을 열고 목록으로 돌아가는 부분의 코드를 수정한다.
폼 액션 속성값에 ../servlet/BoardWriter?page=&lt;%=page %&gt;와 같이 page 파라미터를 전달해서는 안된다.
새글은 언제나 첫번째 페이지로 돌아가야 확인할 수 있기 때문이다.
5 페이지에서 글쓰기를 클릭하여 새글을 등록했는데 다시 5 페이지로 돌아간다면 
자신이 작성한 새글을 확인하기 위해서 하단의 [1] 링크를 클릭해야 하는 수고를 해야 한다.
그래서 새글은 등록하면 1페이지로 이동하는 것이 맞는 동작이다.

<em class="filename">/board/write_form.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
<strong>String page = request.getParameter("page");</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;글쓰기&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;글쓰기&lt;/h1&gt;
&lt;form action="../servlet/BoardWriter" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50"&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="20" cols="100"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="list.jsp<strong>?page=&lt;%=page %&gt;</strong>"&gt;목록&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;  
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/board/modify_form.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%
int no = Integer.parseInt(request.getParameter("no"));
<strong>String page = request.getParameter("page");</strong>

Log log = new Log();


//.. 중간 생략 ..

%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;수정&lt;/h1&gt;
&lt;form action="../servlet/BoardModifier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
<strong>&lt;input type="hidden" name="page" value="&lt;%=page %&gt;"&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=title %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=content %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;<strong>&amp;page=&lt;%=page %&gt;</strong>"&gt;상세보기&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardModifier 서블릿 수정</em>
<pre class="prettyprint">
@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {

	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	<strong>String page = req.getParameter("page");</strong>
	
	//..중간 생략 ..
				
	String path = req.getContextPath();
	resp.sendRedirect(path + "/board/view.jsp?no=" + no + <strong>"&amp;page=" + page</strong>);
	
}
</pre>

<em class="filename">BoardDeleter 서블릿 수정</em>
<pre class="prettyprint">
@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	
	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	<strong>String page = req.getParameter("page");</strong>
		
	//..중간 생략 ..
	
	String path = req.getContextPath();
	resp.sendRedirect(path + "/board/list.jsp<strong>?page=" + page</strong>);
	
}
</pre>

페이징은 웹 프로그래머라면 반드시 익혀야 한다.
구현과 충분한 테스트를 통해서 페이징에 대한 완벽한 이해를 해야 한다.


<h2>검색 기능</h2>

게시글이 많아지면 필요해지는 기능이 검색 기능이다.
다음 코드를 list.jsp의 가장 아래에 추가한다.

<pre class="prettyprint">
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" size="10" maxlength="30" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;
</pre>

list.jsp에 page 외에 keyword 파라미터도 함께 전달해야 한다.
전달받은 keyword 파라미터가 널인 경우 "" 문자로 바꾸어 주는 것이 좋다.
다음 코드를 list.jsp의 적당한 위치에 추가한다.

<pre class="prettyprint">
String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
</pre>

검색 기능이 추가되면 검색 조건에 따라서 총 레코드 수가 변화하기 때문에 list.jsp의 총 레코드 수 구하는 부분을 수정한다.

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT count(*) FROM board";
} else {
	sql = "SELECT count(*) FROM board " +
          "WHERE title LIKE '%" + keyword + "%' " + 
          	"OR content LIKE '%" + keyword + "%'";
}
</pre>

해당 페이지의 레코드을 가져오는 쿼리를 수정한다.

<pre class="prettyprint">
if (keyword.equals("")) {
	sql = "SELECT no,title,wdate " + 
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,title,wdate FROM board ORDER BY no DESC) A) " +
		"WHERE R BETWEEN ? AND ?";
} else {
	sql = "SELECT no,title,wdate " +
		"FROM (SELECT ROWNUM R, A.* FROM (" +
		"SELECT no,title,wdate FROM board " + 
		"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%' " +
		"ORDER BY no DESC) A) " +
		"WHERE R BETWEEN ? AND ?";
}
</pre>

list.jsp 파일을 열고 list.jsp로의 링크에 keyword 파라미터가 전달되도록 수정한다.
결색 결과의 5 페이지를 목록을 보고 있다가 상세보기를 하고 다시 목록보기를 했는데, 검색 결과가 아닌 5 페이지로 돌아가면 사용자는 당황할 것이다.

<pre class="prettyprint">
&lt;a href="list.jsp?page=&lt;%=prevPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[이전]&lt;/a&gt;
</pre>

<pre class="prettyprint">
&lt;a href="list.jsp?page=&lt;%=i %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
</pre>

<pre class="prettyprint">
&lt;a href="list.jsp?page=&lt;%=nextPage %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[다음]&lt;/a&gt;
</pre>

list.jsp를 방문한 후 검색을 테스트한다.
검색 후 목록에서 상세보기로 이동한 후 다시 목록으로 돌아오면 검색된 목록으로 돌아오지 못한다.
view.jsp 요청할 때 page 외에 keyword란 파라미터를 전달해야 다시 검색 목록으로 돌아갈 수 있다.
list.jsp 파일을 열고 아래를 참조하여 상세보기와 글쓰기에 대한 링크를 수정한다.

<pre class="prettyprint">
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;&lt;%=title %&gt;&lt;/a&gt; &lt;%= wdate.toString() %&gt;
</pre>

<pre class="prettyprint">
&lt;a href="write_form.jsp?page=&lt;%=page %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;글쓰기&lt;/a&gt;
</pre>

view.jsp에는 page와 keyword 파라미터를 수신하고 list.jsp로 돌아갈 때는 이 파라미터를 이용하도록 코드를 수정한다.
글쓰기를 제외한 게시판의 다른 컴포넌트 역시 keyword 파라미터를 수신하고 코드에서 다른 컴포넌트로의 링크를 수정한다.

<em class="filename">/board/view.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>
int no = Integer.parseInt(request.getParameter("no"));
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");
%&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8" /&gt;
&lt;title&gt;상세보기&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no,page,keyword) {
	location.href="modify_form.jsp?no=" + no + "&amp;page=" + page + <strong>"&amp;keyword=" + keyword</strong>;
}

function goDelete(no,page,keyword) {
	var check = confirm('정말로 삭제하시겠습니까?');
	if (check) {
		location.href="../servlet/BoardDeleter?no=" + no + "&amp;page=" + page + <strong>"&amp;keyword=" + keyword</strong>;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;상세보기&lt;/h1&gt;

..중간 생략 ..

&lt;a href="list.jsp?page=&lt;%=page %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;목록&lt;/a&gt;
&lt;input type="button" value="수정" onclick="javascript:goModify('&lt;%=no %&gt;','&lt;%=page %&gt;',<strong>'&lt;%=keyword %&gt;'</strong>)"&gt;
&lt;input type="button" value="삭제" onclick="javascript:goDelete('&lt;%=no %&gt;','&lt;%=page %&gt;',<strong>'&lt;%=keyword %&gt;'</strong>)"&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

아래 컴포넌트도 위와 같은 이유로 수정한다.
이때 BoardWriter.java는 수정할 필요가 없다.

<em class="filename">/board/write_form.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>
String page = request.getParameter("page");
<strong>String keyword = request.getParameter("keyword");</strong>
%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;글쓰기&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;글쓰기&lt;/h1&gt;
&lt;form action="../servlet/BoardWriter" method="post"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50"&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="20" cols="100"&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="list.jsp?page=&lt;%=page %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;목록&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;  
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/board/modify_form.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.util.*" %&gt;
&lt;%@ page import="net.java_school.db.dbpool.*" %&gt;
&lt;jsp:useBean id="dbmgr" scope="application" class="net.java_school.db.dbpool.OracleConnectionManager" /&gt;
&lt;%
<strong>request.setCharacterEncoding("UTF-8");</strong>
String no = request.getParameter("no");
String page = request.getParameter("page");
<strong>String keyword = request.getParameter("keyword");</strong>
Log log = new Log();


//.. 중간 생략 ..

%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;수정&lt;/h1&gt;
&lt;form action="../servlet/BoardModifier" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
&lt;input type="hidden" name="page" value="&lt;%=page %&gt;"&gt;
<strong>&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;"&gt;</strong>
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=title %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=content %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;<strong>&amp;keyword=&lt;%=keyword %&gt;</strong>"&gt;상세보기&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">BoardModifier 서블릿 수정</em>
<pre class="prettyprint">@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {

	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	String page = req.getParameter("page");
	<strong>String keyword = req.getParameter("keyword");</strong>
	
	//..중간 생략 ..
				
	String path = req.getContextPath();
	<strong>keyword = java.net.URLEncoder.encode(keyword,"UTF-8");</strong>
	resp.sendRedirect(path + "/board/view.jsp?no=" + no + "&amp;page=" + page + <strong>"&amp;keyword=" + keyword</strong>);
	
}
</pre>


<em class="filename">BoardDeleter 서블릿 수정</em>
<pre class="prettyprint">@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
	
	req.setCharacterEncoding("UTF-8");
	Log log = new Log();
	
	int no = Integer.parseInt(req.getParameter("no"));
	String page = req.getParameter("page");
	<strong>String keyword = req.getParameter("keyword");</strong>
		
	//..중간 생략 ..
	
	String path = req.getContextPath();
	<strong>keyword = java.net.URLEncoder.encode(keyword,"UTF-8");</strong>
	resp.sendRedirect(path + "/board/list.jsp?page=" + page + <strong>"&amp;keyword=" + keyword</strong>);

}
</pre>

 
<strong>keyword = java.net.URLEncoder.encode(keyword,"UTF-8");</strong>
코드가 필요한 이유는 HttpServletResponse 의 sendRedirect() 메소드의 인자가 자바 문자열인데 자바 문자열과 URL 주소 문자의 인코딩이 서로 다르기 때문이다.
URLEncoder의 encode() 메소드는 한글과 같은 문자에 대한 바이트 값을 얻을 수 있게 한다.
<!-- Translates a string into application/x-www-form-urlencoded format using a specific encoding scheme. 
This method uses the supplied encoding scheme to obtain the bytes for unsafe characters. 
-->
이 코드가 우리가 원하는 방식으로 동작하려면 서버 설정을 건드려야 한다.
{톰캣홈}/conf/server.xml 파일을 열고 Connector 엘리먼트 중 port 속성값이 8080인(우리는 8989로 바꿔야 했다) 
Connector 엘리먼트에 URIEncoding 속성을 다음과 같이 UTF-8인지를 확인한다.
URIEncoding 속성이 없다면 아래처럼 추가한다.

<pre class="prettyprint">
&lt;Connector port="8080" protocol="HTTP/1.1" 
	connectionTimeout="20000" 
	<strong>URIEncoding="UTF-8"</strong>
	redirectPort="8443" /&gt;
</pre>

톰캣은 쿼리 스트링을 포함한 URL의 디폴트 캐릭터 인코딩으로 ISO-8859-1을 사용한다.
즉, GET 파라미터의 인코딩은 ISO-8859-1을 사용한다.
<strong>URIEncoding="UTF-8"</strong> 설정은 URL에 대한 캐릭터 인코딩을 UTF-8로 변경한다.
이렇게 설정하면 값이 한글인 파라미터를 GET 방식으로 깨지지 않게 전송할 수 있다. 
톰캣을 재실행한다.
아래 파일을 ROOT 애플리케이션의 도큐먼트베이스에 생성한다.

<em class="filename">/sender.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;Insert title here&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%
String name = "홍길동";
%&gt;
&lt;form id="test" action="taker.jsp?name=&lt;%=name %&gt;" method="post"&gt;
	&lt;input type="hidden" name="nickname" value="의적" /&gt;
	&lt;input type="submit" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/taker.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /&gt;
&lt;title&gt;Insert title here&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%=name %&gt;&lt;br /&gt;
&lt;%=nickname %&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

http://localhost:8989/sender.jsp를 방문하고 서밋 버튼을 클릭한다.
이동한 taker.jsp에서 한글이 깨지지 않고 모두 출력되는지 확인한다.
list.jsp에서 검색폼의 method 속성을 method="post" 에서 method="get"으로 변경한 후 한글 검색이 되는지 확인한다.
검색 기능이 추가된 게시판이 완성되었다.
철저한 테스트를 통해서 게시판의 기능을 익히는 것이 앞으로의 학습에 도움이 될 것이다.

<span id="comments">주석</span>
<ol>
	<li>"페이지 분할 기능"에서 그룹화의 대상은 레코드이고, 레코드 그룹 번호를 저장하는 변수는 page이다.</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://wiki.apache.org/tomcat/FAQ/CharacterEncoding">http://wiki.apache.org/tomcat/FAQ/CharacterEncoding</a></li>
</ul>
