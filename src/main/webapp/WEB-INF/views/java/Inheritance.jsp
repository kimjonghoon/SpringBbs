<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.4.4</div>
	
<h1>상속</h1>

상속을 이용하면 계층적으로 클래스를 만들 수 있다.<br />
수퍼 클래스는 자신의 구현내용을 서브 클래스에 물려주고, 서브 클래스는 수퍼클래스로부터 구현내용을 상속받는다.<br />

<ul>
	<li>수퍼(super) 클래스 : 구현내용을 서브 클래스에 물려주는 클래스, 부모 클래스라고도 한다.</li>
	<li>서브(sub) 클래스 : 수퍼클래스로부터 구현내용을 상속받는 클래스, 자식 클래스라고도 한다.</li> 
</ul>

객체지향 프로그래밍에서 가장 중요하게 생각하는 것이 재사용여부이다.<br />
재사용은 클래스를 그대로 재사용하기도 하고 수퍼 클래스를 재사용하기도 한다.<br />
수퍼 클래스를 재사용할 때는 수퍼 클래스로부터 적절하게 서브 클래스를 만들어 사용하는 것을 말한다.<br />
<br />
상속 관계를 아닌 클래스의 예부터 보자.<br />
다음은 사원(Employee)클래스와 관리자(Manager)클래스이다.<br />


<em class="filename">사원 클래스(Employee.java)</em>
<pre class="prettyprint">
package net.java_school.example;

public class Employee {
	private String name;
	private String position;
	private String telephone;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(name);
		sb.append("|");
		sb.append(position);
		sb.append("|");
		sb.append(telephone);
		
		return sb.toString();
	}
	
}
</pre>

<em class="filename">관리자 클래스(Manager.java)</em>
<pre class="prettyprint">
package net.java_school.example;

public class Manager {
	private String name;
	private String position;
	private String telephone;
	private String manageJob;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getManageJob() {
		return manageJob;
	}

	public void setManageJob(String manageJob) {
		this.manageJob = manageJob;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(name);
		sb.append("|");
		sb.append(position);
		sb.append("|");
		sb.append(telephone);
		sb.append("|");
		sb.append(manageJob);
		
		return sb.toString();
	}
	
}
</pre>

Test클래스를 만든다.<br />

<em class="filename">Test.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class Test {
	public static void main(String[] args) {
		Employee im = new Employee();
		im.setName("임꺽정");
		im.setPosition("대리");
		im.setTelephone("19");
		System.out.println(im.toString());	
	
		Manager hong = new Manager();
		hong.setName("홍길동");
		hong.setPosition("과장");
		hong.setTelephone("9");
		hong.setManageJob("프로젝트관리");
		System.out.println(hong.toString());
	}	
}
</pre>

위의 두 클래스는 서로 아무런 관계가 없는 것으로 만들었다.<br />
하지만 "관리자는 사원이다"라는 명제가 옳으므로 두 클래스는 "~이다" 관계가 성립하는 상속 관계이다.<br />
이때 사원이 관리자보다 더 넓은 개념이므로 사원이 수퍼 클래스, 관리자가 서브 클래스가 된다.<br />
이제 상속 관계를 코드로 구현하기 위해 사원 클래스와 관리자클래스에서 중복되는 코드가 있는지 확인한다.<br />
name,position,telephone인스턴스 변수와 이 변수에 대한 getters, setters메소드가 중복되는 것을 확인할 수 있다.<br />
중복되는 코드는 상속될 것이므로 관리자 클래스 소스에서 삭제할 것이다.<br />
사원 클래스를 상속하도록 관리자 클래스를 아래와 같이 수정한다.<br />

<em class="filename">Manager.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class Manager <strong>extends</strong> Employee {
	private String manageJob;
	
	public String getManageJob() {
		return manageJob;
	}

	public void setManageJob(String manageJob) {
		this.manageJob = manageJob;
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(getName());
		sb.append("|");
		sb.append(getPosition());
		sb.append("|");
		sb.append(getTelephone());
		sb.append("|");
		sb.append(manageJob);
		
		return sb.toString();
	}
	
}
</pre>

클래스가 어떤 클래스를 상속하려면 클래스 선언부에 extends키워드를 사용한다.<br />
이제 관리자 클래스는 사원클래스의 멤버를 마치 자기 멤버<a href="#comments"><sup>1</sup></a>인 양 쓸 수 있게 된다.<br />
하지만 이제부터는 상속된 멤버와 자신의 고유한 멤버는 분리해서 생각해야 하는데 <strong>상속받은 멤버는 여전히 접근자가 적용</strong>되기 때문이다.<br />
관리자클래스의 toString()메소드에서 getName(), getPosition(), getTelephone()을 사용해야 하는 이유가 사원 클래스의 
name, position, telephone 의 접근자가 private이기 때문이다.<br />
부모의 멤버변수인 name, position, telephone에 바로 접근하려면 이들 멤버 변수의 접근자를 변경해야 하다.<br />
사원클래스와 관리자클래스가 같은 팩키지에 있으므로 사원클래스의 name, position, telephone에 디폴트 접근자 이상으로 적용하면 된다.<br />
만약 사원 클래스와 관리자 클래스가 같은 팩키지가 아니라면 사원 클래스의 name, position, telephone의 접근자는 protected접근자 이상으로 적용해야 한다.<br />
protected는 자식 타입의 객체에서 부모의 멤버에 접근할 때 부모 클래스가 다른 팩키지에 속해 있다 하더라도 접근할 수 있게 한다.
다른 팩키지에 있는 클래스간 상속관계를 보호한다는 의미에서 접근자 이름이 protected인 것이다.<br />
Test클래스를 실행하여 결과를 확인한다.<br />

<dl class="note">
<dt>메소드 오버라이딩(Overriding)</dt>
<dd>
부모로부터 상속받은 메소드 그대로 사용할 수 있지만, 원한다면 "재정의"해서 사용하는 것을 <strong>메소드 오버라이딩</strong><a href="#comments"><sup>2</sup></a>이라고 한다.<br />
자식 클래스에서 부모 클래스의 메소드를 재정의 할 때 리턴 타입, 메소드명, 매개변수 리스트는 같아야 한다.<br />
사원 클래스의 toString()은 Object클래스의 toString()를 오버라이딩하고 관리자 클래스의 toString()은 사원 클래스의 toString()를 오버라이딩하고 있다.<br />
잠깐, 사원 클래스의 toString()이 Obejct클래스의 toString()을 오버라이딩한다고? 사원 클래스 코드(Employee.java)를 다시 확인한다. 클래스 선언부에 extends키워드가 있는가?<br />
클래스 선언부에 extends키워드가 없다면 그 클래스는 Object클래스를 상속하게 된다.<br />
컴파일러가 개입하여 클래스 선언부를 public class Employee extends Object로 변경하여 컴파일하기 때문이다.<br />
그래서 사원 클래스의 부모 클래스는 Object가 되는 것이다.<br />
@Override와 같은 쓰임을 어노테이션이라 하는데, 자바 코드로 전달할 수 없는 정보를 컴파일러나 플랫폼에 전달한다.
위 코드에서 @Override는 메소드가 부모 클래스의 메소드를 오버라이딩한다는 정보를 컴파일러에게 알려주게 된다.<br /> 
</dd>
</dl>

<h2>생성자(Constructor)</h2>
Test클래스의 메인 메소드에서 <em>Manager hong = new Manager();</em> 는 Manager객체를 생성하는 코드이다.<br />
이제 이 코드부분에 대해서 좀 더 자세히 말할 때가 되었다.<br />
new다음에 오는 Manager()는 메소드 모양이지만 메소드가 아닌 Manager()라는 생성자를 호출하는 코드이다.<br />
이때 Manager()는 메소드와 마찬가지로 반드시 클래스에 선언되어 있어야 한다.<br />
즉, new다음에는 클래스에 선언된 생성자 중에 하나를 호출할 수 있다.<br />
바로 위의 예제에서 사원 클래스와 관리자 클래스에 생성자를 만들지 않았다.<br />
그렇지만 Test의 메인 메소드에서 생성자를 호출하고 있다.<br />
그리고 에러 없이 결과를 볼 수 있다는 것은 호출한 생성자가 실행되었다는 것을 의미한다.<br />
어떻게 만들지도 않는 생성자가 호출될 수 있었을까?<br />
답은 컴파일러에 있다. 클래스를 작성하면서 아무런 생성자도 만들지 않았다면 컴파일러가 컴파일할 때 매개변수가 없는 생성자를 만들어 컴파일한다.<br />
컴파일러가 자동으로 생성해 준 생성자를 "디폴트 생성자"(default constructor)라고 한다.<br />
만일 생성자를 하나라도 만들었다면 컴파일러는 "디폴트 생성자"를 만들지 않는다.<br />
<br />
다양한 매개변수 리스트를 가진 생성자를 여러개 만들 수 있다.<br />
생성자는 "객체가 생성된 후" <strong>바로 단 한번 호출되고 다시는 호출되지 않는다.</strong><br />
"객체가 생성된 후" 란 말에 주목해야 한다.<br />
생성자라는 이름 때문에 생성자가 호출되어야 객체가 생성되는 것이라고 생각하면 오해다.<br /> 
new 란 키워드에 의해서 힙(heap)메모리<a href="#comments"><sup>3</sup></a>에 객체를 위한 공간이 할당되고 인스턴스 변수의 값이 초기화<a href="#comments"><sup>4</sup></a>된다.<br />
그 다음 new다음에 있는 생성자가 호출된다.<br />
생성자가 에러없이 마치면 참조형 변수에 생성된 객체를 참조할 수 있는 참조값이 대입된다.(Manager <strong>hong</strong> = new Manager();에서 <strong>hong</strong>에 할당된다)<br />
생성자에 에러가 있다면 레퍼런스 hong에 참조값이 할당되지 않고 결과적으로 그 객체는 사용할 수 없게 된다.<br />
<br />
생성자는 객체가 생성 후 자동적으로 호출되므로 객체 초기화나 그 외 초기화와 관련된 작업만을 하도록 작성하는 것이 좋다.<br />
생성자는 인스턴스 변수를 초기화하는 코드가 대부분이다.<br />
생성자 구현부에 메소드를 호출하는 코드가 있다면 좋은 코드가 아닌 경우가 많다.<br />
<br />
생성자는 리턴 타입이 없고 생성자명은 클래스명과 같아야 한다.<br />
많이 하는 실수 중 하나가 생성자명 앞에 void를 붙이는 경우이다.<br /> 
void를 붙이면, 이것은 메소드이지 생성자가 아니다.<br />
<br />
다음은 생성자 내용 중 상속과 관련된 것이다.<br />
서브 클래스는 수퍼 클래스의 멤버(인스턴스 변수와 메소드)를 상속받는다고 했다.<br />
하지만 생성자는 상속되지 않는다. 그리고 자식 클래스 생성자 구현부의 첫 라인은 반드시 부모 클래스의 생성자를 호출하는 코드가 있어야 한다.<br />
만약 없다면 컴파일러가 부모 클래스의 디폴트 생성자를 호출하는 코드를 첫 라인에 집어넣어 컴파일한다.<br />
지금까지의 내용을 종합하여 사원 클래스와 관리자 클래스에 적절한 생성자를 추가할 것이다.<br />
코드를 구현하기 전에 this와 super키워드에 대해 알아보자.<br />

<dl class="note">
<dt>this</dt>
<dd>
this가 실행되는 시점에서 this에는 객체 자신의 참조값을 가지고 있게 된다.<br />
this키워드는 생성자 안에서 다른 생성자를 호출할때와 생성자나 메소드안에서 인스턴스 변수와 매개변수를 구별하기 위해 사용한다.<br />
참고로 이클립스에서 코드를 작성할 때 this다음에 .(도트)를 이어 입력하면 사용가능한 자원(멤버 변수나 메소드 등등)에 대한 코드 어시스트를 받을 수 있다.<br /> 
</dd>
<dt>super</dt>
<dd>
super키워드는 다음 경우에 쓰인다.<br />
1. 메소드 오버라이딩으로 숨겨진 부모 클래스의 메소드를 호출해야 할 때<br /> 
2. 자식의 생성자에서 부모의 생성자를 호출할 때<br />
</dd>
</dl>

<em class="filename">사원 클래스에 생성자 추가</em>
<pre class="prettyprint">
public Employee() {} //생성자를 만들 때 디폴트 생성자도 함께 만드는 것이 좋다.

public Employee(String name, String position, String telephone) {
	this.name = name;
	this.position = position;
	this.telephone = telephone;
}
</pre>

<em class="filename">관리자 클래스에 생성자 추가</em>
<pre class="prettyprint">
public Manager() {} //디폴트 생성자

public Manager(String name, String position, String telephone, String manageJob) {
	super(name, position, telephone);
	this.manageJob = manageJob;
}
</pre>

<em class="filename">테스트의 메인메소드 구현부 수정</em>
<pre class="prettyprint">
Employee im = new Employee("임꺽정", "대리", "19");
System.out.println(im.toString());	

Manager hong = new Manager("홍길동", "과장", "9", "인사");
<strong>System.out.println(hong);</strong>
</pre>

System.out.println(hong);에서 참조값을 전달받는 println()메소드는 참조값이 가리키는 객체의 toString()메소드를 호출하여 반환된 문자열을 출력한다.<br />
따라서 System.out.println(hong.toString());과 System.out.println(hong);의 결과는 같다.<br />
위의 생성자 관련 코드는 컴파일러가 아래처럼 변경하여 컴파일한다.<br />
어떤 코드를 더 좋아할지는 여러분 몫이다.<br />

<em class="filename">컴파일러가 개입하여 바꾼 사원 클래스의 생성자 코드</em>
<pre class="prettyprint">
public Employee() {
	<strong>super();</strong>
}

public Employee(String name, String position, String telephone) {
	<strong>super();</strong>
	this.name = name;
	this.position = position;
	this.telephone = telephone;
}
</pre>

<em class="filename">컴파일러가 개입하여 바꾼 관리자 클래스의 생성자 코드</em>
<pre class="prettyprint">
public Manager() {
	<strong>super();</strong>
}

public Manager(String name, String position, String telephone, String manageJob) {
	super(name, position, telephone);
	this.manageJob = manageJob;
}
</pre>




<h2>부모 타입의 참조형 변수에 자식 타입의 참조값을 할당할 수 있다.</h2>

모양은 같으나 다양한 형태로 실행되는 것 같은 느낌이 들도록 하는 것이 다형성이다.<br />
부모 클래스 타입의 레퍼런스에 자식 클래스 타입의 객체의 참조값을 할당할 수 있다는 점을 이용하면 이러한 다형성을 볼 수 있다.<br /> 

<div style="float: left;width: 300px;">
	<img src="https://lh3.googleusercontent.com/oKmJj0Atf64TWGpKUAukcvyh_IYb1461FvUmL5OvgTkPJoNwS0BkUT17W3UNr5MpnBrGcgqJtAI7WA=w1680-h1050-no" alt="다형성 그림" />
</div>
<p style="line-height: 2em;padding-top: 10px;">
니체 extends 철학자<br />
스피노자 extends 철학자<br />
<strong>철학자 a</strong> = new 니체(); //a는 철학자 타입의 변수<br />
<strong>a.말하다();</strong> //니체 말하다.<br />
a = new 스피노자();<br />
<strong>a.말하다();</strong> //스피노자 말하다.<br />
</p>

<p style="clear: both;">

<strong>a.말하다();</strong>로 니체가 말하고 스피노자가 말한다.<br /> 
a.말하다()는 다형성을 가지게 된다.<br />
a.말하다()가 실행되는 시점(Runtime)에 니체가 말하는지, 스피노자가 말하는지가 결정된다.<br />
컴파일시에 결정되는 않는다는 말이다.<br />
<br />
부모 클래스 타입의 참조형 변수가 자식 타입의 객체를 참조할 때 객체의 모든 멤버에 접근할 수 있는 것은 아니다.<br />
제한이 있는데 자식의 고유한 멤버는 접근하지 못한다.<br />
여기에도 예외가 있다.<br />
자식이 오버라이딩한 메소드는 접근한다는 것이다.(사실 이 부분이 가장 이해하기 힘들다.)<br />
결론적으로, 부모 타입의 레퍼런스(참조형 변수를 대부분 레퍼런스 변수 또는 레퍼런스라고 한다. 레퍼런스는 문맥에 따라 참조값으로 해석될 수 있다.)는 부모로부터 상속된 것과 오버라이딩한 메소드를 접근할 수 있다.<br />
예제를 통해 알아보자.<br />
사원 클래스와 관리자 클래스는 그대로 두고 테스트의 메인 메소드에 다음을 추가한다.<br />
</p>

<em class="filename">Test.java 의 메인메소드 구현부 추가</em>
<pre class="prettyprint">
Object jang = new Manager("장길산", "부장", "1", "영업");
System.out.println(jang);
//jang.setManageJob("회계");//Object형 레퍼런스로 setManagerJob()메소드에 접근할 수 없다.
//만약 장길산 사원객체를 완전하게 사용하기를 원한다면 참조형 변수를 형변환을 해야 한다.
Manager janggilsan = (Manager)jang;
janggilsan.setManageJob("회계");
System.out.println(jang);
</pre>

마지막 줄 System.out.println(jang); 여기서 jang은 Object타입의 참조값이다.<br />
그러면 println()메소드 내부에서 이 참조값이 가리키는 객체의 toString()메소드를 호출할 것이다.<br />
실제로 힙메모리에 생성된 객체는 관리자 객체이므로 관리자 객체가 오버라이딩한 toString()메소드가 호출된다.<br />
아래 그림은 이해를 돕기 위해 그렸다. 관리자 객체를 가리키는 Manager, Employee, Object 중 어떤 타입의 레퍼런스도 (2), (3)은 덮어져서 볼 수 없다. 따라서 (1)이 호출된다.<br />
  
<img src="https://lh5.googleusercontent.com/-srKMgjnwSHg/UzqSHOCBfeI/AAAAAAAABoM/5GeaD937isI/w1040-h768-no/Manager-Object.png" alt="Manager객체 그림" width="590px" /><br />

<dl class="note">
<dt>메소드 오버로딩(method overloading)</dt>
<dd>
아규먼트 리스트가 다르다면 똑같은 이름의 메소드를 얼마든지 만들 수 있다는 것이 메소드 오버로딩이다.<br />
overloading이란 영어 단어를 해석하면 "과적"이다. "고속도로에서 과적차량을 단속한다"할 때 바로 그 과적이다.<br />
오버로딩할 수 있는 것은 똑같은 이름으로 메소드를 여러 개 만들어도 컴파일 에러가 나지 않는다라는 의미 뿐 아니라
호출하면서 전달한 아규먼트에 따라 거기에 꼭 맞게 선언된 메소드가 호출된다는 것을 보장된다는 의미도 포함된다.<br />  
주의할 점은 반환값 타입은 메소드 오버로딩과 아무런 상관이 없다는 것이다.<br />
즉, 매개변수 리스트가 같으면서 반환값 타입만 다르게 하여 같은 이름의 메소드를 만들 수 없다. 
컴파일 에러를 만나게 된다.<br />
<br />
자바에서는 이름을 짓는 것이 중요하다.<br />
메소드 이름만 보고도 이 메소드가 무슨 행위를 하는지 파악이 되도록 이름을 짓도록 하기 위해 노력을 해야 한다.
메소드 오버로딩은 이름을 짓는데 있어서 이와 같은 부담을 줄여준다.<br />
<br />
오버로딩된 메소드를 사용하는 입장에서는 모양은 같으나 다양한 형태로 실행되는 것 같다는 느낌을 받게 된다.<br />
메소드 오버로딩은 다형성을 띠고 있다.<br />
가장 좋은 예는 System.out.println(); 와 같이 써왔던 print()와 println()메소드<a href="#comments"><sup>5</sup></a>이다.<br />
print()와 println()메소드를 호출하면서 인자로 뭘 대입하더라도 모두 출력하는 것처럼 보인다.<br />
사실 이것은 매개변수 리스트가 다르게 정의된 메소드가 오버로딩(과적)되어 만들어져 있고 인자값에 따라서 그에 맞게 정의된 메소드가 정확히 호출되기 때문이다.<br />
</dd>
</dl>

<h2>final 키워드</h2>
<ol>
	<li>클래스 선언부에 사용되면 해당 클래스를 상속하여 서브 클래스를 만들지 못하게 된다.<a href="#comments"><sup>6</sup></a></li>
	<li>메소드 선언부에 사용되면 해당 메소드는 자식 클래스에서 오버라이딩 할 수 없다.</li>
	<li>자바에서 상수를 만들 때는 변수명 앞에 final을 붙인다.</li>
</ol>

<h2>추상클래스(Abstract Class)</h2>
클래스 선언부에서 class앞에 abstract가 있는 클래스를 추상 클래스라고 한다.<br />
추상 클래스는 일반적인 클래스와 달리 new 라는 키워드를 사용해서 객체화 할 수 없다.<br />
추상클래스를 이해하기 위해서는 먼저 추상 메소드의 의미를 알아야 한다.<br />
추상메소드란 메소드 선언부만 있고 메소드의 바디({시작해서 }로 끝나는 구현부)가 없는 메소드이다.<br />
추상메소드는 다른 메소드와 구분하기 위해서 선언부에서 접근자 다음에 abstract를 붙인다.<br />
만약 클래스에 추상 메소드가 하나라도 있다면 그 클래스는 추상 클래스로 선언해야 한다.<br />
(반대로 모든 추상 클래스에는 1개 이상의 추상 메소드가 있어야 하는 것은 아니다. 필요에 따라서 추상 메소드 없이 추상 클래스를 선언하기도 한다.)<br />
추상 클래스를 이용한다는 것은, 추상 클래스를 상속하고 추상 클래스의 추상 메소드를 구현한 클래스를 만들어 사용한다는 의미다.<br />
좋은 예제는 아니더라도 지금까지의 예제를 수정하여 추상 클래스 예제를 만들어 보겠다.<br />
아래처럼 추상클래스 AbstractEmployee.java클래스를 작성한다.<br />
(이와 같이 구체적이지 않고 모호하게 만들면 이식성이 좋아진다. 물론 설계가 잘되었다는 전제가 있어야 하겠지만)

<em class="filename">AbstractEmployee.java</em>
<pre class="prettyprint">
package net.java_school.example;

public abstract class AbstractEmployee {
	private String name;
	
	public AbstractEmployee() {}
	
	public AbstractEmployee(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	<strong>//추상메소드
	public abstract void doWork();
	</strong>
	
}
</pre>

<p>
사원 클래스가 AbstractEmployee추상클래스를 상속하도록 변경한다.<br />
이때 사원 클래스는 AbstractEmployee클래스의 추상메소드 doWork()메소드를 구현해야 한다.<br />
</p>

<em class="filename">Employee.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class Employee extends AbstractEmployee {
	private String position;
	private String telephone;
	
	public Employee() {}
	
	public Employee(String name,String position, String telephone) {
		super(name);
		this.position = position;
		this.telephone = telephone;
	}
	
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append(this.getName());
		sb.append("|");
		sb.append(position);
		sb.append("|");
		sb.append(telephone);
		
		return sb.toString();
	}
	
	<strong>
	public void doWork() {
		System.out.println("일한다");
	}
	</strong>	
}
</pre>

관리자 클래스는 변경하지 않는다.<br />
지금까지 작성한 Test클래스의 메인 메소드 첫 라인을 아래처럼 변경하여 실행한다.<br />
<em>AbstractEmployee im = new Employee("임꺽정", "대리", "19");</em><br />


<h2>인터페이스(interface): 컴포넌트<a href="#comments"><sup>7</sup></a>의 기능을 정의한다.</h2>

인터페이스란 클래스 선언부에 class대신 interface를 사용하며 모든 메소드가 추상 메소드로 구성된 것을 말한다.<br />
모두 추상 메소드이기에 일반 메소드와 구분하기 위한 abstract키워드는 생략한다.<br />
인터페이스 몸체에 선언된 필드는 무조건 <strong>static final</strong><a href="#comments"><sup>8</sup></a>이다.<br />
<br />
추상클래스와 마찬가지로 인터페이스 역시 단독으로 사용할 수 없고 인터페이스를 구현한 클래스를 객체화해서 사용한다.<br />
인터페이스를 구현한 클래스라면 해당 인터페이스의 모든 추상 메소드를 빠짐없이 구현한 클래스를 말한다.<br />
인터페이스를 구현한 클래스의 선언부에는 extends대신 <strong>implements</strong>란 키워드를 사용해서 클래스가 어떤 인터페이스를 구현했는지를 정의한다.<br />
implements 키워드 뒤에는 ,(콤마)로 구분하여 하나 이상의 인터페이스가 올 수 있는데 마치 다중상속처럼 보일 수 있다.<br />
<br />
자바 인터페이스는 전자제품의 사용자 인터페이스와 같다.<br />
대부분 TV는 화면 하단에 - 음량 + 과 - 채널 + 과 같은 인터페이스를 제공한다.<br />
전자제품이 같은 인터페이스를 채택했다는 것은 이들의 사용법이 같다는 것을 의미한다.<br />
자바 클래스가 전자제품이라면 전자제품의 사용자 인터페이스에 해당하는 것이 자바 인터페이스이다.<br />
텔레비젼이 브라운관에서 PDP, LCD, LED로 구현내용은 달라졌지만 다행히도 인터페이스는 변경되지 않았다.<br />
그 결과 새로운 기술의 TV를 구입한 후에 사용자 매뉴얼을 보지 않아도 TV를 사용하는데 문제가 없었다.<br />

<h3>언제 인터페이스를 사용해야 하나?</h3>
언제 상속을 사용하고 언제 인터페이스를 사용해야 하는지는 어려운 문제이다.<br />
이 문제를 간단하게 설명하면 "~이다" 관계를 발견하면 상속을 적용한다.<br />
"~이다" 관계가 아니면서 클래스가 "어떤 기능을 가져야 한다"에 초점이 맞춰 진다면 인터페이스를 적용한다.<br />
인터페이스는 상속처럼 계층형 관계에 제약을 받지 않는다는 점과 자바는 단일 상속만을 지원하는데 반해 인터페이스는 다중상속과 같은 모양을 가질 수 있다는 점도 염두에 두자.<br />
<br />
사원 클래스를 상속한 운전기사 클래스를 만들었다고 가정하자.<br />
그리고 배달맨 클래스가 있는데 배달맨은 사원은 아니면서 운전기사 클래스와 같은 기능이 많다면 그 기능을 가지고 인터페이스를 만들 수 있을 것이다.<br />
이때 배달맨 클래스와 운전기사 클래스에 있는 중복된 코드로 부모 클래스를 만들 수 없다.<br />
왜냐하면 운전기사 클래스는 부모 클래스가 둘이 되기 때문이다.<br />
자바 소스차원에서 보면 클래스 선언부에서 extends다음에는 단 하나의 클래스만이 있어야 한다. extends다음에 ,(콤마)로 부모 클래스를 나열 할 수 없다.<br />
이것이 위에서 언급한 계층형 관계의 제약 중 하나다.<br />
하지만 배달맨 클래스와 운전기사 클래스의 공통된 기능을 인터페이스로 만들 순 있다.<br />
이제까지의 내용을 순서대로 실습해 보자.<br />
먼저 운전기사 클래스를 아래와 같이 만든다.<br />
운전기사는 직원이라고 가정했으므로 사원 클래스를 상속했다.<br />
  
<em class="filename">운전기사 클래스(Driver.java)</em>
<pre class="prettyprint">
package net.java_school.example;

public class Driver <strong>extends Employee</strong> {
	private String carNo;//관리하는 차넘버
	
	public Driver() {}
	
	public Driver(String name, String position, String telephone, String carNo) {
		super(name, position, telephone);
		this.carNo = carNo;
	}

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public void drive() {
		System.out.println(this.getName() + " 운전한다");
	}
	
	public void transport() {
		System.out.println(this.getName() + " 물건을 운송한다");
	}
	
}
</pre>

<em class="filename">배달맨 클래스(Transportor.java)</em>
<pre class="prettyprint">
package net.java_school.example;

public class Transportor {
	private String carNo;
	
	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	public void drive() {
		System.out.println("운전한다");
	}
	
	public void transport() {
		System.out.println("물건을 운송한다");
	}
	
}
</pre>

배달맨클래스와 운전기사 클래스에 drive()와 transport()이라는 공통 기능이 있다.<br /> 
이 공통 기능을 인터페이스로 작성할 수 있다.<br />
인터페이스 이름을 Drivable이라고 하겠다.<br /> 

<em class="filename">Drivable.java</em>
<pre class="prettyprint">
package net.java_school.example;

public interface Drivable {
	public void drive();
	
	public void transport();

}
</pre>

<p>
이제 배달맨과 운전기사가 이 인터페이스를 구현하는 것으로 변경한다.<br />
</p>

<em class="filename">Driver.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class Driver extends Employee implements Drivable {
	private String carNo;
	
	public Driver() {}
	
	public Driver(String name, String position, String telephone, String carNo) {
		super(name, position, telephone);
		this.carNo = carNo;
	}

	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}
	
	@Override
	public void drive() {
		System.out.println(this.getName() + " 운전한다");
	}
	
	@Override
	public void transport() {
		System.out.println(this.getName() + " 물건을 운송한다");
	}
	
}
</pre>

<em class="filename">Transportor.java</em>
<pre class="prettyprint">
package net.java_school.example;

public class Transportor implements Drivable {
	private String carNo;
	
	public String getCarNo() {
		return carNo;
	}

	public void setCarNo(String carNo) {
		this.carNo = carNo;
	}

	@Override
	public void drive() {
		System.out.println("운전하다");
	}
	
	@Override
	public void transport() {
		System.out.println("물건을 운송하다");
	}
	
}
</pre>

<p>
Test클래스의 메인 메소드에 아래 코드조각을 추가한다.<br />
</p>

<em class="filename">Test.java</em>
<pre class="prettyprint">
Drivable a = new Driver("슈마허","대리","ext:8","01거 5000");
System.out.println(a);
a.drive();
Drivable b = new Transportor();
// b.setCarNo("01거 7000"); // 컴파일 에러!
b.drive();
</pre>

상속에서 확인했던 "부모 타입의 레퍼런스에 자식 타입의 객체 참조값이 대입될 수 있다" 는 것과 같이 
인터페이스 타입의 변수에 인터페이스를 구현한 클래스의 객체 참조값이 대입될 수 있다.<br />



<span id="comments">주석</span>
<ol>
	<li>인스턴스 변수와 메소드를 일반적으로 멤버(member)라고 한다.</li>
	<li>override라는 영어 단어의 숨은 뜻에 주목해야 한다.
	ride는 올라탄다는 의미인데 여기에 over가 붙으면 완전히 올라타서 아래 것이 보이지 않게 된다는 뜻이 된다. 
	보이지는 않지만 아래에 있는 것이 없어지지 않기에 컴퓨터 용어 overwrite와는 의미가 전혀 다르다.</li>
	<li>자바에서 heap메모리는 객체가 생성되는 공간이다.</li>
	<li>생성자가 호출되기 전에 객체가 생성될 때 인스턴스 변수의 값은 숫자형은 0으로, 불린은 false로, 참조형 변수는 null로 초기화된다. 
	char로 엄밀하게는 숫자형으로 유니코드 테이블에서 0에 해당하는 문자로 초기화된다.</li>
	<li>print()와 println() 메소드는 java.io.PrintStream클래스의 메소드이다. 자바문서에서 확인해 보라.</li>
	<li>String클래스가 final클래스이다. 다시 말해 String클래스를 상속하여 자신만의 고유한 문자열 클래스를 만들 수 없다. 자바문서에서 확인해 보라.</li>
	<li>한가지 목적을 위한 여러 기능을 제공하기 위해 여러 요소들로 구성된 독립적 단위이다. 조건으로는 이식성이 좋아야 한다.<br /> 
	필요한 컴포넌트를 구입해서 마치 레고 블럭처럼 시스템을 구축할 수 있다면 좋지 않겠는가?<br />
	아마존과 같은 회사에서는 어떤 컴포넌트가 필요할까? 결제 컴포넌트, 창고관리 컴포넌트, 주문관리 컴포넌트, 회계 컴포넌트..<br />
	인터페이스는 컴포넌트간 통신을 위해 컴포넌트의 기능을 정의하는 것을 담당하게 된다.</li>
	<li>static이 붙으면 객체에 속한 것이 아니라는 의미로 이해하면 된다. 다음장에 static에 관해 공부할 것이다. 여기서는 static이 붙은 변수는 인스턴스 변수가 아니라는 점에 주목하면 된다.</li>
</ol>