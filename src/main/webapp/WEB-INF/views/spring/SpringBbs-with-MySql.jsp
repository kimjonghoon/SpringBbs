<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2015.7.29</div>

<h1>MySql을 사용하는 SpringBbs</h1>

<h3>MySql 설치</h3>

<pre class="shell-prompt">
sudo apt-get install mysql-server mysql-client 
</pre>

<h3>사용자 생성</h3>

<pre class="shell-prompt">
mysql --user=root --password mysql
</pre>

<pre class="shell-prompt">
create user 'java'@'%' identified by 'school';
grant all privileges on *.* to 'java'@'%';
</pre>

<h3>한글을 위한 MySql 설정</h3>
root 계정으로 접속한 상태에서 status 명령어를 실행한다.
 
<pre class="shell-prompt">
mysql&gt; <strong>status</strong>
--------------
mysql  Ver 14.14 Distrib 5.6.24, for debian-linux-gnu (x86_64) using  EditLine wrapper

Connection id:		3
Current database:	mysql
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		5.6.24-0ubuntu2 (Ubuntu)
Protocol version:	10
Connection:		Localhost via UNIX socket
<strong>Server characterset:	latin1
Db     characterset:	latin1</strong>
Client characterset:	utf8
Conn.  characterset:	utf8
UNIX socket:		/var/run/mysqld/mysqld.sock
Uptime:			20 min 12 sec
</pre>

exit로 빠져 나온 후, 다음을 실행하여 문서를 연다.

<pre class="shell-prompt">
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
</pre>

[mysqld] 아래에 다음을 추가한다.

<pre class="prettyprint">
default-storage-engine = innodb
innodb_file_per_table
collation-server = utf8_general_ci
init-connect = 'SET NAMES utf8'
character-set-server = utf8
</pre>

MySQL 서비스를 재시작한다.

<pre class="shell-prompt">
sudo service mysql restart
</pre>

root 계정으로 접속한 다음 status를 다시 실행한다.

<pre class="shell-prompt">
mysql> <strong>status</strong>
--------------
mysql  Ver 14.14 Distrib 5.6.24, for debian-linux-gnu (x86_64) using  EditLine wrapper

Connection id:		2
Current database:	mysql
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		5.6.24-0ubuntu2 (Ubuntu)
Protocol version:	10
Connection:		Localhost via UNIX socket
<strong>Server characterset:	utf8
Db     characterset:	utf8</strong>
Client characterset:	utf8
Conn.  characterset:	utf8
UNIX socket:		/var/run/mysqld/mysqld.sock
Uptime:			12 sec
</pre>

<h3>데이터베이스 생성</h3>

MySql 한글 설정을 한 후 데이터베이스를 생성한다.
root 계정으로 다음과 같이 접속한다.

<pre class="shell-prompt">
mysql --user=root --password mysql
</pre>

javaschool 데이터베이스를 생성한다.

<pre class="shell-prompt">
create database javaschool;
</pre>

exit;로 빠져나온 후, 아래 내용으로 mysql-database.sql 파일을 사용자 디렉터리에 생성한다.

<em class="filename">mysql-database.sql</em>
<pre class="prettyprint">
create table member (
    email varchar(60) PRIMARY KEY,
    passwd varchar(20) NOT NULL,
    name varchar(20) NOT NULL,
    mobile varchar(20)
);
 
CREATE TABLE authorities (
  email VARCHAR(60) NOT NULL,
  authority VARCHAR(20) NOT NULL,
  CONSTRAINT fk_authorities FOREIGN KEY(email) REFERENCES member(email)
);
 
CREATE UNIQUE INDEX ix_authorities ON authorities(email,authority); 
 
INSERT INTO member VALUES ('hong@gmail.org','1111','홍길동','010-1111-1111');
INSERT INTO member VALUES ('im@gmail.org','1111','임꺽정','010-1111-2222');
 
INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_USER');
INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_ADMIN');
INSERT INTO authorities VALUES ('im@gmail.org','ROLE_USER');
 
create table board (
    boardcd varchar(20),
    boardnm varchar(40) NOT NULL,
    constraint PK_BOARD PRIMARY KEY(boardcd)
);
 
create table article (
    articleno int NOT NULL AUTO_INCREMENT,
    boardcd varchar(20),
    title varchar(200) NOT NULL,
    content text NOT NULL,
    email varchar(60),
    hit bigint,    
    regdate datetime,
    constraint PK_ARTICLE PRIMARY KEY(articleno),
    constraint FK_ARTICLE FOREIGN KEY(boardcd) REFERENCES board(boardcd)
);
 
create table comments (
    commentno int NOT NULL AUTO_INCREMENT,
    articleno int,    
    email varchar(60),    
    memo varchar(4000) NOT NULL,
    regdate datetime, 
    constraint PK_COMMENTS PRIMARY KEY(commentno)
);
 
create table attachfile (
    attachfileno int NOT NULL AUTO_INCREMENT,
    filename varchar(255) NOT NULL,
    filetype varchar(255),
    filesize bigint,
    articleno int,
    email varchar(60),
    constraint PK_ATTACHFILE PRIMARY KEY(attachfileno)
);
 
insert into board values ('free','자유 게시판');
insert into board values ('qna','QnA 게시판');
insert into board values ('data','자료실');
 
commit;                                       
</pre>

java 계정으로 접속한다. (비밀번호는 school)

<pre class="shell-prompt">
mysql --user=java --password javaschool
</pre>

사용자 디렉터리가 /home/kim/이고 여기에 mysql-database.sql 파일이 있다면,
다음과 같이 명령을 실행하여 파일의 있는 SQL를 실행한다.

<pre class="shell-prompt">
source /home/kim/mysql-database.sql
</pre>

<h3>MySql용 JDBC 드라이버 복사</h3>
MySql용 jdbc 드라이버를 다음 링크에서 내려받는다.<br />
<a href="http://dev.mysql.com/downloads/connector/j/">http://dev.mysql.com/downloads/connector/j/</a><br />
압축을 풀고 다음 파일을 톰캣 라이브러리 폴더에 복사한다.<br />

<pre class="shell-prompt">
sudo cp mysql-connector-java-5.1.36-bin.jar /usr/share/tomcat7/lib/
</pre>



<h3>소스</h3>
기존 SpringBbs 폴더를 복사하여 적당한 곳에 붙여넣는다.<br />
붙여넣은 후, 파일의 메뉴 중 숨긴 파일 보이기를 선택하고 복사하여 붙인 폴더에서 .git 폴더를 제거한다.<br />
먼저 설정 파일을 수정한다.<br />

<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;jdbc-user-service
	data-source-ref="dataSource"
	users-by-username-query="select email as username,passwd as password,1 as enabled
	from member where email = ?"
	authorities-by-username-query="select email as username,authority
	from authorities where email = ?" /&gt;
</pre>

<em class="filename">applicationContext.xml</em>
<pre class="prettyprint">
&lt;bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close"&gt;
	&lt;property name="driverClassName" value="<strong>com.mysql.jdbc.Driver</strong>"/&gt;
	&lt;property name="url" value="<strong>jdbc:mysql://localhost:3306/javaschool?useUnicode=yes&amp;amp;characterEncoding=UTF-8"</strong> /&gt;
	&lt;property name="username" value="java"/&gt;
	&lt;property name="password" value="school"/&gt;
	&lt;property name="maxActive" value="100"/&gt;
	&lt;property name="maxWait" value="1000"/&gt;
	&lt;property name="poolPreparedStatements" value="true"/&gt;
	&lt;property name="defaultAutoCommit" value="true"/&gt;
	&lt;property name="validationQuery" value="<strong>SELECT 1</strong>" /&gt;
&lt;/bean&gt;
</pre>

오라클용 스프링 게시판 애플리케이션이 실행되는 시스템이라면 pom.xml 파일에서 다음 부분을 아래와 같이 수정한다.
 
<em class="filename">pom.xml</em>
<pre class="prettyprint">
&lt;artifactId&gt;<strong>spring-bbs-mysql</strong>&lt;/artifactId&gt;

&lt;build&gt;
&lt;finalName&gt;<strong>spring-bbs-mysql</strong>&lt;/finalName&gt;

</pre>

매퍼를 수정한다.<br />

<em class="filename">BoardMapper.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8" ?&gt;

&lt;!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd"&gt;

&lt;mapper namespace="net.java_school.mybatis.BoardMapper"&gt;

	&lt;select id="selectListOfArticles" resultType="Article"&gt;
		SELECT 
			a.articleno, a.title, a.regdate, a.hit, m.name, 
			count(distinct(f.attachfileno)) attachfileNum, 
			count(distinct(c.commentno)) commentNum
		FROM 
			article as a left join attachfile as f on a.articleno = f.articleno
				left join comments as c on a.articleno = c.articleno
				left join member as m on a.email = m.email
		WHERE
			a.boardcd = <%="#" %>{boardCd}
			&lt;if test="searchWord != null and searchWord != ''"&gt;
			AND (title LIKE '%${searchWord}%' OR content LIKE '%${searchWord}%')
			&lt;/if&gt;
		GROUP BY a.articleno, title, a.regdate, hit, m.name
		ORDER BY articleno DESC
		LIMIT <%="#" %>{offset}, <%="#" %>{rowCount}
	&lt;/select&gt;

	&lt;select id="selectCountOfArticles" parameterType="hashmap" resultType="int"&gt;
		SELECT count(*) FROM article 
		WHERE 
			boardcd = <%="#" %>{boardCd}
			&lt;if test="searchWord != null and searchWord != ''"&gt;
			AND (title LIKE '%${searchWord}%' OR content LIKE '%${searchWord}%')
			&lt;/if&gt;
	&lt;/select&gt;

	&lt;insert id="insert" parameterType="Article" useGeneratedKeys="true" keyProperty="articleNo"&gt;
		INSERT INTO article (boardcd, title, content, email, hit, regdate)
		VALUES
		(<%="#" %>{boardCd}, <%="#" %>{title}, <%="#" %>{content}, <%="#" %>{email}, 0, now())
	&lt;/insert&gt;
	
	&lt;insert id="insertAttachFile" parameterType="AttachFile"&gt;
		INSERT INTO attachfile (filename, filetype, filesize, articleno, email)
		VALUES
		(<%="#" %>{filename}, <%="#" %>{filetype}, <%="#" %>{filesize}, <%="#" %>{articleNo}, <%="#" %>{email})
	&lt;/insert&gt;

	&lt;update id="update" parameterType="Article"&gt;
		UPDATE article 
		SET title = <%="#" %>{title}, content = <%="#" %>{content} 
		WHERE articleno = <%="#" %>{articleNo}
	&lt;/update&gt;

	&lt;delete id="delete" parameterType="int"&gt;
		DELETE FROM article WHERE articleno = <%="#" %>{articleNo}
	&lt;/delete&gt;

	&lt;update id="updateHitPlusOne" parameterType="int"&gt;
		UPDATE article SET hit = hit + 1 WHERE articleno = <%="#" %>{articleNo}
	&lt;/update&gt;

	&lt;select id="selectOne" parameterType="int" resultType="Article"&gt;
		SELECT 
			articleno,
			title,
			content,
			a.email,
			ifNull(name, 'Anonymous') name,
			hit,
			regdate
		FROM article as a left join member as m on a.email = m.email
		WHERE 
			articleno = <%="#" %>{articleNo}
	&lt;/select&gt;

	&lt;select id="selectNextOne" parameterType="hashmap" resultType="Article"&gt;
		SELECT articleno, title 
		FROM article 
		WHERE 
			boardCd = <%="#" %>{boardCd} 
			AND articleno &amp;gt; <%="#" %>{articleNo}
		&lt;if test="searchWord != null and searchWord != ''"&gt;
			AND (title LIKE '%${searchWord}%' OR content LIKE '%${searchWord}%')
		&lt;/if&gt; 
		ORDER BY articleno
		LIMIT 1
	&lt;/select&gt;
	
	&lt;select id="selectPrevOne" parameterType="hashmap" resultType="Article"&gt;
		SELECT articleno, title 
		FROM article 
		WHERE 
			boardCd = <%="#" %>{boardCd} 
			AND articleno &amp;lt; <%="#" %>{articleNo}
		&lt;if test="searchWord != null and searchWord != ''"&gt;
			AND (title LIKE '%${searchWord}%' OR content LIKE '%${searchWord}%')
		&lt;/if&gt; 
		ORDER BY articleno DESC
		LIMIT 1
	&lt;/select&gt;

	&lt;select id="selectListOfAttachFiles" parameterType="int" resultType="AttachFile"&gt;
		SELECT 
			attachfileno,
			filename,
			filetype,
			filesize,
			articleno,
			email 
		FROM attachfile 
		WHERE articleno = <%="#" %>{articleNo} 
		ORDER BY attachfileno
	&lt;/select&gt;

	&lt;delete id="deleteFile" parameterType="int"&gt;
		DELETE FROM attachfile WHERE attachfileno = <%="#" %>{attachFileNo}
	&lt;/delete&gt;

	&lt;select id="selectOneBoardName" parameterType="string" resultType="string"&gt;
		SELECT boardNm FROM board WHERE boardcd = <%="#" %>{boardCd}
	&lt;/select&gt;

	&lt;insert id="insertComment" parameterType="Comment"&gt;
		INSERT INTO comments (articleno, email, memo, regdate)
		VALUES (<%="#" %>{articleNo}, <%="#" %>{email}, <%="#" %>{memo}, now())
	&lt;/insert&gt;

	&lt;update id="updateComment" parameterType="Comment"&gt;
		UPDATE comments SET memo = <%="#" %>{memo} WHERE commentno = <%="#" %>{commentNo}
	&lt;/update&gt;
	
	&lt;delete id="deleteComment" parameterType="int"&gt;
		DELETE FROM comments WHERE commentno = <%="#" %>{commentNo}
	&lt;/delete&gt;

	&lt;select id="selectListOfComments" parameterType="int" resultType="Comment"&gt;
		SELECT 
			commentno, 
			articleno, 
			c.email, 
			ifNull(name, 'Anonymous') name,
			memo, 
			regdate
		FROM comments as c left join member as m on c.email = m.email
		WHERE 
			articleno = <%="#" %>{articleNo}
		ORDER BY commentno DESC
	&lt;/select&gt;

	&lt;select id="selectOneAttachFile" parameterType="int" resultType="AttachFile"&gt;
		SELECT
			attachfileno,
			filename,
			filetype,
			filesize,
			articleno,
			email
		FROM
			attachfile
		WHERE
			attachfileno = <%="#" %>{attachfileno}
	&lt;/select&gt;

	&lt;select id="selectOneComment" parameterType="int" resultType="Comment"&gt;
		SELECT 
			commentno,
			articleno,
			email,
			memo,
			regdate 
		FROM comments 
		WHERE
			commentno = <%="#" %>{commentNo}
	&lt;/select&gt;

 &lt;/mapper&gt;
</pre>

UserMapper.xml은 수정할 게 없다.<br />
페이징 유틸리티 클래스는 MySQL의 LIMIT 연산자에 필요한 값을 주도록 수정한다.

<em class="filename">PagingHelper.java</em>
<pre class="prettyprint">
package net.java_school.commons;

public class PagingHelper {
    private int totalPage; // 총 페이지 수(마지막 페이지 번호)	
    private int firstPage; // 현재 블록의 첫 번째 페이지 번호
    private int lastPage; // 현재 블록의 마지막 페이지 번호
    private int prevPage; // [이전] 링크 페이지 번호
    private int nextPage; // [다음] 링크 페이지 번호
    private int listItemNo; // 목록 아이템 앞에 붙는, 프로그램적으로 계산된 번호
    private int startRecord; // 현재 페이지의 목록 쿼리에서 사용할 오라클 시작 ROWNUM
    private int endRecord; // 현재 페이지의 목록 쿼리에서 사용할 오라클 마지막 ROWNUM
    <strong>private int numPerPage; //페이지당 보일 레코드 수</strong>
    
    public PagingHelper(int totalRecord, int page, int numPerPage, int pagePerBlock) {
        <strong>this.numPerPage = numPerPage;</strong>	
        //총 페이지 수
        this.totalPage = totalRecord / numPerPage;
        if (totalRecord % numPerPage != 0) this.totalPage++;
        
        //총 블록 수
        int totalBlock = totalPage / pagePerBlock;
        if (totalPage % pagePerBlock != 0) totalBlock++;
        
        //현재 블록
        int block = page / pagePerBlock;
        if (page % pagePerBlock != 0) block++;
        
        //현재 블록에 속한 첫 번째 페이지 번호와 마지막 페이지 번호
        firstPage = (block - 1) * pagePerBlock + 1;
        lastPage = block * pagePerBlock;
        
        //현재 블록이 1보다 크다면 [이전] 링크를 위한 페이지 번호 계산
        if (block > 1) {
            prevPage = firstPage - 1;
        }
        
        //현재 블록이 총 블록 수(마지막 블록 번호)보다 작다면 [다음] 링크를 위한 페이지 번호 계산 
        if (block &lt; totalBlock) {
            nextPage = lastPage + 1;
        }
        
        //현재 블록이 마지막 블록이라면 현재 블록의 마지막 페이지 번호를 총 페이지 수로 변경
        if (block &gt;= totalBlock) {
            lastPage = totalPage;
        }
        
        //현재 페이지의 목록 아이템 앞에 붙일 번호 계산
        listItemNo = totalRecord - (page - 1) * numPerPage;
        
        //현재 페이지의 목록을 위한 첫 번째 레코드 번호와 마지막 레코드 번호 계산
        startRecord = (page - 1) * numPerPage + 1;
        endRecord = page * numPerPage;
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
    <strong>
    public int getNumPerPage() {
    	return numPerPage;
    }
	</strong>
}
</pre>

<em class="filename">BoardServiceImpl.java</em>
<pre class="prettyprint">
//목록
@Override
public List&lt;Article&gt; getArticleList(String boardCd, String searchWord) {
	Integer offset = pagingHelper.getStartRecord() - 1; //for mysql limit first number
	Integer rowCount = pagingHelper.getNumPerPage();
	
	return boardMapper.selectListOfArticles(boardCd, searchWord, offset, rowCount);
}
</pre>


<em class="filename">BoardMapper.java</em>
<pre class="prettyprint">
import org.apache.ibatis.annotations.Param;

//목록
public List&lt;Article&gt; selectListOfArticles(
		@Param("boardCd") String boardCd,
		@Param("searchWord") String searchWord,
		@Param("offset") Integer offset,
		@Param("rowCount") Integer rowCount);	
</pre>

<h3>톰캣 컨텍스트 파일</h3>

<pre class="shell-prompt">
cd /etc/tomcat7/Catalina/localhost
sudo nano springBbsMysql.xml
</pre>

아래를 복사하여 파일에 붙여 넣는다.

<em class="filename">springBbsMysql.xml</em>
<pre class="prettyprint">
&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;Context
    docBase="/home/kim/Lab/maven/SpringBbsMysql/src/main/webapp"
    reloadable="true"&gt;
&lt;/Context&gt;
</pre>

메이븐 루트 디렉토리로 가서 컴파일을 실행한다.<br />

<pre class="shell-prompt">
mvn clean compile war:inplace
</pre>

톰캣을 재실행한다.
<pre class="shell-prompt">
sudo service tomcat7 restart
</pre>

http://localhost:8080/springBbsMysql에 방문하여 MySql용 스프링 MVC 게시판 애플리케이션이 동작하는지 확인한다.

<h3>git</h3>
오라클용 스프링 게시판 애플리케이션이 없다면 다음 명령어로 프로젝트를 복제한다.

<pre class="shell-prompt">
git clone https://github.com/kimjonghoon/SpringBbsMySql
</pre>
<span id="refer">참고</span>
<ul id="references">
	<li><a href="https://fosskb.wordpress.com/2015/04/18/installing-openstack-kilo-on-ubuntu-15-04-single-machine-setup/">https://fosskb.wordpress.com/2015/04/18/installing-openstack-kilo-on-ubuntu-15-04-single-machine-setup/</a></li>
</ul>