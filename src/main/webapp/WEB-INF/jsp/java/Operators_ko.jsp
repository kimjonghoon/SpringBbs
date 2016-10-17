<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2016.4.9</div>

<h1>연산자</h1>

연산자란 변수에 값을 대입하거나 변수와 변수의 값을 비교하거나 변수의 값을 변경하기 위해 사용하는 기호를 말한다.<br />

<h3>산술 연산자</h3>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 10%;">연산자</th>
	<th class="table-in-article-th" style="width: 10%;">예</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">+</td>
	<td class="table-in-article-td">a + b</td>
	<td class="table-in-article-td">덧셈</td>
</tr>
<tr>
	<td class="table-in-article-td">-</td>
	<td class="table-in-article-td">a - b</td>
	<td class="table-in-article-td">뺄셈</td>
</tr>
<tr>
	<td class="table-in-article-td">*</td>
	<td class="table-in-article-td">a * b</td>
	<td class="table-in-article-td">곱셈</td>
</tr>
<tr>
	<td class="table-in-article-td">/</td>
	<td class="table-in-article-td">a / b</td>
	<td class="table-in-article-td">나눗셈</td>
</tr>
<tr>
	<td class="table-in-article-td">%</td>
	<td class="table-in-article-td">a % b</td>
	<td class="table-in-article-td">나머지</td>
</tr>
<tr>
	<td class="table-in-article-td" rowspan="2">++</td>
	<td class="table-in-article-td">++a</td>
	<td class="table-in-article-td detail">
	a의 값이 1증가한 후 얻어진다.<br />
	++a가 사칙연산에 참여할때 a의 값이 1증가한 후 a값이 얻어진다.<br />
	++a가 메소드의 인자값으로 전달되는 경우 a의 값이 1증가한 후 a값이 얻어진다.<br />
	</td>
</tr>
<tr>
	<td class="table-in-article-td">a++</td>
	<td class="table-in-article-td detail">a의 값이 얻어지고 난 후 값이 1증가한다.<br />
	++a가 사칙연산에 참여할때는 a의 값이 그대로 얻어져 사칙연산에 참여하게 되고, 그 후 a는 1증가한다.<br />
	++a가 메소드의 인자값으로 전달되는 경우 a의 값이 그대로 얻어져 인자값으로 전달되고, 그 후 a는 1증가한다.<br />
	</td>
</tr>
<tr>
	<td class="table-in-article-td" rowspan="2">--</td>
	<td class="table-in-article-td">--a</td>
	<td class="table-in-article-td detail">a의 값이 1감소한 후 얻어진다.</td>
</tr>
<tr>
	<td class="table-in-article-td">a--</td>
	<td class="table-in-article-td detail">a의 값이 얻어지고 난 후 값이 1감소한다.</td>
</tr>
</table>


<h3>관계 연산자</h3>
수치 데이터의 크기를 비교하는 연산자로 연산 결과는 불린값이다.

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 10%;">연산자</th>
	<th class="table-in-article-th" style="width: 10%;">예</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">&gt;</td>
	<td class="table-in-article-td">a &gt; b</td>
	<td class="table-in-article-td">a가 b보다 크면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">&gt;=</td>
	<td class="table-in-article-td">a &gt;= b</td>
	<td class="table-in-article-td">a가 b보다 크거나 같으면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">&lt;</td>
	<td class="table-in-article-td">a &lt; b</td>
	<td class="table-in-article-td">a가 b보다 작으면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">&lt;=</td>
	<td class="table-in-article-td">a &lt;= b</td>
	<td class="table-in-article-td">a가 b보다 작거나 같으면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">==</td>
	<td class="table-in-article-td">a == b</td>
	<td class="table-in-article-td">a가 b와 같으면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">!=</td>
	<td class="table-in-article-td">a != b</td>
	<td class="table-in-article-td">a가 b와 같지 않으면 true</td>
</tr>
</table>



<h3>논리 연산자</h3>

연산에 참여하는 항은 조건식으로 연산 결과는 불린값이다.
예를 들어 연도가 20세기에 속하려면 1901년 이상 2000이하여야 한다.
year 이 연도를 담고 있는 변수이고 변수가 이 두 조건을 모두 만족하려면 
year &gt;= 1901 란 조건식과 year &lt;= 2000 란 조건식을 논리곱으로 연결해야 한다.<br />
year &gt;= 1901 &amp;&amp; year &lt;= 2000<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 10%;">연산자</th>
	<th class="table-in-article-th" style="width: 10%;">예</th>
	<th class="table-in-article-th">설명(a, b는 모두 조건식이다.)</th>
</tr>
<tr>
	<td class="table-in-article-td">&amp;</td>
	<td class="table-in-article-td">a &amp; b</td>
	<td class="table-in-article-td">a, b모두 true이면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">&amp;&amp;</td>
	<td class="table-in-article-td">a &amp;&amp; b</td>
	<td  class="table-in-article-td detail">a, b모두 true이면 true<br />
	만일 a가 false면 b의 조건은 검사하지 않는다.</td>
</tr>
<tr>
	<td class="table-in-article-td">|</td>
	<td class="table-in-article-td">a | b</td>
	<td class="table-in-article-td">a,b 둘 중 하나라도 true이면 true</td>
</tr>
<tr>
	<td class="table-in-article-td">||</td>
	<td class="table-in-article-td">a || b</td>
	<td  class="table-in-article-td detail">a,b 둘 중 하나라도 true이면 true<br />
	만일 a가 true라면 b의 조건은 검사하지 않는다.</td>
</tr>
<tr>
	<td class="table-in-article-td">!</td>
	<td class="table-in-article-td">!a</td>
	<td class="table-in-article-td">a 가  true면 false,false면 true</td>
</tr>
</table>



<h3>대입 연산자</h3>
<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 10%;">연산자</th>
	<th class="table-in-article-th" style="width: 10%;">예</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">=</td>
	<td class="table-in-article-td">a = 9;</td>
	<td class="table-in-article-td">변수 a에 9를 할당</td>
</tr>
<tr>
	<td class="table-in-article-td">+=</td>
	<td class="table-in-article-td">a += b;</td>
	<td class="table-in-article-td">a = a + b;</td>
</tr>
<tr>
	<td class="table-in-article-td">-=</td>
	<td class="table-in-article-td">a -= b;</td>
	<td class="table-in-article-td">a = a - b;</td>
</tr>
<tr>
	<td class="table-in-article-td">*=</td>
	<td class="table-in-article-td">a *= b;</td>
	<td class="table-in-article-td">a = a * b;</td>
</tr>
<tr>
	<td class="table-in-article-td">/=</td>
	<td class="table-in-article-td">a /= b;</td>
	<td class="table-in-article-td">a = a / b;</td>
</tr>
<tr>
	<td class="table-in-article-td">%=</td>
	<td class="table-in-article-td">a %= b;</td>
	<td class="table-in-article-td">a = a % b;</td>
</tr>
</table>

<h3>삼항 연산자</h3>
연산자에 참여하는 항이 3개라 삼항 연산자라고 한다.<br />
모양은 <em>조건식 ? 값1 : 값2;</em> 형태이다.(조건식, 값1, 값2는 항)<br />
if ~ else 문이 간단한 내용이고 한줄로 쓰고 싶을 때 대신 사용한다.

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 40%;">예</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">max = a &gt; b ? a : b;</td>
	<td  class="table-in-article-td detail">a 가 b 보다 크면 a의 값을  max 에 할당<br />a 가 b 보다 크지 않다면 b의 값을 max 에 할당</td>
</tr>
</table>

<h3>연결 연산자</h3>
문자열을 연결하여 새로운 문자열을 만드는 연산자로, 모양은 산술 연산자의 + 와 같다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 40%;">예</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">String msg = "Hello, " + id;</td>
	<td  class="table-in-article-td detail">"Hello," 문자열과 name 변수의 값으로 새로운 문자열을 생성한다.<br />
	이때 변수 id의 자료형이 무엇이든 id에 들어있는 값은 적절한 문자열로 바뀌게 된다.<br />
	id의 자료형이 int이고 들어있는 값이 1004라면 다음과 같은 절차를 거칠 것이다.<br />
	"Hello, " + 1004<br />
	"Hello, " + "1004"<br />
	"Hello, 1004"<br />
	</td>
</tr>
</table>