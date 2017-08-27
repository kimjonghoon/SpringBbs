SpringBbs
============

## A Bulletin Board Program with 
* Spring MVC
* MyBatis-Spring
* Spring-Security
* Bean Validation
* i18n
* Apache Tiles

## Database Design (Oracle)

	GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO java IDENTIFIED BY school;
	ALTER USER java DEFAULT TABLESPACE USERS;
	ALTER USER java TEMPORARY TABLESPACE TEMP;
	
	CONNECT java/school
	
	create table member (
	    email varchar2(60) PRIMARY KEY,
	    passwd varchar2(200) NOT NULL,
	    name varchar2(20) NOT NULL,
	    mobile varchar2(20)
	);
	
	create table board (
	    boardcd varchar2(20),
	    boardnm varchar2(40) NOT NULL,
	    boardnm_ko varchar2(40),
	    constraint PK_BOARD PRIMARY KEY(boardcd)
	);
	
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
	
	create sequence SEQ_ARTICLE
	increment by 1
	start with 1;
	
	create table comments (
	    commentno number,
	    articleno number,    
	    email varchar2(60),    
	    memo varchar2(4000) NOT NULL,
	    regdate date, 
	    constraint PK_COMMENTS PRIMARY KEY(commentno)
	);
	
	create sequence SEQ_COMMENTS
	    increment by 1
	    start with 1;
	
	create table attachfile (
	    attachfileno number,
	    filename varchar2(50) NOT NULL,
	    filetype varchar2(30),
	    filesize number,
	    articleno number,
	    email varchar2(60),
	    constraint PK_ATTACHFILE PRIMARY KEY(attachfileno)
	);
	
	create sequence SEQ_ATTACHFILE
	increment by 1
	start with 1;
	
	CREATE TABLE authorities (
	  email VARCHAR2(60) NOT NULL,
	  authority VARCHAR2(20) NOT NULL,
	  CONSTRAINT fk_authorities FOREIGN KEY(email) REFERENCES member(email)
	);
	
	CREATE UNIQUE INDEX ix_authorities ON authorities(email, authority); 
	
	-- for test records  
	insert into board values ('free', 'Free', '자유게시판');
	insert into board values ('qna', 'Q and A', '묻고 답하기');
	insert into board values ('data', 'Data', '자료실');
	
	commit;
	
	create table views (
		no number,
		articleNo number,
		ip varchar(60),
		yearMonthDayHour char(10),
		constraint PK_VIEWS PRIMARY KEY(no),
		constraint UNIQUE_VIEWS UNIQUE(articleNo, ip, yearMonthDayHour)
	);

	create sequence SEQ_VIEWS
		increment by 1
		start with 1;
	

## Database Design (MySql)

	mysql --user=root --password mysql
	
	create user 'java'@'%' identified by 'school';
	grant all privileges on *.* to 'java'@'%';
	
	create database javaskool;
	exit;
	
	mysql --user=java --password javaskool
	
	create table member (
	    email varchar(60) PRIMARY KEY,
	    passwd varchar(200) NOT NULL,
	    name varchar(20) NOT NULL,
	    mobile varchar(20)
	);
	
	create table authorities (
	    email VARCHAR(60) NOT NULL,
	    authority VARCHAR(20) NOT NULL,
	    CONSTRAINT fk_authorities FOREIGN KEY(email) REFERENCES member(email)
	);
	
	CREATE UNIQUE INDEX ix_authorities ON authorities(email,authority); 
	
	create table board (
	    boardcd varchar(20),
	    boardnm varchar(40) NOT NULL,
	    boardnm_ko varchar(40) NOT NULL,
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
	    filekey varchar(255),
	    creation datetime,
	    constraint PK_ATTACHFILE PRIMARY KEY(attachfileno)
	);
	
	insert into board values ('free','Free','자유 게시판');
	commit;
	
	create table views (
		no int primary key AUTO_INCREMENT,
		articleNo int,
		ip varchar(60),
		yearMonthDayHour char(10),
		unique key (articleNo, ip, yearMonthDayHour)
	);

## Have to do
 
1. Edit **UPLOAD_PATH** in net.java_school.commons.WebContants.java
2. Edit full path of your log file in /src/main/resources/log4j.xml's &lt;param name="File" value="**Full path of your log file**"/&gt;
3. Install the Oracle JDBC driver(ojdbc6.jar) to your local repository with the following command:
 
> mvn install:install-file -Dfile=ojdbc6.jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0.2.0 -Dpackaging=jar

## How to compile

$ mvn clean compile war:inplace

## Oracle -> MySql

### 1. spring-bbs-servlet.xml

> <!-- <mybatis:scan base-package="net.java_school.mybatis.oracle" /> -->
> <mybatis:scan base-package="net.java_school.mybatis.mysql" />

### 2. applicationContext.xml
	
	<!--
	<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close">
		<property name="driverClassName" value="oracle.jdbc.driver.OracleDriver" />
		<property name="url" value="jdbc:oracle:thin:@localhost:1521:XE" />
		<property name="username" value="java" />
		<property name="password" value="school" />
		<property name="maxActive" value="100" />
		<property name="maxWait" value="1000" />
		<property name="poolPreparedStatements" value="true" />
		<property name="defaultAutoCommit" value="true" />
		<property name="validationQuery" value=" SELECT 1 FROM DUAL" />
	</bean>
	-->
	
	<bean id="dataSource" class="org.apache.commons.dbcp.BasicDataSource" destroy-method="close">
		<property name="driverClassName" value="com.mysql.jdbc.Driver" />
		<property name="url" value="jdbc:mysql://localhost:3306/javaskool?useUnicode=yes&amp;characterEncoding=UTF-8" />
		<property name="username" value="java" />
		<property name="password" value="school" />
		<property name="maxActive" value="100" />
		<property name="maxWait" value="1000" />
		<property name="poolPreparedStatements" value="true" />
		<property name="defaultAutoCommit" value="true" />
		<property name="validationQuery" value="SELECT 1" />
	</bean>

### 3. AdminController.java

	/*
	//oralce
	int startRecord = (page - 1) * numPerPage + 1;
	int endRecord = page * numPerPage;
	List<User> list = userService.getAllUser(search, startRecord, endRecord);
	*/
	
	//mysql
	int offset = (page - 1) * numPerPage;
	List<User> list = userService.getAllUser(search, offset, numPerPage);

### 4. BbsController.java (in list() and view() methods)

	/*
	//oracle
	Integer startRecord = (page - 1) * numPerPage + 1;
	Integer endRecord = page * numPerPage;
		
	HashMap<String, String> map = new HashMap<String, String>();
	map.put("boardCd", boardCd);
	map.put("searchWord", searchWord);
	map.put("start", startRecord.toString());
	map.put("end", endRecord.toString());
	List<Article> list = boardService.getArticleList(map);
	*/
	
	//mysql
	Integer offset = (page - 1) * numPerPage;
	HashMap<String, String> map = new HashMap<String, String>();
	map.put("boardCd", boardCd);
	map.put("searchWord", searchWord);
	map.put("offset", offset.toString());
	Integer rowCount = numPerPage;
	map.put("rowCount", rowCount.toString());
	List<Article> list = boardService.getArticleList(map);

### 5. UserServiceImpl.java
	
	//import net.java_school.mybatis.oracle.UserMapper;
	import net.java_school.mybatis.mysql.UserMapper;
	
### 6. BoardServiceImpl.java

	//import net.java_school.mybatis.oracle.BoardMapper;
	import net.java_school.mybatis.mysql.BoardMapper;