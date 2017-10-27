<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2014.5.20</div>

<h1>SQL 실습 - SCOTT계정</h1>

11g XE를 설치했다면 정식버전에 있는 SCOTT 테스트 계정이 없을 것이다.<sup>1</sup><br />
<em class="path">C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\</em>
에서 scott.sql<sup>2</sup>을 찾을 수 있다.<br />
SQL*Plus(SQL를 실행할 수 있는 오라클 커맨드 라인 프로그램이다.)를 사용해 SYSTEM 계정으로 접속한 후 아래를 실행한다.<br />
<em class="path">@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql</em><br />
커서가 떨어지면 show user 명령어로 계정을 확인하면 SYSTEM 아닌 SCOTT 으로 바뀌어 있을 것이다.<br />
alter user scott identified by tiger;<br />
명령어로 비밀번호를 tiger로 바꾼다.<sup>3</sup><br />
<br />
오라클은 데이터베이스 객체안에 사용자 단위로 오라클 객체(테이블, 뷰, 시퀀스, 인덱스 등)를 관리한다.<br />
scott.sql 파일을 실행하면 파일의 내용대로 SCOTT 계정이 만들어 지고 SCOTT 계정 안에서는 테이블이 만들어진다.<br />
SCOTT 계정에는 어떤 테이블이 있는지 알아보자.<br />
<br />
<strong>select * from tab;</strong><br />
<br />
DEPT, EMP, BONUS, SALGRADE 테이블이 있음을 확인할 수 있다.<br />
<br />
이제 각 테이블의 구조를 살펴보자<br />
먼저 DEPT 테이블 구조부터 확인한다.<br />
<br />
<strong>desc dept;</strong><br />
<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; desc dept;
 이름                                      널?      유형
 ----------------------------------------- -------- -------------------

 DEPTNO                                    NOT NULL NUMBER(2)
 DNAME                                              VARCHAR2(14)
 LOC                                                VARCHAR2(13)

SQL&gt;
</pre>

이름은 컬럼명(열명)이다.<br />
유형은 자바에서 자료형과 같은 의미로 컬럼에 지정된 데이터 형을 의미한다.<br />
자바에서 변수에 데이터 유형을 지정하듯이 데이터베이스에서는 컬럼에 데이터 유형을 지정한다.<br />
지정된 유형의 값만이 해당 컬럼에 저장될 수 있다.<br />
<br />
DEPT 테이블은 첫번째 컬럼의 이름은 DEPTNO 이며 널값이 들어갈 수 없고 NUMBER 형이다.<br />
두번째 컬럼의 이름은 DNAME 이며 널값이 허용되고 VARCHAR2 형이다.<br />
세번째 컬럼의 이름은 LOC 이며 널값이 허용되고 VARCHAR2 형이다.<br />

<dl class="note">
<dt>NULL 이란?</dt>
<dd>
컬럼에 어떤 값도 들어 있지 않다는 것을 의미한다.<br />
연산, 비교가 불가능하다.<br />
0도 공백문자(SPACE)도 아니다.<br />
만일 NULL이 없다면 컬럼에 어떤 값도 들어 있지 않다는 것을 표현하기가 애매할 것이다.
</dd>
<dt>오라클의 대표적인 데이터 형</dt>
<dd>
데이터 형은 데이터베이스마다 다르다.<br />
오라클의 대표적인 데이터 형은 다음과 같다.<br />
<br />
<strong>NUMBER</strong>(PRECISION,SCALE)<br />
숫자를 저장하기 위한 데이터 형<br />
PRECISION : 소수점을 포함한 전체 자리수<br />
SCALE : 소수점 이하 자리수<br />
<br />
예) 72.5 은 NUMBER(3,1), 10 은 NUMBER(2),<br /> 
7788은 NUMBER(4), 어떤숫자도 상관없다면 NUMBER<br />
<br />
<strong>DATE</strong><br />
날짜 및 시간 데이터를 저장하기 위한 데이터 형<br />
<br />
<strong>VARCHAR2</strong>(숫자)<br />
가변적인 문자열를 저장하기 위한 데이터 형<br />
괄호안은 바이트 수를 의미한다.<br />
만일 컬럼의 데이터 형이 VARCHAR2(15)라면 최대 15바이트의 문자열을 저장할 수 있다.<br />
(오라클 캐리터셋이 KO16KSC5601 이나 KO16MSWIN949 이면 한글은 2바이트, 영어는 1바이트이다.<br />
UTF8 이나  AL32UTF8 이면 한글은 3바이트, 영어는 1바이트이다.)<br />
</dd>
</dl>

dept 테이블 구조를 알았으니 dept 테이블에 담겨있는 레코드를 확인한다.<br />
(레코드는 테이블이나 조회결과의 한 행을 의미하는 말이다.)<br />
<br />
<strong>select * from dept;</strong><br />
<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; select * from dept;

    DEPTNO DNAME                        LOC
---------- ---------------------------- --------------------------
        10 ACCOUNTING                   NEW YORK
        20 RESEARCH                     DALLAS
        30 SALES                        CHICAGO
        40 OPERATIONS                   BOSTON

SQL&gt;
</pre>

(참고로, SQL문은 대소문자를 가리지 않는다. 하지만 이 말이 SQL문 속의 데이터까지 대소문자를 구별하지 않는다는 말은 아니다.)<br />
<br />
dept 테이블은 부서 테이블이다.<br />
deptno 컬럼에는 부서번호, dname 컬럼에는 부서명, loc 컬럼에는 부서위치 데이터를 저장한다.<br />
select 문장은 테이블에서 레코드를 가져올 때 사용하는 SQL문이다.<br />
<br />
다음은 테이블 EMP 테이블의 구조를 알아보자.<br />
<br />
<strong>desc emp;</strong>
<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; desc emp;
 이름                                      널?      유형
 ----------------------------------------- -------- ----------------------------

 EMPNO                                     NOT NULL NUMBER(4)
 ENAME                                              VARCHAR2(10)
 JOB                                                VARCHAR2(9)
 MGR                                                NUMBER(4)
 HIREDATE                                           DATE
 SAL                                                NUMBER(7,2)
 COMM                                               NUMBER(7,2)
 DEPTNO                                             NUMBER(2)

SQL&gt;
</pre>

1. EMPNO(사원번호)<br />
2. ENAME(이름)<br />
3. JOB(직책)<br />
4. MGR(직속상사 사원번호)<br />
5. HIREDATE(입사일)<br />
6. SAL(월급여)<br />
7. COMM(커미션)<br />
8. DEPTNO(부서번호)<br />
<br />
컬럼의 데이터 형도 확인할 것.<br />
<br />
데이터 형까지 확인했다면 이제 EMP 테이블에 담긴 모든 사원 레코드를 조회한다.<br />
<br /> 
<strong>select * from emp;</strong>
<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; select * from emp;

EMPNO ENAME  JOB           MGR  HIREDATE   SAL     COMM    DEPTNO   
---- -------------------------- --------   ------- ------- -------
7369 SMITH   CLERK         7902 80/12/17   800               20   
                                                                  
7499 ALLEN   SALESMAN      7698 81/02/20   1600     300      30   
                                                                  
7521 WARD    SALESMAN      7698 81/02/22   1250     500      30   
                                                                  
7566 JONES   MANAGER       7839 81/04/02   2975              20   
                                                                  
7654 MARTIN  SALESMAN      7698 81/09/28   1250     1400     30   
                                                                  
7698 BLAKE   MANAGER       7839 81/05/01   2850              30   
                                                                  
7782 CLARK   MANAGER       7839 81/06/09   2450              10   
                                                                  
7839 KING    PRESIDENT          81/11/17   5000              10   
                                                                  
7844 TURNER  SALESMAN      7698 81/09/08   1500       0      30   
                                                                  
7900 JAMES   CLERK         7698 81/12/03   950               30   
                                                                  
7902 FORD    ANALYST       7566 81/12/03   3000              20   
                                                                  
7934 MILLER  CLERK         7782 82/01/23   1300              10   
      


12 개의 행이 선택되었습니다.

SQL&gt;
</pre>

사원은 총 12명이다.<br />
직책(job)이 영업인 사원만이 월급여 외 커미션이 있다.<br />
나머지 사원의 커미션 컬럼은 NULL 이다.<br />
TURNER 은 실적이 부진했는지 커미션이 0달러이다.<br />
KING 은 직속상사의 사원번호가 NULL이다. 직책이 회장(PRESIDENT)이기 때문이다.<br />
<br />
다음으로 SALGRADE 테이블의 구조를 확인하자.<br />
<br />
<strong>desc salgrade;</strong><br />
<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; desc salgrade;
 이름                                      널?      유형
 ----------------------------------------- -------- ----------------------------

 GRADE                                              NUMBER
 LOSAL                                              NUMBER
 HISAL                                              NUMBER

SQL&gt;
</pre>

sqlgrade 테이블은 월급여의 등급에 대한 테이블이다.<br />
grade 은 월급여등급, losal 은 등급별 최소월급여, hisal 은 등급별 최대월급여 컬럼이다.<br />
이제 sqlgrade 테이블의 데이터를 확인하다.<br />
<br />
<strong>select * from salgrade;</strong><br />
<br />

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; select * from salgrade;

     GRADE      LOSAL      HISAL
---------- ---------- ----------
         1        700       1200
         2       1201       1400
         3       1401       2000
         4       2001       3000
         5       3001       9999

SQL&gt;
</pre>

1등급은 700 ~ 1200달러의 사이의 월급여,<br />
2등급은 1201 ~ 1400달러 사이의 월급여,<br />
3등급은 1401 ~ 2000달러 사이의 월급여,<br />
4등급은 2001 ~ 3000달러 사이의 월급여,<br />
5등급은 3001 ~ 9999달러 사이의 월급여를 의미한다.<br />
<br />

SQL*PLUS를 종료하려면 exit 실행한다.<br />
scott계정에 접속하려면 명령 프롬프트에서 sqlplus 입력하고 엔터를 눌러 SQL*PLUS를 실행한다.<br />
SQL*PLUS는 곧바로 다음과 같이 계정명과 비밀번호를 물어온다.<br />
<pre class="code">
Enter user-name: scott
Enter password: tiger
</pre>

제대로 입력하면 scott계정으로 접속할 수 있게 된다.<br />
관리자로 접속하려면 user-name에 system을, password에는 오라클을 설치할 때 정해준 비밀번호를 입력한다.<br />

<span id="comments">주석</span>
<ol>
	<li>XE가 아닌 Oracle Database 11g Release 2를 설치한 경우는 SCOTT계정이 만들어져 있다.<br />
	하지만 락(lock)이 걸려 있으니 관리자 계정에서 alter user scott account unlock 으로 락을 풀어야 사용할 수 있다.
	락을 푼 후 처음 접속할 때 scott계정의 비밀번호를 바꾸라고 지시하는데, 이어지는 글에서의 예제의 일관성을 위해서 
	기존 패스워드 tiger를 그대로 사용하기로 한다.</li>
	<li>리눅스의 경우 동일한 내용의 파일은 utlsampl.sql 이다.</li>
	<li>XE의 경우 scott.sql 에서 설정한 대로라면 scott계정의 비밀번호는 대문자 TIGER이다.<br />
	이어지는 글의 일관성을 위해서 alter user scott identified by tiger; 로 소문자로 비밀번호를 바꾸어 준다.</li>
	
</ol>