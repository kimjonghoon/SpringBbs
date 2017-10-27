<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2014.8.4</div>

<h1>데이터베이스 설계</h1>

SYS 계정으로 접속한다.<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\Documents and Settings\kim&gt; <strong>sqlplus scott/tiger</strong>

다음에 접속됨:
Oracle Database 11g

SQL&gt; <strong>connect sys as sysdba</strong>
암호 입력: 
연결되었습니다.
SQL&gt; show user
USER은 "SYS"입니다
</pre>

SYS 계정에 접속한 상태에서 아래 내용을 실행한다.<br />

<em class="filename">board-schema.sql</em>
<pre class="prettyprint">
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO java IDENTIFIED BY school;
ALTER USER java DEFAULT TABLESPACE USERS;
ALTER USER java TEMPORARY TABLESPACE TEMP;
CONNECT java/school

-- 회원테이블 
create table member (
	email varchar2(60) PRIMARY KEY,
	passwd varchar2(20) NOT NULL,
	name varchar2(20) NOT NULL,
	mobile varchar2(20)
);

-- 게시판 종류
create table board (
	boardcd varchar2(20),
	boardnm varchar2(40) NOT NULL,
	constraint PK_BOARD PRIMARY KEY(boardcd)
);

-- 게시글
create table article (
	articleno number,
	boardcd varchar2(20),
	title varchar2(200) NOT NULL,
	content clob NOT NULL,
	email varchar2(60),
	hit number,	
	regdate date,
	constraint PK_ARTICLE PRIMARY KEY(articleno),
	constraint FK_ARTICLE FOREIGN KEY(boardcd) REFERENCES board(boardcd)
);

-- 게시글 번호 생성기 
create sequence SEQ_ARTICLE
increment by 1
start with 1;

-- 댓글
create table comments (
	commentno number,
	articleno number,	
	email varchar2(60),	
	memo varchar2(4000) NOT NULL,
	regdate date, 
	constraint PK_COMMENTS PRIMARY KEY(commentno)
);

-- 댓글 번호 생성기
create sequence SEQ_COMMENTS
	increment by 1
	start with 1;

-- 첨부파일 
create table attachfile (
	attachfileno number,
	filename varchar2(50) NOT NULL,
	filetype varchar2(30),
	filesize number,
	articleno number,
	email varchar2(60),
	constraint PK_ATTACHFILE PRIMARY KEY(attachfileno)
);

-- 첨부파일 번호 생성기
create sequence SEQ_ATTACHFILE
increment by 1
start with 1;

insert into board values ('free','자유게시판');
insert into board values ('qna','QnA게시판');
insert into board values ('data','자료실');
commit;                                       
</pre>

<h2>DataSource 설정</h2>

{톰캣홈}/conf/Catalina/localhost/JSPProject.xml 을 열고 아래와 같이 추가한다.<br />

<em class="filename">JSPProject.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
	docBase="C:/www/JSPProject/WebContent"
	reloadable="true"&gt;
	<strong>
	&lt;Resource
		name="jdbc/jsppjt"
		auth="Container"
		type="javax.sql.DataSource"
		username="java"
		password="school"
		driverClassName="oracle.jdbc.driver.OracleDriver"
		url="jdbc:oracle:thin:@127.0.0.1:1521:XE" 
		maxActive="8"
		maxIdle="4" /&gt;
	</strong>
			
&lt;/Context&gt;
</pre>

<h3>JDBC 드라이버 파일을 {톰캣홈}/lib에 복사</h3>
오라클 JDBC 드라이버 파일인 ojdbc6.jar 파일을 {톰캣홈}/lib에 복사한다.<br />

<h3>테스트</h3>
test.jsp 파일을 도큐멘트베이스(C:/www/JSPProject/WebContent)에 생성한다.<br />

<em class="filename">test.jsp</em>
<pre class="prettyprint">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%&gt;
&lt;%@ page import="java.sql.*,javax.sql.*,javax.naming.*" %&gt;
&lt;%
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	DataSource ds = null;
	
	int totalRecord = 0;
		
	try {
		Context ic = new InitialContext();
		Context envCtx = (Context) ic.lookup("java:comp/env");
		ds = (DataSource) envCtx.lookup("<strong>jdbc/jsppjt</strong>");
	} catch (NamingException e) {
		System.out.println(e.getMessage());
	}
	
	try {
		con = ds.getConnection();
		
		String sql = "SELECT count(*) FROM board";
		
		pstmt = con.prepareStatement(sql);
		rs = pstmt.executeQuery();
		rs.next();
		totalRecord = rs.getInt(1);
	} catch (SQLException e) {
		System.out.println(e.getMessage());
	} finally {
		try {
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
%&gt;	
&lt;!DOCTYPE html&gt; 
&lt;html lang="ko"&gt; 
&lt;head&gt;
	&lt;meta charset="UTF-8"&gt;
	&lt;title&gt;DataSource Test&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;p&gt;
<strong>&lt;%=totalRecord %&gt;</strong>
&lt;/p&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

톰캣을 재실행하고 http://localhost:port/JSPProject/test.jsp를 방문한다.
3을 본다면 성공이다.<br />
