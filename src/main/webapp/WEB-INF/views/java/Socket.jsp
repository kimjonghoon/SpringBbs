<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="last-modified">Last Modified : 2014.5.12</div>
	
<h1>소켓</h1>

소켓이란 TCP/IP를 이용하는 API를 말한다.<br />
1982년 BSD 유닉스에서 처음 소개되었다.<br />
소켓은 소프트웨어로 작성된 통신 접속점이라 이해하면 된다.<br />
자바에도 소켓이 있다.<br />
클라이언트와 서버에 소켓이 서로 연결이 되면 스트림을 이용하여 통신을 할 수 있게 된다.<br />
클라이언트 측에서 소켓을 목적지로 하는 출력 스트림을 통해 쓰면 서버 측에서는 자신의 소켓을 근원지로 하는 입력 스트림을 통해 클라이언트가 보낸 정보를 
받을 수 있게 된다.<br />
클라이언트 측과 서버 측의 소켓은 둘 다 java.net.Socket 클래스로 같다.<br />
그런데 이 소켓이 연결되려면 서버 측의 서버 소켓(ServerSocket)을 통해야 한다.<br />
서버 소켓은 서버에서 창구 역할을 하는 것으로 직접적인 통신에 간여하는 것이 아니라,
외부 소켓 연결 요청이 오면 그 소켓과 통신할 서버 측 소켓을 만들고 서로 연결한다.<br />


<em class="filename">Server.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
	public static void main(String[] args) throws IOException {
		ServerSocket serverSocket = new ServerSocket(3000);
		<strong>Socket socket = serverSocket.accept();</strong>
		//TODO
	}
}
</pre>

Socket socket = serverSocket.accept();에서 프로그램은 멈추고 외부의 소켓 접속 요청을 기다린다.<br />
소켓 접속 요청이 오면 클라이언트와 통신을 할 서버 측 소켓을 만들고 외부 소켓과 연결한 후 레퍼런스가 반환된다.<br />
실제로 접속이 이뤄지는 소켓의 포트는 남아있는 포트 번호 중 임의로 정해지게 된다.<br />
<br />
서버 측에서 클라이언트에 적당한 메시지를 보내는 코드를 작성해 보자.<br />
서버 측에서 생성된 소켓이 실제로 몇 번 포트를 사용하는지 클라이언트에게 알려주도록 할 것이다.<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
package net.java_school.socket;
<strong>
import java.io.BufferedWriter;</strong>
import java.io.IOException;
<strong>import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;</strong>
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
	public static void main(String[] args) throws IOException {
		ServerSocket serverSocket = new ServerSocket(3000);
		Socket socket = serverSocket.accept();
		<strong>OutputStream os = socket.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(os);
		BufferedWriter bw = new BufferedWriter(osw);
		PrintWriter pw = new PrintWriter(bw);
		pw.println("Socket Connected[" + socket.getPort() + "]");</strong>
	}
}
</pre>

클라이언트를 작성한다.<br />
클라이언트 측에서 소켓을 연결하기 위해서는 서버 IP뿐 아니라 서버 소켓의 포트 번호가 필요하다.<br />
컴퓨터가 하나라면 IP는 localhost로 대신할 수 있다.<br />
두 대 이상이면 아래 소스에서 localhost 부분을 서버가 동작하는 IP 주소로 대체한다.<br />
포트 번호는 서버 소켓이 3000번 포트를 이용하고 있으므로 3000을 입력한다.<br />

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {

	public static void main(String[] args) throws UnknownHostException, IOException {
		<strong>Socket socket = new Socket("localhost", 3000);</strong>
		//TODO
	}

}
</pre>

소켓이 연결되었다면 우리의 Server는 문자열을 클라이언트에 전달할 것이다.<br />
서버가 보낸 문자열을 읽기 위해서는 다음 코드를 추가한다.<br />

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

<strong>import java.io.BufferedWriter;</strong>
import java.io.IOException;
<strong>import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;</strong>
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {

	public static void main(String[] args) throws UnknownHostException, IOException {
		Socket socket = new Socket("localhost", 3000);
		<strong>OutputStream os = socket.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(os);
		BufferedWriter bw = new BufferedWriter(osw);
		PrintWriter pw = new PrintWriter(bw);
		pw.println("Socket Connected[Port:" + socket.getPort() + "]");
		pw.flush();</strong>
	}

}
</pre>

소켓을 연결하고 소켓이 몇 번 포트로 연결되었다는 메시지만 클라이언트에 전달하고 프로그램이 종료된다.<br />
클라이언트 측도 연결이 되었다는 메시지를 받는다. 메시지를 확인하기 위해 콘솔에 출력하고 프로그램이 종료된다.<br />
<br />
먼저 서버(Server)를 실행한 후에 클라이언트(Client)를 실행하여 테스트한다.<br />
같은 PC에서 실행시킬 때 명령 프롬프트를 각각 띄어서 테스트해야 한다.<br />
<br />
서버가 종료되지 않도록 예제를 수정할 것이다.<br />
현재 코드는 클라이언트의 접속 요청이 오면 메시지를 보낸 후 메인 메서드가 끝나서 서버 프로그램이 종료되므로 
다음 클라이언트의 접속 요청은 서비스할 수 없기 때문이다.<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
public static void main(String[] args) throws IOException {
	ServerSocket serverSocket = new ServerSocket(3000);
	<strong>while (true) {
		Socket socket = serverSocket.accept();
		OutputStream os = socket.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(os);
		BufferedWriter bw = new BufferedWriter(osw);
		PrintWriter pw = new PrintWriter(bw);
		pw.println("Socket Connected[Port:" + socket.getPort() + "]");
		pw.flush();
		pw.close();
		socket.close();
	}</strong>
}
</pre>

서버를 종료하려면 Ctrl + C를 동시에 눌러 강제 종료한다.<br />
예제를 좀 더 제대로 된 통신 프로그램으로 확장해 보자.<br />
코드에 많이 추가될 것이다.<br />
구현하려면 기능은 클라이언트에서 보낸 메시지를 서버가 그대로 다시 클라이언트에게 전송하는 것이다.<br />
서버(Server)부터 구현해 보자<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
package net.java_school.socket;

public class Server {
	//TODO
}
</pre>

서버 측에서는 두 가지 일을 동시에 해야 한다.<br />
외부에서 소켓 접속 연결 요청에 서비스해야 하고,
이미 접속한 클라이언트의 메시지를 받아서 다시 클라이언트로 보내는 일을 동시에 해야 한다.<br />
스레드가 필요한 것이다.<br />
클라이언트의 메시지를 받아서 다시 클라어언트로 그대로 보내는 코드가 새로운 스레드를 타도록 구현할 것이다.<br />
'클라이언트의 메시지를 받아서 다시 클라어언트로 그대로 보내는 코드'가 필요하다면
서버 측의 소켓을 근원지로 하는 입력 스트림과 서버 측의 소켓을 목적지로 하는 출력 스트림이 필요하다.<br />
소켓, 입력 스트림, 출력 스트림, 스레드의 묶음을 하나의 클래스로 만드는 것이 좋아 보인다.<br />
그 클래스의 이름을 Echo라고 짓겠다.<br />
Echo 클래스는 Server의 자원을 쉽게 접근할 수 있도록 서버의 내부 클래스를 만들겠다.<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
package net.java_school.socket;
<strong>
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
</strong>
public class Server {
	<strong>
	private class Echo extends Thread {
		private Socket socket;
		private BufferedReader br;
		private PrintWriter pw;
			
		public Echo(Socket socket) throws IOException {
			this.socket = socket;
			InputStream is = socket.getInputStream();
			br = new BufferedReader(new InputStreamReader(is));
			OutputStream os = socket.getOutputStream();
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
			pw = new PrintWriter(bw);
		}

		@Override
		public void run() {
			try {
				while (true) {
					String str = br.readLine();
					pw.println("From Server: " + str);
					pw.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
				close();
			}
		}
		
		private void close() {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			pw.close();
			
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}//Echo inner class end</strong>
	
     
}
</pre>

소켓 접속을 유지하기 위해서는 Echo 객체를 유지해야 한다.<br />
Echo 객체를 담을 ArrayList를 추가한다.<br />
Echo의 close() 메서드 마지막에 Echo 객체 참조 값을 ArrayList에서 제거하는 코드를 삽입한다.<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
<strong>import java.util.ArrayList;</strong>

public class Server {
	<strong>private ArrayList&lt;Echo&gt; echos = new ArrayList&lt;Echo&gt;();</strong>

	private class Echo extends Thread {
		private Socket socket;
		private BufferedReader br;
		private PrintWriter pw;
			
		public Echo(Socket socket) throws IOException {
			this.socket = socket;
			InputStream is = socket.getInputStream();
			br = new BufferedReader(new InputStreamReader(is));
			OutputStream os = socket.getOutputStream();
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
			pw = new PrintWriter(bw);
		}

		@Override
		public void run() {
			try {
				while (true) {
					String str = br.readLine();
					pw.println("From Server: " + str);
					pw.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
				close();
			}
		}
		
		private void close() {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			pw.close();
			
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

			<strong>echos.remove(this);</strong>
		}

	}//Echo inner class end

     
}
</pre>

외부 소켓 접속 요청에 서비스하는 코드를 작성한다.<br />
이 코드는 서버의 메서드에 구현할 것이다.<br />
메서드 내용은 무한 루프 안에 서버 소켓의 accept() 메서드를 둔다.<br />
메인 메서드에서 서버 객체 생성 후 이 메서드를 호출하도록 구현한다.<br />

<em class="filename">Server.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

public class Server {
	private ArrayList&lt;Echo&gt; echos = new ArrayList&lt;Echo&gt;();
	<strong>
	public void startServer() {
		ServerSocket serverSocket = null;
		
		try {
			serverSocket = new ServerSocket(3000);
			while (true) {
				Socket socket = serverSocket.accept();
				Echo echo = new Echo(socket);
				echo.start();
				echos.add(echo);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}</strong>
	
	private class Echo extends Thread {
		private Socket socket;
		private BufferedReader br;
		private PrintWriter pw;
			
		public Echo(Socket socket) throws IOException {
			this.socket = socket;
			InputStream is = socket.getInputStream();
			br = new BufferedReader(new InputStreamReader(is));
			OutputStream os = socket.getOutputStream();
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
			pw = new PrintWriter(bw);
		}

		@Override
		public void run() {
			try {
				while (true) {
					String str = br.readLine();
					pw.println("From Server: " + str);
					pw.flush();
				}
			} catch (Exception e) {
				e.printStackTrace();
				close();
			}
		}
		
		private void close() {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			pw.close();
			
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

			echos.remove(this);
		}

	}//Echo inner class end
	<strong>
	public static void main(String[] args) {
		new Server().startServer();
	}</strong>
		
}
</pre>

다음은 클라이언트를 작성한다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

public class Client {
	//TODO
}
</pre>

클라이언트 역시 스레드가 필요할까?<br />
사용자가 글을 쓰고 있는 동안에도 서버에서 메시지가 오는 경우에는 그렇다.<br />
같은 이유로 채팅 프로그램의 클라이언트는 반드시 스레드가 필요하다.<br />
하지만 에코는 클라이언트에서 서버로 메시지를 보내야 서버에서 메시지가 온다.<br />
이 경우 서버의 응답시간이 길지 않는다면 굳이 스레드를 사용할 필요가 없다.<br />
소켓 접속 연결을 하는 코드를 추가하는 것으로 클라이언트 구현을 시작한다.<br />

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		<strong>Socket socket = new Socket("localhost", 3000);</strong>
		//TODO
		
	}

}
</pre>

사용자가 키보드에 입력한 문자열을 읽어 오는 입력 스트림이 필요하다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		Socket socket = new Socket("localhost", 3000);

		<strong>BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));</strong>
		//TODO
	}

}
</pre>

서버로 문자열을 보내기 위해서는 소켓을 목적지로 하는 출력 스트림이 필요하다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		Socket socket = new Socket("localhost", 3000);

		BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));
		<strong>
		OutputStream os = socket.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(os);
		PrintWriter pw = new PrintWriter(osw);
		</strong>
		//TODO		
		
	}

}
</pre>

서버로부터 온 메시지를 읽기 위해서는 소켓을 근원지로 하는 입력 스트림이 필요하다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		Socket socket = new Socket("localhost", 3000);

		BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));

		OutputStream os = socket.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(os);
		PrintWriter pw = new PrintWriter(osw);
		<strong>
		InputStream is = socket.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);
		</strong>
		//TODO		
	}

}
</pre>

스레드가 메인 스레드 하나이므로 
사용자가 키보드에 입력하기를 기다리는 상태인지, 
아니면 서버로부터 문자열을 기다리는 상태인지를 저장할 플래그를 둔다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {
	
	public static void main(String[] args) throws UnknownHostException, IOException {
		Socket socket = new Socket("localhost", 3000);

		BufferedReader keyboard = new BufferedReader(new InputStreamReader(System.in));

		OutputStream os = socket.getOutputStream();
		OutputStreamWriter osw = new OutputStreamWriter(os);
		PrintWriter pw = new PrintWriter(osw);

		InputStream is = socket.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);
		<strong>
		boolean isCommandLineInputWaiting = true;
		String str = null;
		
		while (true) {
			if (isCommandLineInputWaiting) {
				str = keyboard.readLine();
				pw.println(str);
				pw.flush();
				isCommandLineInputWaiting = false;
				continue;
			}
			
			if (isCommandLineInputWaiting == false) {
				str = br.readLine();
				System.out.println(str);
				isCommandLineInputWaiting = true;
				continue;
			}
			
		}
		</strong>
	}

}
</pre>


<h3>2대 이상의 컴퓨터에서 테스트하기</h3>
이클립스에서 Server를 먼저 실행한다.<br />
명령 프롬프트를 열고 Client를 실행한다.<br />
서버와 클라이언트를 서로 다른 컴퓨터로 테스트한다면, Sever를 실행하는 서버 컴퓨터는 3000번 포트를 개방해야 한다.<br />
시스템이 윈도라면 Windows 방화벽에서 포트를 개방하는 조치가 필요하다.<br />
클라이언트에서는 Client.java 메인 메서드에서 "localhost"를 서버의 정확한 IP로 수정해야 한다.<br />


<h2>채팅</h2>
위 예제를 확장해서 간단한 채팅 프로그램을 만들어 보자.<br />
위 예제와 차이점은 에코와 달리 한 사용자가 서버로 전송한 메시지가 모든 사용자에게 전달된다는 것이다.<br />
이 차이점에 대해서만 구현하겠다.<br />
일반적인 채팅 프로그램처럼 채팅방을 만드는 기능을 구현하지 않는다.<br />
먼저 클라이언트를 구현한다.<br />

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

public class Client {
	//TODO
}
</pre>

사용자가 키보드에 입력하는 동안에도 서버로부터 메시지가 전달될 수 있으니 스레드를 사용해야 한다.


<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

public class Client <strong>extends Thread</strong> {
	<strong>
	@Override
	public void run() {
		//TODO
	}
	</strong>
}
</pre>

run() 메서드는 서버로부터 오는 메시지를 콘솔에 출력하는 코드를 둘 것이다.
소켓을 근원지로 하는 입력 스트림을 필요하다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;
<strong>
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.Socket;
</strong>
public class Client extends Thread {
	<strong>private Socket socket;
	private BufferedReader br;
	
	public Client() throws IOException {
		this.socket = new Socket("localhost", 3000);
		InputStream is = socket.getInputStream();
		br = new BufferedReader(new InputStreamReader(is));
		//TODO
	}
	</strong>
	@Override
	public void run() {
		//TODO
	}
	<strong>
	public static void main(String[] args) throws IOException {
		new Client();
	}
	</strong>
}
</pre>

이제는 run() 메서드를 구현한다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.Socket;

public class Client extends Thread {
	private Socket socket;
	private BufferedReader br;
	
	public Client() throws IOException {
		this.socket = new Socket("localhost", 3000);
		InputStream is = socket.getInputStream();
		br = new BufferedReader(new InputStreamReader(is));
		//TODO
	}
	
	@Override
	public void run() {
		<strong>String str = null;
		while(true) {
			try {
				str = br.readLine();
				System.out.println(str);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		</strong>
	}
	
	public static void main(String[] args) throws IOException {
		new Client();
	}
	
}
</pre>

메시지를 보내려면 키보드를 근원지로 하는 입력 스트림과 소켓을 목적지로 하는 출력 스트림이 필요하다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
<strong>import java.io.BufferedWriter;</strong>
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
<strong>import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;</strong>
import java.net.Socket;

public class Client extends Thread {
	private Socket socket;
	private BufferedReader br;
	private BufferedReader keyboard;
	private PrintWriter pw;
	
	public Client() throws IOException {
		this.socket = new Socket("localhost", 3000);
		InputStream is = socket.getInputStream();
		br = new BufferedReader(new InputStreamReader(is));
		<strong>keyboard = new BufferedReader(new InputStreamReader(System.in));
		OutputStream os = socket.getOutputStream();
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
		pw = new PrintWriter(bw);</strong>
	}
	
	@Override
	public void run() {
		String str = null;
		while(true) {
			try {
				str = br.readLine();
				System.out.println(str);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) throws IOException {
		new Client();
	}
	
}
</pre>

사용자가 키보드로부터 입력하는 것을 서버로 전송하는 코드를 구현한다.<br />
이 코드를 새로운 메서드 chatStart()에 구현한다.<br />

<em class="filename">Client.java</em>
<pre class="prettyprint">
package net.java_school.socket;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;

public class Client extends Thread {
	private Socket socket;
	private BufferedReader br;
	private BufferedReader keyboard;
	private PrintWriter pw;
	
	public Client() throws IOException {
		this.socket = new Socket("localhost", 3000);
		InputStream is = socket.getInputStream();
		br = new BufferedReader(new InputStreamReader(is));
		keyboard = new BufferedReader(new InputStreamReader(System.in));
		OutputStream os = socket.getOutputStream();
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
		pw = new PrintWriter(bw);
	}
	<strong>
	public void chatStart() {
		start();
		String str = null;
		while (true) {
			try {
				str = keyboard.readLine();
				pw.println(str);
				pw.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	</strong>
	@Override
	public void run() {
		String str = null;
		while(true) {
			try {
				str = br.readLine();
				System.out.println(str);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static void main(String[] args) throws IOException {
		<strong>new Client().chatStart();</strong>
	}
	
}
</pre>

서버를 구현한다.<br />
에코 예제에서 서버의 내부 클래스 Echo의 run() 메서드만 다음과 같이 수정한다.<br />
클라이언트가 강제 종료나 경우에 null이 서버로 전송되므로 전달된 문자열이 null이면 해당 Echo 객체의 자원을 반납한다.<br />
(채팅 프로그램이므로 Echo를 Chatter로 고치는 것이 낫겠다.)<br />

<pre class="prettyprint">
@Override
public void run() {
	try {
		String str = null;
		while (true) {
			str= br.readLine();
			if (str != null) {
				<strong>for (Echo echo : echos) {
					echo.pw.println(str);
					echo.pw.flush();</strong>
				}
			} else {
				throw new Exception("null!");
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
		close();
	}
}
</pre>

<h3>버그</h3>

서버를 강제 종료하면 모든 사용자는 무한 루프로 null 값이 찍히는 것을 보게 된다.<br />
클라이언트의 run() 메서드를 다음과 같이 수정한다.

<em class="filename">Client.java</em>
<pre class="prettyprint">
@Override
public void run() {
	String str = null;
	try {
		while((str = br.readLine()) != null) {
			System.out.println(str);
		}
	} catch (IOException e) {
		e.printStackTrace();
	}
}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://www.hanb.co.kr/book/look.html?isbn=89-7914-377-X">IT CookBook, 자바 5.0 프로그래밍: 차근차근 배우는 자바 AtoZ -한빛미디어</a></li>
	<li><a href="http://mastmanban.tistory.com/350">윈도우 7 방화벽에서 포트 열기</a></li>
</ul>