<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.6.17</div>

<h1>자바은행 데이터 모델링</h1>

<p style="clear: both;font-weight: bold;padding: 10px 30px;font-size: 14px;">
<a href="/java/javabank01.php">자바은행</a> 예제를 데이터베이스를 이용하는 예제로 바꾸는 과정을 설명한다.<br />
추가되는 내용은 계좌 사용내역이 저장된다는 것이다.<br />
</p>

<h2>요구사항 분석</h2>
<em>보다 예제를 간단히 하기 위해, 지점이 없는 온라인 은행이라고 가정하고 은행 사원은 고려하지 않도록 한다.</em><br />
<br />
고객은 은행에 계좌를 만들기 위해서는 아이디, 패스워드, 이름을 제공한다.<br />
고객은 계좌를 하나 이상 만들 수 있다.<br />
계좌는 자유입출금계좌와 마이너스계좌가 있다.<br />
계좌는 계좌번호, 고객이름, 잔고로 구성된다.<br /> 
거래내역은 거래일자,거래시간,계좌번호,입금/출금여부,거래금액,은행명으로 기록된다.<br />
여기서 은행명은 타행이체인 경우 타행의 이름이 기록된다.<br />

<h2>개체와 속성 추출</h2>
시나리오에서 명사를 도출한다.<br />
명사는 개체이거나 속성이다.<br />
<ul>
	<li>은행</li>
	<li>고객(아이디, 패스워드, 이름)</li>
	<li>계좌(계좌번호, 이름, 잔고,계좌종류)</li>
	<li>거래내역(거래일자, 거래시간, 계좌번호, 입금/출금여부, 거래금액, 은행명)</li>
</ul>
<em>
여기서 은행은 개체가 될 수 없다.<br />
만약 여러 은행을 관리하는 프로젝트라면 은행 역시 개체가 될 수 있다.<br />
</em>
<br />

<h2>개체간의 관계</h2>
시나리오에서 동사를 분석하여 개체간의 관계를 알아낸다.<br />
<br />
고객과 계좌는 관계가 있다.<br />
계좌와 거래내역은 관계가 있다.<br />
<br />
이제 개체간의 부모와 자식를 구별하는 과정이 필요하다.<br />
고객이 있어야 계좌도 있을 수 있다.<br />
따라서 고객이 부모, 계좌가 자식이다.<br />
계좌가 있어야 거래내역이 있을 수 있다.<br />
시간적으로도 계좌가 먼저이다.<br />
따라서 계좌가 부모, 거래내역이 자식이다.<br />
<br />
다음으로 개체간의 관계에서 일대일,일대다,다대다 관계인지를 파악해야 한다.<br />
고객과 계좌의 관계는 일대다 관계이다.<br />
계좌와 거래내역은 일대다 관계이다.<br />
따라서 새로운 테이블이 필요없고 외래키를 자식 테이블에 추가한다.<br />

<h2>개체관계도(ERD)</h2>
<img src="https://lh6.googleusercontent.com/-C52Ned9mpa0/UAiZBgl3-sI/AAAAAAAAA8c/QfoPqfuvgbs/s580/erd.jpg" alt="자바은행 ERD" /><br />
<!-- <img src="images/erd.jpg" alt="자바은행 ERD"  width="580px" /><br /> -->

<h2>테이블</h2>
<pre class="prettyprint">
create table member (
	id varchar2(20),
	passwd varchar2(20),
	name varchar2(21),
	constraint pk_member primary key(id)
);

create table account (
	ano varchar2(20),
	id varchar(20),
	name varchar2(21),
	balance number,
	kind varchar2(20) not null, --계좌종류 : 자유입출금계좌(NORMAL),마이너스계좌(MINUS)
	constraint pk_account primary key(ano),
	constraint fk_account_id foreign key(id) references member(id)
);

create table transaction (
	tdate date, --거래일자
	ttime timestamp, --거래시간
	ano varchar2(20),
	money number,
	kind char(1), --입금/출금여부(입금은 'D',출금은 'W')
	bank varchar2(20), -- 은행명
	constraint pk_transaction primary key(tdate,ttime,ano),
	constraint fk_transaction foreign key(ano) references account(ano),
	constraint ck_transaction check(kind = 'D' or kind = 'W')
);
</pre>