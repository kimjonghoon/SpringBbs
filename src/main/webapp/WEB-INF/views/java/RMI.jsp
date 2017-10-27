<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.8.27</div>
	
<h1>RMI</h1>

지금까지 객체의 메서드 호출은 같은 JVM 환경의 객체와 객체 사이에서 이루어진 것이었다.<br />
그러면 다른 JVM 에서 동작하고 있는 객체의 메서드를 호출할 수 있을까?<br />
우리는 이미 소켓에 대해 알고 있다.<br />
소켓을 이용한다면 서버와 클라이언트가 사용하는 프로토콜을 개발해야 하지만
RMI를 이용한다면 프로토콜을 정해야 하는 수고 없이 다른 JVM에서 활동하고 있는 객체의 메서드를 호출할 수 있다.<br />
즉, 소켓을 이용하는 경우처럼 프로토콜에 맞게 메시지를 만들고, 메시지를 해석할 필요가 없어진다.<br />

<h2>RMI 프로그래밍 방법</h2>
<ol>
	<li>원격 인터페이스를 정의</li>
	<li>서버 구현</li>
	<li>클라이언트 구현</li>
	<li>자바 RMI 레지스트리 시작 , 서버 시작, 클라이언트 시작</li>
</ol>

<ul>
	<li>Hello.java - 원격 인터페이스</li>
	<li>Server.java - 원격 인터페이스를 구현한 원격 객체</li>
	<li>Client.java - 원격 인터페이스의 원격 메서드를 호출하는 클라이언트</li>
</ul>

<h3>1. 원격 인터페이스 정의 - Hello.java</h3>

원격 인터페이스에서는 클라이언트에서 원격으로 호출할 수 있는 메서드를 정의한다.<br />
원격 인터페이스는 java.rmi.Remote를 상속해야 한다.<br />
원격 인터페이스의 원격 메서드는 throws java.rmi.RemoteException을 선언해야 한다.<br />
RemoteException 이외에 다른 예외가 추가될 수 있다.<br />

<em class="filename">Hello.java</em>
<pre class="prettyprint">
package example.hello;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Hello extends Remote {
	String sayHello() throws RemoteException;
}
</pre>

<h3>2. 서버 구현 - Server.java</h3>

Server.java는 원격 인터페이스 Hello.java를 구현한다.<br />
원격 인터페이스의 sayHello()를 구현하는데 RemoteException 예외를 선언할 필요가 없다.<br />
왜냐하면 원격 객체의 sayHello()가 RemoteException 객체를 던지지 않기 때문이다.<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
package example.hello;

import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;

public class Server implements Hello {

	public Server(){}
	
	public String sayHello() {
		return "안녕하세요 홍길동입니다.";
	}
	
	public static void main(String[] args) {
		Server obj = new Server();
		try {
			Hello stub = (Hello) UnicastRemoteObject.exportObject(obj, 0);
			
			// Bind the remote object's stub in the registry
			Registry registry = LocateRegistry.getRegistry();
			registry.bind("Hello", stub);
			System.out.println("Server ready");
		} catch (Exception e) {
			System.out.println("Server exception: " + e.toString());
		}
	}

}
</pre>

서버의 메인 메서드는 서비스를 공급하는 원격 객체를 생성해야 한다.<br />
그리고 원격 객체는 자바 RMI 런타임으로 익스포트(export)되어야 한다. 
이 과정을 통해 서버에 해당하는 자바 RMI 런타임에 스텁이 만들어진다.<br />
이를 수행하는 코드는 아래와 같다.<br />
<br />
Server obj = new Server();<br />
Hello stub = (Hello) UnicastRemoteObject.exportObject(obj, 0);<br />
<br />
위 코드로 만들어진 서버 측 스텁을 클라이언트에서 찾을 수 있도록 자바 RMI 레지스트리에 등록한다.<br />
이를 수행하는 코드는 아래와 같다.<br />
<br />
Registry registry = LocateRegistry.getRegistry();<br />
registry.bind("Hello", stub);<br />
<br />
LocateRegistry의 getRegistry() 메서드가 인자 없이 호출된다면 디폴트 포트인 1099를 사용한다.<br />
따라서 1099 포트를 개방한 후 테스트한다.<br />

<h3>3. 클라이언트 구현</h3>
클라이언트는 서버 측에 등록된 스텁을 등록된 이름으로 찾아서 클라이언트 측 JVM에 다운로드한다.<br />
그 후 스텁의 sayHello() 메서드를 호출한다.<br />

<pre class="prettyprint">
package example.hello;

import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

public class Client {

	private Client() {}

	public static void main(String[] args) {
		String host = (args.length &lt; 1) ? null : args[0];
		
		try {
			Registry registry = LocateRegistry.getRegistry(host);
			Hello stub = (Hello) registry.lookup("Hello");
			String response = stub.sayHello();
			System.out.println("response: " + response);
		} catch (Exception e) {
			System.err.println("Client exception: " + e.toString());
			e.printStackTrace();
		}
	}
}
</pre>

<h2>4. 테스트</h2>

<h3>윈도</h3>
윈도 시스템에서 자바 클래스 파일 위치가 C:/java/rmi/bin이라면 
명령 프롬프트에서 C:/java/rmi/bin으로 이동한다.
C:/java/rmi/bin에서 start rmiregistry를 실행한다.<br />

<pre class="commandLine">
start rmiregistry

start java -classpath c:/java/rmi/bin ^
-Djava.rmi.server.codebase=file:c:/java/rmi/bin ^
example.hello.Server
</pre>

위에서 ^는 윈도 커맨드 명령어에서 줄바꿈 문자이다.<br />
새로운 명령 프롬프트를 띄우고 클라이언트를 실행한다.<br />
이때 디렉터리 위치는 상관없다.<br />

<pre class="commandLine">
java -classpath c:/java/rmi/bin example.hello.Client
</pre>

<h3>리눅스</h3>
리눅스 시스템에서의 자바 클래스 파일 위치가 /home/kim/java/rmi/bin이라면
터미널을 실행하고 /home/kim/java/rmi/bin으로 이동한다.<br />
/home/kim/java/rmi/bin에서 rmiregistry &amp;을 실행한다.<br />

<pre class="commandLine">
rmiregistry &amp;

java -classpath /home/kim/java/rmi/bin \
-Djava.rmi.server.codebase=file:/home/kim/java/rmi/bin \
example.hello.Server &amp;
</pre>

위에서 역슬래시는 리눅스 bash의 줄바꿈 문자이다.<br /> 
새로운 명령 프롬프트를 띄우고 아래처럼 클라이언트를 실행한다.<br />
이때 디렉터리는 어디든 상관없다.<br />

<pre class="commandLine">
java -classpath /home/kim/java/rmi/bin example.hello.Client
</pre>

<h3>컴퓨터가 2대 이상에서 테스트</h3>
서버 IP가 192.168.0.8이라면 클라이언트에서 아래처럼 실행한다.<br />

<pre class="commandLine">
java -classpath /home/kim/java/rmi/bin example.hello.Client 192.168.0.8
</pre>

위의 예는 윈도 시스템이 서버이고 리눅스 시스템이 클라이언트가 되는 경우이다.<br />
클라이언트 측에서는 Hello와 Client의 바이트 코드가 있어야 한다.<br />
서버 측에서는 Hello와 Server의 바이트 코드가 있어야 한다.<br />

<dl class="note">
<dt>테스트 실패시 체크 리스트</dt>
<dd>
1. 윈도 시스템에서 테스트가 실패할 경우 loopback adapter를 사용 중지한 후 시도한다.<br />
2. 윈도를 서버로 테스트할 때 실패했다면 1099(RMI 디폴트 포트) 포트를 개방한 후 시도한다.<br />
3. 리눅스를 서버로 테스트할 때 실패했고 공유기를 사용하는 경우라면<br />
/etc/hosts 파일에서 127.0.0.1을 모두 리눅스가 실제 할당받은 사설 IP로 변경한 후 테스트한다.<br />
이때 공유기 설정에서 서버가 고정된 사설 IP를 할당받도록 하는 것이 좋다.
</dd>
</dl>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html">http://docs.oracle.com/javase/7/docs/technotes/guides/rmi/hello/hello-world.html</a></li>
</ul>