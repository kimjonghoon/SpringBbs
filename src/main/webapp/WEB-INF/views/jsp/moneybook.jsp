<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2012.8.23</div>


<h1>가계부</h1>

<h2>1. 테이블과 시퀀스를 작성</h2>
<pre class="prettyprint">
create table moneybook (
    no  number,
    item    varchar2(100) NOT NULL,
    price   number,
    pdate   date,
    constraint PK_MONEYBOOK_NO primary key(no)
)
/
 
create sequence SEQ_MONEYBOOK_NO
start with 1
increment by 1
nocache
nocycle
/
</pre>
<h2>2. 자바 빈즈 설계</h2>
<em class="filename">Moneybook.java</em>
<pre class="prettyprint">
package net.java_school.moneybook;

public class Moneybook {
	private int no;
	private String item;
	private int price;
	private String pdate;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	
}
</pre>
<em class="filename">DataAccessException.java</em>
<pre class="prettyprint">
package net.java_school.moneybook;

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
<em class="filename">Log.java</em>
<pre class="prettyprint">
package net.java_school.util;

import java.io.*;
import java.util.Date;

public class Log {
	public String logFile = "D:/www/bbs/WEB-INF/debug.log";
	private static final String LINE_SEPARATOR = System.getProperty("line.separator");
	private FileWriter fw = null;
  
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
			fw.write(new Date() + " : ");
			fw.write(msg + LINE_SEPARATOR);
			fw.flush();
		} catch (IOException e) {
			System.err.println("IOException!");
		}
	}
	
}
</pre>
<em class="filename">MoneybookDao.java</em>
<pre class="prettyprint">
package net.java_school.moneybook;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import net.java_school.util.Log;

public class MoneybookDao {
	
	private static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	public MoneybookDao() {
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

	public ArrayList&lt;Moneybook&gt; selectByCondition(String startDate, String endDate, String searchWord) throws DataAccessException {
		
		ArrayList&lt;Moneybook&gt; books = new ArrayList&lt;Moneybook&gt;();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT no,item,price,to_char(pdate,'YYYY/MM/DD') pdate " +
				"FROM moneybook " +
				"WHERE pdate between to_date(?,'YYYY/MM/DD') AND to_date(?,'YYYY/MM/DD') ";
		if (searchWord != null &amp;&amp; !searchWord.equals("")) {
			sql = sql + " AND item like ? "; 
		}
		sql = sql + " ORDER BY pdate DESC,no DESC";
		
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			if (searchWord != null &amp;&amp; !searchWord.equals("")) {
				searchWord = "%" + searchWord + "%";
				pstmt.setString(3, searchWord);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Moneybook moneybook = new Moneybook();
				moneybook.setNo(rs.getInt("no"));
				moneybook.setItem(rs.getString("item"));
				moneybook.setPrice(rs.getInt("price"));
				moneybook.setPdate(rs.getString("pdate"));
				books.add(moneybook);
			}
		} catch (SQLException e) {
			log.debug("Error Source : MoneybookDao's selectByCondition() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			throw new DataAccessException(e.getMessage(), e);
		} finally {
			log.close();
			close(rs, pstmt, con);
		}
		
		return books;
	
	}

	public Moneybook selectOne(int no) throws DataAccessException {
		Moneybook moneybook = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT no,item,price,to_char(pdate,'YYYY/MM/DD') pdate FROM moneybook WHERE no = ?";
		
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				moneybook = new Moneybook();
				moneybook.setNo(rs.getInt("no"));
				moneybook.setItem(rs.getString("item"));
				moneybook.setPrice(rs.getInt("price"));
				moneybook.setPdate(rs.getString("pdate"));
			}
		} catch (SQLException e) {
			log.debug("Error Source : MoneybookDao's selectOne() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			throw new DataAccessException(e.getMessage(), e);
		} finally {
			log.close();
			close(rs, pstmt, con);
		}
		
		return moneybook;
	
	}
	
	public void insert(Moneybook moneybook) throws DataAccessException {
		Connection con = null;
		PreparedStatement pstmt = null;
		//순서 item,price,pdate
		String sql = "INSERT INTO moneybook VALUES (seq_moneybook_no.nextval, ?, ?, to_date(?, 'YYYY/MM/DD') )";
		
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, moneybook.getItem());
			pstmt.setInt(2, moneybook.getPrice());
			pstmt.setString(3, moneybook.getPdate());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source : MoneybookDao's insert() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			throw new DataAccessException(e.getMessage(), e);
		} finally {
			log.close();
			close(null, pstmt, con);
		}
	}

	public void update(Moneybook book) throws DataAccessException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE moneybook SET item = ?, price = ?, pdate = to_date(?, 'YYYY/MM/DD')  WHERE no = ?";
		
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, book.getItem());
			pstmt.setInt(2, book.getPrice());
			pstmt.setString(3, book.getPdate());
			pstmt.setInt(4, book.getNo());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source : MoneybookDao's update() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			throw new DataAccessException(e.getMessage(), e);
		} finally {
			log.close();
			close(null, pstmt, con);
		}
	}
	
	public void delete(int no) throws DataAccessException {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "DELETE FROM moneybook WHERE no = ?";
		
		Log log = new Log();
		
		try {
			con = getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			log.debug("Error Source : MoneybookDao's delete() 메소드");
			log.debug("SQLState : " + e.getSQLState());
			log.debug("Message : " + e.getMessage());
			log.debug("Oracle Error Code : " + e.getErrorCode());
			log.debug("sql : " + sql);
			throw new DataAccessException(e.getMessage(), e);
		} finally {
			log.close();
			close(null, pstmt, con);
		}
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

}
</pre>
<h2>3.JSP 작성</h2>
<em class="filename">index.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.moneybook.*" %&gt;
&lt;%@ page import="java.util.ArrayList" %&gt;
&lt;%@ page import="java.util.Calendar" %&gt;
<strong>&lt;%@ page import="java.text.NumberFormat" %&gt;</strong>    
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");

	String yr = request.getParameter("yr");
	String mon = request.getParameter("mon");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String searchWord = request.getParameter("searchWord");
	
	Calendar cal = null;
	int year = 0;
	int month = -1;
	int endDay = 0;
	
	cal = Calendar.getInstance();
	if (yr == null || yr.equals("")) {
		year = cal.get(Calendar.YEAR);
	} else {
		int y = Integer.parseInt(yr);
		cal.set(Calendar.YEAR, y);
		year = cal.get(Calendar.YEAR);
	}
	
	if (mon == null) {
		month = cal.get(Calendar.MONTH) + 1;
		endDay = cal.getActualMaximum(Calendar.DATE);
	} else {
		int m = Integer.parseInt(mon);
		cal.set(Calendar.MONTH, m - 1);
		month = m;
		endDay = cal.getActualMaximum(Calendar.DATE);
	}
	
	if (startDate == null || startDate.equals("")) {
		startDate = year + "/" + month + "/" + 1;
	}
	if (endDate == null || endDate.equals("")) {
		endDate = year + "/" + month + "/" + endDay;
	}

	MoneybookDao dao = new MoneybookDao();
	ArrayList&lt;Moneybook&gt; list = dao.selectByCondition(startDate, endDate, searchWord);
	
	<strong>NumberFormat nf = NumberFormat.getInstance();</strong>
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;가계부&lt;/title&gt;
&lt;script type="text/javascript"&gt;
	function goDelete(no) {
		var check = confirm("정말로 삭제하겠습니까?");
		if (check) {
			location.href='del.jsp?no='+no;
		}
	}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;가계부&lt;/h1&gt;
&lt;h2&gt;&lt;%=startDate %&gt; ~ &lt;%=endDate %&gt;&lt;/h2&gt;
&lt;table border="1"&gt;
	&lt;tr&gt;
		&lt;td&gt;날짜&lt;/td&gt;
		&lt;td&gt;사용내역&lt;/td&gt;
		&lt;td&gt;금액&lt;/td&gt;
		&lt;td&gt;관리&lt;/td&gt;
	&lt;/tr&gt;
&lt;%
int total = 0;
int size = list.size();
for(int i=0;i &lt; size;i++) {
	Moneybook book = list.get(i);
	int price = book.getPrice();
	total = total + price;
%&gt;	
	&lt;tr&gt;
		&lt;td&gt;&lt;%=book.getPdate() %&gt;&lt;/td&gt;
		&lt;td&gt;&lt;%=book.getItem() %&gt;&lt;/td&gt;
		&lt;td&gt;&lt;%=<strong>nf.format(price)</strong> %&gt;&lt;/td&gt;
		&lt;td&gt;
			&lt;input type="button" value="수정" onclick="location.href='modify.jsp?no=&lt;%=book.getNo() %&gt;'" /&gt;
			&lt;input type="button" value="삭제" onclick="javascript:goDelete('&lt;%=book.getNo() %&gt;')" /&gt;
		&lt;/td&gt;
	&lt;/tr&gt;
&lt;%
}
%&gt;
	&lt;tr&gt;
		&lt;td colspan="2"&gt;합계&lt;/td&gt;
		&lt;td colspan="2"&gt;&lt;%=<strong>nf.format(total)</strong> %&gt;&lt;/td&gt;
	&lt;/tr&gt;	
&lt;/table&gt;
&lt;p&gt;
&lt;input type="button" value="사용내역추가" onclick="location.href='add.jsp'" /&gt;
&lt;/p&gt;
&lt;form action="./" method="post"&gt;
	기간&lt;input type="text" name="startDate" size="10" /&gt; ~ 
	&lt;input type="text" name="endDate" size="10" /&gt;, 검색어
	&lt;input type="text" name="searchWord" size="12" /&gt;
	&lt;input type="submit" value="검색" /&gt;&lt;br /&gt;
	년도
	&lt;select name="yr"&gt;
		&lt;option value="2012"&gt;2012&lt;/option&gt;
	&lt;/select&gt;&lt;br /&gt;
	&lt;input type="radio" name="mon" value="1" id="Jan" /&gt;&lt;label for="Jan"&gt;1월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="2" id="Feb" /&gt;&lt;label for="Feb"&gt;2월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="3" id="Mar" /&gt;&lt;label for="Mar"&gt;3월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="4" id="Apr" /&gt;&lt;label for="Apr"&gt;4월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="5" id="May" /&gt;&lt;label for="May"&gt;5월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="6" id="Jun" /&gt;&lt;label for="Jun"&gt;6월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="7" id="Jul" /&gt;&lt;label for="Jul"&gt;7월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="8" id="Aug" /&gt;&lt;label for="Aug"&gt;8월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="9" id="Sep" /&gt;&lt;label for="Sep"&gt;9월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="10" id="Oct" /&gt;&lt;label for="Oct"&gt;10월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="11" id="Nov" /&gt;&lt;label for="Nov"&gt;11월&lt;/label&gt;
	&lt;input type="radio" name="mon" value="12" id="Dec" /&gt;&lt;label for="Dec"&gt;12월&lt;/label&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">add.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.*" %&gt;
&lt;%
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	int day = cal.get(Calendar.DAY_OF_MONTH);
	
	String payDate = year + "/" + month + "/" + day;
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;사용내역 추가&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;가계부 | 사용내역 추가&lt;/h1&gt;

&lt;form action="add_proc.jsp" method="post"&gt;
날짜 : &lt;input type="text" name="pdate" value="&lt;%=payDate %&gt;" /&gt;(2012/1/1 형식으로 입력)&lt;br /&gt;
사용내역 : &lt;input type="text" name="item" /&gt;&lt;br /&gt;
금액 : &lt;input type="text" name="price" /&gt;&lt;br /&gt;
&lt;input type="submit" value="확인" /&gt;
&lt;input type="button" value="취소" onclick="location.href='./'" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
<em class="filename">add_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.moneybook.*" %&gt;    
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	String pdate = request.getParameter("pdate");
	String item = request.getParameter("item");
	int price = Integer.parseInt(request.getParameter("price"));
	
	Moneybook book = new Moneybook();
	book.setPdate(pdate);
	book.setItem(item);
	book.setPrice(price);
	
	MoneybookDao dao = new MoneybookDao();
	dao.insert(book);

	response.sendRedirect("./");
%&gt;
</pre>
<em class="filename">modify.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.moneybook.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	int no = Integer.parseInt(request.getParameter("no"));
	MoneybookDao dao = new MoneybookDao();
	Moneybook book = dao.selectOne(no);
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;사용내역 수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;가계부 | 사용내역 수정&lt;/h1&gt;
&lt;form action="modify_proc.jsp" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=no %&gt;" /&gt;
날짜 : &lt;input type="text" name="pdate" value="&lt;%=book.getPdate() %&gt;" /&gt;&lt;br /&gt;
사용내역 : &lt;input type="text" name="item" value="&lt;%=book.getItem() %&gt;" /&gt;&lt;br /&gt;
금액 : &lt;input type="text" name="price" value="&lt;%=book.getPrice() %&gt;" /&gt;&lt;br /&gt;
&lt;input type="submit" value="확인" /&gt;
&lt;input type="button" value="취소" onclick="location.href='./'" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
<em class="filename">modify_proc.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.moneybook.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	int no = Integer.parseInt(request.getParameter("no"));
	String item = request.getParameter("item");
	int price = Integer.parseInt(request.getParameter("price"));
	String pdate = request.getParameter("pdate");
	
	Moneybook book = new Moneybook();
	book.setNo(no);
	book.setItem(item);
	book.setPrice(price);
	book.setPdate(pdate);
	
	MoneybookDao dao = new MoneybookDao();
	dao.update(book);
	
	response.sendRedirect("./");
%&gt;
</pre>
<em class="filename">del.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="net.java_school.moneybook.*" %&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;%
	int no = Integer.parseInt(request.getParameter("no"));
	MoneybookDao dao = new MoneybookDao();
	dao.delete(no);

	response.sendRedirect("./");
%&gt;
</pre>
