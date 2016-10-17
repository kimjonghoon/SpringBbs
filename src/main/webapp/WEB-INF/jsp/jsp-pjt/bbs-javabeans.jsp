<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2015.6.20</div>

<h1>자바빈즈 설계</h1>

<h2>회원</h2>
회원 모듈에 필요한 자바빈즈를 먼저 만든다.<br />
회원 한 명의 정보를 저장하기 위한 User.java, 회원 모듈에서 JDBC 관련 작업을 도맡아 할 UserDao.java, 
회원 모듈과 관련된 모든 기능을 제공할 UserService.java가 필요하다.<br />
User.java는 이미 프로토타입에서 만들었고 UserDao.java를 작성하기 전에 다음 예외 클래스가 필요하다.<br />
이 예외 클래스는 회원 가입이 실패했을 때 사용자에게 알려주기 위한 용도이다.<br />

<em class="filename">SignUpFailException.java</em>
<pre class="prettyprint">package net.java_school.exception;

public class SignUpFailException extends RuntimeException {

    private static final long serialVersionUID = 4175726732067144500L;

    public SignUpFailException() {
        super();
    }

    public SignUpFailException(String message, Throwable cause,
            boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }

    public SignUpFailException(String message, Throwable cause) {
        super(message, cause);
    }

    public SignUpFailException(String message) {
        super(message);
    }

    public SignUpFailException(Throwable cause) {
        super(cause);
    }

    
}
</pre>

<em class="filename">UserDao.java</em>
<pre class="prettyprint">package net.java_school.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import net.java_school.exception.SignUpFailException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class UserDao {
    private Log log = LogFactory.getLog(UserDao.class);
    private static UserDao instance = new UserDao();
    private DataSource ds;
    public static String NEW_LINE = System.getProperty("line.separator");

    public static UserDao getInstance() {
        return instance;
    }
    
    private UserDao() {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/jsppjt");
        } catch (NamingException e) {
            if (log.isDebugEnabled()) {
                log.debug(e.getMessage());
            }
        }
    }
    
    private Connection getConnection() throws SQLException {
        return ds.getConnection();
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
    
    //회원 가입
    public void insert(User user) {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        //email,passwd,name,mobile
        String sql = "insert into member values (?, ?, ?, ?)";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPasswd());
            pstmt.setString(3, user.getName());
            pstmt.setString(4, user.getMobile());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
            throw new <strong>SignUpFailException("회원 가입 실패");</strong>
        } finally {
            close(null, pstmt, con);
        }
    }
    
    //로그인
    public User login(String email, String passwd) {
        User user = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT email, passwd, name, mobile FROM member "
            + "WHERE email = ? AND passwd = ?";
         
         
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, passwd);
            rs = pstmt.executeQuery();
             
            if (rs.next()) {
                user = new User();
                user.setEmail(rs.getString("email"));
                user.setPasswd(rs.getString("passwd"));
                user.setName(rs.getString("name"));
                user.setMobile(rs.getString("mobile"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
         
        return user;
    }
    
    //회원정보 수정
    public int update(User user) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE member SET name = ?, mobile = ? WHERE email = ? AND passwd = ?";
        int ret = 0;
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getMobile());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getPasswd());
            ret = pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
            throw new RuntimeException(e);
        } finally {
            close(null, pstmt, con);
        }
        
        return ret;
    }
    
    //비밀번호 변경
    public int update(String currentPasswd, String newPasswd, String email) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE member SET passwd = ? WHERE passwd = ? AND email = ?";
        int ret = 0;
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, newPasswd);
            pstmt.setString(2, currentPasswd);
            pstmt.setString(3, email);
            ret = pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
        
        return ret;
    }
    
    //탈퇴
    public int delete(String email, String passwd) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "DELETE member WHERE email = ? AND passwd = ?";
        int ret = 0;
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, passwd);
            ret = pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
            throw new RuntimeException(e);
        } finally {
            close(null, pstmt, con);
        }
        
        return ret;
    }
    
    //이메일로 회원 찾기
    public User selectOne(String email) {
        User user = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT email, passwd, name, mobile "
                + "FROM member WHERE email = ?";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setEmail(rs.getString("email"));
                user.setPasswd(rs.getString("passwd"));
                user.setName(rs.getString("name"));
                user.setMobile(rs.getString("mobile"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
         
        return user;

    }
        
}
</pre>

<em class="filename">UserService.java</em>
<pre class="prettyprint">package net.java_school.user;

public class UserService {
    private UserDao dao = UserDao.getInstance();
    
    //회원 가입
    public void addUser(User user) {
        dao.insert(user);
    }
    
    //로그인
    public User login(String email, String passwd) {
        return dao.login(email, passwd);
    }
    
    //회원정보 수정
    public int editAccount(User user) {
        return dao.update(user);
    }
    
    //비밀번호 변경
    public int changePasswd(String currentPasswd, String newPasswd, String email) {
        return dao.update(currentPasswd, newPasswd, email);
    }
    
    //탈퇴
    public void bye(String email, String passwd) {
        dao.delete(email, passwd);
    }

    //회원 찾기
    public User getUser(String email) {
        return dao.selectOne(email);
    }
        
}
</pre>

<h2>게시판</h2>

게시판에서 사용할 자바빈즈를 만든다.<br />
게시판 종류를 저장할 객체를 위한 Board.java,<br />
게시글을 저장할 객체를 위한 Article.java,<br />
댓글을 저장할 객체를 위한 Comment.java,<br />
첨부 파일을 저장할 객체를 위한 AttachFile.java,<br />
게시판 DAO 패턴인 BoardDao.java,<br />
페이징 처리를 담당하는 유틸리티 클래스인 PagingHelper.java,<br />
게시판 로직의 프런트 역할을 할 BoardService.java를 만든다.<br />

<em class="filename">Board.java</em>
<pre class="prettyprint">package net.java_school.board;

public class Board {
    private String boardCd;
    private String boardNm;
    
    public String getBoardCd() {
        return boardCd;
    }
    public void setBoardCd(String boardCd) {
        this.boardCd = boardCd;
    }
    public String getBoardNm() {
        return boardNm;
    }
    public void setBoardNm(String boardNm) {
        this.boardNm = boardNm;
    }
}
</pre>

<em class="filename">Article.java</em>
<pre class="prettyprint">package net.java_school.board;

import java.util.Date;

public class Article {
    private int articleNo;
    private String boardCd;
    private String title;
    private String content;
    private String email; //글 소유자 ID에 해당하는 email
    private String name; //글 소유자 이름
    private int hit;
    private Date regdate;
    private int attachFileNum;
    private int commentNum;
    
    public int getArticleNo() {
        return articleNo;
    }
    public void setArticleNo(int articleNo) {
        this.articleNo = articleNo;
    }
    public String getBoardCd() {
        return boardCd;
    }
    public void setBoardCd(String boardCd) {
        this.boardCd = boardCd;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public int getHit() {
        return hit;
    }
    public void setHit(int hit) {
        this.hit = hit;
    }
    public Date getRegdate() {
        return regdate;
    }
    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }
    public int getAttachFileNum() {
        return attachFileNum;
    }
    public void setAttachFileNum(int attachFileNum) {
        this.attachFileNum = attachFileNum;
    }
    public int getCommentNum() {
        return commentNum;
    }
    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }
    
}
</pre>

<em class="filename">Comment.java</em>
<pre class="prettyprint">package net.java_school.board;

import java.util.Date;

public class Comment {
    private int commentNo;
    private int articleNo;
    private String email;//댓글 작성자 email
    private String name;//댓글 작성자 이름
    private String memo;
    private Date regdate;
    
    public int getCommentNo() {
        return commentNo;
    }
    public void setCommentNo(int commentNo) {
        this.commentNo = commentNo;
    }
    public int getArticleNo() {
        return articleNo;
    }
    public void setArticleNo(int articleNo) {
        this.articleNo = articleNo;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }   
    public String getMemo() {
        return memo;
    }
    public void setMemo(String memo) {
        this.memo = memo;
    }
    public Date getRegdate() {
        return regdate;
    }
    public void setRegdate(Date regdate) {
        this.regdate = regdate;
    }
    
}
</pre>

<em class="filename">AttachFile.java</em>
<pre class="prettyprint">package net.java_school.board;

public class AttachFile {
    private int attachFileNo;
    private String filename;    
    private String filetype;    
    private long filesize;    
    private int articleNo;
    private String email;
    
    public int getAttachFileNo() {
        return attachFileNo;
    }
    public void setAttachFileNo(int attachFileNo) {
        this.attachFileNo = attachFileNo;
    }
    public String getFilename() {
        return filename;
    }
    public void setFilename(String filename) {
        this.filename = filename;
    }
    public String getFiletype() {
        return filetype;
    }
    public void setFiletype(String filetype) {
        this.filetype = filetype;
    }
    public long getFilesize() {
        return filesize;
    }
    public void setFilesize(long filesize) {
        this.filesize = filesize;
    }
    public int getArticleNo() {
        return articleNo;
    }
    public void setArticleNo(int articleNo) {
        this.articleNo = articleNo;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    
}
</pre>

<em class="filename">BoardDao.java</em>
<pre class="prettyprint">package net.java_school.board;
package net.java_school.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class BoardDao {
    private Log log = LogFactory.getLog(BoardDao.class);
    private static BoardDao instance = new BoardDao();
    private DataSource ds;
    public static String NEW_LINE = System.getProperty("line.separator");
    
    public static BoardDao getInstance() {
        return instance;
    }
    
    private BoardDao() {
        try {
            Context initCtx = new InitialContext();
            Context envCtx = (Context) initCtx.lookup("java:comp/env");
            ds = (DataSource) envCtx.lookup("jdbc/jsppjt");
        } catch (NamingException e) {
            if (log.isDebugEnabled()) {
                log.debug(e.getMessage());
            }
        }
    }
    
    private Connection getConnection() throws SQLException {
        return ds.getConnection();
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
    
    //특정 페이지에 해당하는 게시글 리스트
    public List&lt;Article&gt; selectListOfArticles(
            String boardCd, 
            String searchWord, 
            int startRownum, 
            int endRownum) {
        
        List&lt;Article&gt; articleList = new ArrayList&lt;Article&gt;();
        
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT articleno, title, regdate, hit, name, attachfileNum, commentNum FROM ");
        sb.append("( ");
        sb.append("     SELECT rownum r,a.* FROM ");
        sb.append("     ( ");
        sb.append("     SELECT ");
        sb.append("         a.articleno,"); 
        sb.append("         a.title,");
        sb.append("         a.regdate,");
        sb.append("         a.hit,");
        sb.append("         m.name,");
        sb.append("         COUNT(DISTINCT(f.attachfileno)) attachfileNum,");
        sb.append("         COUNT(DISTINCT(c.commentno)) commentNum ");
        sb.append("     FROM article a, attachfile f, comments c, member m "); 
        sb.append("     WHERE ");
        sb.append("         a.articleno = f.articleno(+) "); 
        sb.append("         AND a.articleno = c.articleno(+) "); 
        sb.append("         AND a.email = m.email(+) ");
        sb.append("         AND a.boardcd = ? ");
    if (searchWord != null &amp;&amp; !searchWord.equals("")) {
        sb.append("         AND (title LIKE '%" + searchWord + "%' OR content LIKE '%" + searchWord + "%') ");
    }
        sb.append("     GROUP BY a.articleno, a.title, a.regdate, a.hit, m.name ORDER BY articleno DESC ");
        sb.append("     ) a ");
        sb.append(") ");
        sb.append("WHERE r BETWEEN ? AND ?");
        
        final String sql = sb.toString();
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardCd);
            pstmt.setInt(2, startRownum);
            pstmt.setInt(3, endRownum);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Article article = new Article();
                int articleNo = rs.getInt("articleno");
                String title = rs.getString("title");
                Date regdate = rs.getDate("regdate");
                int hit = rs.getInt("hit");
                int attachfileNum = rs.getInt("attachfileNum");
                int commentNum = rs.getInt("commentNum");
                article.setArticleNo(articleNo);
                article.setTitle(title);
                article.setRegdate(regdate);
                article.setHit(hit);
                article.setAttachFileNum(attachfileNum);
                article.setCommentNum(commentNum);
                articleList.add(article);
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }

        return articleList;
    }
    
    //총게시글수
    public int selectCountOfArticles(String boardCd, String searchWord) {
        int totalRecord = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT count(*) FROM article WHERE boardcd=? ";
        if (searchWord != null &amp;&amp; !searchWord.equals("")) {
            sql = sql + "AND (title LIKE '%" + searchWord + "%' OR content LIKE '%" + searchWord + "%') ";
        } 
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardCd);
            rs = pstmt.executeQuery();
            rs.next();
            totalRecord = rs.getInt(1);
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
        
        return totalRecord;
    }

    //게시글 삽입
    public void insert(Article article, AttachFile attachFile) {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO article " +
        "(articleno, boardcd, title, content, email, hit, regdate) " +
        "VALUES " +
        "(SEQ_ARTICLE.nextval, ?, ?, ?, ?, 0, sysdate)";
        
        int chk = 0;
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, article.getBoardCd());
            pstmt.setString(2, article.getTitle());
            pstmt.setString(3, article.getContent());
            pstmt.setString(4, article.getEmail());
            chk = pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        try {
            if (chk &gt; 0 &amp;&amp; attachFile != null) {
                sql = "INSERT INTO attachfile " +
                "(attachfileno, filename, filetype, filesize, articleno, email) " +
                "VALUES " +
                "(SEQ_ATTACHFILE.nextval, ?, ?, ?, SEQ_ARTICLE.currval, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, attachFile.getFilename());
                pstmt.setString(2, attachFile.getFiletype());
                pstmt.setLong(3, attachFile.getFilesize());
                pstmt.setString(4, attachFile.getEmail());
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
        
    }
    
    //게시글 수정
    public void update(Article article, AttachFile attachFile) {
        String sql = "UPDATE article SET title=?, content=? WHERE articleno=?";
        
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, article.getTitle());
            pstmt.setString(2, article.getContent());
            pstmt.setInt(3, article.getArticleNo());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    
        try {
            if (attachFile != null) {
                sql = "INSERT INTO attachfile "
                        + "(attachfileno, filename, filetype, filesize, articleno, email) "
                        + "VALUES (SEQ_ATTACHFILE.nextval, ?, ?, ?, ?, ?)";
                pstmt = con.prepareStatement(sql);
                pstmt.setString(1, attachFile.getFilename());
                pstmt.setString(2, attachFile.getFiletype());
                pstmt.setLong(3, attachFile.getFilesize());
                pstmt.setInt(4, attachFile.getArticleNo());
                pstmt.setString(5, attachFile.getEmail());
                pstmt.executeUpdate();
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }

    }
    
    //게시글 삭제
    public void delete(int articleNo) {
        Connection con = null;
        PreparedStatement pstmt1 = null;
        PreparedStatement pstmt2 = null;
        PreparedStatement pstmt3 = null;
        
        String sql = "DELETE FROM comments WHERE articleno = ?";
        
        try {
            con = getConnection();
            con.setAutoCommit(false);
            pstmt1 = con.prepareStatement(sql);
            pstmt1.setInt(1, articleNo);
            pstmt1.executeUpdate();
            
            sql = "DELETE FROM attachfile WHERE articleno = ?";
            pstmt2 = con.prepareStatement(sql);
            pstmt2.setInt(1, articleNo);
            pstmt2.executeUpdate();
            
            sql = "DELETE FROM article WHERE articleno = ?";
            pstmt3 = con.prepareStatement(sql);
            pstmt3.setInt(1, articleNo);
            pstmt3.executeUpdate();
            con.commit();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
            
            try {
                con.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            if (pstmt1 != null) {
                try {
                    pstmt1.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (pstmt2 != null) {
                try {
                    pstmt2.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            close(null, pstmt3, con);
        }   
        
    }
    
    //게시글 조회 수 증가
    public void updateHitPlusOne(int articleNo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String sql = "UPDATE article SET hit = hit + 1 WHERE articleno = ?";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, articleNo);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState");
                msg.append(" : ");
                msg.append(e.getSQLState());
                msg.append(NEW_LINE);
                msg.append("Message");
                msg.append(" : ");
                msg.append(e.getMessage());
                msg.append(NEW_LINE);
                msg.append("Oracle Error Code");
                msg.append(" : ");
                msg.append(e.getErrorCode());
                msg.append(NEW_LINE);
                msg.append("sql");
                msg.append(" : ");
                msg.append(sql);
                msg.append(NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
    }
    
    //P.K 에 해당하는 게시글 조회
    public Article selectOne(int articleNo) {
        Article article = null;
        final String sql = "SELECT "
                        + "articleno, title, content, a.email, NVL(name,'Anonymous') name, hit, regdate "
                    + "FROM "
                        + "article a, member m "
                    + "WHERE "
                        + "a.email = m.email(+) AND articleno = ?";
             
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
         
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, articleNo);
            rs = pstmt.executeQuery();
             
            if (rs.next()) {
                article = new Article();
                article.setArticleNo(rs.getInt("articleno"));
                article.setTitle(rs.getString("title"));
                article.setContent(rs.getString("content"));
                article.setEmail(rs.getString("email"));
                article.setName(rs.getString("name"));
                article.setHit(rs.getInt("hit"));
                article.setRegdate(rs.getDate("regdate"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
        return article;
    
    }
    
    //다음 글
    public Article selectNextOne(int articleNo, String boardCd, String searchWord) {
        Article article = null;
        String sql = "SELECT articleno, title " +
            "FROM " +
                "(SELECT rownum r,a.* " +
                "FROM " +
                "(SELECT articleno, title "
                + "FROM article "
                + "WHERE boardCd = ? AND articleno &gt; ? ";
             
        if (searchWord != null &amp;&amp; !searchWord.equals("")) {
            sql = sql + "AND (title like '%" + searchWord + "%' "
                + "OR content like '%" + searchWord + "%') ";
        } 
             
        sql = sql + "ORDER BY articleno) a) WHERE r = 1";
         
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
             
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardCd);
            pstmt.setInt(2, articleNo);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                article = new Article();
                article.setArticleNo(rs.getInt("articleno"));
                article.setTitle(rs.getString("title"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
         
        return article;

    }
    
    //이전 글
    public Article selectPrevOne(int articleNo, String boardCd, String searchWord) {
        Article article = null;
        String sql = "SELECT articleno, title " +
            "FROM " +
            "(SELECT rownum r,a.* " +
                "FROM " +
                "(SELECT articleno, title "
                + "FROM article "
                + "WHERE boardCd = ? AND articleno &lt; ? ";
         
        if (searchWord != null &amp;&amp; !searchWord.equals("")) {
            sql = sql + "AND (title like '%" + searchWord + "%' "
                + "OR content5 like '%" + searchWord + "%') ";
        } 
         
        sql = sql + "ORDER BY articleno DESC) a) WHERE r = 1";
         
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
             
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardCd);
            pstmt.setInt(2, articleNo);
            rs = pstmt.executeQuery();
             
            if (rs.next()) {
                article = new Article();
                article.setArticleNo(rs.getInt("articleno"));
                article.setTitle(rs.getString("title"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
         
        return article;

    }
    
    //첨부 파일 리스트
    public List&lt;AttachFile&gt; selectListOfAttachFiles(int articleNo) {
        List&lt;AttachFile&gt; attachFileList = new ArrayList&lt;AttachFile&gt;();
        String sql = "SELECT attachfileno, filename, filetype, filesize, articleno, email " +
            "FROM attachfile WHERE articleno=? ORDER BY attachfileno ASC";
     
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
         
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, articleNo);
            rs = pstmt.executeQuery();
             
            while(rs.next()) {
                AttachFile attachFile = new AttachFile();
                int attachFileNo = rs.getInt("attachfileno");
                String filename = rs.getString("filename");
                String filetype = rs.getString("filetype");
                long filesize = rs.getLong("filesize");
                String email = rs.getString("email");
                attachFile.setAttachFileNo(attachFileNo);
                attachFile.setFilename(filename);
                attachFile.setFiletype(filetype);
                attachFile.setFilesize(filesize);
                attachFile.setEmail(email);
                attachFileList.add(attachFile);
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);  
        }
         
        return attachFileList;

    }
    
    //첨부 파일 삭제
    public void deleteFile(int attachFileNo) {
        String sql = "DELETE FROM attachfile WHERE attachfileno=?";
         
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, attachFileNo);
            pstmt.executeQuery();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);    
        }

    }
    
    //게시판 코드로 게시판 이름 조회
    public String selectOneBoardName(String boardCd) {
        String boardNm = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "SELECT boardNm FROM board WHERE boardcd = ?";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, boardCd);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                boardNm = rs.getString("boardnm");
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
            
        return boardNm;
    
    }
    
    //댓글 삽입
    public void insertComment(Comment comment) {
        String sql = "INSERT INTO comments (commentno, articleno, email, memo, regdate) "
            + "VALUES (SEQ_COMMENTS.nextval, ?, ?, ?, sysdate)";
                 
        Connection con = null;
        PreparedStatement pstmt = null;
             
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, comment.getArticleNo());
            pstmt.setString(2, comment.getEmail());
            pstmt.setString(3, comment.getMemo());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
        
    }
    
    //댓글 수정
    public void updateComment(Comment comment) {
        String sql = "UPDATE comments SET memo = ? WHERE commentno = ?";
        Connection con = null;
        PreparedStatement pstmt = null;
         
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, comment.getMemo());
            pstmt.setInt(2, comment.getCommentNo());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
    }
    
    //댓글 삭제
    public void deleteComment(int commentNo) {
        String sql = "DELETE FROM comments WHERE commentno = ?";
         
        Connection con = null;
        PreparedStatement pstmt = null;
         
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, commentNo);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
    
    }
    
    //댓글 리스트
    public List&lt;Comment&gt; selectListOfComments(int articleNo) {
        List&lt;Comment&gt; commentList = new ArrayList&lt;Comment&gt;();

        String sql = "SELECT "
                        + "commentno, articleno, c.email, NVL(name,'Anonymous') name, memo, regdate "
                    + "FROM "
                        + "comments c, member m "
                    + "WHERE "
                        + "c.email = m.email(+) AND "
                        + "articleno = ? "
                    + "ORDER BY commentno DESC"; 
     
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
         
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, articleNo);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                 
                comment.setCommentNo(rs.getInt("commentno"));
                comment.setArticleNo(rs.getInt("articleno"));
                comment.setEmail(rs.getString("email"));
                comment.setName(rs.getString("name"));
                comment.setMemo(rs.getString("memo"));
                comment.setRegdate(rs.<strong>getTimestamp("regdate")</strong>);
                
                commentList.add(comment);
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(null, pstmt, con);
        }
        
        return commentList;
    }

    //첨부 파일 찾기
    public AttachFile selectOneAttachFile(int attachFileNo) {
        AttachFile attachFile = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        //attachfileno,filename,filetype,filesize,articleno,email
        String sql = "SELECT attachfileno, filename, filetype, filesize, articleno, email "
                + "FROM attachFile WHERE attachfileno = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, attachFileNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                attachFile = new AttachFile();
                attachFile.setAttachFileNo(rs.getInt("attachfileno"));
                attachFile.setFilename(rs.getString("filename"));
                attachFile.setFiletype(rs.getString("filetype"));
                attachFile.setFilesize(rs.getLong("filesize"));
                attachFile.setArticleNo(rs.getInt("articleno"));
                attachFile.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
        
        return attachFile;
    }

    //댓글 찾기
    public Comment selectOneComment(int commentNo) {
        Comment comment = null;
        
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        //commentno,articleno,email,memo,regdate
        String sql = "SELECT commentno, articleno, email, memo, regdate "
                + "FROM comments WHERE commentno = ?";

        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, commentNo);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                comment = new Comment();
                comment.setCommentNo(rs.getInt("commentno"));
                comment.setArticleNo(rs.getInt("articleno"));
                comment.setEmail(rs.getString("email"));
                comment.setMemo(rs.getString("memo"));
                comment.setRegdate(rs.getDate("regdate"));
            }
        } catch (SQLException e) {
            if (log.isDebugEnabled()) {
                StringBuilder msg = new StringBuilder();
                msg.append("SQLState : " + e.getSQLState() + NEW_LINE);
                msg.append("Message : " + e.getMessage() + NEW_LINE);
                msg.append("Oracle Error Code : " + e.getErrorCode() + NEW_LINE);
                msg.append("sql : " + sql + NEW_LINE);
                log.debug(msg);
            }
        } finally {
            close(rs, pstmt, con);
        }
        
        return comment;
    }

}
</pre>

페이징 처리를 위한 PagingHelper.java는 이전과 같으나 다시 싣는다.

<em class="filename">PagingHelper.java</em>
<pre class="prettyprint">package net.java_school.commons;

public class PagingHelper {
    private int totalPage; //총 페이지 수
    private int firstPage; //현재 블록의 첫 번째 페이지 번호
    private int lastPage; //현재 블록의 마지막 페이지 번호
    private int prevPage; //[이전] 링크 페이지 번호
    private int nextPage; //[다음] 링크 페이지 번호
    private int listItemNo; //목록 아이템에 붙여지는 번호
    private int startRecord; //목록 조회를 위한 오라클 시작 ROWNUM
    private int endRecord; //목록 조회를 위한 오라클 마지막 ROWNUM

    public PagingHelper(
            int totalRecord, 
            int curPage, 
            int numPerPage, 
            int pagePerBlock) {
        
        //총 페이지 수를 구한다.
        if (totalRecord % numPerPage == 0) {
            this.totalPage = totalRecord / numPerPage;
        } else {
            this.totalPage = totalRecord / numPerPage + 1;
        }
        
        int totalBlock = 1;//총 블록 수
        if (totalPage % pagePerBlock == 0) {
            totalBlock = totalPage / pagePerBlock;
        } else {
            totalBlock = totalPage / pagePerBlock + 1;
        }
        
        int block = 1;//현재 블록
        if (curPage % pagePerBlock == 0) {
            block = curPage / pagePerBlock;
        } else {
            block = curPage / pagePerBlock + 1;
        }
        
        //현재 블록에 속한 첫 번째 페이지와 마지막 페이지를 구한다.
        this.firstPage = (block - 1) * pagePerBlock + 1;
        this.lastPage = block * pagePerBlock;
        
        //현재 블록이 총 블록 수(마지막 블록 번호)보다 크거나 같다면 마지막 페이지를 총 페이지 수로 바꾼다. 
        if (block &gt;= totalBlock) {
            this.lastPage = totalPage;
        }
        
        //블록이 1보다 크다면 [이전]링크에 해당하는 페이지 번호를 구한다.
        if (block &gt; 1) {
            this.prevPage = firstPage - 1;
        }
        
        //블록이 총 블록 수(마지막 블록 번호)보다 작다면 [다음] 링크에 해당하는 페이지 번호를 구한다. 
        if (block &lt; totalBlock) {
            this.nextPage = lastPage + 1;
        }
        
        //list.jsp 에서 목록 아이템 앞에 붙여지는 번호를 계산한다.
        this.listItemNo = totalRecord - (curPage - 1) * numPerPage;
        
        //목록을 구하기 위해서 첫 번째 레코드번호와 마지막 레코드 번호를 구한다.
        this.startRecord = (curPage - 1) * numPerPage + 1;
        this.endRecord = startRecord + numPerPage - 1;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public int getFirstPage() {
        return firstPage;
    }

    public int getLastPage() {
        return lastPage;
    }

    public int getPrevPage() {
        return prevPage;
    }

    public int getNextPage() {
        return nextPage;
    }

    public int getListItemNo() {
        return listItemNo;
    }

    public int getStartRecord() {
        return startRecord;
    }

    public int getEndRecord() {
        return endRecord;
    }

}
</pre>

<em class="filename">BoardService.java</em>
<pre class="prettyprint">package net.java_school.board;

import java.util.List;

import net.java_school.commons.PagingHelper;

public class BoardService {
    private BoardDao dao = BoardDao.getInstance(); //게시판 Dao
    private PagingHelper pagingHelper; //페이징 처리 유틸리티 
    
    public BoardService() {}
    
    //목록
    public List&lt;Article&gt; getArticleList(String boardCd, String searchWord) {
        int startRownum = pagingHelper.getStartRecord();
        int endRownum = pagingHelper.getEndRecord();
        return dao.selectListOfArticles(boardCd, searchWord, startRownum, endRownum);
    }
    
    //총 레코드수
    public int getTotalRecord(String boardCd, String searchWord) {
        return dao.selectCountOfArticles(boardCd, searchWord);
    }

    //글쓰기
    public void addArticle(Article article, AttachFile attachFile) {
        dao.insert(article, attachFile);
    }

    //글 수정
    public void modifyArticle(Article article, AttachFile attachFile) {
        dao.update(article, attachFile);
    }

    //글 삭제
    public void removeArticle(int articleNo) {
        dao.delete(articleNo);
    }
    
    //조회 수 증가
    public void increaseHit(int articleNo) {
        dao.updateHitPlusOne(articleNo);
    }
    
    //게시글 조회
    public Article getArticle(int articleNo) {
        return dao.selectOne(articleNo);
    }
    
    //다음 글
    public Article getNextArticle(int articleNo, String boardCd, String searchWord) {
        return dao.selectNextOne(articleNo, boardCd, searchWord);
    }

    //이전 글
    public Article getPrevArticle(int articleNo, String boardCd, String searchWord) {
        return dao.selectPrevOne(articleNo, boardCd, searchWord);
    }

    //첨부 파일 리스트
    public List&lt;AttachFile&gt; getAttachFileList(int articleNo) {
        return dao.selectListOfAttachFiles(articleNo);
    }

    //첨부 파일 찾기
    public AttachFile getAttachFile(int attachFileNo) {
        return dao.selectOneAttachFile(attachFileNo);
    }
    
    //첨부 파일 삭제
    public void removeAttachFile(int attachFileNo) {
        dao.deleteFile(attachFileNo);
    }
    
    //게시판 이름
    public String getBoardNm(String boardCd) {
        return dao.selectOneBoardName(boardCd);
    }

    //댓글 리스트
    public List&lt;Comment&gt; getCommentList(int articleNo) {
        return dao.selectListOfComments(articleNo);
    }

    //댓글 조회
    public Comment getComment(int commentNo) {
        return dao.selectOneComment(commentNo);
    }

    //댓글 쓰기
    public void addComment(Comment comment) {
        dao.insertComment(comment);
    }

    //댓글 수정
    public void modifyComment(Comment comment) {
        dao.updateComment(comment);
    }
    
    //댓글 삭제
    public void removeComment(int commentNo) {
        dao.deleteComment(commentNo);
    }

    public int getListItemNo() {
        return this.pagingHelper.getListItemNo();
    }
    
    public int getPrevPage() {
        return pagingHelper.getPrevPage();
    }
    
    public int getFirstPage() {
        return pagingHelper.getFirstPage();
    }
    
    public int getLastPage() {
        return pagingHelper.getLastPage();
    }
    
    public int getNextPage() {
        return pagingHelper.getNextPage();
    }

    public void setPagingHelper(PagingHelper pagingHelper) {
        this.pagingHelper = pagingHelper;
    }
            
}
</pre>