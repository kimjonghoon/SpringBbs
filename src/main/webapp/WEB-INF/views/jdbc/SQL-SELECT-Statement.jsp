<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
    
<div id="last-modified">Last Modified : 2011.1.7</div>

<h1>SQL 연습 - SELECT 문</h1>

SQL도 역시 표준이 존재한다.<br />
여기서는 오라클을 사용하지만 표준 SQL 위주로 실습한다.<br />
SELECT 문장은 순서에 유의해서 작성해야 한다.<br />
"SELECT <em>column1,column2,..</em> FROM <em>table_name</em>" 까지는 필수적으로 작성해야 한다.<br />

<pre class="prettyprint">
SELECT 컬럼,컬럼...
FROM 테이블명 
WHERE 조건 
GROUP BY 구문 
UNION/UNION ALL/INTERSECT/MINUS 구문 
ORDER BY 구문
</pre>

SQL*PLUS로 scott계정에 접속한 후 다음에 나오는 모든 SQL문을 실행한다.<br />

<h3>사원 테이블의 모든 레코드를 조회하시오.</h3>
<pre class="prettyprint">
SELECT * 
FROM EMP
</pre>
<pre class="prettyprint">
SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO 
FROM EMP
</pre>

위 두 SQL문은 같은 레코드를 가져온다.<br />
select 다음에  * 사용하면 <em>모든 컬럼을 순서대로</em> 를 의미한다.<br />

<h3>사원명과 입사일을 조회하시오.</h3>
<pre class="prettyprint">
SELECT ENAME,HIREDATE
FROM EMP;
</pre>

<h3>사원번호와 이름을 조회하시오.</h3>
<pre class="prettyprint">
SELECT DEPTNO,ENAME 
FROM EMP
</pre>

컬럼을 선택하여 조회할 수 있고 컬럼의 순서를 바꾸어 조회할 수 있다. 

<h3>사원테이블에 있는 직책의 목록을 조회하시오.</h3>
<pre class="prettyprint">
SELECT DISTINCT JOB
FROM
EMP
</pre>
DISTINCT는 검색 결과에서 중복된 레코드는 한 번만 보여주어야 할 때 사용한다.

<h3>총 사원수를 구하시오.</h3>
<pre class="prettyprint">
SELECT COUNT(EMPNO)
FROM
EMP
</pre>
COUNT는 그룹함수의 하나로  검색된 레코드의 수를 반환한다.<br />
COUNT(컬럼명)은 NULL이 아닌 레코드의 수를,COUNT(*)은  NULL을 포함한 레코드의 수를 반환한다.<br /> 

<h2>WHERE 조건</h2>
<h3>부서번호가 10인 사원을 조회하시오.</h3>
<pre class="prettyprint">
SELECT * 
FROM EMP
WHERE DEPTNO = 10;
</pre>

<h3>월급여가 2500이상 되는 사원을 조회하시오.</h3>
<pre class="prettyprint">
SELECT *
FROM EMP
WHERE SAL &gt;= 2500;
</pre>
where 조건이 추가되었다.<br />
이제 where 다음에 나오는 조건에 맞는 레코드만 선별해서 가져오게 된다.<br />
위 SQL문은 where 조건에  =,&gt;,&gt;=,&lt;=,&lt; 비교 연산자를 사용한 예이다.<br />

<h3>이름이 'KING'인 사원을 조회하시오.</h3>
<pre class="prettyprint">
SELECT *
FROM EMP
WHERE ENAME = 'KING';
</pre>
SQL문장은 대소문자를 가리지 않는다고 했다.<br />
하지만 컬럼에 들어가는 데이터는 당연히 대소문자를 가린다.<br /> 
KING라고 저장되어 있는데 king로는 검색되지 않는다.<br />

<h3>사원들 중 이름이 S로 시작하는 사원의 사원번호와 이름을 조회하시오.</h3>   
<pre class="prettyprint">
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME LIKE 'S%';
</pre>

<h3>사원 이름에 T가 포함된 사원의 사원번호와 이름을 조회하시오.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME LIKE '%T%';
</pre>
LIKE 는  % 와 _문자와 함께 검색시 사용된다.<br />

<dl class="note">
<dt>SQL*PLUS 사용법</dt>
<dd>
명령 버퍼에 있는 SQL문을 편집하는 방법을 소개한다.<br />
SQL문을 잘못 입력했을 때 유용하다.<br />
<br />
<strong>ed</strong><br />
<br />
SQL*PLUS 에서 ed 명령어를 실행하면 버퍼에 있는 내용을 시스템의 디폴트 편집기가 실행되면서 보여준다.<br />
윈도우의 경우 메모장이 실행되면서 버퍼에 저장된 SQL문를 보여주게 된다.<br />
메모장에 있는 내용을 수정하고 닫은 다음에 / 명령으로 버퍼의 SQL문을 실행할 수 있다.<br />
<br />
<strong>/</strong>
</dd>
</dl>

<h3>커미션이 300, 500, 1400 인 사원의 사번,이름,커미션을 조회하시오.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;
</pre>

<pre class="prettyprint">
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM IN (300,500,1400);
</pre>
둘 다 같은 결과를 보여주는 SQL문이다.<br />
첫번째 SQL문은 논리 연산자 OR 를 사용했고 두번째는 IN 을 사용했다.<br />

<h3>월급여가 1200 에서 3500 사이의 사원의 사번,이름,월급여를 조회하시오.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL BETWEEN 1200 AND 3500;
</pre>
BETWEEN ~ AND ~ 사용법이다.<br />
<em>SAL BETWEEN 1200 AND 3500</em> 은 수학적으로 1200 &lt;= SAL &lt;= 3500 와 같다.<br />

<h3>직급이 매니저이고 부서번호가 30번인 사원의  이름,사번,직급,부서번호를 조회하시오.</h3>
<pre class="prettyprint">
SELECT ENAME,EMPNO,JOB,DEPTNO
FROM EMP
WHERE DEPTNO = 30 AND JOB = 'MANAGER';
</pre>

<h3>부서번호가 30인 아닌 사원의 사번,이름,부서번호를 조회하라.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,DEPTNO
FROM EMP
WHERE NOT DEPTNO = 30;
</pre>

<h3>커미션이 300, 500, 1400 이 모두 아닌 사원의 사번,이름,커미션을 조회하라.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM NOT IN (300,500,1400);
</pre>

<h3>이름에 S가 포함되지 않는 사원의 사번,이름을 조회하라.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME NOT LIKE '%S%';
</pre>

<h3>급여가 1200보다 미만이거나 3700 초과하는 사원의 사번,이름,월급여를 조회하라.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL NOT BETWEEN 1200 AND 3700;
</pre>
AND, OR, NOT 사용법이다.<br />

<h3>직속상사가 NULL 인 사원의 이름과 직급을 조회하라.</h3>
<pre class="prettyprint">
SELECT ENAME,JOB
FROM EMP
WHERE MGR IS NULL;
</pre>
컬럼이 NULL 인지 아닌지를 알기 위한 IS NULL, IS NOT NULL 의 사용법이다. 

<!-- GROUP BY 구문 -->
<h2>GROUP BY 구문</h2>
<pre class="prettyprint">
SELECT DEPTNO,AVG(SAL)
FROM EMP
</pre>
위 SQL문의 의도는 DEPTNO별로 월급여 평균값을 구하는 것일 것이다.<br />
이때 그룹화의 기준이 되는 컬럼은 DEPTNO 이다.<br />
그룹함수와 그룹화의 기준이 되는 컬럼이 함께 쓰일 때는 이 컬럼을 GROUP BY 로 명시해 주어야 에러가 나지 않는다.<br />  

<h3>부서별 평균월급여를 구하는 쿼리</h3>
<pre class="prettyprint">
SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO;
</pre>

<h3>부서별 전체 사원수와 커미션을 받는 사원들의 수를 구하는 쿼리</h3>
<pre class="prettyprint">
SELECT DEPTNO,COUNT(*),COUNT(COMM)
FROM EMP
GROUP BY DEPTNO;
</pre>

<h3>부서별 최대 급여와 최소 급여를 구하는 쿼리</h3>
<pre class="prettyprint">
SELECT DEPTNO,MAX(SAL),MIN(SAL)
FROM EMP
GROUP BY DEPTNO;
</pre>
HAVING 은 GROUP BY 절에서 생성된 결과 값 중 원하는 조건에 부합하는 자료 추출할 때 사용한다.<br />

<h3>부서별로 월급여 평균을 구하되 나온 결과값이 2000 이상인 것만 구하는 쿼리</h3>
<pre class="prettyprint">
SELECT DEPTNO,AVG(SAL)
FROM EMP
WHERE AVG(SAL) &gt;= 2000;
GROUP BY DEPTNO;
</pre>
GROUP BY 구문을 사용하면서 이 결과에 조건을 줄 때 WHERE 조건문을 사용할 수 없다.<br />
따라서 위 쿼리는 에러를 발생한다.<br />
GROUP BY 구문을 사용하면서 조건을 주기 위해서는 대신 HAVING 구문을 사용한다.<br />
HAVING 구문 에서는 그룹화의 기준이 되는 컬럼과 그룹함수만이 사용 할 수 있다는 점을 주의해야 한다.<br />
위의 쿼리문에서는 그룹화의 기준이 되는 컬럼이 DEPTNO 이므로 DEPTNO 는 HAVING 구문에 쓸 수 있다.<br />
<pre class="prettyprint">
SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) &gt;= 2000;
</pre>

<h3>월급여가 1000 이상인 사원만을 대상으로 부서별로 월급여 평균을 구하라. 단, 평균값이 2000 이상인 레코드만 구하라.</h3>
<pre class="prettyprint">
SELECT DEPTNO,AVG(SAL)
FROM EMP
WHERE SAL &gt;= 1000
GROUP BY DEPTNO
HAVING AVG(SAL) &gt;= 2000;
</pre>
WHERE 절은 테이블에서 데이터를 가져올 때 그 테이블에서 특정 조건에 부합하는 레코드만을 가져올 때 사용하는 절이고,
HAVING 절은 GROUP BY 구문 사용시 나온 레코드 중에서 원하는 조건에 맞는 레코드만을 가져올 때 사용한다.<br />

<!--  ORDER BY 구문 -->
<h2>ORDER BY 구문</h2>
SELECT 문장을 사용하여 레코드를 검색할 때 임의의 컬럼을 기준으로 정렬을 해야 할 필요가 발생한다.<br />
이런 경우 사용하는 구문이 ORDER BY 이다.<br />
<br />
사용형식은 아래와 같다.<br />
<br />
ORDER BY 정렬의 기준이 되는 컬럼 ASC 또는 DESC;<br />
<br />
ASC : 오름차순을 의미(생략가능)<br />
DESC : 내림차순을 의미<br />

<h3>급여가 높은 순으로 조회하되 급여가 같을 경우 이름의 철자가 빠른 사원순으로 사번,이름,월급여를 조회하시오.</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL DESC,ENAME ASC;
</pre>

<!-- 조인 -->
<h2>조인</h2>
조인은 2개 이상의 테이블에서 데이터를 조회할 때 사용한다.<br />
조인조건은 테이블 N개를 조인할 때 N-1 개의 조인 조건을 주어야 한다.<br />
<br />
사용형식<br />
SELECT 테이블1.컬럼,테이블2.컬럼,....<br />
FROM 테이블1,테이블2,...<br />

<h3>카테시안 곱</h3>
<pre class="prettyprint">
SELECT EMP.ENAME,DEPT.DNAME
FROM EMP,DEPT
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
SQL&gt; select ename,dname
  2  from emp,dept;

ENAME                DNAME
-------------------- ----------------------------
SMITH                ACCOUNTING
ALLEN                ACCOUNTING
WARD                 ACCOUNTING
JONES                ACCOUNTING
MARTIN               ACCOUNTING
BLAKE                ACCOUNTING
CLARK                ACCOUNTING
KING                 ACCOUNTING
TURNER               ACCOUNTING
JAMES                ACCOUNTING
FORD                 ACCOUNTING
MILLER               ACCOUNTING
SMITH                RESEARCH
ALLEN                RESEARCH
WARD                 RESEARCH
JONES                RESEARCH
MARTIN               RESEARCH
BLAKE                RESEARCH
CLARK                RESEARCH
KING                 RESEARCH
TURNER               RESEARCH
JAMES                RESEARCH
FORD                 RESEARCH
MILLER               RESEARCH
SMITH                SALES
ALLEN                SALES
WARD                 SALES
JONES                SALES
MARTIN               SALES
BLAKE                SALES
CLARK                SALES
KING                 SALES
TURNER               SALES
JAMES                SALES
FORD                 SALES
MILLER               SALES
SMITH                OPERATIONS
ALLEN                OPERATIONS
WARD                 OPERATIONS
JONES                OPERATIONS
MARTIN               OPERATIONS
BLAKE                OPERATIONS
CLARK                OPERATIONS
KING                 OPERATIONS
TURNER               OPERATIONS
JAMES                OPERATIONS
FORD                 OPERATIONS
MILLER               OPERATIONS

48 개의 행이 선택되었습니다.

SQL&gt;
</pre>
조인의 기본이 되는 위의 WHERE 조건이 없는 단순조인 결과를 보고 스스로 파악해야 한다.<br />
앞으로 나오는 조인예제는 위와 같은 단순 조인을 머리속에 그리면서 실습해야 한다.<br />
총 56개의 행으로 EMP 테이블에 존재하는 14개의 레코드와 DEPT 테이블에 존재하는 4개의 레코드의 곱으로 생성된 것이다.<br />
조회 대상이 되는 각 테이블의 컬럼이 명백히 어느 테이블의 컬럼인지가 확실하다면 EMP.ENAME 을 ENAME 처럼 테이블명을 
생략 할 수 있다.<br />

<h3>사원명과 부서명을 구하는 쿼리</h3>
<pre class="prettyprint">
SELECT ENAME,DNAME
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
</pre>

<pre class="prettyprint">
SELECT E.ENAME,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO;
</pre>
테이블에 별칭을 사용할 수 있다.<br />
이로써 복잡한 조인문이 간단해 질 수 있다.<br />

<h3>이름,월급여,월급여등급을 조회</h3>
<pre class="prettyprint">
SELECT E.ENAME,E.SAL,S.GRADE
FROM EMP E,SALGRADE S
WHERE E.SAL &gt;= S.LOSAL AND E.SAL &lt;= S.HISAL;
</pre>

WHERE 조건에 조인조건을 = 이외의 비교 연산자를 사용한 조인문이다.<br />
이 SQL문을 BETWEEN ~ AND 문으로 변경하면 아래와 같다.<br />

<pre class="prettyprint">
SELECT E.ENAME,E.SAL,S.GRADE
FROM EMP E,SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
</pre>

<h3>이름,부서명,월급여등급을 조회</h3>
<pre class="prettyprint">
SELECT E.ENAME,D.DNAME,S.GRADE
FROM EMP E,DEPT D,SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL;
</pre>

<h3>이름,직속상사이름을 조회</h3>
<pre class="prettyprint">
SELECT E.ENAME,M.ENAME
FROM EMP E,EMP M
WHERE E.MGR = M.EMPNO;
</pre>

위 결과에 회장에 대한 레코드가 빠졌다.<br />
회장은 직속상사가 없으므로 MGR 컬럼이 NULL 이고 사원번호과 NULL인 사원은 없으므로 조인조건에 만족하지 않아서
빠진것이다.<br />
그럼에도 불구하고 결과에 회장 레코드를 보여야 한다면 아래처럼 질의해야 한다.<br />

<pre class="prettyprint">
SELECT E.ENAME,M.ENAME
FROM EMP E,EMP M
WHERE E.MGR = M.EMPNO(+);
</pre>

위와 같은 조인을 외부조인이라 한다.<br />
외부조인은 조인 조건에 만족하지 못하였더라도 해당 행을 나타내고 싶을 때 사용한다.<br />
외부조인은 (+) 연산자를 사용하여 NULL 값이기에 배제된 행을 결과에 포함시킬 수 있다.<br />
KING 의 MGR 필드 값은 NULL 인데 사원 번호가 NULL 인 사원이 존재하지 않아서
KING 이 결과에서 배제되었지만 이번 예제에서 WHERE 조건 오른쪽에 (+) 연산자를 붙이면
KING 에 대한 정보를 포함된다.<br />

<h3>이름,부서명을 조회하라.단, 사원테이블에 부서번호가 40인 사원이 없지만 부서명 OPERATIONS 도 출력되도록 할 것.</h3>
<pre class="prettyprint">
SELECT E.ENAME,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
</pre>

<h3>이름,부서번호,부서이름을 출력</h3>
<pre class="prettyprint">
SELECT ENAME,E.DEPTNO,DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO;
</pre>

<h3>부서번호가 30번인 사원들의 이름, 직급, 부서번호, 부서위치</h3>
<pre class="prettyprint">
SELECT ENAME,JOB,E.DEPTNO,LOC
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DEPTNO = 30;
</pre>

<h3>커미션을 받는 사원의 이름, 커미션, 부서이름,부서위치</h3>
<pre class="prettyprint">
SELECT ENAME,COMM,DNAME,LOC
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO 
AND EMP.COMM IS NOT NULL AND EMP.COMM &lt;&gt; 0;
</pre>
<pre class="prettyprint">
SELECT ENAME,COMM,DNAME,LOC
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO 
AND EMP.COMM IS NOT NULL AND EMP.COMM != 0;
</pre>
<pre class="prettyprint">
SELECT ENAME,COMM,DNAME,LOC
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO 
AND EMP.COMM IS NOT NULL AND EMP.COMM NOT IN(0);
</pre>

<h3>DALLAS 에서 근무하는 사원의 이름,직급,부서번호,부서명</h3>
<pre class="prettyprint">
SELECT E.ENAME,E.JOB,D.DEPTNO,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND D.LOC = 'DALLAS';
</pre>

<h3>이름에 A 가 들어가는 사원들의 이름,부서명</h3>
<pre class="prettyprint">
SELECT E.ENAME,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.ENAME LIKE '%A%';
</pre>

<h3>이름, 직급, 월급여, 월급여등급</h3>
<pre class="prettyprint">
SELECT E.ENAME,E.JOB,E.SAL,S.GRADE
FROM EMP E,SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
</pre>

<h3>ALLEN 과 같은 부서에 근무하는 사원의 이름, 부서번호</h3>
<pre class="prettyprint">
SELECT C.ENAME,C.DEPTNO
FROM EMP E,EMP C
WHERE E.EMPNO &lt;&gt; C.EMPNO
AND E.DEPTNO = C.DEPTNO
AND E.ENAME = 'ALLEN'
ORDER BY C.ENAME;
</pre>

<h2>서브쿼리</h2>
서브 쿼리는 SELECT문안에서 ()로 둘러싸인 SELECT 문을 말하며 쿼리문의 결과를 메인 쿼리로 전달하기 위해 사용된다.

<h3>사원명 'JONES'가 속한 부서명</h3>
<pre class="prettyprint">
SELECT DNAME 
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'JONES');
</pre>
부서번호를 알아내기 위한 쿼리가 서브 쿼리로 사용되고, 이 서브쿼리는 단 하나의 결과값을 얻기 때문에 단일 행 서브 쿼리라 한다.

<h3>10번 부서에서 근무하는 사원의 이름과 10번 부서의 부서명</h3>
<pre class="prettyprint">
SELECT E.ENAME,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND D.DEPTNO = 10;
</pre>

<pre class="prettyprint">
SELECT E.ENAME,D.DNAME
FROM EMP E,
(
	SELECT DEPTNO,DNAME
	FROM DEPT
	WHERE DEPTNO = 10
) D
WHERE E.DEPTNO = D.DEPTNO;
</pre>

<h3>평균 월급여보다 더 많은 월급여를 받은 사원의 사원번호,이름,월급여 조회</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL &gt; (SELECT AVG(SAL)
	      FROM EMP)
ORDER BY SAL DESC;
</pre>

<h3>부서번호가 10인 사원중에서 최대급여를 받는 사원과 동일한 급여를 받는 사원의 사원번호, 이름 조회</h3>
<pre class="prettyprint">
SELECT EMPNO,ENAME
FROM EMP
WHERE SAL = (SELECT MAX(SAL) 
	     FROM EMP 
	     WHERE DEPTNO = 10);
</pre>
