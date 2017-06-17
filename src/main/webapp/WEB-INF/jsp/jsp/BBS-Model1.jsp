<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.7.15</div>


<h1>모델1 게시판</h1>

모델1이란 JSP안의 자바 코드를 자바빈즈로 뽑아낸 코드를 말한다.<br />
이전 코드는 JSP안에 JDBC 코드가 포함되어 있었다.<br />
이와같은 코드는 악몽이라 불리는 코드로 최소한 JDBC 관련 코드는 자바빈즈에 있어야 한다.<br />
지금까지 작업한 게시판을 모델1 게시판으로  수정하기 위해, 먼저 게시글 하나(Article)의 정보를 담기 위한 자바빈즈를 작성하자.<br />

<em class="filename">Article.java</em>
<pre class="prettyprint">
package net.java_school.board;
 
import java.util.Date;
 
public class Article {
	public static final String LINE_SEPARATOR = System.getProperty("line.separator");
	
    private int no;
    private String title;
    private String content;
    private Date writeDate;
    private int family;
    private int parent;
    private int depth;
    private int indent;
    
    public int getNo() {
        return no;
    }
     
    public void setNo(int no) {
        this.no = no;
    }
     
    public String getTitle() {
        return title;
    }
     
    public void setTitle(String title) {
        this.title = title;
    }
     
    public String getContent() {
        if (content == null) content = "";
        return content;
    }
     
    public void setContent(String content) {
        this.content = content;
    }
     
    //view.jsp 에서 내용중 개행문자를 HTML의 개행문자로 바꾸는 메소드
    public String getHtmlContent() {
        if (content == null) content = "";
        return content.replaceAll(LINE_SEPARATOR, "&lt;br /&gt;");
    }
     
    public Date getWriteDate() {
        return writeDate;
    }
     
    public void setWriteDate(Date writeDate) {
        this.writeDate = writeDate;
    }

	public int getFamily() {
		return family;
	}

	public void setFamily(int family) {
		this.family = family;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	public int getIndent() {
		return indent;
	}

	public void setIndent(int indent) {
		this.indent = indent;
	}
    
}
</pre>

다음으로 JDBC를 담당하는 BoardDao 빈즈를 작성한다.<br />
(이름뒤에 Dao는 Data Access Object 의 약자이다. 이와 같은 이름을 가진 빈은 JDBC 관련 코드만을 지녀야 한다. 이를 DAO 패턴이라 한다.)<br />
여기서는 지금까지 사용했던 사용자 정의 커넥션 풀을 사용하지 않는다.<br />
다음글에서 소개할  DataSource 를 쉽게 접근하기 위해서이다.<br />
사용자 정의 커넥션 풀은 되도록이면 사용하지 않아야 한다.<br />
예제로 사용했던 이유는 코드를 볼 수 있는 커넥션 풀링를 사용하므로써 커넥션 풀링에 대한 이해를 쉽게 하기 위한 목적이었다.<br />
이제는 좀 더 실용적인 코드를 배워야 한다.<br />

<em class="filename">BoardDao.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import net.java_school.util.Log;

public class BoardDao {
	private static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public BoardDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private Connection getConnection() throws SQLException {
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}
	
	private void close(ResultSet rs, PreparedStatement stmt, Connection con) {
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
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList&lt;Article&gt; getBoardList(int start, int end, String keyword) {
		Log log = new Log();
		ArrayList&lt;Article&gt; list = new ArrayList&lt;Article&gt;();
		String sql = null;
		
		if (keyword != null &amp;&amp; keyword.equals("")) {
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
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, start);
			stmt.setInt(2, end);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				Article article = new Article();
				article.setNo(rs.getInt("no"));
				article.setTitle(rs.getString("title"));
				article.setWriteDate(rs.getDate("wdate"));
				article.setIndent(rs.getInt("indent"));
				list.add(article);
			}
		} catch (SQLException e) {
			log.debug("Error Source : BoardDao.getBoardList() : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
		} finally {
			close(rs, stmt, con);
			log.close();
		}
		
		return list;
	}
	
	public int getTotalRecord(String keyword) {
		Log log = new Log();
		int totalRecord = 0;
		String sql = null;
		
		if (keyword != null &amp;&amp; !keyword.equals("")) {
			sql = "SELECT count(*) FROM board";
		} else {
			sql = "SELECT count(*) FROM board " +
			"WHERE title LIKE '%" + keyword + "%' OR content LIKE '%" + keyword + "%'";
		}
				
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, keyword);
			stmt.setString(2, keyword);
			rs = stmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);
		} catch (SQLException e) {
			log.debug("Error Source : BoardDao.getTotalRecord() : SQLException");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
		} finally {
			close(rs, stmt, con);
			log.close();
		}
		
		return totalRecord;
	}
}
</pre>

PagingHelper은 페이징 처리를 위한 유틸리티 클래스이다.<br />

<em class="filename">PagingHelper.java</em>
<pre class="prettyprint">
package net.java_school.commons;

public class PagingHelper {
	private int firstPage;
	private int lastPage;
	private int prevLink;
	private int nextLink;
	private int listNo;
	private int startRecord;
	private int endRecord;
	
	public PagingHelper(int totalRecord, int page, int numPerPage, int pagePerBlock) {
		int totalPage = totalRecord / numPerPage;
		if (totalRecord % numPerPage != 0) totalPage++;
		
		int totalBlock = totalPage / pagePerBlock;
		if (totalPage % pagePerBlock != 0) totalBlock++;
		
		int block = page / pagePerBlock;
		if (page % pagePerBlock != 0) block++;
		
		firstPage = (block - 1) * pagePerBlock + 1;

		lastPage = block * pagePerBlock;
		if (block &gt;= totalBlock) {
			lastPage = totalPage;
		}
		
		if (block &gt; 1) {
			prevLink = firstPage - 1;
		}
		
		if (block &lt; totalBlock) {
			nextLink = lastPage + 1;
		}
		
		listNo = totalRecord - (page - 1) * numPerPage;
		
		startRecord = (page - 1) * numPerPage + 1;
		endRecord = page * numPerPage;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public int getPrevLink() {
		return prevLink;
	}

	public int getNextLink() {
		return nextLink;
	}

	public int getListNo() {
		return listNo;
	}

	public int getStartRecord() {
		return startRecord;
	}

	public int getEndRecord() {
		return endRecord;
	}

}
</pre>

ROOT 애플리케이션의 도큐먼트 베이스에 model1 이란 서브 디렉토리를 만들고 아래 JSP 파일을 생성한다.<br />
목록을 보여주는 list.jsp 작성한다.<br />

<em class="filename">/model1/list.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="net.java_school.commons.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
int page = (request.getParameter("page") == null  ? 1 : 
	Integer.parseInt(request.getParameter("page")));
String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
BoardDao dao = new BoardDao();
int totalRecord = dao.getTotalRecord(keyword);
PagingHelper pagingHelper = new PagingHelper(totalRecord,page,10,5);
int startRecord = pagingHelper.getStartRecord();
int endRecord = pagingHelper.getEndRecord();
ArrayList&lt;Article&gt; list = dao.getBoardList(startRecord, endRecord, keyword);
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;목록&lt;/title&gt;
&lt;/head&gt;
&lt;body style="font-size: 11px;"&gt;
&lt;h1&gt;목록&lt;/h1&gt;
&lt;%
int bbsNo = pagingHelper.getListNo();//no 컬럼값이 아닌, 순서대로 계산한 번호
for (int i = 0; i &lt; list.size(); i++) {
	Article article = list.get(i);
	int indent = article.getIndent();
	for (int j = 0; j &lt; indent; j++) {
		out.println("&nbsp;&nbsp;");
	}
	if(indent != 0) {
		out.println("ㄴ");
	}
%&gt;
&lt;%=bbsNo %&gt;
&lt;a href="view.jsp?no=&lt;%=article.getNo() %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;&lt;%=article.getTitle() %&gt;&lt;/a&gt;
&lt;%=article.getWriteDate() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
bbsNo--;
}
int prevLink = pagingHelper.getPrevLink();
if (prevLink != 0) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=prevLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[이전]&lt;/a&gt;
&lt;%
}
int firstPage = pagingHelper.getFirstPage();
int lastPage = pagingHelper.getLastPage();
for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=i %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
&lt;%
}
int nextLink = pagingHelper.getNextLink();
if (nextLink != 0) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=nextLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[다음]&lt;/a&gt;
&lt;%
}
%&gt;				
&lt;p&gt;
&lt;a href="write_form.jsp?page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;글쓰기&lt;/a&gt;
&lt;/p&gt;
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" size="10" maxlength="30" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;	
&lt;/body&gt;
&lt;/html&gt;
</pre>

목록을 방문하여 테스트한다.<br />
<br />
간단한 게시판은 Article과 BoardDao 정도로 충분하지만 
대부분의 모듈은 JSP의 프론트 역할을 하는 빈즈을 따로 두는 경우가 많다.
이 빈즈의 이름은 대부분 Service 란 이름이 붙는다.
다음과 같이 JSP의 프론트 역할을 하는 BoardService 빈즈을 아래를 참고하여 생성한다.<br />
BoardService를 만들면 JSP는 BoardService의 서비스만 받게 되고<br />
BoardService 빈즈에서 BoardDao 와 PagingHelper 의 메소드를 호출한다.<br />

<em class="filename">BoardService.java</em>
<pre class="prettyprint">
package net.java_school.board;

import java.util.ArrayList;

import net.java_school.commons.PagingHelper;

public class BoardService {
	private BoardDao dao = new BoardDao();
	private PagingHelper pagingHelper;
	private String keyword;
	
	public BoardService() {}
	
	public BoardService(int page, String keyword, int numPerPage, int pagePerBlock) {
		this.keyword = keyword;
		int totalRecord = dao.getTotalRecord(keyword);
		pagingHelper = new PagingHelper(totalRecord, page, numPerPage, pagePerBlock);
	}

	public String getkeyword() {
		return keyword;
	}

	public void setkeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public ArrayList&lt;Article&gt; getBoardList() {
		return dao.getBoardList(pagingHelper.getStartRecord(), pagingHelper.getEndRecord(), this.keyword);
	}
	
	public int getFirstPage() {
		return pagingHelper.getFirstPage();
	}

	public int getLastPage() {
		return pagingHelper.getLastPage();
	}

	public int getPrevLink() {
		return pagingHelper.getPrevLink();
	}

	public int getNextLink() {
		return pagingHelper.getNextLink();
	}

	public int getListNo() {
		return pagingHelper.getListNo();
	}

}
</pre>

BoardService.java 만을 사용하도록 list.jsp 수정한다.

<em class="filename">/model1/list.jsp 수정</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%@ page import="net.java_school.commons.*" %&gt;
&lt;%@ page import="java.util.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
int page = (request.getParameter("page") == null  ? 1 : Integer.parseInt(request.getParameter("page")));
String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
BoardService service = new BoardService(page, keyword, 10, 5);
ArrayList&lt;Article&gt; list = service.getBoardList();
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;목록&lt;/title&gt;
&lt;/head&gt;
&lt;body style="font-size: 11px;"&gt;
&lt;h1&gt;목록&lt;/h1&gt;
&lt;%
int bbsNo = service.getListNo();
for (int i = 0; i &lt; list.size(); i++) {
	Article article = list.get(i);
	int indent = article.getIndent();
	for (int j = 0; j &lt; indent; j++) {
		out.println("&nbsp;&nbsp;");
	}
	if(indent != 0) {
		out.println("ㄴ");
	}
%&gt;
&lt;%=bbsNo %&gt;
&lt;a href="view.jsp?no=&lt;%=article.getNo() %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;&lt;%=article.getTitle() %&gt;&lt;/a&gt;
&lt;%=article.getWriteDate() %&gt;&lt;br /&gt;
&lt;hr /&gt;
&lt;%
bbsNo--;
}
int prevLink = service.getPrevLink();
if (prevLink != 0) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=prevLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[이전]&lt;/a&gt;
&lt;%
}
int firstPage = service.getFirstPage();
int lastPage = service.getLastPage();
for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=i %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[&lt;%=i %&gt;]&lt;/a&gt;
&lt;%
}
int nextLink = service.getNextLink();
if (nextLink != 0) {
%&gt;
	&lt;a href="list.jsp?page=&lt;%=nextLink %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;[다음]&lt;/a&gt;
&lt;%
}
%&gt;				
&lt;p&gt;
&lt;a href="write_form.jsp?page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;글쓰기&lt;/a&gt;
&lt;/p&gt;
&lt;form action="list.jsp" method="post"&gt;
	&lt;input type="text" size="10" maxlength="30" name="keyword" /&gt;
	&lt;input type="submit" value="Search" /&gt;
&lt;/form&gt;	
&lt;/body&gt;
&lt;/html&gt;
</pre>

/board/write_form.jsp 파일을 복사하여 /model1 에 복사한다.
폼 태그의 action 속성값을 write.jsp 로 수정한다.

<em class="filename">/model1/write_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;글쓰기&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;글쓰기&lt;/h1&gt;
&lt;form action="<strong>write.jsp</strong>" method="post"&gt;
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
		&lt;a href="list.jsp?page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;목록&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

BoardDao 에 다음 메소드를 추가한다.

<em class="filename">BoardDao.java 수정</em>
<pre class="prettyprint">
public void insert(Article article) {
	Log log = new Log();
	String sql = "INSERT INTO board (no, title, content, wdate, family, parent, depth, indent) "
		+ "VALUES (board_no_seq.nextval, ?, ?, sysdate, board_no_seq.nextval, 0, 0, 0)";
		
	Connection con = null;
	PreparedStatement stmt = null;
	
	try {
		con = getConnection();
		stmt = con.prepareStatement(sql);
		stmt.setString(1, article.getTitle());
		stmt.setString(2, article.getContent());
		stmt.executeUpdate();
	} catch (SQLException e) {
		log.debug("Error Source : BoardDao.insert() : SQLException");
		log.debug("SQLState : " + e.getSQLState());
		log.debug("Message : " + e.getMessage());
		log.debug("Oracle Error Code : " + e.getErrorCode());
		log.debug("sql : " + sql);
	} finally {
		close(null, stmt, con);
		log.close();
	}
}
</pre>

BoardService 에 다음 메소드를 추가한다.

<em class="filename">BoardService.java 수정</em>
<pre class="prettyprint">
public void write(Article article) {
	dao.insert(article);
}
</pre>

새글쓰기를 처리하는 write.jsp 파일을 만든다.

<em class="filename">/model1/write.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Article article = new Article();
	article.setTitle(title);
	article.setContent(content);
	
	BoardService service= new BoardService();
	service.write(article);
	
	response.sendRedirect("list.jsp");
%&gt;
</pre>

새글이 등록되는지 확인한다.
다음으로 상세보기 구현한다.
BoardDao 에 selectOne() 메소드를 추가한다.

<em class="filename">BoardDao.java  수정</em>
<pre class="prettyprint">
public Article selectOne(int no) {
	Log log = new Log();
	
	Article article = null;
	String sql = "SELECT no,family,depth,indent,title,content,wdate FROM board WHERE no = ?";
	
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	try {
		con = getConnection();
		stmt = con.prepareStatement(sql);
		stmt.setInt(1, no);
		rs = stmt.executeQuery();
		while (rs.next()) {
			article = new Article();
			article.setNo(rs.getInt("no"));
			article.setFamily(rs.getInt("family"));
			article.setDepth(rs.getInt("depth"));
			article.setIndent(rs.getInt("indent"));
			article.setTitle(rs.getString("title"));
			article.setContent(rs.getString("content"));
			article.setWriteDate(rs.getDate("wdate"));
		}
	} catch (SQLException e) {
		log.debug("Error Source : BoardDao.selectOne() : SQLException");
		log.debug("SQLState : " + e.getSQLState());
		log.debug("Message : " + e.getMessage());
		log.debug("Oracle Error Code : " + e.getErrorCode());
		log.debug("sql : " + sql);
	} finally {
		close(rs, stmt, con);
		log.close();
	}

	return article;
}
</pre>

<em class="filename">BoardService.java  수정</em>
<pre class="prettyprint">
public Article getArticle(int no) {
	return dao.selectOne(no);
}
</pre>

<em class="filename">/model1/view.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
int no = Integer.parseInt(request.getParameter("no"));
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");
if (keyword == null) keyword = "";
BoardService service = new BoardService();
Article article = service.getArticle(no);
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;상세보기&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function goModify(no,page,keyword) {
	location.href="modify_form.jsp?no=" + no + "&amp;page=" + page + "&amp;keyword=" + keyword;
}

function goDelete(no,page,keyword) {
	var check = confirm("정말로 삭제하겠습니까?");
	if (check) {
		location.href="del.jsp?no=" + no + "&amp;page=" + page + "&amp;keyword=" + keyword;
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;상세보기&lt;/h1&gt;
&lt;h2&gt;제목: &lt;%=article.getTitle() %&gt;, 작성일: &lt;%=article.getWriteDate() %&gt;&lt;/h2&gt;
&lt;p&gt;
&lt;%=article.getHtmlContent() %&gt;
&lt;/p&gt;
&lt;a href="list.jsp?page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;목록&lt;/a&gt;
&lt;input type="button" value="수정" onclick="javascript:goModify('&lt;%=no %&gt;','&lt;%=page %&gt;','&lt;%=keyword %&gt;')"&gt;
&lt;input type="button" value="삭제" onclick="javascript:goDelete('&lt;%=no %&gt;','&lt;%=page %&gt;','&lt;%=keyword %&gt;')"&gt;
&lt;a href="reply_form.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;답변쓰기&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

상세보기를 테스트한다.
다음으로 글수정 구현한다.
BoardDao 에 update() 메소드를 추가한다.

<em class="filename">BoardDao.java 수정</em>
<pre class="prettyprint">
public void update(Article article) {
	Log log = new Log();
	String sql = "UPDATE board SET title = ?, content = ? WHERE no = ?";		
	Connection con = null;
	PreparedStatement stmt = null;
	try {
		con = getConnection();
		stmt = con.prepareStatement(sql);
		stmt.setString(1, article.getTitle());
		stmt.setString(2, article.getContent());
		stmt.setInt(3, article.getno());
		stmt.executeUpdate();
	} catch (SQLException e) {
		log.debug("Error Source : BoardDao.update() : SQLException");
		log.debug("SQLState : " + e.getSQLState());
		log.debug("Message : " + e.getMessage());
		log.debug("Oracle Error Code : " + e.getErrorCode());
		log.debug("sql : " + sql);
	} finally {
		close(null, stmt, con);
		log.close();
	}
}
</pre>

<em class="filename">BoardService.java 수정</em>
<pre class="prettyprint">
public void modify(Article article) {
	dao.update(article);
}
</pre>

<em class="filename">/model1/modify_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*" %&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");

int no = Integer.parseInt(request.getParameter("no"));
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");

BoardService service = new BoardService();
Article article = service.getArticle(no);
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;!-- 본문 시작 --&gt;
&lt;h1&gt;수정&lt;/h1&gt;
&lt;form action="modify.jsp" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;"&gt;
&lt;input type="hidden" name="page" value="&lt;%=page %&gt;"&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;"&gt;
&lt;table&gt;
&lt;tr&gt;
	&lt;td&gt;제목&lt;/td&gt;
	&lt;td&gt;&lt;input type="text" name="title" size="50" value="&lt;%=article.getTitle() %&gt;" /&gt;&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;textarea name="content" rows="30" cols="100"&gt;&lt;%=article.getContent() %&gt;&lt;/textarea&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;tr&gt;
	&lt;td colspan="2"&gt;
		&lt;input type="submit" value="전송"&gt;
		&lt;input type="reset" value="취소"&gt;
		&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;상세보기&lt;/a&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;/form&gt;
&lt;!-- 본문 끝 --&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/model1/modify.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	int articleNo = Integer.parseInt(request.getParameter("articleNo"));
	String page = request.getParameter("page");
	String keyword = request.getParameter("keyword");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	Article article = new Article();
	article.setNo(articleNo);
	article.setTitle(title);
	article.setContent(content);
	
	BoardService service= new BoardService();
	service.modify(article);
	keyword = java.net.URLEncoder.encode(keyword,"UTF-8");
	response.sendRedirect("view.jsp?articleNo=" + articleNo + "&amp;page=" + page + "&amp;keyword=" +  keyword);
%&gt;
</pre>

글수정을 테스트한다.
다음으로 삭제 구현한다.
BoardDao 에 delete()메소드를 추가한다.

<em class="filename">BoardDao.java 수정</em>
<pre class="prettyprint">
public void delete(int no) {
	Log log = new Log();
	
	String sql1 = "SELECT count(*) FROM board WHERE parent = ?";
	String sql2 = "DELETE FROM board WHERE no = ?";
	
	Connection con = null;
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	ResultSet rs = null;
	
	boolean check = false; //true 면 삭제,false 면 삭제하지 않음
	
	try {
		con = getConnection();
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
	} catch (SQLException e) {
		log.debug("Error Source : BoardDao.delete() : SQLException");
		log.debug("SQLState : " + e.getSQLState());
		log.debug("Message : " + e.getMessage());
		log.debug("Oracle Error Code : " + e.getErrorCode());
		log.debug("sql : " + sql1);
	} finally {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {}
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (SQLException e) {}
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (SQLException e) {}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {}
		}
		log.close();
	}
}
</pre>

<em class="filename">BoardService.java 수정</em>
<pre class="prettyprint">
public void delete(int articleNo) {
	dao.delete(articleNo);
}
</pre>

<em class="filename">/model1/del.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
int no = Integer.parseInt(request.getParameter("no"));
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");

BoardService service= new BoardService();
service.delete(no);
keyword = java.net.URLEncoder.encode(keyword,"UTF-8");
response.sendRedirect("list.jsp?page=" + page + "&amp;keyword=" +  keyword);
%&gt;
</pre>

삭제를 테스트한다.
답변글이 있으면 삭제되지 않는다.
다음으로 답변쓰기를 구현한다.
BoardDao 에 다음 메소드를 추가한다.

<em class="filename">BoardDao 에 reply()메소드 추가</em>
<pre class="prettyprint">
public void reply(Article article) {
	Log log = new Log();
	//depth 갱신용 쿼리
	String sql1 = "UPDATE board SET depth = depth + 1 " + 
			"WHERE family = ? AND depth &gt; ? ";
	
	//답변쓰기용 쿼리
	String sql2 = "INSERT INTO board " + 
			"(no, family, parent, depth, indent, title, content, wdate) " + 
			"VALUES (board_no_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate)";
	Connection con = null;
	PreparedStatement stmt1 = null;
	PreparedStatement stmt2 = null;
	
	try {
		con = getConnection();
		con.setAutoCommit(false);
		
		stmt1 = con.prepareStatement(sql1);
		stmt1.setInt(1,article.getFamily());
		int depth = article.getDepth();
		stmt1.setInt(2,depth++);
		stmt1.executeUpdate();
		
		stmt2 = con.prepareStatement(sql2);
		stmt2.setInt(1, article.getFamily());
		stmt2.setInt(2, article.getParent());
		stmt2.setInt(3, depth);
		stmt2.setInt(4, article.getIndent());
		stmt2.setString(5, article.getTitle());
		stmt2.setString(6, article.getContent());
		stmt2.executeUpdate();
		
		con.commit();
	} catch (SQLException e) {
		try {
			con.rollback();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		log.debug("Error Source:BoardDao.reply() : SQLException");
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
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		log.close();
	}
}
</pre>

<em class="filename">BoardService 에 reply()메소드 추가</em>
<pre class="prettyprint">
public void reply(Article article) {
	dao.reply(article);
}
</pre>

<em class="filename">/model1/reply_form.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");

int no = Integer.parseInt(request.getParameter("no"));
String page = request.getParameter("page");
String keyword = request.getParameter("keyword");

BoardService service = new BoardService();
Article article = service.getArticle(no);
String content = article.getContent();

//부모글을  구별하기 위해 부모글의 각 행마다 &gt;가 추가되도록 한다.
content = content.replaceAll(Article.LINE_SEPARATOR, Article.LINE_SEPARATOR + "&gt;");
content = Article.LINE_SEPARATOR + Article.LINE_SEPARATOR + "&gt;" + content;
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;/head&gt;
&lt;body&gt;

&lt;h1&gt;답변쓰기&lt;/h1&gt;

&lt;form action="reply.jsp" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
&lt;input type="hidden" name="family" value="&lt;%=article.getFamily() %&gt;" /&gt;
&lt;input type="hidden" name="indent" value="&lt;%=article.getIndent() %&gt;" /&gt;
&lt;input type="hidden" name="depth" value="&lt;%=article.getDepth() %&gt;" /&gt;
&lt;input type="hidden" name="page" value="&lt;%=page %&gt;" /&gt;
&lt;input type="hidden" name="keyword" value="&lt;%=keyword %&gt;" /&gt;
제목 : &lt;input type="text" name="title" size="45" value="&lt;%=article.getTitle() %&gt;" /&gt;&lt;br /&gt;
&lt;textarea name="content" rows="10" cols="60"&gt;&lt;%=article.getContent() %&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="전송" /&gt;
&lt;input type="reset" value="취소" /&gt;&lt;br /&gt;
&lt;/form&gt;
&lt;a href="view.jsp?no=&lt;%=no %&gt;&amp;page=&lt;%=page %&gt;&amp;keyword=&lt;%=keyword %&gt;"&gt;상세보기&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/model1/reply.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.board.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");

// 파라미터를 받는다.
int parent = Integer.parseInt(request.getParameter("no"));
int family = Integer.parseInt(request.getParameter("family"));
int depth = Integer.parseInt(request.getParameter("depth"));
int indent = Integer.parseInt(request.getParameter("indent")) + 1;
String title = request.getParameter("title");
String content = request.getParameter("content");

String page = request.getParameter("page");
String keyword = request.getParameter("keyword");

Article article = new Article();
article.setParent(parent);
article.setFamily(family);
article.setDepth(depth);
article.setIndent(indent);
article.setTitle(title);
article.setContent(content);

BoardService service= new BoardService();
service.reply(article);

keyword = java.net.URLEncoder.encode(keyword,"UTF-8");
response.sendRedirect("list.jsp?page=" + page + "&amp;keyword=" + keyword);
%&gt;
</pre>

답변글을 테스트한다.
