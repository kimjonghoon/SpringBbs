SpringBbs
============

## A Bulletin Board Program with 
* Spring MVC
* MyBatis-Spring
* Spring-Security
* Bean Validation
* i18n
* Apache Tiles

## Database Design

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
	
	INSERT INTO member VALUES ('hong@gmail.org','1111','홍길동','010-1111-1111');
	INSERT INTO member VALUES ('im@gmail.org','1111','임꺽정','010-1111-2222');
	
	INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_USER');
	INSERT INTO authorities VALUES ('hong@gmail.org','ROLE_ADMIN');
	INSERT INTO authorities VALUES ('im@gmail.org','ROLE_USER');
	
	commit;

## Have to do
 
1. Edit **UPLOAD_PATH** in net.java_school.commons.WebContants.java
2. Edit full path of your log file in /src/main/resources/log4j.xml's &lt;param name="File" value="**Full path of your log file**"/&gt;
3. Save the Oracle JDBC driver(ojdbc6.jar) to your local repository with the following command: 
> mvn install:install-file -Dfile=ojdbc6.jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0.2.0 -Dpackaging=jar

## How to compile

$ mvn clean compile war:inplace
    




