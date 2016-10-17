<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2013.4.24</div>

<h1>자바스크립트 객체</h1>

<h2>객체의 종류</h2>
<ol>
	<li>내장 객체</li>
	<li>브라우저 객체</li>
	<li>문서 객체</li>
	<li>사용자 정의 객체</li>
</ol>

<h3>1. 내장 객체</h3>
자바스크립트 객체는 Object 라는 객체에 기초한다.<br />

<h4>Number</h4>
기본 데이터형 숫자와 매칭된다.<br />

<pre class="brush: js">
var su = new Number(2194.123456);
alert(su.toExponential(3));//소수점 이하 3자리를 넘긴 부분은 지수 표현
alert(su.toPrecision(3)); // 유효숫자를 3자리로 표현
alert(su.toFixed(8));//소수점 이하를 8자로 나머지는 반올림
alert(su.toLocaleString());// 로케일에 맞게 숫자를 표현
alert(Number.MAX_VALUE);//최대값
alert(Number.MIN_VALUE);//최소값
alert(Number.NEGATIVE_INFINITY);
alert(Number.POSITIVE_INFINITY);
alert(Number.NaN);//NaN 의 의미는 Not a Number 즉, 숫자가 아니라는 의미
//isNaN() 내장함수 사용법
if (isNaN("이상한수") == true) {
	alert("숫자가 아니다.");
}
</pre>
<input type="button" value="예제" onclick="location.href='examples/Number.html'" />

<h4>String</h4>

<pre class="brush: js;">
var name = new String("김태희");
var engName = "kim taehee"
var lastName = name.substring(0,1);//자바와 같음
alert(lastName);
var firstName = name.substring(1);//자바와 같음
alert(firstName);
alert(name.length);//자바는 length() 메소드 이용
alert(name.charAt(1));//자바와 같음
alert(name.charCodeAt(1));//문자코드 반환, 자바에서의 codePointAt() 메소드와 같음
alert(name.concat("와비"));//자바와 같음
alert(name.indexOf("태"));//자바와 같음 
alert(name.lastIndexOf("비",2));//자바와 같음
alert(name.match(/태희/));//인자인 정규표현식에 해당하는 문자열을 반환,자바에는 없음
alert(name.replace("태희","희선"));//자바에서의 replaceAll()이 가장 비슷
alert(name.search(/김/g));//인자인 정규표현식에 해당하는 문자열의 찾아 문자열의 인덱스 반환
alert(name.slice(1,2));//자바의 substring(int,int)
alert(name.slice(1));//자바의 substring(int)
alert(name.split("태"));//자바스크립트의 배열은 , 로 구분된다.,자바에서의 split() 같음
alert(name.substring(1,2));//자바와 같음
alert(engName.toUpperCase());//자바와 같음
alert(engName.toLowerCase());//자바와 같음
</pre>
<input type="button" value="예제" onclick="location.href='examples/String.html'" />

<h4>RegExp</h4>
RegExp 는 정규표현식 객체이다.
/ 와 / 로 표현된다. 
주의할 점은 "/ 와 /" 이나 '/ 와 /' 가 아니라는 점.
test()와 exec() 메소드가 있다.
test()는 인자로 들어온 문자열이 정규표현식에 부합한지를 판단한다. 불린값을 리턴
exec()는 인자로 들어온 문자열에서 정규표현식에 부합된 문자열을 찾아 반환. 문자열을 반환

<pre class="brush: js;">
var regExp = /Java-*/;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</pre>

<strong>결과 : </strong>
<script type="text/javascript">
var regExp = /Java-*/;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</script>

<br />
정규표현식 객체의 끝의 / 다음에 오는 문자열은 플래그다.<br />
i 플래그가 붙으면 대소문자를 가리지 않는다.<br />

<pre class="brush: js;">
var regExp = /Java-*/i;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</pre>

<strong>결과: </strong>
<script type="text/javascript">
var regExp = /Java-*/i;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</script>

<br />
g 플래그를 사용하면 마지막으로 매칭된 위치를 기억하고 있다가 다음번의 exec()호출되면 그 다음 위치부터 매칭되는 곳을 찾게 된다.<br />

<pre class="brush: js;">
var regExp = /Java-*/gi;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</pre>

<strong>결과 : </strong>
<script type="text/javascript">
var regExp = /Java-*/gi;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</script>
<br />

/../ 사이의 특수문자<br />
* : 0개 이상<br />
+ : 1개 이상<br />
\다음에 일반문자가 오면 약속된 특수문자로 취급<br />
\다음에 특수문자가 오면 문자 그 자체로 취급<br />

<h5>예제 1</h5>
<pre class="brush: js;">
var regExp = /Java-*/gi;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</pre>

<strong>결과 : </strong>
<script type="text/javascript">
var regExp = /Java-*/gi;
var testStr = "www.java-school.net is the best Java site to learn";
var retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
retArr = regExp.exec(testStr);
document.writeln(retArr[0]);
</script>
<br />

<h5>예제 2</h5>
\s 는 공백문자를 의미한다.<br />
<pre class="brush: js;">
var regExp = /\s\*/g;
var testStr = "www.java-school.net *is *the *best *web *site *to *learn *JAVA";
var retStr = testStr.replace(regExp,'-');
document.writeln(retStr);
</pre>

<strong>결과 : </strong>
<script type="text/javascript">
var regExp = /\s\*/g;
var testStr = "www.java-school.net *is *the *best *web *site *to *learn *JAVA";
var retStr = testStr.replace(regExp,'-');
document.writeln(retStr);
</script>
<br />
<h4>문제</h4>
다음은 회원가입을 위한 폼을 제공하는 페이지의 한부분이다.<br />
이름에 해당하는 파라미터의 값이 공백문자로만 이루어졌는지 검사하는 자바스크립트 코드를 
작성한다.<br />
<pre class="code">
&lt;form id="signUpForm" action="signUp" method="post" onsubmit="return check()"&gt;
	이름 &lt;input type="text" name="name" /&gt;
	...
	..
	.
&lt;/form&gt;
</pre>
<pre class="brush: js;">
function check() {
	var regExp = /\s/g;
	var form = document.getElementById("signUpForm");
	var name = form.name.value;
	name = name.replace(regExp,"");
	if (name.length == 0) {
		alert("이름이 유효하지 않습니다.");
		return false;
	}
	return true;
}
</pre>

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">*</th>
	<td class="table-in-article-td">0회 이상 반복</td>
</tr>
<tr>
	<th class="table-in-article-th">+</th>
	<td class="table-in-article-td">1회 이상 반복</td>
</tr>
<tr>
	<th class="table-in-article-th">?</th>
	<td class="table-in-article-td">0 또는 1개의 문자 매칭</td>
</tr>
<tr>
	<th class="table-in-article-th">.</th>
	<td class="table-in-article-td">정확히 1개의 문자 매칭</td>
</tr>
<tr>
	<th class="table-in-article-th">\D</th>
	<td class="table-in-article-td">숫자가 아닌 문자</td>
</tr>
<tr>
	<th class="table-in-article-th">\D*</th>
	<td class="table-in-article-td">문자 0회 이상</td>
</tr>
<tr>
	<th class="table-in-article-th">\d</th>
	<td class="table-in-article-td">숫자</td>
</tr>
<tr>
	<th class="table-in-article-th">\w</th>
	<td class="table-in-article-td">알파벳,숫자,_</td>
</tr>
<tr>
	<th class="table-in-article-th">\W</th>
	<td class="table-in-article-td">\w와 반대</td>
</tr>

<tr>
	<th class="table-in-article-th">\s</th>
	<td class="table-in-article-td">공백문자</td>
</tr>
<tr>
	<th class="table-in-article-th">[]</th>
	<td class="table-in-article-td">여러문자를 매칭하고 싶다면 []안에 나열한다. [A-Za-z]</td>
</tr>
<tr>
	<th class="table-in-article-th" rowspan="2">^</th>
	<td class="table-in-article-td">[ ]안에서 쓰이면 ~을 제외한다는 의미. ex) \D 는 [^0-9]와 같다.</td>
</tr>
<tr>
	<td class="table-in-article-td">[]밖에서 쓰이면 시작을 의미. ex) var regExp = /^JAVA/;</td>
</tr>
<tr>
	<th class="table-in-article-th">$</th>
	<td class="table-in-article-td">끝을 의미. ex) var regExp = /school$/;</td>
</tr>
<tr>
	<th class="table-in-article-th">/ / 안의 ()</th>
	<td class="table-in-article-td">
	괄호로 묶은 패턴은 매칭된 다음 그 부분을 기억하고 그 값을 배열과 같이 저장된다.
	$1,$2,... 기억되는 부분 문자열은 이 특수문자에 저장된다.
	</td>
</tr>
</table>

<h3>|</h3>
| 는 "또는" 의미한다.<br />

<pre class="code">
a|b // a 또는 b
a|b|c // a 또는 b 또는 c
</pre>

중괄호는 문자의 반복횟수를 지정할 때 사용한다.<br />
s{2} s의 두번반복 즉, ss를 의미한다.<br />

다음 사이트에서 이메일에 대한 정규표현식을 얻는다.<br />
http://regexlib.com <br />

이를 이용해서 사용자가 입력한 이메일과 날짜가 유효한 값인지 체크하는 자바스크립트 함수를 만들어 본다.<br />

이메일 : ^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$<br />
yyyy/mm/dd 형식의 날짜 : ^\d{4}\/\d{2}\/d{2}

<script type="text/javascript">
var emailRegExp = /^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$/;
var dateRegExp = /^\d{4}\/\d{2}\/\d{2}/;
var email = "kim0070@gmail.com";
var signUpDate = "2013/06/25";

var check = emailRegExp.test(email);
if (check) {
	alert("유효한 이메일입니다.");
} else {
	alert("유효한 이메일이 아닙니다.");
}
check = dateRegExp.test(signUpDate);
if (check) {
	alert("유효한 등록일입니다.");
} else {
	alert("유효한 등록일이 아닙니다.");
}
</script>

<h2>Date 객체</h2>
Date 객체를 통해 날짜를 생성하고 년,월,일,초 등의 값에 접근할 수 있다.
인자를 지정하지 않고 생성하면 시스템의 현재 날짜와 시간으로 초기화 된다.
<pre class="brush: js;">
var now = new Date();
document.writeln("now.toUTCString() : " + now.toUTCString());

var milliSecs = new Date(7789110879);
document.writeln(milliSecs.toUTCString());

var lastDay = new Date("June 7, 2013 17:55:05");
document.writeln(lastDay.toUTCString());

var birthday = new Date(1969,2,9);
document.writeln(birthday.toLocaleString());

lastDay = new Date(2013,6,7,17,55,5,30);
document.writeln(lastDay.toUTCString());
</pre>

<strong>결과 : </strong><br />
<script type="text/javascript">
var now = new Date();
document.writeln("now.toUTCString() : " + now.toUTCString() + "<br />");

var milliSecs = new Date(1000000000000);
document.writeln("milliSecs.toUTCString() : " + milliSecs.toUTCString() + "<br />");

var lastDay = new Date("June 7, 2013 17:55:05");
document.writeln("lastDay.toUTCString() : " + lastDay.toUTCString() + "<br />");

var birthday = new Date(1969,2,9);
document.writeln("birthday.toLocaleString()" + birthday.toLocaleString() + "<br />");

lastDay = new Date(2013,5,7,17,55,5,30);
document.writeln("lastDay.toLocaleString() : " + lastDay.toLocaleString() + "<br />");
</script>

<!-- 
Date 객체를 생성하고 난 후엔, 여러 가지 메소드로 값에 접근할 수 있다.
단순히 값에 접근하는 정적 메소드도 몇 가지 있고, 날짜의 각 비트를 조작할 수 있는 메소드도
몇가지 있다.
Date.now 는 현재 날짜와 시각을 반환하고, Date.parse는 1970년 1월 1일 12시 이후로 현재까지 경과된 시간을 밀리 초 단위로 반환하며, 
Date.UTC 는 1970년 1월 1일 자정 이후로 현재까지 경과된 시간을 밀리 초 단위로 반환한다.

var numMs = Date.UTC(1977,16,24,30,30,30);

Date 객체의 메소드를 사용하면, 특정 요소를 설정하거나 값을 알아낼 수 있다.
다음 메소드는 로컬 날짜값과 시각값을 가져온다.

getFullYear
getHours
getMilliseconds
getMinutes
getMonth
getSeconds
getYear

getUTCFullYear
getUTCHours
getUTCMilliseconds
getUTCMinutes
getUTCMonth
getUTCSeconds

대부분의 get 메소드는 상응하는 set 메소드가 있다.

getDate 메소드는 월을 숫자로 반환하며, getDay 메소드는 요일을 숫자로 반환한다.
요일을 반환할 때는 기준으로 일요일을 0으로 한다.

var dtNow = new Date();
alert(dtNow.getDay());

getTimezoneOffset 는 UTC 와 로컬 시각의 차이를 +/-기호와 함께 분 단위로 표시한다.

toString
로컬 시각을 문자열로 출력한다.

toGMTString
문자열 형식을 GMT 표준으로 지정한다.

toLocaleDateString 과 toLocaleTimeString
로케일을 사용해서 날짜와 시각을 출력한다.

toLocaleString
문자열 형식으로 현재 로케일로 지정한다.

toUTCString
문자열 형식을 UTC 표준으로 정한다.

[예제 4-8] : 다양한 date 메소드의 사용 예

주의
getYear 에 대해서 firefox 와 IE 모두 테스트한다.
-->

<h2>Math</h2>
<pre class="brush: js;">
var random = Math.random();
document.writeln(random);
</pre>
<!-- [예제 4-9] : random() 메소드 사용예  -->

<strong>결과 : </strong><br />
<script type="text/javascript">
var random = Math.random();
document.writeln(random + "<br />");
</script>

<h2>배열</h2>

배열 선언 방법
<pre class="code">
var arr1 = new Array('하나','둘');
var arr2 = ['셋','넷'];
</pre>

자바스크립트의 배열은 배열 선언시 배열 요소의 수를 정할 수 있고 프로그램 실행 중에 추가할 수도 있다.
<pre class="code">
var arr1 = new Array('하나','둘');
var arr2 = ['셋','넷'];
arr1[99] = '아흔아홉';
document.writeln(arr1.length);
</pre>

<strong>결과 : </strong><br />
<script type="text/javascript">
var arr1 = new Array('하나','둘');
var arr2 = ['셋','넷'];
arr1[99] = '아흔아홉';
document.writeln(arr1.length);
</script>

배열의 메소드
splice()
slice()
concat()
reverse()
concat()과 slice()는 원래의 배열을 변경하지 않는다.
대신 수행결과를 배열로 반환한다.
자바스크립트 엔진은 쉽표를 구분자로 사용해 배열을 문자열로 변환한다.
splice : 배열에 원소를 제거하거나 추가할 수 있다.

<pre class="code">
var killers = new Array('손흥민','이동국','박주영','메시','호날두');
var removed = fruitArray.splice(2,2,'김신욱','차범근');
document.writeln(removed + "&lt;br /&gt;");
document.writeln(killers);
var killers2 = killers.slice(2,4);
document.writeln(killers2);
</pre>
slice : 메소드는 배열에서 지정한 범위에 해당하는 부분 배열을 반환한다.
인덱스 2에서부터 2개의 원소를 제거하고 2개의 원소를 추가한다.
<br />
<strong>결과 : </strong><br />
<script type="text/javascript">
var killers = new Array('손흥민','이동국','박주영','메시','호날두');
var removed = killers.splice(2,2,'김신욱','차범근');
document.writeln(removed + "<br />");
document.writeln(killers + "<br />");
var killers2 = killers.slice(2,4);
document.writeln(killers2 + "<br />");
var arr3 = arr1.concat(arr2);
document.writeln(arr3 + "<br />");
</script>
 
for .. in 문 사용예
<pre class="code">
var lang = ["C","JAVA","JavaScript"];
for (var idx in lang) {
	document.writeln(lang[idx] + "&lt;br /&gt;");
}
</pre>

<strong>결과 : </strong><br />
<script type="text/javascript">
var lang = ["C","JAVA","JavaScript"];
for (var idx in lang) {
	document.writeln(lang[idx] + "<br />");
}
</script>


<!-- 
자바스크립트 엔진은 쉼표(,)를 구분자로 사용해 배열을 문자열로 변환한다.
쉼표 대신 다른 구분자를 지정하고 싶다면 join 메소드를 사용한다.

var strng = fruitArray.join('*'); // 쉼표(,) 대신 별표(*)를 구분자로 사용한다.

reverse 메소드를 사용하면 배열 원소들의 순서를 뒤집을 수 있다.

fruitArray.reverse();

FIFO 큐
push: 배열 끝에 원소를 추가한다.
pop: 배열의 마지막 원소를 제거한다.
shift: 첫번째 원소를 제거한다.
unshift: 배열의 시작 위치에 원소를 추가한다.

[예제 4-10]
-->

연관배열 (일종의 맵)
연관 배열에는 인덱스가 존재하지 않으므로 다음과 같이 인덱스를 이용해서 원소에 접근할 수 없다.

associativeArray[1];

Array 생성자를 사용하면 연관 배열을 생성할 수 있다. 
하지만 숫자 인덱스를 사용해서 접근할 수 없기 때문에 그리 좋은 방법은 아니다.
대신 Object 를 일반적으로 사용한다. 그러면 새 원소가 추가될 때마다 배열이 자동으로 확장된다.
<pre class="code">
var accout = new Object();
account["accountNo"] = "111-222-333444";
account["name"] = "김종훈";
account["balance"] = 100000000;
document.writeln(account.balance);
</pre>

<strong>결과 : </strong><br />
<script type="text/javascript">
var account = new Object();
account["accountNo"] = "111-222-333444";
account["name"] = "김종훈";
account["balance"] = 100000000;
document.writeln(account.balance);
</script>
<br />

연관배열은 전형적인 숫자 배열과는 달리 객체에서 원소에 직접 접근할 수 있다.<br />
필요하지 않는 혼란을 주지 않기 위해서는<br />
다음과 같이 사용되는 예가 모두 연관 배열이다.<br />

<pre class="code">
document.writeln();
Math.ceil(165.7);
</pre>

자바스크립트에서 Array 를 언급할 때는 일반적으로 숫자 인덱스를 사용할 수 있는 
배열을 말한다.<br />
그 외의 경우에는 객체 또는 연관 배열이라고 지칭한다.<br />

<h2>함수</h2>
자바스크립트에서 함수는 객체다.<br />
함수를 변수나 배열에 배정할 수 있으며, 심지어는 다른 함수를 호출할 때 인자로 
넘겨줄 수 있다.<br />
이를 유연성이라 한다면 이런 유연성은 자바스크립트 전문가에게 훌륭한 자바스크립트 
프레임워크를 만드는데 장점으로 작용할 것이다.<br />
하지만 우리와 같은 초보자는 필요하지 않는 혼란을 주지 않기 위해서는 
함수를 변수나 배열에 배정하거나 다른 함수를 호출할때 
인자로 념기는 코드는 피하는 것이 좋다.<br />
    
자바스크립트 함수를 정의하는 방법은 다양한다.<br />
여기서는 자주 쓰이는 선언적 함수만을 배워보자.<br />

<h4>선언적 함수</h4>
가장 널리 사용하는 함수의 종류는 선언적/정적인 형태이다.<br />
function 키워드, 함수명, 인자 리스트, 함수 몸체로 구성된다.<br />

<pre class="code">
function 함수명 (인자1, 인자2,,,,,, 인자n) {
	함수의 실행구문이 위치하는 곳
}
</pre>

선언적/정적 함수는 페이지를 로드할 때 단 한번만 파싱된다.<br />
이때 파싱된 결과는 함수가 호출될 때마다 사용된다.<br />
이 방법은 코드 내에서 찾기 쉽고 이해하기 쉬우며, 일반적으로 부작용
(예를 들어, 메모리 누수)도 없다.<br />
이는 다른 프로그래밍 언어에 능숙한 개발자들에게 능숙한 방법이기도 하다.<br />

함수를 만들 때는 가급적 크기를 줄이고, 한 가지 일을 전문적으로 수행하며, 
일반적인 형태로 만드는 것을 규칙으로 삼는 것이 좋다.<br />

이외에도 자바스크립트에서 함수는<br /> 
익명함수, 함수식이라고 불리는 함수 리터럴이 있다.<br />
이 함수에 대한 자세한 사항은 참고 문서를 참조한다.<br />

함수의 선언이란 함수를 정의한 것이다.<br />
선언된 함수가 실행되려면 이벤트와 연결되어야 한다.<br />
이벤트란 페이지가 로드되었거나 또는 사용자가 마우스를 클릭했거나 움직였을 때 
발생한다.<br />

<dl class="note">
<dt>this</dt>
<dd>
w3c 모델에 따르면, this 는 이벤트를 받는 객체를 참조해야 한다.<br />
하지만 IE 에서는 this 가 무조건 window 객체를 참조한다.
</dd>
</dl>

예제<br />

폼 검사<br />

폼 접근<br />
만약 폼 태그가 이런 모양이라면, &lt;form name="someform" ...<br />
폼 태그가 나오는 순서로 접근<br />

var form = document.forms[0];<br />

또는<br />

var form = document.someform;<br />

폼 태그가 &lt;form id="someform" ...라면<br />

var form = document.getElementById("someform");<br />

폼에 이벤트를 추가하는 방법<br />

&lt;form name="someform" onsubmit="return 핸들러함수명() "&gt;<br />

여기서 핸들러함수의 구현부는<br />
유효성 검사에서 통과하지 못해서 폼 전송을 취소하려면<br />
핸들러 함수의 바디에서 return false;<br />
모든 유효성 검사에서 통과하여 폼을 전송하려면 return true;<br />
를 해야 한다.<br />

라디오 버튼과 체크 박스<br />

비활성화 <br />
document.someform.radiogroup[i].disabled = true;<br />
비활성화하면 이 파라미터는 서버에 전송되지 않는다.<br />
<em class="filename">send.jsp</em>
<pre class="code">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	return true;
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" action="take.jsp" method="post" onsubmit="return check()"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;
	&lt;input type="submit" value="확인" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">take.jsp</em>
<pre class="code">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String condition = request.getParameter("condition");
%&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
Hello, &lt;%=name %&gt;님, 컨디션은 &lt;%=condition %&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

라디오 버튼이나 체크 박스의 선택에 의해서 이벤트 핸들러 등록하기<br />
<em class="filename">send.jsp</em>
<pre class="code">
&lt;%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%&gt;
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;자바스크립트 테스트&lt;/title&gt;
&lt;script type="text/javascript"&gt;
function agree() {
	var form = document.getElementById("testForm");
	var submit = document.getElementById("submit");
	if (form.agreement.checked == true) {
		submit.disabled = false;	
	} else {
		submit.disabled = true;
	}
	
}
function check() {
	var form = document.getElementById("testForm");
	form.condition[4].disabled = true;
	var chk = form.confirm[0].value

	return true;
}
&lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;form id="testForm" action="take.jsp" method="post" onsubmit="return check()"&gt;
	이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
	B&lt;input type="radio" name="condition" value="best" /&gt;
	G&lt;input type="radio" name="condition" value="good" /&gt;
	N&lt;input type="radio" name="condition" value="normal" /&gt;
	B&lt;input type="radio" name="condition" value="bad" /&gt;
	W&lt;input type="radio" name="condition" value="worst" /&gt;&lt;br /&gt;
	서버로 정보를 전달하는 것에 동의합니다.&lt;input type="radio" name="agreement" value="y" onchange="agree()" /&gt;
	&lt;input type="submit" id="submit" value="확인" disabled="disabled" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>
라디오 버튼이나 체크박스의 경우 옵션을 동적으로 추가/삭제하지 못한다.<br />

input 엘리먼트의 type 속성은 text,password,hidden 이 있다.<br />
textarea 엘리먼트는 여러줄을 입력할 수 있게 한다.<br />
사용자가 입력한 값은 value 라는 속성으로 접근할 수 있다.<br />

사용자가 텍스트 필드에 입력한 값을 검사할 때 click 이외에도<br />
change, focus, blur 이벤트를 이용할 수 있다.<br />

click 이벤트를 함수와 연결하기 위해선 onclick="핸들러함수()"<br />
와 같이<br /> 
onchange="핸들러함수"<br />
onfocus="핸들러함수"<br />
onblur="핸들러함수"<br />
와 같이 사용할 수 있다.<br />

<h2>쿠키</h2>
쿠키란 키-값 쌍의 작은 데이터로 파기 날짜, 도메인, 경로 정보를 담고 있다.<br />
쿠키에 담긴 정보는 웹페이지 요청의 일부로 전송되기 때문에 <br />
서버 사이드 스크립트와 클라이언트 사이드 스크립트에서 
모두 핸들링 할 수 있다.<br />

쿠키 저장 읽기<br />
쿠키를 생성하려면 <br />
쿠키명=쿠키값;파기날짜;경로 <br />
이런 형태의 문자열이 요청의 일부로 웹브라우저에 전달되어야 한다.<br />

쿠키예제(클라이언트 사이드에서)<br />
페이지에서 보일 레코드 수를 쿠키값으로 변경하기<br />
<pre  class="code">
function setCookie(name, value, days) {
	var cookieStr = name + "=" + escape(value);
	
	if (days) {
		var expires = new Date();
		expires.setDate(expires.getDate() + days);
		cookieStr += "; expires=" + expires.toGMTString();
	}
	
	document.cookie = cookieStr;
}

function getCookie(name) {
	var cookie = document.cookie;
	var beginIndex = cookie.indexOf(" " + name + "=");
	if (beginIndex == -1) {
		beginIndex = cookie.indexOf(name+"=");
	}
	if (beginIndex == -1) {
		return null;
	} else {
		beginIndex = cookie.indexOf("=", beginIndex) + 1;
		var endIndex = cookie.indexOf(";", beginIndex);
		if (endIndex == -1) {
			endIndex = cookie.length;
		}
		return unescape(cookie.substring(beginIndex, endIndex));
	}
	
}
</pre>

<pre class="code">
function setNumPerPage() {
	var selectElement = document.getElementById("numPerPage");
	var numPerPage = selectElement.value;
	setCookie('numPerPage',numPerPage,'100')
}
</pre>

<em class="filename">index.jsp</em>
<pre class="code">
&lt;%
int numPerPage = 10;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (int i=0; i &lt; cookies.length; i++) {
	String name = cookies[i].getName();
	if (name.equals("numPerPage")) {
		numPerPage = Integer.parseInt(cookies[i].getValue());
	}
}

//중간생략..
%&gt;
</pre>

<h2>문서 객체 모델</h2>
웹브라우저는 도큐먼트 객체 모델로 웹 페이지를 관리한다.<br />
DOM 을 자바스크립트를 이용하면 동적으로 변경할 수 있다.<br />
<br />
DOM 란?<br />
플랫폼과 언어에 중립적인 인터페이스로,프로그램과 스크립트를 사용해서 
동적으로 접근할 수 있도록 하며,문서의 내용,구조,스타일을 변경할 수 있다.<br />

<pre class="code">
&lt;html&gt;
  &lt;head&gt;
    &lt;title&gt;무한도전 팬클럽&lt;/title&gt;
  &lt;/head&gt;
  &lt;body&gt;
    &lt;h1&gt;오늘의 미션&lt;/h1&gt;
    &lt;div&gt;
	&lt;p&gt;
	베이징 올림픽을 맞아 체조 선수들을 격려차 방문하여
	미션을 펼친다.
	&lt;/p&gt;
	&lt;p&gt;
	방송일 2008년 8월 15일 2시 45분
	&lt;/p&gt;
    &lt;/div&gt;
  &lt;/body&gt;
&lt;/html&gt;
</pre>

이 문서를 DOM 구조로 그려보시오.<br />

DOM 은 이러한 트리 노드에 접근할 수 있는 표준을 제공<br />

노드의 프로퍼티, 메소드<br />
문서 트리 내의 각 노드는 종류에 상관없이 Node 객체 프로퍼티와 메소드를
 기본 집합으로 갖는다.<br />

Node 객체의 프로퍼티<br />
nodeName<br />
객체명, 예를 들면 HEAD 엘리먼트의 nodeName 은 HEAD<br />

nodeValue<br />
엘리먼트가 아닌 경우, 객체의 값<br />

nodeType<br />
노드의 종류, 숫자로 표현<br />

parentNode<br />
부모 노드<br />

childNodes<br />
자식노드의 NodeList<br />

firstChild<br />
NodeList 에 존재하는 자식 노드 중 첫번째 노드<br />

lastChild<br />
NodeList 에 존재하는 자식 노드 중 마지막 노드<br />

previousSibling<br />
NodeList 에 존재하는 현재 자식 노드의 이전 노드<br />

nextSibling<br />
NodeList 에 존재하는 현재 자식 노드의 다음 노드<br />

attributes<br />
엘리먼트 속성의 키-값의 목록인 NamedNodeMap<br />
(다른 객체에는 사용할 수 없다)<br />

ownerDocument<br />
문서 객체<br />

namespaceURI<br />
노드에 대한 네임스페이스 URI<br />

prefix<br />
노드에 대한 네임 스페이스 prefix<br />

localName<br />
네임스페이스 URI 가 존재할 경우 노드에 대한 로컬 이름<br />

일부 프로퍼티는 엘리먼트(h1, div)에, 또는 엘리먼트가 아닌 것(text)에
 적용된다는 것에 유의할 것<br />

노드 프로퍼티로의 접근하는 예제<br />

nodeValue : null 이 아닐 때 style 프로퍼티 설정<br />
nodeValue 프로퍼티 값이 없을 경우 style 프로퍼티 값을 설정하지 않음<br />

nodeType<br />
ELEMENT : 1<br />
ATTRIBUTE : 2<br />
TEXT : 3<br />
CDATA_SECTION : 4<br />
ENTITY_REFERENCE : 5<br />
ENTITY : 6<br />
PROCESSING_INSTRUCTION : 7<br />
COMMENT : 8<br />
DOCUMENT : 9<br />
DOCUMENT_TYPE : 10<br />
DOCUMENT_FRAGMENT : 11<br />
NOTATION : 12<br />

Node 트리 탐색<br />
문서 내용의 탐색에 Node 사용<br />
예제 10-4 : 페이지 엘리먼트의 자식에 접근하기 위해서 childNodes<br /> 
리스트 사용<br />
예제 10-5,6,7 : 객체와 레벨을 함께 출력하며, 자식이 존재할 경우<br /> 
자식까지 출력<br />
레벨은 페이지 내에서 HTML 엘리먼트가 중첩된 정도를 의미<br />

이 예제보다 더 좋은 예제는 w3c 옵션 레벨 2 탐색 및 범위 스펙 사용<br />
http://www.w3.org/TR/DOM-level-2-Traversal-Range/<br />

DOM 코어 document 객체<br />
document 객체는 자바스크립트에서 웹 브라우저의 DOM 나무를 사용할 수 
있게 해준다.<br />
웹 브라우저가 만든 웹 페이지 모델의 모든 부분은 자바스크립트의 document
 객체를 통해 접근할 수 있다.<br />

대표 메소드 : <br />
getElementById<br />
getElementByTagName : 특정 태그의 노드 리스트 반환<br />

var list = document.getElementByTagName("div");<br />

예제 10-8,9 : getElementByTagName 사용 예<br />

컨텍스트 내에서 엘리먼트 접근하기<br />

Element<br />
문서 내의 모든 객체는 Element 의 기본 기능과 프로퍼티를 상속한다.<br />
이들 대부분의 속성을 알아내고 설정하는 것이거나 속성의 존재 여부를 
알아내는 것이다.<br />

* getAttribute(name)<br />
* setAttribute(name,value)<br />
* removeAttribute(name)<br />
* getAttributeNode(attr)<br />
* removeAttributeNode(attr)<br />
* hasAttribute(name) .. 등등<br />

HTML 문서에<br />

&lt;img src="dotty.gif" width="100" alt="an image" align="left" /&gt;<br />

자바스크립트<br />
<pre class="code">
var img = document.images[0];
var imgstr = img.getAttribute("scr") + " " +
	     img.getAttribute("width") + " " +
	     img.getAttribute("alt") + " " +
	     img.getAttribute("align");

alert(imgstr);
</pre>
width, alt 변경
<pre class="code">
img.setAttribute("width", "200");
img.setAttribute("alt", "This was an image");
</pre>
Element 의 getElementByTagName <br />
특정 컨텍스트 내의 엘리먼트에 대해서만 동작<br />

<pre class="code">
&lt;div id="div1"&gt;
  &lt;p&gt;one&lt;/p&gt;
  &lt;p&gt;two&lt;/p&gt;
&lt;/div&gt;
&lt;div id="div2"&gt;
  &lt;p&gt;three&lt;/p&gt;
&lt;/div&gt;
</pre>
getElementById 를 사용하면 각 문단에 개별적으로 접근할 수 없다.<br />
getElementByTagName 를 사용하면 가능<br />

var ps = document.getElementByTagName("p");<br />

div1 의 p 에 접근하려면<br />

var div = document.getElementById("div1");<br />
var ps = div.getElementByTagName("p");<br />
ps 는 div1 엘리먼트에만 포함된 p 엘리먼트<br />

트리 변경<br />
document 는 모든 페이지 엘리먼트의 소유자이자 부모<br />
새로운 엘리먼트의 인스턴스를 생성하는 대부분의 팩토리 메소드는 
document 객체의 메소드이다.<br />

메소드<br />
createElement(tagName) : Element : 특정태그에 해당하는 엘리먼트 생성    <br />                   
createDocumentFragment : DocumentFragment : document 트리의 특정부분을 추출할 때 사용<br />
createTextNode(data) : Text : 페이지 내의 텍스트<br />
createComment(data) : Comment : XML 주석<br />
createCDATASection(data) : CDATASection : CDATA 부분<br />
createProcessInstructions(target,data) : ProcessingInstruction : XML 처리 지시 사항<br />
createAttribute(name) : Attr : 엘리먼트 속성<br />
createEntityReference(name) : EntityReference : 나중에 추가될 엘리먼트에 대한 공간 확보<br />
createElementNS(namespaceURI,qualifiedName) : Element : Element 에 대한 네임스페이스<br />
createAttributeNS(namespaceURI,qualifiedName) : Attr : Element 속성에 대한 네임스페이스<br />

새로운 노드 생성<br />
var textNode = document.createTextNode("This is a Text node");<br />

하나의 노드가 존재하는 상태에서 새로운 노드를 추가하려면 Node 변경 메소드를 사용<br />

insertBefore(newChild, refChild)<br />
; 현재 노드 앞에 새 노드를 추가한다.<br />

replaceChild(newChild,oldChild)<br />
; 현재 노드를 대체한다.<br />

removeChild(oldChild)<br />
; 현재 노드를 제거한다.<br />

appendChild(newChild)<br />
; 문서에 자식 노드를 추가한다.<br />

이러한 메소드가 유효하려면 컨텍스트 내에서 사용해야 한다.<br />
다시 말해서, 대체하거나 변경해야 할 노드를 포함하는 엘리먼트에 사용해야 한다.<br />

웹페이지 h1 이 포함된 div 엘리먼트가 있을 때 이 h1 를 대체하려면 
div 엘리먼트에 접근해야 한다.<br />

var div = document.getElementById("div1");<br />
var hdr = document.getElementById("hrd1");<br />
div.removeChild(hdr);<br />

<pre class="code">
&lt;div id="div1"&gt;
  &lt;h1 id="hdr1"&gt;..&lt;/h1&gt;
&lt;/div&gt;
</pre>
예제 10-10 : 정적 페이지를 변경<br />

<h2>동적 웹페이지와 CSS</h2>
되도록이면 CSS를 사용하지만 그래도 필요하면...<br />
element 의 style 프로퍼티<br />

형식<br />
element.style.color="#fff";<br />

div 엘리먼트의 style 프로퍼티 변경하기<br />
엘리먼트에서 style를 인라인으로 사용하지 않았다면 자바스크립트를 
이용해서 style 를 변경했다 하더라도 안될 것이다.(확인요)<br />

폰트와 텍스트<br />
형식<br />
div.style.font="italic small-caps 14px verdana";<br />

예제 12-3 : 텍스트의 속성을 변경하는 예제(TODO)<br />

위치 지정과 이동<br />
position :{ absolute | relative }<br />
디폴트는 static<br />

top, left, bottom, right<br />
z-index : 0이 기본<br />

예제 12-4 : 플라인 인을 사용한 엘리먼트의 위치 지정과 이동<br />
엘리먼트를 움직이기 위해서 값이 100 이상이 되기 전까지 증가시켜 
이동시킨다.<br />
엘리먼트를 페이지 바깥에 위치시킬 때는 숨기는 것이 좋다.<br />
왜냐하면 스크롤이 나타나기 때문<br />

드래그 앤 드롭<br />
overflow 속성 <br />
div 엘리먼트의 컨텐츠 중에서 넘치는 부분은 숨기거나 자르는데 사용<br />

예제 12-5 : 구글맵의 효과, 컨테이너 객체의 드래그 앤 드롭<br />
소스 설명<br />
dragObject : 드래그되는 객체<br />
mouseOffset : 그 객체의 offset 값<br />
offset 은 컨테이너에서 객체의 상대적 위치를 말한다.<br />
이 경우에 컨테이너는 문서(웹페이지)다.<br />
문서에 대해서 mousemove 또는 mouseup 이벤트를 캡쳐하여 mouseMove,mouseUp 이벤트 핸들러 각각을 처리한다.<br />
; 전역 변수<br />

mousePoint 객체 : 마우스의 x좌표와 y좌표를 나타낸다.<br />
이렇게 객체로 만들어 놓으면 주고 받을 때 편리<br />

mousePosition 함수 :<br /> 
대상 객체의 clientX, clientY 값(즉, 창에서 크롭영역을 제외한 클라이언트 영역의 상대값)에 접근해서 그 값을 mousePoint 객체에 저장해서 반환
parseInt 는 값이 숫자임을 확실히 해준다.<br />

getMouseOffset :<br /> 
대상 객체와 이벤트를 인자로 받는다.<br />
이벤트 객체의 처리를 여러 브라우저에서 호환할 수 있도록 한 다음에,<br />
이벤트의 마우스 위치를 mousePoint 객체에 저장한다.<br />
그리고 여기서 객체의 offsetLeft 와 offsetTop 프로퍼티 값만큼 빼준다.<br />
이 연산을 생략한다면 객체가 마우스를 따라서 움직이기는 하겠지만 객체가 위에 뜨거나 가라앉는 것과 같이 약간 이상한 행동을 보일 것이다.<br />

mouseUp 함수 : dragObject 를 null 로 설정해서 드래그의 중단을 알리는 것이다.<br />
그 다음에 오는 mouseMove 는 드래그의 움직임에 따라 연산하는 부분이다.<br />
이 연산은 드래그 객체가 설정되어 있을 때만 한다.<br />
즉, 드래그 객체가 설정되어 있지 않으면 함수가 종료된다.<br />
노멀라이즈된 마우스의 위치가 발견되면 객체의 position 프로퍼티를 absolute 로 설정하고 left, top 프로퍼티를 설정한다.<br />
(이때 설정 직전에 오프셋 값을 반영)<br />

makeDraggable 함수 :<br /> 
인자로 받은 객체를 드래그 가능하도록 한다.<br />
즉, 객체의 mousedown 이벤트에 대한 핸들러 함수를 추가하고,<br />
이 함수에서 객체가 드래그 객체를 배정하고, 객체의 오프셋 값을 얻는다.<br />

크기와 클리핑<br />
엘리먼트의 크기 width, height<br />
엘리먼트의 width, height에 따라 border, margin, padding, content 등의 여러 속성들이 결정된다.<br />

이들 모두를 합쳐 CSS 박스 모델 이라고 부른다.<br />

cSS overflow 속성값<br />
visible : 모든 컨텐츠 표시<br />
hidden : 경계선 바깥을 잘라냄<br />
scroll : 일부만 잘라내고, 스크롤바 나타남<br />
auto : 넘칠 경우 스크롤바 나타남<br />
<br />
오버플로우와 동적 컨텐츠<br />
예제 12-6 : 컨텐츠의 크기 변경과 overflow 설정의 영향<br />
; 컨텐츠가 서로 교환되었을 때, 첫번째 블록은 빈 공간이 많이 생긴다.<br />

클리핑 사각형<br />
클리핑 구역 : 엘리먼트의 컨텐츠에서 보이도록 지정하는 구역<br />
CSS clip 프로퍼티 (top, right, bottom, left)<br />

형식<br />
clip : rect(top,right,bottom,left)<br />

예제 12-7 : 타이머와 클리핑을 이용한 드롭다운 애니메이션<br />
;현재의 상태를 알아내기 위해 style 프로퍼티에서 클리핑 값을 직접 얻지 않고 전역 변수를 사용했음<br />

디스플레이, 가시성, 투명도<br />
visibility 의 값의 종류<br />
hidden<br />
visible<br />
inheric : 컨테이너 엘리먼트의 설정을 상속<br />

display: none<br /> 
; 페이지 레이아웃에 영향을 준다.<br />

마지막 장: 풍부한 라이브러리<br />
http://http://prototypejs.org/<br />
다운로드 한 후<br /> 
자신의 프로젝트의 웹페이지에 다음과 같이 임포트한다.<br />
&lt;script type="text/javascript" src="prototype.js" /&gt;

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://en.wikipedia.org/wiki/HTTP_cookie">http://en.wikipedia.org/wiki/HTTP_cookie</a></li>
	<li><a href="http://ezbuilder.tistory.com/34">http://ezbuilder.tistory.com/34</a></li>
</ul>