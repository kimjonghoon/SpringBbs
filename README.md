SpringBbs
============

#BBS using Spring MVC + MyBatis-Spring + Spring-Security + Bean Validation

##Database design

	GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO java IDENTIFIED BY school;
	ALTER USER java DEFAULT TABLESPACE USERS;
	ALTER USER java TEMPORARY TABLESPACE TEMP;
	CONNECT java/school
	
	create table member (
	    email varchar2(60) PRIMARY KEY,
	    passwd varchar2(20) NOT NULL,
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
	
	insert into board values ('free', 'Free', '자유게시판');
	insert into board values ('qna', 'Q and A', '묻고 답하기');
	insert into board values ('data', 'Data', '자료실');
	commit;

##have to edit
 
1. net.java_school.commons.WebContants.java's UPLOAD_PATH

2. /src/main/resources/log4j.xml 
&lt;param name="File"  value="{Full path of log file}"/&gt; 

3. ojdbc6.jar -&gt; {TOMCAT_HOME}/lib

##How to compile and Run

$ mvn clean compile war:inplace
    




