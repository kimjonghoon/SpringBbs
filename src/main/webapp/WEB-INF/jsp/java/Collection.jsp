<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>    
<div id="last-modified">Last Modified : 2014.4.10</div>

<h1>컬렉션</h1>

Collection이란 같은 타입의 참조값을 여러개 저장하기 위한 자바 라이브러리이다.<br />
"배열과 비슷한데 훨씬 더 편리하다." 라는 정도로 접근하자.<br />
다음 그림은 Collection관련 주요 인터페이스의 계층관계를 보여 준다.<br />
<br />

<img src="https://lh3.googleusercontent.com/fQwp-98LN8SEeEa4_ujfMnO-MTGXUmO8jKZ458DnzCj6qKEwuntIt0Zw6dc9iT3xJEM3O8zGvk4e7W5RtcNB-cpCbX1e6McD5HXvmhmfWQYc6e8pZ0-XphhDShod7ygxfFcBDLwxdA-mkVNtE8X566C1N0n2tjx5LZZURt5tMb4p0HDZXbnYWFky6IAw-HpF7UG6WBh9f3ZUc6mxlD9AvT1GNIvldHDjWIBkV_YDVW2MDDBND8We8oqAjwPUM4JSQIHNDUb0s9ln90z89fyiJVrQVP3b-YXyVuVBd8T_t_mMCwz1Swj0454c5uynIASNCg-jMsMrG-x1aJAlCOv4qrvEaoqIhAE5Qd6U-AEhIEEit6MtNptXM8VrdqKYRJNy9-BAYnGOa4PdOpMrS1hoMiQPWRB0_Xbc-ofojNrF_V4FxZmB3hJfXm9iuF1lrC2R7rvX5Q_yP0xCdz6BveEZxXgctx2pH6apFj0JboQDtN0rXtjCf88pHx5VYpjVuIKHyZZyj8-4WlTGabMtRFfWeQ8RRll_yU6xX2BACOHFC8mtNev984bw8KRpEQg1-eNq4dALnNO7_pqNinq2wfn04r-0vwvCw14=w380-h242-no" alt="Collection Framework" /><br />

컬렉션 클래스를 선택할 때 다음을 고려하자.<a href="#comments"><sup>1</sup></a>

<ul>
	<li>Set - 중복을 허용하지 않고 순서도 가지지 않는다.</li>
	<li>List - 중복을 허용하고 순서를 가진다.</li>
	<li>Map - key 와 value의 형태로 저장한다.</li>
</ul>

다음은 자주 사용되는 컬렉션 클래스이다.<br />
자바 2이후의 6개의 클래스와 자바 2이전의 2개 클래스를 보여준다.
<table class="table-in-article">
<tr>
	<th class="table-in-article-th">인터페이스</th>
	<th class="table-in-article-th">구현 클래스(자바 2)</th>
	<th class="table-in-article-th">구현 클래스(자바 2이전)</th>
</tr>
<tr>
	<td class="table-in-article-td" rowspan="2">Set</td>
	<td class="table-in-article-td">HashSet</td>
	<td class="table-in-article-td" rowspan="2"></td>
</tr>
<tr>
	<td class="table-in-article-td">TreeSet</td>
</tr>
<tr>
	<td class="table-in-article-td" rowspan="2">List</td>
	<td class="table-in-article-td">ArrayList</td>
	<td class="table-in-article-td" rowspan="2">Vector</td>
</tr>
<tr>
	<td class="table-in-article-td">LinkedList</td>
</tr>
<tr>
	<td class="table-in-article-td" rowspan="2">Map</td>
	<td class="table-in-article-td">HashMap</td>
	<td class="table-in-article-td" rowspan="2">Properties</td>
</tr>
<tr>
	<td class="table-in-article-td">TreeMap</td>
</tr>
</table>

이들 컬렉션 클래스들을 아래에서 예제로 다룬다.<br />

<h2>컬렉션 클래스 예제</h2>

<h3>Set</h3>
예제는 Set인터페이스의 사용법을 보여 주고 있다.<br/>
HashSet을 생성하고 Set인터페이스의 add메소드를 사용하여 이름을 추가한다.<br/>
양효선은 중복 추가를 시도하고 있는데 Set은 중복을 허용하지 않으므로 추가되지 않는다.<br/>
System.out.println(set);로 확인할 수 있다.<a href="#comments"><sup>2</sup></a><br/>
System.out.println(set);다음에 기존의 Set을 TreeSet으로 처리한다.<br/>
TreeSet를 표준 출력 메소드로 출력해보면 리스트가 정렬되어 있는 것을 확인할 수 있다.<br />

<em class="filename">SetExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class SetExample {
	public static void main(String args[]) {
	  
		Set set = new HashSet();
		<strong>set.add("양효선");</strong>
		set.add("홍용표");
		set.add("황진호");
		set.add("김동진");
		set.add("전경수");
		<strong>set.add("양효선");</strong>
		    
		System.out.println(set);
		    
		Set sortedSet = new TreeSet(set);
		System.out.println(sortedSet);
	}
}
</pre>

다음은 제네릭을 사용하여 변경한 코드다.<br />

<em class="filename">SetExample.java - 제네릭을 사용</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class SetExample {
	public static void main(String args[]) {
	  
		Set<strong>&lt;String&gt;</strong> set = new HashSet<strong>&lt;String&gt;</strong>();
		set.add("양효선");
		set.add("홍용표");
		set.add("황진호");
		set.add("김동진");
		set.add("전경수");
		set.add("양효선");
		    
		System.out.println(set);
		    
		Set<strong>&lt;String&gt;</strong> sortedSet = new TreeSet<strong>&lt;String&gt;</strong>(set);
		System.out.println(sortedSet);
	}
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.SetExample
[홍용표, 김동진, 전경수, 양효선, 황진호]
[김동진, 양효선, 전경수, 홍용표, 황진호]

</pre>

예제에서 다룬 컬렉션 클래스를 자바 문서에서 찾아보면 클래스 선언부에 
&lt;E&gt;, &lt;T&gt;, &lt;K, V&gt;가 붙어있는 것을 볼 수 있다.
이런 인터페이스, 추상클래스, 클래스를 제네릭(Generic)이라 한다.<br />
제네릭은 JDK 1.5부터 추가되었다.<br />
&lt;E&gt;는 Element,  &lt;T&gt;는 Type, &lt;K, V&gt; 는 Key, Value 의미한다.<br />
이 기호를 이용하여 정해지지 않은 데이터 타입을 선언할 수 있다.<br />
정해지지 않는 데이터 타입은 제네릭으로부터 객체가 생성될 때 결정된다.<br /> 
다음 예는 계좌 클래스의 계좌 번호를 제네릭으로 만든 것이다.<br />

<pre class="prettyprint">
package net.java_school.collection;

public class Account<strong>&lt;T&gt;</strong> {
	
	private <strong>T</strong> accountNo;//accountNo는 어떤 타입도 될 수 있다.
	
	public <strong>T</strong> getAccountNo() {
		return accountNo;
	}

	public void setAccountNo(<strong>T</strong> accountNo) {
		this.accountNo = accountNo;
	}

	public static void main(String[] args) {
		Account<strong>&lt;String&gt;</strong> ac1 = null;
		ac1 = new Account<strong>&lt;String&gt;</strong>();//계좌번호 데이터 타입은 String으로 결정
		ac1.setAccountNo("111-222-333");//문자열만 가능
		
		Account<strong>&lt;Integer&gt;</strong> ac2 = null;
		ac2 = new Account<strong>&lt;Integer&gt;</strong>();//계좌번호 데이터 타입은 Integer로 결정
		ac2.setAccountNo(111222333);//Integer만 가능(아래 랩퍼클래스 참조)
	}

}
</pre>

<h3>List</h3>
List는 Collection인터페이스를 상속하며, 순서가 있고 중복을 허락한다.<br />
List는 배열과 같이 방마다 차례대로 0부터 시작하는 인덱스 번지가 주어진다.<br />
다음 예제는 가장 많이 사용되고 있는 ArrayList에 대한 예제이다.<br />

<em class="filename">ArrayListExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.ArrayList;

public class ArrayListExample {

	public static void main(String[] args) {
		ArrayList a = new ArrayList();
		
		a.add("장길산");
		a.add("홍길동");
		
		String hong = <strong>(String)</strong> a.get(1);//형변환 필요
		System.out.println(hong);
		
		//모든 요소를 출력하려면
		for (<strong>Object</strong> name : a) {//JDK 1.5부터 추가된 '확장 for문'
			System.out.print(name +"\t");
		}
	}

}
</pre>

다음은 제네릭 ArrayList&lt;E&gt;를 사용한 코드이다.<br />
제네릭을 사용하면 특정 데이터 타입의 참조값만 저장하게 되므로 값을 가져올 때 형변환이 필요없다는 사실에 주목해야 한다.<a href="#comments"><sup>3</sup></a>

<em class="filename">ArrayListExample.java - 제네릭을 사용</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.ArrayList;

public class ArrayListExample {

	public static void main(String[] args) {
		ArrayList<strong>&lt;String&gt;</strong> a = new ArrayList<strong>&lt;String&gt;</strong>();
		
		a.add("장길산");
		a.add("홍길동");
		
		String hong = <strong>a.get(1);</strong>//형변환이 필요없다.
		System.out.println(hong);
		
		//'확장for문'에서 name의 데이터타입을 String둘 수 있다.
		for (<strong>String</strong> name : a) {
			System.out.print(name +"\t");
		}
	}

}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.ArrayListExample
홍길동
장길산	홍길동
</pre>

아래 예제는 List의 구현체중에 ArrayList와 LinkedList의 사용법을 비교하여 보여주고 있다.<br />

<em class="filename">ListExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class ListExample {
	public static void main(String args[]) {
		List list = new ArrayList();
		    
		list.add("A");
		list.add("B");
		list.add("C");
		list.add("D");
		list.add("E");
		
		System.out.println(list);
		System.out.println("2: " + list.get(2));
		System.out.println("0: " + list.get(0));
		
		LinkedList linkedList = new LinkedList();
		
		linkedList.addFirst("A");
		linkedList.addFirst("B");
		linkedList.addFirst("C");
		linkedList.addFirst("D");
		linkedList.addFirst("E");
		    
		System.out.println(linkedList);
		linkedList.removeLast();
		linkedList.removeLast();
		    
		System.out.println(linkedList);
	    
	}
}
</pre>

다음은 제네릭을 사용하여 변경한 코드이다.<br />

<em class="filename">ListExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class ListExample {
	public static void main(String args[]) {
		List<strong>&lt;String&gt;</strong> list = new ArrayList<strong>&lt;String&gt;</strong>();
		    
		list.add("A");
		list.add("B");
		list.add("C");
		list.add("D");
		list.add("E");
		
		System.out.println(list);
		System.out.println("2: " + list.get(2));
		System.out.println("0: " + list.get(0));
		
		LinkedList<strong>&lt;String&gt;</strong> linkedList = new LinkedList<strong>&lt;String&gt;</strong>();
		
		linkedList.addFirst("A");
		linkedList.addFirst("B");
		linkedList.addFirst("C");
		linkedList.addFirst("D");
		linkedList.addFirst("E");
		    
		System.out.println(linkedList);
		linkedList.removeLast();
		linkedList.removeLast();
		    
		System.out.println(linkedList);
	    
	}
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.ListExample
[A, B, C, D, E]
2: C
0: A
[E, D, C, B, A]
[E, D, C]
</pre>

<h3>Map</h3>
Map은 키(key)와 값(value)의 쌍으로 데이터를 저장한다.<br />
다음 예제는 HashMap을 사용하고 있다.<br />
끝부분에서 HashMap을 TreeMap으로 처리한다.<br /> 
TreeMap은 데이터를 키값으로 정렬한다.<br />

<em class="filename">MapExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class MapExample {
	public static void main(String args[]) {
	
		Map map = new HashMap();
		
		map.put("1", "양효션");
		map.put("2", "홍용표");
		map.put("3", "황진호");
		map.put("4", "김동진");
		map.put("5", "전경수");
		
		System.out.println(map);
		System.out.println(<strong>(String)</strong> map.get("4"));//형변환 필요
		
		Map sortedMap = new TreeMap(map);
		System.out.println(sortedMap);
	
	}
}
</pre>

다음은 제네릭 HashMap&lt;K,V&gt;과 TreeMap&lt;K,V&gt;을 사용하여 변경한 코드이다.<br />

<em class="filename">MapExample.java - 제네릭 사용</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class MapExample {
	public static void main(String args[]) {
	
		Map<strong>&lt;String,String&gt;</strong> map = new HashMap<strong>&lt;String,String&gt;</strong>();
		
		map.put("1", "양효션");
		map.put("2", "홍용표");
		map.put("3", "황진호");
		map.put("4", "김동진");
		map.put("5", "전경수");
		
		System.out.println(map);
		System.out.println(map.get("4"));//형변환 필요없다!
		
		Map<strong>&lt;String,String&gt;</strong> sortedMap = new TreeMap<strong>&lt;String,String&gt;</strong>(map);
		System.out.println(sortedMap);
	
	}
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.MapExample
{3=황진호, 2=홍용표, 1=양효션, 5=전경수, 4=김동진}
김동진
{1=양효션, 2=홍용표, 3=황진호, 4=김동진, 5=전경수}
</pre>

예제를 아래와 같이 바꾸어 테스트한다.<br />
Integer는 int에 대응하는 랩퍼(Wrapper) 클래스이다.<br />
Integer타입의 키값을 주면 HashMap도 정렬이 된다는 것을 확인할 수 있다.<br />

<em class="filename">MapExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class MapExample {
	public static void main(String args[]) {
	
		Map<strong>&lt;Integer</strong>,String&gt; map = new HashMap<strong>&lt;Integer</strong>,String&gt;();
		
		map.put(1, "양효션");
		map.put(2, "홍용표");
		map.put(3, "황진호");
		map.put(4, "김동진");
		map.put(5, "전경수");
		
		System.out.println(map);
		System.out.println(map.get(4));
		
		Map<strong>&lt;Integer</strong>,String&gt; sortedMap = new TreeMap<strong>&lt;Integer</strong>,String&gt;(map);
		System.out.println(sortedMap);
	
	}
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.MapExample
{1=양효션, 2=홍용표, 3=황진호, 4=김동진, 5=전경수}
김동진
{1=양효션, 2=홍용표, 3=황진호, 4=김동진, 5=전경수}
</pre>


<h3>Vector</h3>
과거에 자주 쓰였던 Vector에 관한 예제다.<br /> 
현재는 Vector 대신에 ArrayList가 더 많이 사용되고 있다.<a href="#comments"><sup>4</sup></a><br />
 
<em class="filename">VectorExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class VectorExample {

	public static void main(String[] args) {
		Vector v = new Vector();
		    
		for (int i = 0; i &lt; 10; i++) {
			v.<strong>addElement</strong>(String.valueOf(Math.random() * 100));
		}
		    
		for (int i = 0; i &lt; 10; i++) {
			System.out.println(v.<strong>elementAt</strong>(i));//Object타입의 참조값을 반환
		}
	}
  
}
</pre>

다음은 제네릭 Vector&lt;E&gt;을 사용하여 변경한 코드이다.<br />

<em class="filename">VectorExample.java - 제네릭 사용</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class VectorExample {
	public static void main(String[] args) {
	
		Vector<strong>&lt;String&gt;</strong> v = new Vector<strong>&lt;String&gt;</strong>();
	
		for (int i = 0; i &lt; 10; i++) {
			v.addElement(String.valueOf(Math.random() * 100));
		}
		
		for (int i = 0; i &lt; 10; i++) {
			System.out.println(v.elementAt(i));//String타입의  참조값 반환
		}
	}
  
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.VectorExample
64.93767837163008
1.7024404924644077
56.445592597123806
23.41304656773643
92.55620070095163
41.6525553754475
47.39373268828609
83.84855063525016
67.34657837510855
41.04715452201211
</pre>

<h3>Properties</h3>
자바에서 설정 파일로부터 값을 읽을 때 많이 사용하는 클래스이다.<br />
키와 값의 쌍으로 데이터를 저장한다.<br />

<h4>PropertiesStore.java</h4>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;
import java.io.*;

public class PropertiesStore {
	public static void main(String[] args) {
	
		Properties prop = new Properties();
		prop.<strong>put</strong>("name", "장길산");
		prop.<strong>put</strong>("address", "황해도 구월산");
		
		try {
			prop.<strong>store</strong>(new FileOutputStream("test.properties"),"My Favorite Bandit");
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
	}
}
</pre>

<em class="filename">PropertiesLoad.java</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;
import java.io.*;

public class PropertiesLoad {
	public static void main(String[] args) {
	
		Properties prop = new Properties();
		try {
			prop.<strong>load</strong>(new FileInputStream("test.properties"));
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		System.out.println(prop.<strong>getProperty</strong>("name"));
		System.out.println(prop.<strong>getProperty</strong>("address"));
	}
}
</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.PropertiesStore

C:\java\Collection\bin&gt;java net.java_school.collection.PropertiesLoad
장길산
황해도 구월산

</pre>

PropertiesStore를 실행하면 파일시스템에 test.properties파일이 만들어진다.<a href="#comments"><sup>5</sup></a><br />
파일을 열어보면 다음과 같다.<br />

<em class="filename">test.properties</em>
<pre class="prettyprint">
#My Favorite Bandit
#Thu Apr 10 13:07:41 KST 2014
address=\uD669\uD574\uB3C4 \uAD6C\uC6D4\uC0B0
name=\uC7A5\uAE38\uC0B0
</pre>

예상과 달리 한글 부분이 이상한 문자로 되어 있다.<br />
자바 프러퍼티는 자바 프로그램에서 설정에 관련된 부분에 이용하기 위해 만들어 졌지만 비영어권을 위한 배려는 하지 않은 것 같다.<br />
한글은 프로퍼티 파일에서 자바에서 사용하는 <strong>유니 코드값</strong>으로 저장되어 있어야 한다.<br />
이것이 우리로서는 자바 프로퍼티의 단점이다.<br />

<h3>Enumeration 인터페이스</h3>
열거형 형태로 저장된 객체를 처음부터 끝까지 차례로 조회하는데 유용한 인터페이스이다.<br />
메소드는 다음 2개가 전부이다.<br />

<pre class="prettyprint">
hasMoreElements()
nextElement()
</pre>

아래 코드 조각은 Vector&lt;E&gt; v 의 모든 요소를 출력한다.<br />

<pre class="prettyprint">
for (Enumeration&lt;E&gt; e = v.elements(); e.hasMoreElements();) {
  System.out.println(e.nextElement());
}
</pre>

이 코드를 이용하여 우리의 벡터 예제를 수정하면 다음과 같다.<br />
성능으로만 보면 이 예제는 전 예제보다 떨어진다.<br />

<em class="filename">VectorExample.java - 제네릭, Enumeration 사용</em>
<pre class="prettyprint">
package net.java_school.collection;

import java.util.*;

public class VectorExample {
	public static void main(String[] args) {
	
		Vector<strong>&lt;String&gt;</strong> v = new Vector<strong>&lt;String&gt;</strong>();
	
		for (int i = 0; i &lt; 10; i++) {
			v.addElement(String.valueOf(Math.random() * 100));
		}
		
		for (Enumeration<strong>&lt;String&gt;</strong> e = v.<strong>elements()</strong>; e.<strong>hasMoreElements()</strong>;) {
			System.out.println(e.<strong>nextElement()</strong>);
		}
	}
  
}
</pre>

<h3>Iterator 인터페이스</h3>

Collection인터페이스의 iterator()메소드는 Iterator를 리턴한다.<a href="#comments"><sup>6</sup></a><br />
Iterator는 Enumeration인터페이스와 비슷하나 Enumeration보다 나중에 만들어졌다.<br />  
Enumeration보다 메소드명이 간단하며 Enumeration과는 달리 값을 삭제하는 메소드가 추가되어 있다.<br />

<pre class="prettyprint">
hasNext()
next()
remove()
</pre>

<h2>랩퍼(Wrapper) 클래스</h2>

컬렉션은 참조값만을 담을 수 있다.<br />
기본 자료형의 값은 컬렉션에 담을 수 없다.<br />
기본 자료형의 값을 컬렉션에 담기 위해선는 랩퍼 클래스 이용하는 것이 답일 수 있다.<br />
모든 기본 자료형에 대해서 그에 대응하는 랩퍼 클래스가 존재한다.<br />
기본 자료형의 값을 멤버 변수의 값으로 저장하고 이 값 주위로 값을 가공하는 메소드들이 감싸고 있다 해서 
랩퍼(Wrap:감싸다)클래스라고 불리는 것이다.<br /> 

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">기본 자료형</th>
	<th class="table-in-article-th">랩퍼 클래스</th>
</tr>
<tr>
	<td class="table-in-article-td">boolean</td>
	<td class="table-in-article-td">Boolean</td>
</tr>
<tr>
	<td class="table-in-article-td">byte</td>
	<td class="table-in-article-td">Byte</td>
</tr>
<tr>
	<td class="table-in-article-td">char</td>
	<td class="table-in-article-td">Character</td>
</tr>
<tr>
	<td class="table-in-article-td">short</td>
	<td class="table-in-article-td">Short</td>
</tr>
<tr>
	<td class="table-in-article-td">int</td>
	<td class="table-in-article-td">Integer</td>
</tr>
<tr>
	<td class="table-in-article-td">long</td>
	<td class="table-in-article-td">Long</td>
</tr>
<tr>
	<td class="table-in-article-td">float</td>
	<td class="table-in-article-td">Float</td>
</tr>
<tr>
	<td class="table-in-article-td">double</td>
	<td class="table-in-article-td">Double</td>
</tr>
</table>

<em class="filename">IntegerExample.java</em>
<pre class="prettyprint">
package net.java_school.collection;

public class IntegerExample {

	public static void main(String[] args) {
		<strong>Integer a = new Integer(2000000000);</strong>//20억
		int intValue = a.<strong>intValue();</strong>
		System.out.println(intValue);

		byte byteValue = a.<strong>byteValue();</strong>
		System.out.println(byteValue);
		
		short shortValue = a.<strong>shortValue();</strong>
		System.out.println(shortValue);
		
		long longValue = a.<strong>longValue();</strong>
		System.out.println(longValue);
		
		float floatValue = a.<strong>floatValue();</strong>
		System.out.println(floatValue);
		
		double doubleValue = a.<strong>doubleValue();</strong>
		System.out.println(doubleValue);
		
		String strValue = a.<strong>toString();</strong>
		System.out.println(strValue);

		System.out.println(<strong>Integer.MAX_VALUE</strong>);
		System.out.println(<strong>Integer.MIN_VALUE</strong>);
		System.out.println(<strong>Integer.parseInt("1004")</strong>);

		/* 
		* 아래 코드는 컴파일러에 의해 
		* Integer b = new Integer(200000000);로 바뀐다. 
		* 이를 오토박싱이라고 한다.
		* 형변환이 아니다. 기본 자료형이 참조형으로 바뀌는 그런 형변환은 없다.		  
		*/
		Integer b = 2000000000;
		
		/* 
		 * == 은 항상 값이 같은가를 묻는다. 
		 * 참조값이 올 때는 같은 객체인지를 판단한다.
		*/
		if (a == b) {
			System.out.println("a == b true");
		} else {
			System.out.println("a == b false");
		}
		
		/* 
		 * a와 b가 같은 int값을 가지고 있는지 판단하기 위해선 Integer의 equals()메소드를 사용한다.
		 * Integer의 equals메소드는 관리하는 int값이 같은지를 판단하도록 Object의 equals메소드를 오버라이딩했다.
		 <em>if (obj instanceof Integer) {
		    return value == ((Integer)obj).intValue();
		 }
		 return false;</em>  
		 */
		if (a.equals(b)) {
			System.out.println("a.equals(b) true");
		} else {
			System.out.println("a.equals(b) false");
		}
		
		
		/*
		 * a와 b가 가진 값을 다양하게 판단하기 위해선
		 * Integer의 compareTo()메소드를 이용한다. 
		 */
		int check = a.<strong>compareTo(b);</strong>
		System.out.println(check);
		if (check == 0) {
			System.out.println("a(int) == b(int)");
		} else if (check &lt; 0) {
			System.out.println("a(int) &lt; b(int)");
		} else {
			System.out.println("a(int) &gt; b(int)");
		}
		
		/*
		 * 오토박싱의 또다른 예제
		 * equals메소드의 인자값은 new Integer(c)의 참조값으로
		 * 컴파일 단계에서 변경된다.
		 */
		int c = 2000000000;
		if (a.<strong>equals(c)</strong>) {
			System.out.println("a.equals(c) true");
		} else {
			System.out.println("a.equals(c) false");
		}
		
		
		/*
		 * 오토언박싱
		 * a가 참조하는 Integer객체안에 있는 
		 * int값의 복사본이 객체 밖으로 나와 d에 대입
		 * 이 역시 컴파일 단계에서 
		 * int d = a.intValue();로 변경된다. 
		 */
		int d = a;
		System.out.println(d);
		
		
		/*
		* obj에는 1를 안에 내포하는 Integer객체의 참조값이 대입
		* 컴파일 단계에서 Object obj = new Integer(1);로 변경
		* Object타입의 레퍼런스로 Integer 고유의 메소드를 호출할 수 없다.
		* 호출하려면 형변환이 필요하다.
		*/
		Object obj = 1;
		System.out.println(obj);
		System.out.println((<strong>(Integer)obj</strong>).intValue());
		
	}

}

</pre>

<strong class="screen-header"><b>C:\</b> <spring:message code="command.prompt" /></strong>
<pre class="screen">
C:\java\Collection\bin&gt;java net.java_school.collection.IntegerExample
2000000000
0
-27648
2000000000
2.0E9
2.0E9
2000000000
2147483647
-2147483648
1004
a == b false
a.equals(b) true
0
a(int) == b(int)
a.equals(c) true
2000000000
1
1
</pre>

예제에서 보이는 오토박싱(AutoBoxing)과 오토언박싱(AutoUnboxing)은 개발의 편의성을 제공하기 위한 것이다.<br />
유리로 사면이 막힌 상자에 동전을 유리를 통과해서 상자에 넣고 또 상자안의 동전을 상자 밖으로 통과시키는 마술을 본 적이 있을 것이다.<br /> 
비유하면 상자 안에 동전을 넣는 것이 오토박싱, 상자 밖으로 동전을 꺼내는 것이 오토언박싱이다.<br />

<span id="comments">주석</span>
<ol>
	<li>컬렉션 클래스는 Set인터페이스를 구현했거나 List인터페이스를 구현했거나 Map인터페이스를 구현한 것으로 나눌 수 있다.</li>

	<li>HashSet의 toString()이 어떻게 오버라이딩하고 있는지 결과를 보면 확인할 수 있다.<br/>
	Set은 저장한 값이 순서가 없으므로 인덱스를 주고 값을 반환하는 메소드가 없다.<br/>
	저장한 값을 하나씩 가져올 수는 있는데 뒤에 학습할 Enumeration또는 Iterator인터페이스의 구현체를 반환하는 메소드를 이용해야 한다.
	</li>
	
	<li>JDK1.5이전에 컬렉션 클래스에서 값을 추가하는 메소드는 모두 매개변수 타입이 Object이다.<br/>
	모든 참조값을 저장할 수 있다고 하여 마치 자바의 강점처럼 설명되기도 했다.<br/>
	하지만 컬렉션을 사용할 때 다양한 참조값을 저장하는 경우가 많지 않을 뿐 아니라 값을 가져올 때 형변환을 해야 한다는 것이 악몽과 같다는 사실을 경험으로 깨닫고 
	JDK1.5부터 제네릭이 추가된 것이다.</li>

	<li>ArrayList와 Vector는 큰 차이가 있는데 ArrayList는 스레드 안전하지 않는데 반해 Vector는 스레드 안전하다.<br/>
	스레드 안전한 것과 안전하지 않는 것의 성능상 차이가 많으므로 스레드 안전한 것을 선택할 때는 그만한 이유가 반드시 필요하다.<br/>
	대부분의 경우 스레드 안전하지 않는 것을 선택하는 것이 옳다.<br />
	참고로 JDBC에서 다루게 되는 JDBC커넥션 풀링관련 코드는 스레드 안전한 Vector를 사용한다.</li>

	<li>이때 이클립스로 실행하는 경우와 콘솔에서 실행하는 경우 파일의 위치가 다르다.<br/>
	이클립스의 경우는 프로젝트 디렉토리에 생성된다.<br/>
	모호하다고 생각하면 위 코드에서 FileOutputStream과 FileInputStream의 생성자에 다음과 같이 파일 시스템의 전체 경로를 전달하면 된다.<br/>
	new FileOutputStream("C:/java/Collection/test.properties"), new FileInputStream("C:/java/Collection/test.properties")</li>
	
	<li>Set이나 List인터페이스를 구현한 모든 클래스에 iterator()메소드가 있어야 한다.<br/>
	왜냐하면 Set과 List인터페이스는 Collection인터페이스를 상속하기 때문이다.<br/>
	iterator()메소드가 Iterator타입을 리턴한다는 것에도 주목해야 하는데<br/>
	물론 Iterator가 인터페이스이기 때문에 실제 리턴되는 것은 Iterator를 구현한 구현 클래스로부터 생성된 객체일 것이다.<br/>
	하지만 우리는 그 구현체가 뭔지는 관심을 가지지 않아도 된다.<br/>
	그 구현체는 Iterator인터페이스를 구현하고 있다는 것으로 충분하기 때문이다.<br/>
	</li>      
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://java.sun.com/developer/onlineTraining/collections/Collection.html">http://java.sun.com/developer/onlineTraining/collections/Collection.html</a></li>
</ul>