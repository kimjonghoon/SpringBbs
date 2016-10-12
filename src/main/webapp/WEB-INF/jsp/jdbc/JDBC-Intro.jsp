<div id="last-modified">Last Modified : 2014.3.3</div>
	
<h1>JDBC 소개</h1>

JDBC(Java Database Connectivity)란 <strong>데이터베이스</strong>에 접근하여 <strong>SQL</strong>문을 
실행하기 위한 자바 라이브러리를 말한다.<br />
<br />
데이터베이스 벤더들이 이러한 자바 라이브러리를 각자 만든다면 제품마다 프로그래밍 방법이 달라질 것이다.<br />
자바 프로그래머는 데이터베이스가 달라질때마다 각 벤더가 만든 클래스들의 사용법을 익혀야 할 것이다.<br />
<br />
썬에서 RDBMS에 접근하여 SQL문을 실행하기 위한 자바 라이브러리를 만들어 표준으로 제공한 것이 바로 JDBC이다.<br />
<br />
JDBC에는 구현클래스가 거의 없고 대부분이 인터페이스이다.<br />
인터페이스를 구현한 클래스를 만들어 제공하는 것은 각 벤더의 책임이다.<br />
지금부터 우리가 배우게 되는 것은 썬에서 제공하는 인터페이스의 사용법이다.<br />
JDBC 예제 소스를 보면 각 벤더가 만든 JDBC 구현체가 보이지 않는다.
썬의 인터페이스만 보인다.<br />
 
<dl class="note">
<dt>데이터베이스</dt>
<dd>
1970년 E.F. Codd가 "데이터를 관계형 테이블의 집합으로 나타낼 수 있다"고 소개한 후 많은 회사에서 
관계형 데이터베이스 관리시스템(RDBMS)을 만들어 왔다.<br />
RDBMS를 처음으로 상용화 한 회사가 Oracle이다.<br />
이 외에도 IBM의 DB2, 마이크로소프트의 Microsoft SQL Server 등 많은 RDBMS제품이 있다.<br />
오늘날 데이터베이스라 하면 관계형 데이터베이스를 말한다.<br />
</dd>
<dt>SQL</dt>
<dd>
SQL(Structured Query Language)란 RDBMS의 표준 언어이다.<br />
SQL를 이용하여 테이블을 생성하고 테이블에 레코드를 조회, 삽입,갱신,삭제할 수 있으며 
데이터베이스 사용자의 권한을 컨트롤 할 수 있다.<br />
</dd>
</dl>