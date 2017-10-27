<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.4.30</div>

<h1>자바은행 분석/설계</h1>

자바 기초를 끝내고 처음으로 자바다운 예제를 실습한다.<br />
자바로 구현하는 은행 프로그램이다.<br />
프로그램을 만들기 위한 첫번째 단계는 어떤 프로그램을 만들 것인가에 대한 명확한 이해를 나와 동료가 
공유하는 것이다.<br />
그러기 위해서는 아래 시나리오와 같은 작업이 필요하다.<br />

<h2>시나리오</h2>

은행은 계좌를 관리한다.<br /><!-- 관리한다는 모호하다 다음줄이 구체적으로 어떻게 관리하는가에 대한 내용이다. 구체적인 내용이 필요한 것이다. -->
은행은 계좌를 등록한다.<br />
은행은 계좌번호로 계좌를 찾을 수 있다.<br />
은행은 계좌의 소유자명으로 계좌를 찾을 수 있다.<br />
은행은 모든 계좌의 목록을 볼 수 있다.<br />
계좌는 소유자명, 계좌번호, 잔고로 구성된다.<br /><!-- 소유자명,계좌번호,잔고는 모두 명사지만 클래스 후보가 아니라 계좌 클래스의 필드 후보라는 것을 짐작할 수 있다. -->
계좌는 입금,출금 기능과 잔고확인 기능이 있다.<br />
계좌에서 잔액의 변화가 있을 때마다 입출금 명세에 기록된다.<br />
입출금 명세는 거래일자, 거래시간, 입금/출금, 금액, 잔액으로 구성된다.<br />

<h2>클래스 다이어그램</h2>
시나리오로부터 클래스와 필드, 메소드를 추출해 내어야 한다.<br />
시나리오에서 명사에 해당하는 것이 클래스나 필드로, 동사에 해당하는 것이 메소드가 될 것이다.<br />

<a href="https://lh3.googleusercontent.com/-Dgg4barA3Sk/VX_qKuvc-LI/AAAAAAAACLI/9r_JG99thNs/w617-h526-no/bank-classdiagram.png"><img src="https://lh3.googleusercontent.com/-Dgg4barA3Sk/VX_qKuvc-LI/AAAAAAAACLI/9r_JG99thNs/w617-h526-no/bank-classdiagram.png" alt="자바은행 클래스다이어그램 추상화 단계" width="590" /></a><br />

분석/설계 단계에서의 산출물은 아래와 같은 클래스 다이어그램이다.<sup><a href="#comments">1</a></sup><br />

<a href="https://lh4.googleusercontent.com/-7_W2KsCUQSU/VX_qK5Qp9gI/AAAAAAAACLM/5EQN6xP4NXo/w814-h526-no/bank-classdiagram2.png"><img src="https://lh4.googleusercontent.com/-7_W2KsCUQSU/VX_qK5Qp9gI/AAAAAAAACLM/5EQN6xP4NXo/w814-h526-no/bank-classdiagram2.png" alt="자바은행 클래스다이어그램" width="590" /></a><br />

클래스 다이어그램은 클래스의 구조뿐만 아니라 객체와 객체간의 관계를 나타낸다.<br />
클래스 다이어그램에서 두 클래스가 선으로 연결되어 있다면 두 클래스로부터 생성된 객체들은 서로 관계가 있다.<br />
속이 찬 다이아몬드는 객체가 다른 객체를 부품처럼 가지고 있는 관계를 나타낸다.<sup><a href="#comments">2</a></sup><br />
0이나 *는 부품처럼 쓰는 객체의 최대 갯수로. 0..*는 0개 이상을 의미한다.<br />
화살표는 객체가 다른 객체의 메소드를 호출하는 방향이다.<br />

<span id="comments">주석</span>
<ol>
	<li>클래스 다어어그램 외에 유즈 케이스 다이어그램(Use Case Diagram), 씨퀀스 다이어그램(Sequence Diagram)등이 있다.<br />
	프로젝트에 따라 다양한 다이어그램이 필요할 수 있으나, 여기서 실습하는 예제 정도는 클래스 다이어그램으로 충분한다.<br />
	클래스 다이어그램에서 접근자는, private는 -로, public은 +로, protected는 #으로 간단히 표현한다.<br />
	거래내역 클래스(Transaction)의 메소드란이 비었는데 메소드가 없는것이 아니라, private인 멤버 변수의 getter, setter외에 특별한 메소드는 없기에 지면상 생략한 것이다.<br />
	Bank와 Account 역시 짐작 가능한 getter와 setter메소드는 지면상 생략했다.<br />
	분석이 완벽할 수 없으므로 에제가 진행되면서 구현소스는 위의 클래스 다이어그램과 다를 수 있다.  
	</li>
	<li>
	객체가 어떤 객체를 부품처럼 가지고 있는 관계를 "has a"관계라고 한다.<br />
	"은행은 여러 계좌를 가지고 있다."는 맞는 말이므로 두 클래스는 "has a"관계이다.<br />
	"has a"관계 중에서 부품을 가지고 있는 본체가 사라지면 부품도 같이 사라지는 높은 결합도라면 이를 합성(Composistion)이라 하고 속이 찬 다이아몬드로 표현한다.<br />
	본체가 사라지더라도 부품이 사라지지 않는 낮은 결합도라면 집합(Aggregation)이라 하고 속이 빈 다이아몬드로 표현한다.<br />
	자바에서는 합성이나 집합 모두 다른 객체의 레퍼런스를 멤버 변수로 가지는 것으로 구현한다.<br />
	참고로, 자바 프레임워크 중 하나인 스프링에서는 부품에 해당하는 멤버 변수를 종속 변수라고 부른다.
	</li>	
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.infopub.co.kr/bookinfo/bookinfo.asp?sku=05000195">New 알기쉬운 Java 2 J2SE 1.4</a></li>
</ul>