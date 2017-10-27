<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2012.8.21</div>

<h1>방명록</h1>

<h2>화면</h2>
<img src="images/guestbook.png" alt="방명록 화면" />
<h2>테이블과 시퀀스를 작성</h2>
<pre class="prettyprint">
create table guestbook (
    no  number,
    memo  varchar2(4000) NOT NULL,
    ip   varchar2(30) NOT NULL,
    wdate   date,
    constraint PK_GUESTBOOK_NO primary key(no)
);
 
create sequence SEQ_GUESTBOOK_NO
start with 1
increment by 1
nocache
nocycle;
</pre>
<h2>자바 빈즈 설계</h2>
<em class="filename">Guestbook.java</em>
<pre class="prettyprint">
package net.java_school.guestbook;

public class Guestbook {
	private int no;
	private String memo;
	private String ip;
	private String wdate;
	private static final String ENTER = System.getProperty("line.separator");
	
	public Guestbook() {}
	public Guestbook(String memo, String ip) {
		this.memo = memo;
		this.ip = ip;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getWdate() {
		return wdate;
	}
	public void setWdate(String wdate) {
		this.wdate = wdate;
	}
	public String getHtmlMemo() {
		return memo.replaceAll(ENTER, "&lt;br /&gt;");
	}
}
</pre>

<em class="filename">GuestbookDao.java</em>
<pre class="prettyprint">
package net.java_school.guestbook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GuestbookDao {
	private static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public GuestbookDao() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private Connection getConnection() throws SQLException {
		Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
		return con;
	}
	
	private void close(ResultSet rs, PreparedStatement pstmt, Connection con) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		if (pstmt != null) {
			try {
				pstmt.close();
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
	
	/*
	 * 방명록을 등록하는 메소드
	 */
	public void insert(Guestbook guestbook) {
		//TODO
	}
	
	/*
	 * 방명록 레코드 모두를 가져오는 메소드
	 */
	public ArrayList&lt;Guestbook&gt; selectAll() {
		ArrayList&lt;Guestbook&gt; all = new ArrayList&lt;Guestbook&gt;();
		//TODO
		return all;
	}
	
}
</pre>
<em class="filename">insert() 메소드 구현</em>
<pre class="prettyprint">
/*
 * 방명록을 등록하는 메소드
 */
public void insert(Guestbook guestbook) {
	String sql = "INSERT INTO guestbook VALUES (seq_guestbook_no.nextval,?,?,sysdate)";
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, guestbook.getMemo());
		pstmt.setString(2, guestbook.getIp());
		pstmt.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
		System.err.println(sql);
	} finally {
		close(null, pstmt, con);
	}
	
}
</pre>
<em class="filename">selectAll() 메소드 구현</em>
<pre class="prettyprint">
	/*
	 * 방명록 레코드 모두를 가져오는 메소드
	 */
	public ArrayList&lt;Guestbook&gt; selectAll() {
		ArrayList&lt;Guestbook&gt; all = new ArrayList&lt;Guestbook&gt;();
		String sql = "SELECT no,memo,ip," +
				"to_char(wdate,'YYYY/MM/DD HH:MI:SS') wdate " +
				"FROM guestbook " +
				"ORDER BY no DESC";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Guestbook book = new Guestbook();
				book.setNo(rs.getInt("no"));
				book.setMemo(rs.getString("memo"));
				book.setIp(rs.getString("ip"));
				book.setWdate(rs.getString("wdate"));
				all.add(book);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			System.err.println(sql);
		} finally {
			close(rs, pstmt, con);
		}
		
		return all;
	
	}
</pre>
<h2>JSP 작성</h2>
웹 애플리케이션의 최상위 디렉토리에서 guestbook 이라는 서브 디렉토리를 만든다.<br />
<em class="filename">/guestbook/index.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.ArrayList" %&gt;
&lt;%@ page import="net.java_school.guestbook.*" %&gt;
&lt;%
	GuestbookDao dao = new GuestbookDao();
	ArrayList&lt;Guestbook&gt; all = dao.selectAll();
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;style type="text/css"&gt;
.guestbook {
	margin: 10px 0;
	border: 1px solid #333;
}
.guestbook p {
 	margin: 0;
 	padding: 7px;
 }
 &lt;/style&gt;
&lt;title&gt;방명록&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;방명록에 글 남겨주세요&lt;/h1&gt;
&lt;form action="write.jsp" method="post"&gt;
&lt;textarea rows="5" cols="40" name="memo"&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="글남기기" /&gt;
&lt;/form&gt;
&lt;%
	int size = all.size();
	for (int i = 0; i &lt; size; i++) {
		Guestbook book = all.get(i);	
%&gt;
&lt;div class="guestbook"&gt;
&lt;p&gt;&lt;%=book.getHtmlMemo() %&gt;&lt;/p&gt;
&lt;p style="text-align: right;"&gt;
&lt;%=book.getWdate() %&gt;, 
IP: &lt;%=book.getIp() %&gt;
&lt;/p&gt;
&lt;/div&gt;
&lt;%
	}
%&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">write.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.guestbook.*" %&gt;
&lt;%
request.setCharacterEncoding("UTF-8");
String memo = request.getParameter("memo");
String ip = request.getRemoteAddr();
Guestbook book = new Guestbook(memo, ip);

GuestbookDao dao = new GuestbookDao();
dao.insert(book);
%&gt;    
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;방명록 쓰기&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
방명록을 성공적으로 등록했습니다. &lt;a href="./"&gt;목록으로&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
<h2>Logging</h2>
디버깅을 위해 톰캣 로그파일을 뒤지는 것은 쉽지 않다.<br />
<em class="filename">Log.java</em>
<pre class="prettyprint">
package net.java_school.util;

import java.io.*;
import java.util.Date;

public class Log {
	public String logFile = "D:/www/bbs/WEB-INF/debug.log";
	private static final String LINE_SEPARATOR = System.getProperty("line.separator");
	FileWriter fw = null;
  
	public Log() {
		try {
			fw = new FileWriter(logFile, true);
		} catch (IOException e){}
	}

	public void close() {
		try {
			fw.close();
		} catch (IOException e){}
	}

	public void debug(String msg) {
		try {
			fw.write(new Date()+ " : ");
			fw.write(msg + LINE_SEPARATOR);
			fw.flush();
		} catch (IOException e) {
			System.err.println("IOException!");
		}
	}
	
}
</pre>
<em class="filename">GuestbookDao.java 수정</em>
<pre class="prettyprint">
/*
 * 방명록을 등록하는 메소드
 */
public void insert(Guestbook guestbook) {
	String sql = "INSERT INTO guestbook VALUES (seq_guestbook_no.nextval, ?, ?, sysdate)";
	Connection con = null;
	PreparedStatement pstmt = null;
	<strong>Log log = new Log();</strong>
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, guestbook.getMemo());
		pstmt.setString(2, guestbook.getIp());
		pstmt.executeUpdate();
	} catch (SQLException e) {
		<strong>log.debug("Error Source : GuestbookDao's insert() 메소드");
		log.debug("SQLState : " + e.getSQLState());
		log.debug("Message : " + e.getMessage());
		log.debug("Oracle Error Code : " + e.getErrorCode());
		log.debug("sql : " + sql);</strong>
	} finally {
		<strong>log.close();</strong>
		close(null, pstmt, con);
	}
	
}

/*
 * 방명록 레코드 모두를 가져오는 메소드
 */
public ArrayList&lt;Guestbook&gt; selectAll() {
	ArrayList&lt;Guestbook&gt; all = new ArrayList&lt;Guestbook&gt;();
	String sql = "SELECT no,memo,ip," +
			"to_char(wdate,'YYYY/MM/DD HH:MI:SS') wdate " +
			"FROM guestbook " +
			"ORDER BY no DESC";
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	<strong>Log log = new Log();</strong>
	
	try {
		con = getConnection();
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
			Guestbook book = new Guestbook();
			book.setNo(rs.getInt("no"));
			book.setMemo(rs.getString("memo"));
			book.setIp(rs.getString("ip"));
			book.setWdate(rs.getString("wdate"));
			all.add(book);
		}
	} catch (SQLException e) {
		<strong>log.debug("Error Source : GuestbookDao's selectAll() 메소드");
		log.debug("SQLState : " + e.getSQLState());
		log.debug("Message : " + e.getMessage());
		log.debug("Oracle Error Code : " + e.getErrorCode());
		log.debug("sql : " + sql);</strong>
	} finally {
		<strong>log.close();</strong>
		close(rs, pstmt, con);
	}
	
	return all;

}
</pre> 
<h2>Exception 처리</h2>
Exception 처리는 Logging 정책과 함께 애플리케이션 전 영역에 적용되므로 프로젝트 초반에 정책이 수립되어야 한다.<br />
여기서는 GuestbookDao 의 모든 메소드에서 실행중 에러가 발생하면 unchecked 익셉션을 생성하여 던지도록 코드를 변경한다.<br />   
전달된 익셉션을 JSP페이지에서 직접 핸들링 할 수도 있지만 핸들링 하지 않고 서블릿 컨테이너가 제공하는 에러 처리 기능을 활용하여 처리되도록
한다.<br />

<em class="filename">web.xml 추가</em>
<pre class="prettyprint">
&lt;error-page&gt;
	&lt;error-code&gt;404&lt;/error-code&gt;
	&lt;location&gt;/404.jsp&lt;/location&gt;
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
<em class="filename">DataAccessException.java</em>
<pre class="prettyprint">
package net.java_school.guestbook;

public class DataAccessException extends RuntimeException {

	public DataAccessException() {
		super();
	}

	public DataAccessException(String message, Throwable cause) {
		super(message, cause);
	}

	public DataAccessException(String message) {
		super(message);
	}

	public DataAccessException(Throwable cause) {
		super(cause);
	}

}
</pre>
<em class="filename">GuestbookDao.java 수정</em>
<pre class="prettyprint">
	/*
	 * 방명록을 등록하는 메소드
	 */
	public void insert(Guestbook guestbook) <strong>throws DataAccessException</strong> {
		String sql = "INSERT INTO guestbook VALUES (seq_guestbook_no.nextval, ?, ?, sysdate)";
		Connection con = null;
		PreparedStatement pstmt = null;
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, guestbook.getMemo());
			pstmt.setString(2, guestbook.getIp());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source : GuestbookDao's insert() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			<strong>throw new DataAccessException(e.getMessage(), e);</strong>
		} finally {
			log.close();
			close(null, pstmt, con);
		}
		
	}
	
	/*
	 * 방명록 레코드 모두를 가져오는 메소드
	 */
	public ArrayList&lt;Guestbook&gt; selectAll() <strong>throws DataAccessException</strong> {
		ArrayList&lt;Guestbook&gt; all = new ArrayList&lt;Guestbook&gt;();
		String sql = "SELECT no,memo,ip," +
				"to_char(wdate,'YYYY/MM/DD HH:MI:SS') wdate " +
				"FROM guestbook " +
				"ORDER BY no DESC";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Guestbook book = new Guestbook();
				book.setNo(rs.getInt("no"));
				book.setMemo(rs.getString("memo"));
				book.setIp(rs.getString("ip"));
				book.setWdate(rs.getString("wdate"));
				all.add(book);
			}
		} catch (SQLException e) {
			log.debug("Error Source : GuestbookDao's selectAll() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			<strong>throw new DataAccessException(e.getMessage(), e);</strong>
		} finally {
			log.close();
			close(rs, pstmt, con);
		}
		
		return all;
	
	}
</pre>
<em class="filename">/404.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;404&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;페이지를 찾을 수 없습니다.&lt;/h1&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">/error.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;에러 페이지&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;%=request.getAttribute("javax.servlet.error.message") %&gt;
&lt;pre&gt;
&lt;/pre&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
