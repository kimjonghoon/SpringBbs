<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified" class="floatstop">Last Modified : 2014.6.30</div>

<h1>모델2 명함관리</h1>

<h2>테이블,시퀀스</h2>
<pre class="code">
CREATE TABLE namecard (
    no  NUMBER,                       -- 고유번호
    name    VARCHAR2(20) NOT NULL,    -- 이름
    mobile  VARCHAR2(20) NOT NULL,    -- 손전화
    email   VARCHAR2(30),             -- 이메일
    mdate   DATE,                     -- 만난 날짜
    CONSTRAINT pk_namecard_no PRIMARY KEY(no)
);
 
CREATE SEQUENCE seq_namecard_no
INCREMENT BY 1
START WITH 1;

--명함추가
insert into namecard values (
	seq_namecard_no.nextval,
	'박지성',
	'010-1111-1111',
	'park@qpr.com',
	to_date('2013/5/31','YYYY/MM/DD'));
	
commit;	
</pre>

<h2>JSP 파일</h2>
웹애플리케이션의 최상위 디렉토리(Document Base) 에서 card 라는 서브 디렉토리를 만들고 그곳에 아래 JSP 파일을 만든다.
 
<em class="filename">list.jsp</em>
<pre class="code">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.util.ArrayList" %&gt;
&lt;%@ page import="com.google.namecard.vo.CardListVO" %&gt;
&lt;%@ page import="com.google.namecard.Namecard" %&gt;
&lt;%
	CardListVO vo = (CardListVO)request.getAttribute("listVo");
	ArrayList&lt;Namecard&gt; list = vo.getList();
	int prevPage = vo.getPrevPage(); //[이전] 페이지 번호  
	int nextPage = vo.getNextPage(); //[다음] 페이지 번호
	int firstPage = vo.getFirstPage(); //for문 첫번째 페이지 번호
	int lastPage = vo.getLastPage(); //for문 마지막 페이지 번호
	int curPage = vo.getCurPage(); //현재 페이지 번호(요청 페이지 번호)
	String searchWord = vo.getSearchWord(); //검색어
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함목록&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function modify(no) {
	var form = document.getElementById("modifyForm");
	form.no.value = no;
	form.submit();
}
function del(no) {
	var check = confirm("정말로 삭제하겠습니까?");
	if (check) {
		var form = document.getElementById("deleteForm");
		form.no.value = no;
		form.submit();
	}
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;명함목록&lt;/h1&gt;
&lt;table border="1"&gt;
&lt;tr&gt;
	&lt;th&gt;번호&lt;/th&gt;
	&lt;th&gt;이름&lt;/th&gt;
	&lt;th&gt;모바일&lt;/th&gt;
	&lt;th&gt;이메일&lt;/th&gt;
	&lt;th&gt;만난날짜&lt;/th&gt;
	&lt;th&gt;관리&lt;/th&gt;
&lt;/tr&gt;
&lt;!--  반복부분 시작 --&gt;
&lt;%
	int size = list.size();
	for (int i = 0; i &lt; size; i++) {
		Namecard card = list.get(i);
%&gt;
&lt;tr&gt;
	&lt;td&gt;&lt;%=card.getNo() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getName() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getMobile() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getEmail() %&gt;&lt;/td&gt;
	&lt;td&gt;&lt;%=card.getMdate() %&gt;&lt;/td&gt;
	&lt;td&gt;
		&lt;input type="button" value="수정" onclick="modify('&lt;%=card.getNo() %&gt;')" /&gt;
		&lt;input type="button" value="삭제" onclick="del('&lt;%=card.getNo() %&gt;')" /&gt;
	&lt;/td&gt;
&lt;/tr&gt;
&lt;%
	}//for 문 끝
%&gt;
&lt;!--  반복부분 끝 --&gt;
&lt;tr&gt;
	&lt;td colspan="6"&gt;
&lt;%
	if (prevPage &gt; 0) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=prevPage %&gt;&amp;searchWord=&lt;%=searchWord %&gt;"&gt;[이전]&lt;/a&gt;
&lt;%		
	}
	for (int i = firstPage; i &lt;= lastPage; i++) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=i %&gt;&amp;searchWord=&lt;%=searchWord %&gt;"&gt;&lt;%=i %&gt;&lt;/a&gt;
&lt;%
	}//for statement end
	if (nextPage &gt; 0) {
%&gt;
	&lt;a href="list.do?curPage=&lt;%=nextPage %&gt;&amp;searchWord=&lt;%=searchWord %&gt;"&gt;[다음]&lt;/a&gt;
&lt;%
	}
%&gt;	
	&lt;/td&gt;
&lt;/tr&gt;
&lt;/table&gt;
&lt;form action="list.do" method="post"&gt;
&lt;input type="button" value="명함추가" onclick="location.href='add.do?curPage=&lt;%=curPage %&gt;&amp;searchWord=&lt;%=searchWord %&gt;'" /&gt;
&lt;input type="text" name="searchWord" /&gt;
&lt;input type="submit" value="검색" /&gt;
&lt;/form&gt;

&lt;!-- 수정화면으로 no,curPage,searchWord를 전송하기 위한 폼--&gt;
&lt;form id="modifyForm" action="modify.do" method="post"&gt;
&lt;input type="hidden" name="no" /&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;" /&gt;
&lt;input type="hidden" name="searchWord" value="&lt;%=searchWord %&gt;" /&gt;	
&lt;/form&gt;

&lt;!-- 삭제액션으로 no,curPage,searchWord를 전송하기 위한 폼--&gt;
&lt;form id="deleteForm" action="delAction.do" method="post"&gt;
&lt;input type="hidden" name="no" /&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;" /&gt;
&lt;input type="hidden" name="searchWord" value="&lt;%=searchWord %&gt;" /&gt;	
&lt;/form&gt;

&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">add.jsp</em>
<pre class="code">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%
	String curPage = request.getParameter("curPage");
	String searchWord = request.getParameter("searchWord");
	if (searchWord == null) searchWord = "";
	out.println("curPage :" +curPage);
	out.println("searchWord :" +searchWord);
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함추가&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;명함추가&lt;/h1&gt;
&lt;form action="addAction.do" method="post"&gt;
이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
모바일 &lt;input type="text" name="mobile" /&gt;&lt;br /&gt;
이메일 &lt;input type="text" name="email" /&gt;&lt;br /&gt;
만난날짜 &lt;input type="text" name="mdate" /&gt;(2013/05/05 형식으로)&lt;br /&gt;
&lt;input type="submit" value="전송" /&gt;
&lt;input type="button" value="목록으로" onclick="location.href='list.do?curPage=&lt;%=curPage %&gt;&amp;searchWord=&lt;%=searchWord %&gt;'" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">modify.jsp</em>
<pre class="code">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;%@ page import="com.google.namecard.Namecard" %&gt;
&lt;%
	String curPage = request.getParameter("curPage");
	String searchWord = request.getParameter("searchWord");
	if (searchWord == null) searchWord = "";
	Namecard card = (Namecard) request.getAttribute("card");
%&gt;
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;명함수정&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form action="modifyAction.do" method="post"&gt;
&lt;input type="hidden" name="no" value="&lt;%=card.getNo() %&gt;" /&gt;
&lt;input type="hidden" name="curPage" value="&lt;%=curPage %&gt;" /&gt;
&lt;input type="hidden" name="searchWord" value="&lt;%=searchWord %&gt;" /&gt;
이름 &lt;input type="text" name="name" value="&lt;%=card.getName() %&gt;" /&gt;&lt;br /&gt;
모바일 &lt;input type="text" name="mobile" value="&lt;%=card.getMobile() %&gt;" /&gt;&lt;br /&gt;
이메일 &lt;input type="text" name="email" value="&lt;%=card.getEmail() %&gt;" /&gt;&lt;br /&gt;
만난날짜 &lt;input type="text" name="mdate" value="&lt;%=card.getMdate() %&gt;" /&gt;&lt;br /&gt;
&lt;input type="submit" value="수정" /&gt;
&lt;input type="button" value="목록으로" onclick="location.href='list.do?curPage=&lt;%=curPage %&gt;&amp;searchWord=&lt;%=searchWord %&gt;'" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h2>자바 빈즈</h2>
<em class="filename">Namecard.java</em>
<pre class="code">
package com.google.namecard;

public class Namecard {
	private int no;
	private String name;
	private String mobile;
	private String email;
	private String mdate;

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMdate() {
		return mdate;
	}
	public void setMdate(String mdate) {
		this.mdate = mdate;
	}
	
}
</pre>


<em class="filename">NamecardDao.java</em>
<pre class="code">
package com.google.namecard;

import java.sql.Connection;  
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class NamecardDao {
	private DataSource ds;
	
	public NamecardDao () {
		try {
		    Context init = new InitialContext();
		    ds  = (DataSource) init.lookup("java:comp/env/jdbc/scott");
		  } catch (NamingException e) {
		    System.out.println(e.getMessage());
		  }
	}
	
	//명함추가한다.
	public void insert(Namecard card) {
		String sql = "INSERT INTO namecard " +
				"values " +
				"(seq_namecard_no.nextval,?,?,?," +
				"to_date(?,'YYYY/MM/DD'))";
		Connection con=null;
		PreparedStatement pstmt=null;
		try{
			con=ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, card.getName());
			pstmt.setString(2, card.getMobile());
			pstmt.setString(3, card.getEmail());
			pstmt.setString(4, card.getMdate());
			pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, pstmt, con);
		}
		
	}
	
	//명함수정한다.
	public void update(Namecard card) {
		String sql="UPDATE namecard " +
				"SET name = ?," +
					"mobile = ?, " +
					"email = ?, " +
					"mdate = to_date(?,'YYYY/MM/DD') " +
				"WHERE no = ?";
		Connection con = null;
		PreparedStatement pstmt = null;
		try{
			con=ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, card.getName());
			pstmt.setString(2, card.getMobile());
			pstmt.setString(3, card.getEmail());
			pstmt.setString(4, card.getMdate());
			pstmt.setInt(5, card.getNo());
			pstmt.executeUpdate();
		}catch(SQLException e){
			System.out.println(sql);
			e.printStackTrace();
		}finally{
			close(null, pstmt, con);
		}
	}
	
	//명함삭제한다.
	public void delete(int no) {
		String sql = "DELETE FROM namecard WHERE no = ?";
		Connection con = null;
		PreparedStatement stmt = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, no);
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(null, stmt, con);
		}
	}
	
	//명함목록출력(검색하지 않음)
	public ArrayList&lt;Namecard&gt; select(int page, int numberPerPage) {
		ArrayList&lt;Namecard&gt; list = 
				new ArrayList&lt;Namecard&gt;();
		String sql = "select no,name,mobile,email,mdate " + 
		"from " + 
		"(select rownum r,A.* " + 
		"from " +  
		"(select no,name,mobile,email," +
		"to_char(mdate,'YYYY/MM/DD') mdate " + 
		"from namecard " + 
		"order by no desc) A) " + 
		"where r between ? and ?";
		int startRow = (page - 1) * numberPerPage + 1;//1
		int endRow = page * numberPerPage;//10
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Namecard card = new Namecard();
				card.setNo(rs.getInt("no"));
				card.setName(rs.getString("name"));
				card.setMobile(rs.getString("mobile"));
				card.setEmail(rs.getString("email"));
				card.setMdate(rs.getString("mdate"));
				list.add(card);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return list;
	}
	//명함목록출력(검색함)
	public ArrayList&lt;Namecard&gt; selectBykeyword(
			int page, int limit, String keyword) {
		ArrayList&lt;Namecard&gt; matched = 
				new ArrayList&lt;Namecard&gt;();
		String sql = "select no,name,mobile,email,mdate " +
		"from " +
		"( " +
		"select rownum r,A.* " +
		"from " + 
		"(select no,name,mobile,email," +
		"	to_char(mdate,'YYYY/MM/DD') mdate " +
		"from namecard " +
		"where name like ? or " +
		"	mobile like ? or " +
		"	email like ? " +		
		"order by no desc) A " +
		") " +
		"where r between ? and ?";
		
		
		keyword = "%" + keyword + "%";
		int startRow = (page - 1) * limit + 1;
		int endRow = page * limit;
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try{
			con=ds.getConnection();
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			pstmt.setString(2, keyword);
			pstmt.setString(3, keyword);
			pstmt.setInt(4, startRow);
			pstmt.setInt(5, endRow);
			rs=pstmt.executeQuery();
			while(rs.next()){
				Namecard card=new Namecard();
				card.setNo(rs.getInt("no"));
				card.setName(rs.getString("name"));
				card.setMobile(rs.getString("mobile"));
				card.setEmail(rs.getString("email"));
				card.setMdate(rs.getString("mdate"));
				matched.add(card);
			}
		}catch(SQLException e){
			System.out.println(sql);
			e.printStackTrace();
		} finally {
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
				
		return matched;
	}
	//총명함수 구하기
	public int getTotalRecord() {
		int totalRecord = 0;
		String sql = "SELECT count(*) FROM namecard";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return totalRecord;
	}
	
	public int getTotalRecord(String searchWord) {
		int totalRecord = 0;
		searchWord="%"+searchWord+"%";
		String sql = "SELECT count(*) FROM namecard " +
				     "where name like ? " +
				     "or mobile  like? or email like ? ";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, searchWord);
			pstmt.setString(2, searchWord);
			pstmt.setString(3, searchWord);
			rs = pstmt.executeQuery();
			rs.next();
			totalRecord = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, pstmt, con);
		}
		return totalRecord;
	}
	
	// 명함을 no로 찾아 반환한다.
	public Namecard selectOne(int no) {
		Namecard card = null;
		String sql = "SELECT " +
				"no,name,mobile,email," +
				"to_char(mdate,'YYYY/MM/DD') mdate " +
				"FROM namecard " +
				"WHERE no = ?";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, no);
			rs = stmt.executeQuery();
			if (rs.next()) {
				card = new Namecard();
				card.setNo(rs.getInt("no"));
				card.setName(rs.getString("name"));
				card.setMobile(rs.getString("mobile"));
				card.setEmail(rs.getString("email"));
				card.setMdate(rs.getString("mdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs, stmt, con);
		}
		return card;
	}
	
	
	private void close(ResultSet rs, Statement stmt, Connection con) {
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
}
</pre>

<h2>액션</h2>

<em class="filename">Action.java</em>
<pre class="code">
package kr.or.iei.action;

import javax.servlet.http.HttpServletRequest;

public interface Action {
	public void execute(HttpServletRequest request);
}
</pre>

<em class="filename">NamecardAddAction.java</em>
<pre class="code">
package com.google.namecard.action;

import javax.servlet.http.HttpServletRequest;

import com.google.namecard.Namecard;
import com.google.namecard.NamecardDao;

import kr.or.iei.action.Action;

public class NamecardAddAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		String mdate = request.getParameter("mdate");
		
		Namecard card = new Namecard();
		card.setName(name);
		card.setMobile(mobile);
		card.setEmail(email);
		card.setMdate(mdate);

		NamecardDao dao = new NamecardDao();
		dao.insert(card);

	}

}
</pre>


<em class="filename">NamecardDelAction.java</em>
<pre class="code">
package com.google.namecard.action;

import javax.servlet.http.HttpServletRequest;

import com.google.namecard.NamecardDao;

import kr.or.iei.action.Action;

public class NamecardDelAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("no"));
		
		NamecardDao dao = new NamecardDao();
		
		dao.delete(no);
		
	}

}

</pre>


<em class="filename">NamecardListAction.java</em>
<pre class="code">
package com.google.namecard.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.or.iei.action.Action;

import com.google.namecard.Namecard;
import com.google.namecard.NamecardDao;
import com.google.namecard.vo.CardListVO;

public class NamecardListAction implements Action {
	public void execute(HttpServletRequest request) {
		String searchWord = request.getParameter("searchWord"); 
		if (searchWord == null) searchWord = "";
		int curPage = request.getParameter("curPage") == null ? 
				1 : Integer.parseInt(request.getParameter("curPage")); 
		NamecardDao dao = new NamecardDao();
		int numPerPage = 10;//페이지당 레코드 갯수
		ArrayList&lt;Namecard&gt; list = null;
		if (searchWord == null || searchWord.equals("") ) {
			list = dao.select(curPage,numPerPage);	
		} else {
			list = dao.selectBykeyword(curPage,numPerPage,searchWord);
		}
		//총페이지수 구하기(마지막 페이지번호와 같다.)
		int totalPage = 0;
		int totalRecord = 0;
		if (searchWord == null || searchWord.equals("")) {
			totalRecord = dao.getTotalRecord();	
		} else {
			totalRecord = dao.getTotalRecord(searchWord);
		}
		if (totalRecord % numPerPage == 0) {
			totalPage = totalRecord / numPerPage;
		} else {
			totalPage = totalRecord / numPerPage + 1;
		}
		int pagePerBlock = 10;//블록마다 페이지 링크가 몇개인가?
		int block = 0;//페이지를 그룹화할 때 그룹번호를 저장할 변수
		//curPage 가 속한 블록번호는 curPage 로 부터 구할 수 있다.
		if (curPage % pagePerBlock == 0) {
			block = curPage / pagePerBlock;
		} else {
			block = curPage / pagePerBlock + 1;
		}
		int firstPage = 0;
		int lastPage = 0;
		firstPage = (block - 1) * pagePerBlock + 1;
		lastPage = block * pagePerBlock;
		//totalPage(총페이지수) = 마지막페이지번호
		int nextPage = 0;		
		if (lastPage &gt;= totalPage) {//마지막 블록
			lastPage = totalPage;
		} else {//마지막 블록이 아니면
			nextPage = lastPage + 1;
		}
		//[이전] [다음]링크번호를 구하는 코드
		int prevPage = 0;
		if (block &gt; 1) {
			prevPage = firstPage - 1;
		}
		
		CardListVO vo = new CardListVO();
		vo.setList(list);
		vo.setPrevPage(prevPage);
		vo.setNextPage(nextPage);
		vo.setFirstPage(firstPage);
		vo.setLastPage(lastPage);
		vo.setCurPage(curPage);
		vo.setSearchWord(searchWord);
		
		//구해서 전달할 데이터를 request에 담는다.
		request.setAttribute("listVo", vo);
	}
}

</pre>


<em class="filename">NamecardModifyFormAction.java</em>
<pre class="code">
package com.google.namecard.action;

import javax.servlet.http.HttpServletRequest;

import com.google.namecard.Namecard;
import com.google.namecard.NamecardDao;

import kr.or.iei.action.Action;

public class NamecardModifyFormAction implements Action {

	@Override
	public void execute(HttpServletRequest request) {
		int no = Integer.parseInt(request.getParameter("no"));
		
		NamecardDao dao = new NamecardDao();
		
		Namecard card = dao.selectOne(no);
		
		request.setAttribute("card", card);
	}

}

</pre>


<em class="filename">NamecardModifyAction.java</em>
<pre class="code">
package com.google.namecard.action;

import javax.servlet.http.HttpServletRequest;

import com.google.namecard.Namecard;
import com.google.namecard.NamecardDao;

import kr.or.iei.action.Action;

public class NamecardModifyAction implements Action {

	@Override
	public void execute(HttpServletRequest request)  {
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
		
		NamecardDao dao = new NamecardDao();
		dao.update(card);
	}

}

</pre>

<h2>VO</h2>

<em class="filename">CardListVO.java</em>
<pre class="code">
package com.google.namecard.vo;

import java.util.ArrayList;

import com.google.namecard.Namecard;

public class CardListVO {
//목록,[이전],[다음],firstPage,lastPage,curPage,검색어
	private ArrayList&lt;Namecard&gt; list;//목록
	private int prevPage;//[이전]
	private int nextPage;//[다음]
	private int firstPage;// 11,12,.....20 에서 11
	private int lastPage;//  11,12,.....20에서 20
	private int curPage;//list.do?curPage=현재 페이지번호
	private String searchWord;//검색어
	
	public ArrayList&lt;Namecard&gt; getList() {
		return list;
	}
	public void setList(ArrayList&lt;Namecard&gt; list) {
		this.list = list;
	}
	public int getPrevPage() {
		return prevPage;
	}
	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}
	public int getFirstPage() {
		return firstPage;
	}
	public void setFirstPage(int firstPage) {
		this.firstPage = firstPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	
	
}

</pre>

<h2>컨트롤러</h2>
<em class="filename">HelloServlet.java</em>
<pre class="code">
package com.google.namecard;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.iei.action.Action;

import com.google.namecard.action.NamecardAddAction;
import com.google.namecard.action.NamecardDelAction;
import com.google.namecard.action.NamecardListAction;
import com.google.namecard.action.NamecardModifyAction;
import com.google.namecard.action.NamecardModifyFormAction;

public class HelloServlet extends HttpServlet {

	private static final long serialVersionUID = -2393230310739587029L;

	@Override
	protected void doGet(HttpServletRequest req,HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = null;
		command = uri.substring(contextPath.length());
		System.out.println(command);
		String url = null;//이동할 서버자원(JSP,서블릿)
		Action action = null;
		boolean isRedirect = false;
		if (command.equals("/list.do")) {
			action = new NamecardListAction();
			action.execute(req);
			url = "/card/list.jsp";
		} else if (command.equals("/add.do")) {
			url = "/card/add.jsp";
		} else if (command.equals("/modify.do")) {
			action = new NamecardModifyFormAction();
			action.execute(req);
			url = "/card/modify.jsp";
		} else if (command.equals("/addAction.do")) {
			//명함추가 처리
			action = new NamecardAddAction();
			action.execute(req);
			url = contextPath + "/list.do";
			isRedirect = true;
		} else if (command.equals("/modifyAction.do")) {
			action = new NamecardModifyAction();
			action.execute(req);
			String curPage = req.getParameter("curPage");
			String searchWord = req.getParameter("searchWord");
			if (searchWord == null) searchWord = "";
			searchWord = URLEncoder.encode(searchWord,"UTF-8");
			url = contextPath + "/list.do?curPage=" + 
					curPage + "&amp;searchWord=" + searchWord;
			isRedirect = true;
		} else if (command.equals("/delAction.do")) {
			//명함삭제 처리
			action = new NamecardDelAction();
			action.execute(req);
			String curPage = req.getParameter("curPage");
			String searchWord = req.getParameter("searchWord");
			searchWord = URLEncoder.encode(searchWord,"UTF-8");
			url = contextPath + "/list.do?curPage=" + 
					curPage + "&amp;searchWord=" + searchWord;
			isRedirect = true;
		}
		if (isRedirect == false) {
			ServletContext sc = getServletContext();
			RequestDispatcher rd = 
			sc.getRequestDispatcher(url);
			rd.forward(req, resp);
		} else {
			resp.sendRedirect(url);
		}
	}

}

</pre>

<h2>web.xml</h2>
<em class="filename">web.xml</em>
<pre class="code">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;web-app id="WebApp_9" 
	version="2.4" xmlns="http://java.sun.com/xml/ns/j2ee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
		http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"&gt;
		
	&lt;servlet&gt;
		&lt;servlet-name&gt;hello&lt;/servlet-name&gt;
		&lt;servlet-class&gt;com.google.namecard.HelloServlet&lt;/servlet-class&gt;
	&lt;/servlet&gt;
	
	&lt;servlet-mapping&gt;
		&lt;servlet-name&gt;hello&lt;/servlet-name&gt;
		&lt;url-pattern&gt;*.do&lt;/url-pattern&gt;
	&lt;/servlet-mapping&gt;
	
&lt;/web-app&gt;
</pre>
