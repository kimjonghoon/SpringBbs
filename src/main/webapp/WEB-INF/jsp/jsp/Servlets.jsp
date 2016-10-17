<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div id="last-modified">Last Modified : 2014.7.28</div>

<h1>서블릿</h1>

<h2>서블릿이란?</h2>
게시판과 같은 프로그램을 만들기 위한 자바측 기술 중 하나이다.<br />
java.sql 팩키지를 JDBC 라고 부르는 것처럼, javax.servlet 과 javax.servlet.http 팩키지를 서블릿이라 부른다.<br />
<br />

서블릿은 네트워크 프로토콜과 무관하게 설계되었지만, 
대부분 HTTP 프로토콜을 사용하는, 웹환경에서 동적인 컨텐츠를 만들 때에 사용된다.<br />
참고로, JSP는 서블릿 이후에, 서블릿 기술을 기반으로 탄생했는데, 서블릿보다 동적인 웹 페이지 화면을 쉽게 만들 수 있다.<br />
<br />

서블릿을 학습할 때는 javax.servlet, javax.servlet.http 팩키지에서 서블릿의 기본골격을 먼저 공략하는 것이 현명한 학습방법이다.<br />

<h2>서블릿의 기본 골격</h2>
서블릿 기본골격은, 모든 서블릿이 구현해야 하는 javax.servlet.Servlet 인터페이스,
대부분의 모든 서블릿이 상속해야 하는 javax.servlet.GenericServlet 추상클래스,
HTTP 프로토콜을 사용하는 서블릿이 상속해야 하는 javax.servlet.http.HttpServlet 클래스로 구성된다.<br />
아래 그림<sup>1</sup>처럼 GenericServlet 은 프로그래머가 사용하기 편하도록 javax.servlet.ServletConfig 인터페이스를 구현하고 있다.<br />

<img src="https://lh3.googleusercontent.com/0kb0Odyc6_vK-yUuRo57EQY4lorUnVlMdqvOIMSAKfm5cz1e5rX1gwWQ06kkA8ef5tPgc37P7r9NC8eSFlWiFOUW7GrLUdisVwxJD2_qHd2tvtr25RXg-YIZTqOIQ51nXIbvH73XFaWmWDLOgcwNiSBcq1HBUlVmzI0qzJEfHEqAUSmczooaVspnF8AxDi0F7aiUc2poEBj7B3jDKKOX0pm6IMe2LRj06KjUaB7kKK7mxct9ca-dC65hYA93lm97tKBMxKgaO2oE-li5eZEu4CCs23Kdy5V3GDXCV72dRhIVEpDbuFp2R2mjxHS5OptF1r3Gt1R9LLAzg71cU771ZVGc6Wx3CGlfvGaJ1hpujAQ34hM07xY4GXR29KRcndoS8yHFQmVlqtdTX7KQ6ipUZveUW9JWk5pqe6SIfUFDKMqYguDAf1rRmPBeLCir3P6NAy5WXRNJlOlb3ydX8uJddtcAfAWZ4Xuf3jmmG0suogG6KU_IFj4vX3iBQQ94khdk3aKAPCpJWNmelPLIpiX5VNQvnkkOdSOVnGrEMwQNzc4-iUfhAEn_C_ff79yt8UY3tdsEOHEO-N44adcmH6DOfa1kZQkclo8=w495-h921-no" alt="Servlets Framework" /><br />


<h3>Servlet 인터페이스</h3>
javax.servlet.Servlet 인터페이스는 서블릿 아키텍처의 핵심이다.<br />
모든 서블릿은 Servlet 인터페이스를 구현해야 한다.<br />
이 인터페이스에는 서블릿의 라이프 사이클 메소드가 선언되어 있다.<br />

<ul>
	<li>init() : 서블릿 초기화</li>
	<li>service() : 클라이언트 요청에 대한 서비스</li>
	<li>destroy() : 서비스 중지, 자원반납</li>
</ul>

<h4>init() 메소드</h4>
서블릿 컨테이너는 서블릿 객체가 생성된 후, 단 한번 init() 메소드를 호출한다.<br />
서블릿은 init() 메소드가 완료되어야 서비스할 수 있다. init() 메소드 완료 전의 요청은 블록킹된다.<br />
init() 메소드가 호출될 때 ServletConfig 인터페이스 타입의 객체를 매개변수로 전달받는데, 
만약 web.xml 에서 서블릿 초기화 파라미터를 설정했다면, 전달받은 ServletConfig 에는 web.xml에서 설정했던 서블릿 초기화 파라미터 정보를 가지고 있게 된다.<br />
초기화 파라미터가 있다면 init() 메소드에 서블릿의 초기화 작업을 수행하는 코드가 있어야 할 것이다.<br />
 
<pre>
void init(ServletConfig config) throws ServletException;
</pre>

<h4>service() 메소드</h4>
클라이언트가 서블릿에 요청을 보낼때마다, 서블릿 컨테이너는 서블릿의 service() 메소드를 호출한다.<br />
전달받은 ServletRequest 타입의 객체를 통해서 요청정보와 클라이언트가 전달한 데이터를 읽을 수 있으며,
전달받은 ServletResponse 타입의 객체를 사용하여 클라이언트에게 응답할 수 있다.<br />
여기서 주목해야 할 점은, 서블릿 컨테이너는 새로운 쓰레드에서 service()메소드를 실행한다는 것이다.<br />
즉, 요청시마다 새로운 쓰레드에서 service() 메소드를 동시에 실행한다.<br />
가각의 스레드에서 동시에 실행되기에 수많은 클라이언트의 요청에 대해 지체없이 응답을 할 수 있지만,
서블릿에서 공유되는 자원(파일이나 네트워크 커넥션, static 변수, 인스턴스 변수)은 "자바기초의 스레드"에서 보았던 문제가 발생할 수 있다.<br />
문제가 발생하지 않도록 하려면, 서블릿에서 문제가 될 수 있는 static 이나 인스턴스 변수를 만들지 않는 것이 좋다.<br />
서블릿이 공유하는 자원을 모두 동기화하는 것은 대부분의 경우에 옳은 코딩이 아니다.<br />

<pre>
void service(ServletRequest req, ServletResponse res) 
	throws ServletException, IOException;
</pre>


<h4>destroy() 메소드</h4>
서블릿이 더이상 서비스를 하지 말아야 할 때 서블릿 컨테이너에 의해 호출된다.<br />
<!-- Called by the servlet container to indicate to a servlet that the servlet is being taken out of service. -->
이 메소드는 프로그래머가 호출하는게 아니다.<br />
따라서 destroy() 를 예제로 확인하려면 "톰캣 매니저"를 사용하여 애플리케이션을 언로드하거나 톰캣을 셧다운시켜야 한다.<br />
참고로 톰캣매니저는 http://localhost:port/manager로 접근할 수 있는 웹 애플리케이션으로 웹 애플리케이션을 관리할 용도로 제공된다.<br />
톰캣을 설치할 때 정해준 관리자와 관리자 비밀번호를 사용하여 로그인을 해야 화면을 볼 수 있다.<br />
관리자와 관리자 비밀번호가 생각나지 않으면 {톰캣홈}/conf/tomcat-users.xml 파일을 열어보면 알 수 있다.<br />  

<pre>
void destroy();
</pre>


<h3>GenericServlet 추상클래스</h3>
GenericServlet 클래스는 부모 클래스로 쓰인다.<br />
GenericServlet 클래스는 편의를 위해서 ServletConfig 인터페이스를 구현한다.<br />
GenericServlet 는 Servlet 인터페이스를 불완전하게 구현한다.<br />
Servlet 인터페이스의 service() 메소드를 구현하지 않았기 때문에, GenericServlet 의 service() 메소드는 abstract 가 붙어야 하고, 
그래서 GenericServlet 은 추상클래스이다.<br />
GenericServlet 를 상속하는 자식 클래스는 service() 메소드를 구현해야 한다.<br />

<pre>
public abstract void service(ServletRequest req, ServletResponse res) 
	throws ServletException, IOException;
</pre>

init(ServletConfig config) 메소드는 다음과 같이 GenericServlt 에 구현되었다.<br />

<pre>
public void init(ServletConfig config) throws ServletException {
	this.config = config;
	<strong>this.init();</strong>
}
</pre>

init(ServletConfig config) 구현부에 마지막에 매개변수가 없는 init() 메소드를 호출하고 있다.<br />
매개변수가 없는 init() 메소드는 편의를 위해 GenericServlet 에 추가되었다.<br />
자식 클래스에서 init(ServletConfig config) 메소드를 오버라이딩하는 것보다 이 메소드를 오버라이딩하는 것이 편리하다.<br />
왜냐하면 ServletConfig 객체를 저장해야 한다는 걱정을 하지 않아도 되기 때문이다.<br />
init(ServletConfig config) 메소드의 경우 자식 클래스에서 오버라이딩하려면 구현부에 super(config); 코드가 반드시 있어야 한다.<br />
이 코드가 없으면 서블릿이 ServletConfig 객체를 저장하지 못하게 된다.<br /> 
매개변수가 없는 init() 메소드는 다음과 같이 아무일도 하지 않는 것으로 구현되어 있다.<br />

<pre>
public void init() throws ServletException {

}
</pre>

Servlet 인터페이스의 getServletConfig() 메소드는, 
init(ServletConfig config) 메소드에서 전달받아서 인스턴스 변수 config 에 저장된 ServletConfig 객체를 반환하도록 구현되어 있다.<br />

<pre>
public ServletConfig getServletConfig() {
	return config;
}
</pre>

ServletConfig 인터페이스의 getServletContext() 메소드는 ServletContext 타입의 객체를 반환한다.

<pre>
public ServletContext getServletContext() {
	return getServletConfig().getServletContext();
}
</pre>

ServletConfig 인터페이스의 getInitParameter() 와 getInitParameterNames() 메소드는 
GenericServlet 에서 다음과 같이 구현되어 있다.<br />

<pre>
public String getInitParameter(String name) {
	return getServletConfig().getInitParameter(name);
}
</pre>

<pre>
public Enumeration getInitParameterNames() {
	return getServletConfig().getInitParameterNames();
}   
</pre>

편의를 위해서 GenericServlet이 ServletConfig를 구현했다는 말은 이런 것이다.<br />
서블릿에서 ServletContext에 대한 레퍼런스를 얻기 위해서 this.getServletConfig().getServletContext(); 란 코드도 되지만 
this.getServletContext(); 를 쓰는 것이 편리할 것이다.<br />
초기화 파라미터 정보를 얻기 위해서 String driver = this.getServletConfig().getInitParameter("driver"); 와 같이 쓰기 보다는 
String driver = this.getInitParameter("driver"); 쓰는 것이 편리할 것이다.<br />


<h3>HttpServlet 클래스</h3>
HTTP 요청을 서비스하는 서블릿을 작성하는 경우에는 HttpServlet을 상속한다.<br />
GenericServlet 추상 클래스를 상속하는 HttpServlet 클래스는 HTTP 프로토콜에 특화된 서블릿이다.<br />
HttpServlet 클래스는 HTTP 요청을 처리하는 메소드를 제공한다.<br />
클라이언트의 요청은 HttpServletRequest 객체 타입으로 서블릿에 전달되며, 서버는 HttpServletResponse 객체 타입으로 사용하여 응답한다.<br />
HttpServlet 클래스는 GenericServlet 의 service() 추상 메소드를 구현했는데 구현 내용은 단지 클라이언트의 요청을
protected void service(HttpServletRequest req, HttpServletResponse resp) 메소드에 전달하는 것이다.<br />


<pre class="prettyprint">
public void service(ServletRequest req, ServletResponse res) 
	throws ServletException, IOException {
	
	HttpServletRequest  request; 
	HttpServletResponse response;
	
	try {
		request = (HttpServletRequest) req;
		response = (HttpServletResponse) res;
	} catch (ClassCastException e) {
		throw new ServletException(&quot;non-HTTP request or response&quot;);
	}
	
	<strong>service(request, response);</strong>
}
</pre>

결국, 다음 메소드가 HTTP 요청을 처리한다.<br />

<pre class="prettyprint">
protected void service(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException {
	
	String method = req.getMethod();
	
	if (method.equals(METHOD_GET)) {
		long lastModified = getLastModified(req);
		if (lastModified == -1) {
			// servlet doesn't support if-modified-since, no reason
			// to go through further expensive logic
			<strong>doGet(req, resp);</strong>
		} else {
			long ifModifiedSince = req.getDateHeader(HEADER_IFMODSINCE);
			if (ifModifiedSince &lt; (lastModified / 1000 * 1000)) {
				// If the servlet mod time is later, call doGet()
				// Round down to the nearest second for a proper compare
				// A ifModifiedSince of -1 will always be less
				maybeSetLastModified(resp, lastModified);
				<strong>doGet(req, resp);</strong>
			} else {
				resp.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
			}
		}
	} else if (method.equals(METHOD_HEAD)) {
		long lastModified = getLastModified(req);
		maybeSetLastModified(resp, lastModified);
		doHead(req, resp);
	} else if (method.equals(METHOD_POST)) {
		<strong>doPost(req, resp);</strong>
	} else if (method.equals(METHOD_PUT)) {
		doPut(req, resp);
	} else if (method.equals(METHOD_DELETE)) {
		doDelete(req, resp);
	} else if (method.equals(METHOD_OPTIONS)) {
		doOptions(req,resp);
	} else if (method.equals(METHOD_TRACE)) {
		doTrace(req,resp);
	} else {
		//
		// Note that this means NO servlet supports whatever
		// method was requested, anywhere on this server.
		//
		
   		String errMsg = lStrings.getString("http.method_not_implemented");
   		Object[] errArgs = new Object[1];
   		errArgs[0] = method;
   		errMsg = MessageFormat.format(errMsg, errArgs);
   		
		resp.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED, errMsg);
	}
}
</pre>

HttpServlet 의 +service()는 단지 #service()메소드에게 제어권을 넘기는 역할만 한다.<br />
HttpServlet 클래스의 #service() 메소드가 호출되면 이 메소드는 요청객체(HttpServletRequest타입의 객체)안에서 
HTTP 메소드(대표적으로 POST, GET이 있다.)를 읽어내고 이 값에 따라 매칭되는 메소드를 호출한다.<br />
이를 테면 HTTP 메소드가 "GET"이면 doGet(), "POST"이면 doPost() 메소드를 호출한다.<br />
doGet(), doPost() 와 같은 메소드가 우리가 오버라이딩 해야 하는 메소드이다.<br />
<br />
HttpServletRequest 인터페이스는 ServletRequest 인터페이스를 상속하고,
HttpServletResponse 인터페이스는 ServletResponse 인터페이스를 상속한다.<br />
서블릿 컨테이너는 클라이언트의 요청이 오면 HttpServletRequest타입의 객체와 HttpServletResponse 타입의 객체를 만들어서 
서블릿의 +service(req:ServletRequest,res:ServletResponse)메소드를 호출하면서 전달한다.<br />
HttpServletRequest, HttpServletResponse 인터페이스를 구현한 클래스는 서블릿 컨테이너를 제작하는 벤더의 몫이다.<br />


<h2>서블릿 클래스, 인터페이스 요약</h2>
<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">Servlet 인터페이스</dt>
	<dd class="api-summary-dd">init (config:ServletConfig)</dd>
	<dd class="api-summary-dd">service(req:ServletRequest, res:ServletResponse)</dd>
	<dd class="api-summary-dd">destroy()</dd>
	<dd class="api-summary-dd">getServletConfig() : ServletConfig</dd>
	<dd class="api-summary-dd-method-desc">서블릿 초기화에 관련된 변수를 가지고 있는 ServletConfig 객체를 리턴</dd>
	<dd class="api-summary-dd">getServletInfo() : String</dd>
	<dd class="api-summary-dd-method-desc">서블릿에 대한 간단한 정보를 리턴</dd>
</dl>	

<dl class="api-summary">
	<dt class="api-summary-dt bottom-line">ServletConfig 인터페이스</dt>
	<dd class="api-summary-dd">getInitParameter(name:String) : String</dd>
	<dd class="api-summary-dd-method-desc">name에 해당하는 초기화 파라미터 값을 리턴</dd>
	<dd class="api-summary-dd">getInitParameterNames() : Enumeration</dd>
	<dd class="api-summary-dd-method-desc">서블릿의 초기화 파라미터 이름들을 Enumeration 타입으로 리턴</dd>
	<dd class="api-summary-dd">getServletContext() : ServletContext</dd>
	<dd class="api-summary-dd-method-desc">ServletContext 를 리턴</dd>
	<dd class="api-summary-dd">getServletName() : String</dd>
	<dd class="api-summary-dd-method-desc">서블릿 인스턴스의 이름 리턴</dd>
</dl>


<dl class="api-summary">
	<dt class="api-summary-dt">+GenericServlet 추상 클래스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">프로토콜에 무관한 기본적인 서비스를 제공하는 클래스로 Servlet, ServletConfig 인터페이스를 구현</dd>
	<dd class="api-summary-dd">+init()</dd>
	<dd class="api-summary-dd-method-desc">서블릿 초기화 메소드로, GenericServlet의 init(config:ServletConfig) 메소드의 의해 호출됨</dd>
	<dd class="api-summary-dd">&lt;&lt;abstract&gt;&gt; + service (req:ServletRequest, res:ServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">Servlet 인터페이스의 service() 메소드는 여전히 추상 메소드</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpServlet 추상 클래스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">GenericServlet 추상 클래스 상속</dd>
	<dd class="api-summary-dd">#doGet (req:HttpServletRequest, res:HttpServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">HTTP의 GET 요청을 처리하기 위한 메소드</dd>
	<dd class="api-summary-dd">#doPost (req:HttpServletRequest, res:HttpServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">HTTP의 POST 요청을 처리하기 위한 메소드</dd>
	<dd class="api-summary-dd">+service (req:ServletRequest, res:ServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">GenericServlet 추상클래스의 추상 메소드 service() 구현함. 구현내용은 아래 service() 메소드에 호출하는 것이 전부</dd>
	<dd class="api-summary-dd">#service (req:HttpServletRequest, res:HttpServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">클라이어트의 요청에 따라 doGet(), doPost() 메소드 호출</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">ServletContext 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">서블릿이 서블릿 컨테이너와 통신하기 위해서 사용하는 메소드 제공한다.
	파일의 MIME 타입, 파일의 전체경로, RequestDispatcher 레퍼런스를 얻거나 로그파일에 기록할 수 있다.
	ServletContext 객체는 웹 애플리케이션마다 하나씩 존재하며, 그래서 웹 애플리케이션 전체의 공동 저장소를 역할을 한다.
	ServletContext 에 저장된 데이터는 같은 웹 애플리케이션내의 서블릿이나 JSP 에서 자유롭게 접근할 수 있다.
	</dd>
	<dd class="api-summary-dd">setAttribute (name:Strng, value:Object)</dd>
	<dd class="api-summary-dd-method-desc">데이터를 이름과 값의 쌍으로 저장한다.</dd>
	<dd class="api-summary-dd">getAttribute (name:String) : Object</dd>
	<dd class="api-summary-dd-method-desc">이름을 이용해서 저장된 데이터를 리턴</dd>
	<dd class="api-summary-dd">removeAttribute(name:String)</dd>
	<dd class="api-summary-dd-method-desc">name에 해당하는 데이터를 삭제</dd>
	<dd class="api-summary-dd">getInitParameter(name:String) : String</dd>
	<dd class="api-summary-dd-method-desc">웹 애플리케이션 전영역에 대한 초기화 파라미터 이름에 해당하는 값 반환</dd>
	<dd class="api-summary-dd">getRequestDispatcher(path:String) : RequestDispatcher</dd>
	<dd class="api-summary-dd-method-desc">주어진 Path 를 위한 RequestDispatcher 를 리턴</dd>
	<dd class="api-summary-dd">getRealPath(path:String) : String</dd>
	<dd class="api-summary-dd-method-desc">주어진 가상 Path의 실제 Path를 리턴</dd>
	<dd class="api-summary-dd">getResource(path:String) : URL</dd>
	<dd class="api-summary-dd-method-desc">주어진 Path 에 해당되는 자원의 URL을 리턴</dd>
	<dd class="api-summary-dd">log(msg:String)</dd>
	<dd class="api-summary-dd-method-desc">로그에 기록</dd>
	<dd class="api-summary-dd">log(String message, Throwable throwable)</dd>
	<dd class="api-summary-dd-method-desc">로그에 기록</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">RequestDispatcher 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">클라이언트의 요청을 다른 자원(서블릿, JSP)으로 전달하거나 다른 자원의 내용을 응답에 포함하기 위해 사용한다.</dd>
	<dd class="api-summary-dd">forward(req:ServletRequest, res:ServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">클라이언트의 요청을 다른 자원으로 전달</dd>
	<dd class="api-summary-dd">include(req:ServletRequest, res:ServletResponse)</dd>
	<dd class="api-summary-dd-method-desc">다른 자원의 내용을 응답에 포함</dd>
</dl>


<dl class="api-summary">
	<dt class="api-summary-dt">ServletRequest 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">서블릿에 대한 클라이언트의 요청 정보을 담고 있음.</dd>
	<dd class="api-summary-dd">setAttribute(name:String,o:Object)</dd>
	<dd class="api-summary-dd-method-desc">객체를 주어진 이름으로 저장</dd>
	<dd class="api-summary-dd">getAttribute(name:String) : Object</dd>
	<dd class="api-summary-dd-method-desc">주어진 이름의 저장된 데이터를 리턴</dd>
	<dd class="api-summary-dd">removeAttribute(name:String)</dd>
	<dd class="api-summary-dd-method-desc">주어진 이름의 데이터를 삭제</dd>
	<dd class="api-summary-dd">getInputStream() : ServletInputStream</dd>
	<dd class="api-summary-dd-method-desc">클라이언트 요청의 바디에 있는 바이너리 테이터를 읽기 위한 입력 스트림 리턴</dd>
	<dd class="api-summary-dd">getParameter(name:String) : String</dd>
	<dd class="api-summary-dd-method-desc">클라이언트의 요청에 포함되어 있는 파라미터 이름에 해당하는 값 리턴</dd>
	<dd class="api-summary-dd">getParameterNames() : Enumeration</dd>
	<dd class="api-summary-dd-method-desc">클라이언트의 요청에 포함되어 있는 모든 파라미터 이름을 Enumeration 타입으로 리턴</dd>
	<dd class="api-summary-dd">getParameterValues(name:String) : String[]</dd>
	<dd class="api-summary-dd-method-desc">파라미터 name에 해당하는 모든 값을 String 배열로 리턴.<br />체크박스나 다중 선택 리스트와 같이 값이 여러 개 있을 때 이 메소드를 사용한다.</dd>
	<dd class="api-summary-dd">getServletPath() : String</dd>
	<dd class="api-summary-dd-method-desc">"/" 로 시작하는 경로를 리턴. 경로에 쿼리스트링은 포함되지 않음.</dd>
	<dd class="api-summary-dd">getRemoteAddr() : String</dd>
	<dd class="api-summary-dd-method-desc">클라이언트의 IP 주소를 리턴</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpServletRequest 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">ServletReqeust 상속</dd>
	<dd class="api-summary-dd">getCookies() : Cookie[]</dd>
	<dd class="api-summary-dd-method-desc">브라우저가 전달한 쿠키 배열을 리턴</dd>
	<dd class="api-summary-dd">getSession() : HttpSession</dd>
	<dd class="api-summary-dd-method-desc">현재 세션(HttpSession)을 리턴</dd>
	<dd class="api-summary-dd">getSession(created:boolean) : HttpSession</dd>
	<dd class="api-summary-dd-method-desc">현재 세션을 리턴, 만약 세션이 없는 경우 created 가 true 이면 세션을 생성후 리턴하고 created 가 false 면 null 리턴</dd>
	<dd class="api-summary-dd">getContextPath() : String</dd>
	<dd class="api-summary-dd-method-desc">요청 URI 에서 컨텍스트를 지시하는 부분을 리턴한다.<br />http://localhost:port/ContextPath/board/list.do?curPage=1를 요청하면 /ContextPath 를 리턴한다.</dd>
	<dd class="api-summary-dd">getRequestURI() : String</dd>
	<dd class="api-summary-dd-method-desc">http://localhost:port/ContextPath/board/list.do?curPage=1를 요청하면<br />/ContextPath/board/list.do 를 리턴한다.</dd>
	<dd class="api-summary-dd">getQueryString() : String</dd>
	<dd class="api-summary-dd-method-desc">http://localhost:port/ContextPath/board/list.do?curPage=1를 요청하면<br />curPage=1 를 리턴한다.</dd>
</dl>


<dl class="api-summary">
	<dt class="api-summary-dt">ServletResponse 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">클라이언트에 응답을 보내기 위해 사용</dd>
	<dd class="api-summary-dd">getOutputStream() : ServletOutputStream</dd>
	<dd class="api-summary-dd-method-desc">응답으로 바이너리 데이터를 전송하기 위한 출력 스트림 리턴</dd>
	<dd class="api-summary-dd">getWriter() : PrintWriter</dd>
	<dd class="api-summary-dd-method-desc">응답으로 문자 데이터를 전송하기 위한 출력 스트림 리턴</dd>
	<dd class="api-summary-dd">setContentType(type:String)</dd>
	<dd class="api-summary-dd-method-desc">응답 데이터의 MIME 타입을 설정.<br />
	HTML은 text/html, 일반 텍스트는 text/plain, 바이너리 데이터는 application/octet-stream 으로 설정<br />
	이 메소드는 getWriter() 메소드 전에 호출되어야 한다.</dd>
	<dd class="api-summary-dd">getContentType() : String</dd>
	<dd class="api-summary-dd-method-desc">setContentType()메소드에서 지정한 MIME 타입 리턴<br />
	만약 지정하지 않았다면 null 리턴</dd>
	<dd class="api-summary-dd">setCharacterEncoding(charset:String)</dd>
	<dd class="api-summary-dd-method-desc">응답 데이터의 캐릭터셋을 설정<br />
	UTF-8로 설정하려면 setCharacterEncoding("UTF-8");<br />
	이것은 setContentType("text/html; <strong>charset=UTF-8</strong>"); 에서의 캐릭터셋 설정과 동일하다.<br />
	getWrite()메소드가 실행되기 전에 호출되어야 한다.</dd>
	<dd class="api-summary-dd">getCharacterEncoding() : String</dd>
	<dd class="api-summary-dd-method-desc">설정된 응답 데이터의 캐릭터셋 리턴<br />
	캐릭터셋이 지정되지 않았다면 "ISO-8859-1" 을 리턴</dd>
	<dd class="api-summary-dd">setContentLength(length:int)</dd>
	<dd class="api-summary-dd-method-desc">응답 데이터의 크기를 int형 값으로 설정<br />
	이 메소드는 클라이언트측에서 서버로부터의 응답 데이터를 어느 정도 다운로딩하고 있는지 표시하는데 응용될 수 있다.</dd>				
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpServletResponse 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">ServletResponse 인터페이스를 상속, HTTP 응답을 클라이언트에 보내기 위해 사용</dd>
	<dd class="api-summary-dd">addCookie(cookie:Cookie)</dd>
	<dd class="api-summary-dd-method-desc">응답에 쿠키를 전송</dd>
	<dd class="api-summary-dd">sendRedirect(location:String)</dd>
	<dd class="api-summary-dd-method-desc">주어진 URL로 리다이렉트</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">HttpSession 인터페이스</dt>
	<dd class="api-summary-dd-class-desc bottom-line">세션유지에 필요한 사용자의 정보를 서버측에서 저장할 때 사용한다.</dd>
	<dd class="api-summary-dd">getAttribute(name:String) : Object</dd>
	<dd class="api-summary-dd">setAttribute(name:String, value:Object)</dd>
	<dd class="api-summary-dd">removeAttribute(name:String)</dd>
	<dd class="api-summary-dd">invalidate()</dd>
</dl>

<dl class="api-summary">
	<dt class="api-summary-dt">Cookie</dt>
	<dd class="api-summary-dd-class-desc bottom-line">서블릿에서 만들어져서 웹브라우저로 보내는 작은 정보로 브라우저에 저장된 후에 다시 서버로 보내어진다.
	이말은 세션 유지에 필요한 정보를 클라이언트측에서 저장한다는 것이다.
	쿠키는 name 과 name 에 대해 하나의 value 를 가지며 경로, 도메인, 유효기간, 보안에 대한 옵션값을 가지기도 한다.
	서블릿에서 쿠키를 만들면 쿠키에 대한 일정한 형식의 문자열이 응답헤더에 추가된다.
	쿠키가 포함된 응답을 받은 웹브라우저는 이후 쿠키 정보를 모든 요청시 같이 보내게 된다.
	서버 요소로 전달된 쿠키 정보는 HttpServletRequest.getCookie() 메소드를 이용하면 전송된 모든 쿠키의 배열을 얻을 수 있다.
	쿠키나 세션은 응답후 접속을 끊는 HTTP 프로토콜의 한계를 극복하기 위한 기술이다.   
	</dd>
	<dd class="api-summary-dd">+ Cookie(name:String, value:String)</dd>
	<dd class="api-summary-dd">+ getName() : String</dd>
	<dd class="api-summary-dd">+ getValue() : String</dd>
	<dd class="api-summary-dd">+ setValue(newValue:String)</dd>
	<dd class="api-summary-dd">+ getPath() : String</dd>
	<dd class="api-summary-dd">+ setPath(uri:String)</dd>
	<dd class="api-summary-dd">+ getDomain() : String</dd>
	<dd class="api-summary-dd">+ setDomain(pattern:String)</dd>
	<dd class="api-summary-dd">+ getMaxAge() : int</dd>
	<dd class="api-summary-dd">+ setMaxAge(expiry:int)</dd>
	<dd class="api-summary-dd">+ getSecure() : boolean</dd>
	<dd class="api-summary-dd">+ setSecure(flag:boolean)</dd>
</dl>


<h2>서블릿 예제</h2>
<strong>아래 나오는 모든 예제는 ROOT 애플리케이션에 작성한다.<br />
<a href="Web-Application-Directory-Structure">웹 애플리케이션 작성 실습</a>에서
도큐먼트베이스가 C:/www/myapp 인 애플리케이션을 ROOT 애플리케이션으로 변경했었다.<br />
JSP는 C:/www/myapp 아래에, 자바는 C:/www/myapp/WEB-INF/src 아래 자바 팩키지 이름의 서브디렉토리에 생성한다.<br /> 
이클립스를 사용하지 않고 에디트플러스와 같은 일반 에디터를 사용한다.</strong><br />

<em class="filename">SimpleServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SimpleServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req,resp);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
    	
		out.println("&lt;html&gt;");
		out.println("&lt;body&gt;");
    	
		//요청한 클라이언트의 IP를 출력
		out.println("당신의 IP 는 " + req.getRemoteAddr() + "입니다.\n");
		out.println("&lt;/body&gt;&lt;/html&gt;");
		out.close();
	}
  
}
</pre>

SimpleServlet은 서블릿 라이프 사이클 메소드 중 init()과 destroy()는 구현하지 않았다.<br /> 
이 메소드들은 GenericServlet 에서 이미 구현되어 있고, 또 특별히 오버라이딩할 이유가 없기 때문에 위의 소스에서 보이지 않는 것이다.<br />
/WEB-INF/web.xml 파일을 열고 web-app 엘리먼트의 자식 엘리먼트로 servlet 엘리먼트와 내용을 아래와 같이 추가한다.<br />

<em class="filename">web.xml</em>
<pre class="prettyprint">
/* .. 중간 생략 .. */

    &lt;servlet&gt;
      &lt;servlet-name&gt;SimpleServlet&lt;/servlet-name&gt;
      &lt;servlet-class&gt;example.SimpleServlet&lt;/servlet-class&gt;
    &lt;/servlet&gt;

    &lt;servlet-mapping&gt;
      &lt;servlet-name&gt;SimpleServlet&lt;/servlet-name&gt;
      &lt;url-pattern&gt;/simple&lt;/url-pattern&gt;
    &lt;/servlet-mapping&gt;

/* .. 중간 생략 .. */
</pre>

명령 프롬프트에서 SimpleServlet.java 가 있는 소스 폴더로 이동하여 아래와 같이 컴파일한다.

<pre>
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 7.0/lib/servlet-api.jar" ^
SimpleServlet.java<br />
</pre>

<dl class="note">
<dt>package javax.servlet.http does not exist</dt>
<dd>
SimpleServlet.java 를 컴파일할 때 위와 같은 컴파일 에러가 나온다는 것은 자바 컴파일러가 
javax.servlet.http 팩키지를 찾지 못한다는 의미로, javac 의 classpath 옵션의 값으로 
servlet-api.jar 파일의 전체경로를 잘못 적었기 때문이다.<br />
classpath 옵션값으로 주는 경로가 중간에 공백이 있다면 "" 으로 묶어주어야 한다.<br />
다른 방법으로는 CLASSPATH 란 환경변수에 servlet-api.jar 의 전체경로를 추가해주면 
아래와 같이 classpath 옵션을 사용하지 않고도 컴파일을 할 수 있다.<br />
javac -d C:/www/myapp/WEB-INF/classes SimpleServlet.java
(CLASSPATH 환경변수의 값은 반드시 현재 디렉토리를 나타내는 . 를 포함해야 한다.<br />
그래서 CLASSPATH를 설정하면 아래와 같다.<br />
<em class="path">.;C:\Program Files\Apache Software Foundation\Tomcat 7.0\lib\servlet-api.jar</em>
</dd>
</dl>

톰캣을 재시작한 후 http://localhost:8989<span class="emphasis">/simple</span>를 방문하여 테스트한다.<br />

<h3>SimpleServlet.java 소스설명</h3>

<pre class="prettyprint">
public class SimpleServlet extends HttpServlet {
</pre>

HttpServlet 클래스를 상속받은 서블릿은 public class으로 선언해야 한다.

<pre class="prettyprint">
@Override
public void doGet(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException {
	
   doPost(req,res);
}

@Override
public void doPost(HttpServletRequest req, HttpServletResponse resp) 
	throws ServletException, IOException {
	
   ..생략..
   
}
</pre>

doGet()과 doPost()메소드는 HttpServlet의 doGet()와 doPost()메소드를 오버라이드 한 메소드이다.<br />
모든 비즈니스 로직이 이 메소드에 존재한다.<br />
HTTP METHOD가 GET으로 요청해오면 doGet() 메소드를 오버라이딩한다.<br />
웹브라우저의 주소창에서 웹서버의 자원을 요청하는 것은 GET방식의 요청이다.<br />
예제에서는 doGet()메소드는 단순히 doPost()메소드를 호출하는 것으로 구현하여 GET이든 POST요청이든 같은 코드가 실행된다.<br />
doGet()과 doPost()메소드는 HttpServletRequest와 HttpServletResponse타입의 파라미터를 가진다.<br />
이 메소드는 예외가 발생할 수 있으므로 throws ServletException, IOExcepiton가 메소드 선언부에 추가되어 있다.<br />

<pre class="prettyprint">
resp.setContentType("text/html; charset=UTF-8");
PrintWriter out = resp.getWriter();
</pre>

resp.setContentType("text/html; charset=UTF-8");은 응답(HttpServletResponse)의 컨텐츠타입을 셋팅하는 작업을 한다.<br />
웹브라우저에 응답으로 출력될 문서의 MIME<sup>2</sup>타입을 설정하는 것이다.<br />
이 코드는 서블릿에서 단 한번만 사용이 가능하며 PrintWriter를 획득하기 전에 실행되야 한다.<br />
<strong>; charset=UTF-8</strong> 부분이 빠지면 한글이 깨진다.<br />
PrintWriter의 획득은 HttpServletResponse의 getWriter()을 호출함으로써 이루어진다.<br />
PrintWriter out = resp.getWriter();<br />
out 은 웹브라우저가 목적지인 문자 출력 스트림이다.<br />

<pre class="prettyprint">
out.println("&lt;html&gt;");
out.println("&lt;body&gt;");
//요청한 클라이언트의 IP를 출력
out.println("당신의 IP 는 " + req.getRemoteAddr() + "입니다.\n");
</pre>

PrintWrtier는 클라이언트로의 응답으로 보내는 스트림에 글을 쓸 수 있게 한다.<br />
PrintWriter의 plintln()메소드안에 문자열을 넣으면 클라이언트의 웹브라우저에 출력된다.<br />
위에서 보듯이 SimpleServlet는 클라이언트에게 HTML을 보내기 위해 PrintWriter의 println()메소드를 사용하고 있다.<br />
req.getRemoteAddr()은 클라이언트의 IP주소값을 반환하는 메소드이다.<br />
이와같이 HttpServeltRequest 는 클라이언트가 보내거나 클라이언트에 관한 정보를 담고 있다.<br />
<br />	

SimpleServlet 서블릿이 응답을 보내기까지 과정을 살펴보자.<br />
클라이언트가 웹브라우저를 이용해서 서버의 SimpleSerlvet을 요청한다.<br />
서블릿 컨테이너인 톰캣은 SimpleServlet의 +service(ServletRequest req, ServletResponse res) 메소드를 호출하면서 
클라이언트의 요청을 캡슐화한 객체(HttpSerlvetRequest 인터페이스 구현체)와 응답을 위한 객체(HttpSerlvetResponse 인터페이스 구현체)를 
메소드의 인자로 전달한다.<br />
+service(ServletRequest req, ServletResponse res) 메소드는 단지 #service(HttpServletRequest req,HttpServletResponse res) 
메소드를 호출하도록 구현되어 있다.<br /> 
#service(HttpServletRequest req,HttpServletResponse res) 메소드는 HTTP 메소드타입(GET,POST 등)에 따라 doGet() 또는 doPost()메소드를 호출한다.<br />
테스트에서는 웹브라우저의 주소창에서 서블릿 자원을 요청했기 때문에 GET 방식의 요청이다.<br />  
따라서 doGet() 메소드가 호출된다.<br />


<h2>사용자가 문자열 데이터를 서버측 자원으로 전송하는 방법과 이 데이터를 서버측 자원에서 수신하는 방법</h2>
웹 환경에서 동적인 요소라 하면 클라이언트가 보낸 문자열 데이터에 따라 응답을 하는 요소를 말한다.<br />
웹에서 동적인 요소를 만들어야 하는 웹 프로그래머는 클라이언트가 웹 브라우저를 통해서 문자열 데이터를 보내는 방법과 
그 데이터를 획득하는 방법을 알아야 한다.<br />
클라이언트 사이드에서 서버 사이드로 문자열 데이터를 전송하기 위해서는 주로 form 엘리먼트와 form의 서브 엘리먼트를 사용한다.<sup><a href="#comments">3</a></sup><br />
클라이언트가 서버로 전달하는 데이터는 form 엘리먼트의 action 속성의 값으로 지정된 자원으로 전달된다.<br />

<h3>파라미터 전송 방법과 전송된 파라미터의 값 얻기</h3>
아래 표에서 폼 작성은 사용자로부터 값을 받기 위한 form 양식을 출력하기 위한 HTML 태그를 보여주고 있다.<br />
표에서 서블릿은 form 양식에서 입력받은 파라미터 값을 서블릿에서 가져오기 위한 코드 조각이다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">폼 작성</th>
	<th class="table-in-article-th">서블릿</th>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;input type="text" name="<strong>addr</strong>" /&gt;</td>
	<td>req.getParameter("<strong>addr</strong>");</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;input type="radio" name="<strong>os</strong>" value="Windows" /&gt;<br />
	&lt;input type="radio" name="<strong>os</strong>" value="Linux" /&gt;				
	</td>
	<td>req.getParameter("<strong>os</strong>");</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;input type="hidden" name="<strong>curPage</strong>" value="1" /&gt;</td>
	<td>req.getParameter("<strong>curPage</strong>");</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;input type="password" name="<strong>passwd</strong>" /&gt;
	</td>
	<td class="table-in-article-td">req.getParamter("<strong>passwd</strong>");</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;textarea name="<strong>content</strong>" cols="60" rows="12"&gt;<br />&lt;/textarea&gt;</td>
	<td>req.getParamter("<strong>content</strong>");</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;select name="<strong>grade</strong>"&gt;<br />
	&nbsp;&nbsp;&lt;option value="A"&gt;A&lt;/option&gt;<br />
	&nbsp;&nbsp;&lt;option value="B"&gt;B&lt;/option&gt;<br />
	&nbsp;&nbsp;&lt;option value="C"&gt;C&lt;/option&gt;<br />
	&nbsp;&nbsp;&lt;option value="D"&gt;D&lt;/option&gt;<br />
	&nbsp;&nbsp;&lt;option value="F"&gt;F&lt;/option&gt;<br />
	&lt;/select&gt;
	</td>
	<td class="table-in-article-td">
	req.getParameter("<strong>grade</strong>");
	</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;input type="checkbox" name="<strong>hw</strong>" value="Intel" /&gt;<br />
	&lt;input type="checkbox" name="<strong>hw</strong>" value="AMD" /&gt;<br />
	</td>
	<td class="table-in-article-td">req.getParameterValues("<strong>hw</strong>");</td>
</tr>
<tr>
	<td class="table-in-article-td">
	&lt;select name="<strong>sports</strong>" <strong>multiple="multiple"</strong>&gt;<br />
		&lt;option value="soccer"&gt;축구&lt;/option&gt;<br />
		&lt;option value="basketball"&gt;농구&lt;/option&gt;<br />
		&lt;option value="baseball"&gt;야구&lt;/option&gt;<br />
	&lt;/select&gt;
	</td>
	<td class="table-in-article-td">
	req.getParameterValues("<strong>sports</strong>");<br />
	</td>
</tr>
</table>

<h4>getParameter(String name)</h4>
ServletRequest 의 getParameter(String name) 메소드는 사용자가 보낸 데이터를 얻기 위해 사용하는 가장 보편적인 메소드이다.<br />
전달되는 데이터는 파라미터 이름과 값의 쌍으로 서버 요소에 전달된다.<br />
|name|value| 이때 파라미터의 이름은 form 의 서브 엘리먼트(input, textarea, select)의 name 속성값과 같고 value 는 사용자가 입력한 값이다.<br /> 
getParameter(String name) 인자값으로 파라미터명(input, textarea, select 엘리먼트의 name 속성값)을 전달하면 사용자가 입력하거나 선택한 값을 얻을 수 있다.<br /> 
<br />
input 엘리먼트의 type 속성값이 radio(라디오 버튼)인 의 경우, name 속성값이 같은 라디오 버튼들은 그룹을 형성한다.<br />
그룹내의 라디오 버튼은 그 중 하나만 선택된다.<br />

<h4>getParameterValues(String name)</h4>
클라이언트 사이드에서 하나의 파라미터명에 여러 개의 값이 전송할 때 서블릿에서 
이 데이터를 수신하려면 HttpServletRequest 의 getParamterValues(String name) 메소드를 사용한다.<br />
이 메소드의 리턴 타입은 사용자가 선택한 값들만으로 구성된 String 배열이다.<br />
<br />
클라이언트 사이드에서 하나의 파라미터에 값을 여러개 보내려면 체크박스나 multiple 속성값이 
"multiple" 인 select 엘리먼트가 사용된다.<br />
체크박스는 input 엘리먼트의 type 속성값이 checkbox 인 것을 말한다.<br />
체크박스는 라디오 버튼과 마찬가지로 name 속성값을 같게 하면 그룹화되는데 라디오 버튼과 다른 점은 그룹내에서 선택을 다중으로 할 수 있다는 것이다.<br />

select 엘리먼트는 일반적으로 값을 하나만 선택할 수 있지만 
multiple 속성값이 "multiple" 인 select 엘리먼트는 Ctrl 이나 Shift 버튼을 이용해서 값을 여러개 선택할 수 있다.<br />

<h4>getParamterNames()</h4>
클라이언트 사이드에서 전송되는 데이터가 어떤 파라미터에 담겨 오는지 알 수 있는 메소드가 HttpServletRequest 의 getParamterNames() 메소드이다.<br /> 
getParameterNames() 메소드는 파라미터 이름을 접근할 수 있는 Enumeration<sup><a href="#comments">4</a></sup> 타입을 반환한다.<br />

<dl class="note">
<dt>input type="file" 은 파일 업로드에 쓰인다.</dt>
<dd>
type 속성값이 file 인 input 엘리먼트는 이미지와 같은 바이너리 데이터를 서버 사이드로 전송할 때 쓰인다.
이때 form 엘리먼트의 method 속성값은 post 이고 동시에 enctype 속성(속성값이 "multipart/form-data")이 반드시 있어야 한다.<br />
<em>&lt;form action="서버요소" method="post" enctype="multipart/form-data"&gt;</em><br />
업로드하는 파일뿐만 아니라 다른 부가 정보(예를 들면 이름,제목,내용 등등)을 전송해야 한다면 
이들 엘리먼트 역시 input type="file" 이 있는 form 안에 같이 위치시키면 된다.
submit 버튼을 누르면 이제까지와는 다른 전송 규약에 의해 서버 요소로 전송된다.
따라서 서버 요소에서는 getParameter() 메소드를 사용하여 데이터에 접근할 수 없다.
서블릿 JSP API를 가지고 바이너리 데이터를 수신하는 방법을 서블릿에 구현할 수 있겠지만 대부분의 경우 외부 라이브러리를 있고 이용한다.
이에 대한 예제는 곧 다룬다.
</dd>
</dl>

<h3>문자열 전송 예제</h3>
회원가입 예제를 통해 사용자가 보낸 데이터를 서블릿에서 수신하는 방법을 실습한다.<br />
이 예제의 목적은 사용자가 보낸 데이터를 확인하는 것이다.<br />
회원가입 양식(form)을 보여주는 HTML 파일을 작성한다.<br />

<em class="filename">/example/join.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta charset="UTF-8"&gt;
&lt;title&gt;회원가입 폼&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h3&gt;회원가입&lt;/h3&gt;
&lt;form id="joinForm" action="../RegisterServlet" method="post"&gt;
아이디 &lt;input type="text" name="id" /&gt;&lt;br /&gt;
별명 &lt;input type="text" name="nickname" /&gt;&lt;br /&gt;
비밀번호 &lt;input type="password" name="passwd" /&gt;&lt;br /&gt;
이름 &lt;input type="text" name="name" /&gt;&lt;br /&gt;
&lt;br /&gt;
성별&lt;br /&gt;
남 &lt;input type="radio" name="gender" value="M" /&gt; 
여 &lt;input type="radio" name="gender" value="F" /&gt;&lt;br /&gt;

&lt;br /&gt;
생년월일 &lt;input type="text" name="birthyear" style="width: 30px" /&gt; 년
 
&lt;select name="birthmon"&gt;
   &lt;option value="0" selected="selected"&gt;-월-&lt;/option&gt;
   &lt;option value="1"&gt;1&lt;/option&gt;
   &lt;option value="2"&gt;2&lt;/option&gt;
   &lt;option value="3"&gt;3&lt;/option&gt;
   &lt;option value="4"&gt;4&lt;/option&gt;
   &lt;option value="5"&gt;5&lt;/option&gt;
   &lt;option value="6"&gt;6&lt;/option&gt;
   &lt;option value="7"&gt;7&lt;/option&gt;
   &lt;option value="8"&gt;8&lt;/option&gt;
   &lt;option value="9"&gt;9&lt;/option&gt;
   &lt;option value="10"&gt;10&lt;/option&gt;
   &lt;option value="11"&gt;11&lt;/option&gt;
   &lt;option value="12"&gt;12&lt;/option&gt;
&lt;/select&gt;
월

&lt;select name="birthday"&gt;
   &lt;option value="0" selected="selected"&gt;-일-&lt;/option&gt;
   &lt;option value="1"&gt;1&lt;/option&gt;
   &lt;option value="2"&gt;2&lt;/option&gt;
   &lt;option value="3"&gt;3&lt;/option&gt;
   &lt;option value="4"&gt;4&lt;/option&gt;
   &lt;option value="5"&gt;5&lt;/option&gt;
   &lt;option value="6"&gt;6&lt;/option&gt;
   &lt;option value="7"&gt;7&lt;/option&gt;
   &lt;option value="8"&gt;8&lt;/option&gt;
   &lt;option value="9"&gt;9&lt;/option&gt;
   &lt;option value="10"&gt;10&lt;/option&gt;
   &lt;option value="11"&gt;11&lt;/option&gt;
   &lt;option value="12"&gt;12&lt;/option&gt;
   &lt;option value="13"&gt;13&lt;/option&gt;
   &lt;option value="14"&gt;14&lt;/option&gt;
   &lt;option value="15"&gt;15&lt;/option&gt;
   &lt;option value="16"&gt;16&lt;/option&gt;
   &lt;option value="17"&gt;17&lt;/option&gt;
   &lt;option value="18"&gt;18&lt;/option&gt;
   &lt;option value="19"&gt;19&lt;/option&gt;
   &lt;option value="20"&gt;20&lt;/option&gt;
   &lt;option value="21"&gt;21&lt;/option&gt;
   &lt;option value="22"&gt;22&lt;/option&gt;
   &lt;option value="23"&gt;23&lt;/option&gt;
   &lt;option value="24"&gt;24&lt;/option&gt;
   &lt;option value="25"&gt;25&lt;/option&gt;
   &lt;option value="26"&gt;26&lt;/option&gt;
   &lt;option value="27"&gt;27&lt;/option&gt;
   &lt;option value="28"&gt;28&lt;/option&gt;
   &lt;option value="29"&gt;29&lt;/option&gt;
   &lt;option value="30"&gt;30&lt;/option&gt;
   &lt;option value="31"&gt;31&lt;/option&gt;		
&lt;/select&gt;
일
&lt;br /&gt;

양력 &lt;input type="radio" name="solar" value="Y" checked="checked" /&gt;
음력 &lt;input type="radio" name="solar" value="N" /&gt;&lt;br /&gt;
&lt;br /&gt;

휴대전화 &lt;input type="text" name="mobile" /&gt;&lt;br /&gt;
일반전화 &lt;input type="text" name="tel" /&gt;&lt;br /&gt;
&lt;br /&gt;

주소&lt;br /&gt;
&lt;input type="text" name="zipcode1" style="width: 30px" /&gt; -
&lt;input type="text" name="zipcode2" style="width: 30px" /&gt;&lt;br /&gt;
&lt;input type="text" name="add" style="width: 300px" /&gt;&lt;br /&gt;
&lt;br /&gt;
이메일 &lt;input type="text" name="email" /&gt;&lt;br /&gt;
이메일수신여부&lt;br /&gt;
수신 &lt;input type="radio" name="emailyn" value="Y" checked="checked" /&gt;
수신안함 &lt;input type="radio" name="emailyn" value="N" /&gt;&lt;br /&gt;
&lt;br /&gt;
좋아하는 운동&lt;br /&gt;
&lt;input type="checkbox" name="sports" value="soccer" /&gt;축구&lt;br /&gt;
&lt;input type="checkbox" name="sports" value="baseball" /&gt;야구&lt;br /&gt;
&lt;input type="checkbox" name="sports" value="basketball" /&gt;농구&lt;br /&gt;
&lt;input type="checkbox" name="sports" value="tennis" /&gt;테니스&lt;br /&gt;
&lt;input type="checkbox" name="sports" value="tabletennis" /&gt;탁구&lt;br /&gt;
&lt;br /&gt;
복수선택&lt;br /&gt;
&lt;select name="focus" multiple="multiple"&gt;
	&lt;option value=""&gt;-- 복수선택 --&lt;/option&gt;
	&lt;option value="java"&gt;JAVA&lt;/option&gt;
	&lt;option value="jdbc"&gt;JDBC&lt;/option&gt;
	&lt;option value="jsp"&gt;JSP&lt;/option&gt;
	&lt;option value="css-layout"&gt;CSS Layout&lt;/option&gt;
	&lt;option value="jsp-prj"&gt;JSP 프로젝트&lt;/option&gt;
	&lt;option value="spring"&gt;Spring&lt;/option&gt;
	&lt;option value="javascript"&gt;자바스크립트&lt;/option&gt;
&lt;/select&gt;
&lt;br /&gt;
&lt;br /&gt;
자기소개&lt;br /&gt;
&lt;textarea name="aboutMe" cols="40" rows="7"&gt;&lt;/textarea&gt;&lt;br /&gt;
&lt;input type="submit" value="전송" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<h4>RegisterServlet 서블릿 작성 : 회원 등록처리</h4>
데이터를 처리하는 서블릿을 아래와 같이 작성한다.

<em class="filename">RegisterServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegisterServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws IOException,ServletException {
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		
		out.println("&lt;html&gt;&lt;body&gt;");
		out.println("id : " + id);
		
		String[] sports = req.getParameterValues("sports");
		int len = sports.length;
		
		out.println("&lt;ol&gt;");
		for (int i = 0; i &lt; len; i++) {
			out.println("&lt;li&gt;" + sports[i] + "&lt;/li&gt;");
		}
		
		out.println("&lt;/ol&gt;");
		
		String path = req.getContextPath();
		out.println("&lt;a href=" + path + "/example/join.html&gt;Join&lt;/a&gt;");
		out.println("&lt;/body&gt;&lt;/html&gt;");
	}
}
</pre>

명령 프롬프트를 열고 위 소스코드가 있는 /WEB-INF/src/exampe 로 이동하여 아래와 같이 컴파일한다.<br />

<pre>
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 7.0/lib/servlet-api.jar" ^
RegisterServlet.java<br />
</pre>

다음으로 web.xml 파일을 열고 아래를 추가한다.<br />
 
<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;			
    &lt;servlet-name&gt;RegisterServlet&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.RegisterServlet&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;RegisterServlet&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/RegisterServlet&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

톰캣을 재시작 한 후 http://localhost:8989/<span class="emphasis">example/join.html</span>를 방문하여 테스트한다.<br />
ID와 좋아하는 운동외에 사용자가 입력하거나 선택한 값을 확인하는 소스를 서블릿에 추가하고 테스트해 보자.<br />

<h2>RequestDispatcher 인터페이스</h2>
RequestDispathcer는 include()와 forward() 2개의 메소드가 있다.<br />
include()메소드는 요청을 다른 자원으로 보냈다가 다른 자원에서 실행이 끝나면 다시 요청을 가져오는 메소드로 
요청을 전달한 자원의 결과를 포함해서 클라이언트에게 보내게 된다.<br />
forward()메소드는 이름 그대로 클라이언트의 요청을 서버상의 다른 자원에게 넘기는 메소드이다.<br />
다음은 RequestDispatcher 의 forward() 메소드의 예로 모델 2 컨트롤러에 대한 이해에 도움이 될 것이다.<br />

<em class="filename">ControllerServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ControllerServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		
		String uri = req.getRequestURI();
		String contextPath = req.getContextPath();
		String command = null;
		String view = null;
		boolean isRedirect = false;
		
		command = uri.substring(contextPath.length());
		
		if (command.equals("/example/join.action")) {
			view = "/example/join.html";
		}
		if (isRedirect == false) {
			ServletContext sc = this.getServletContext();
			RequestDispatcher rd = sc.getRequestDispatcher(view);
			rd.forward(req,resp);
		} else {
			resp.sendRedirect(view);
		}
		
	}
	
}
</pre>

명령 프롬프트를 열고 위 소스코드가 있는 /WEB-INF/src/exampe 로 이동하여 컴파일한다.<br />

<pre>
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 7.0/lib/servlet-api.jar" ^
ControllerServlet.java
</pre>

다음으로 web.xml 파일을 열고 아래를 추가한다.

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;Controller&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.ControllerServlet&lt;/servlet-class&gt;
    &lt;load-on-startup&gt;1&lt;/load-on-startup&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;Controller&lt;/servlet-name&gt;
    &lt;url-pattern&gt;*.action&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

톰캣을 재시작한 다음 http://localhost:8989<span class="emphasis">/example/join.action</span>를 방문하여 
/example/join.html이 응답하는지 확인한다.<br />
ControllerServlet에서 isRedirect를 true로 변경한 다음 다시 테스트한다.<br />

<h3>소스 설명</h3>
web.xml에서 모든 action 확장자의 요청을 ControllerServlet 담당하도록 설정했다.<br />
확장자가 action 인 요청이 오면 톰캣은 web.xml 의 매핑정보를 해석해서 ControllerServlet 서블릿의 +service(req:ServletRequest, res:ServletResponse)
메소드를 호출한다.<br />
+service(req:ServletRequest, res:ServletResponse) 메소드는 #service(req:HttpServletRequest, resp:HttpServletResponse)
메소드를 호출한다.<br />
#service(req:HttpServletRequest, resp:HttpServletResponse) 메소드에서는 요청의 HTTP METHOD가 무엇인지 판단하고 그에 맞는 메소드를 호출한다.<br />
웹브라우저의 주소창에서 http://localhost:8989/example/join.action를 요청했으므로 GET 방식의 요청이다.<br /> 
따라서 이 경우는 doGet()메소드를 호출된다.<br /> 
ControllerServlet서블릿의 doGet()메소드는 단순히 doPost()을 호출한다.<br />
doPost()의 구현부에서 사용된 HttpServletRequest 의 다음 메소드를 다음과 같이 정리한다.<br />
<br />
<strong>getRequestURI()</strong><br />
&nbsp; 웹브라우저로 http://localhost:8989/example/join.action 요청시 "/example/join.action"을 리턴한다.<br />
<strong>getContextPath()</strong><br />
&nbsp; 컨텍스트 파일의 path 속성값을 얻을 수 있다.(이를 Context Path 라 한다.)<br />
&nbsp; 우리는 ROOT 애플리케이션에서 작업하므로 이 메소드를 통해 얻을 수 있는 값은 "" 이다.<br />
<strong>req.getRequestURI().substring(req.getContextPath().length())</strong><br />
&nbsp; 결과는 "/example/join.action" 를 리턴한다.<br />
&nbsp; 이 값이 getRequestURI() 의 리턴값이 같은 이유는 ROOT 애플리케이션이기 때문이다.<br />
&nbsp; ROOT 애플리케이션이 아니라도 이 값은 달라지지 않는다.<br />  
<br />

/example/join.html 에 대한 RequestDispatcher 를 얻은 후 forward() 메소드를 이용해서 사용자의 요청을 /example/join.html 로 전달한다.<br /> 
제어권이 ControllerServlet 에서 /example/join.html 로 이동한 것이다.<br />
결과적으로 /example/join.action 을 요청한 사용자는 /example/join.html 의 응답을 받게 된다.<br />


<h2>데이터베이스 연동</h2>
JDBC 메뉴에서 실습했던 오라클 JDBC 연동 테스트 파일인 GetEmp.java 를 서블릿으로 변환해보자.<br />
이번 예제는 순수 자바 애플리케이션을 서블릿으로 바꾸는 예제인 것이다.<br />
ROOT 애플리케이션의 /WEB-INF/src/example 디렉토리에 GetEmpServlet.java 파일을 생성한다.<br />

<em class="filename">GetEmpServlet.java</em>
<pre class="prettyprint">
package example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetEmpServlet extends HttpServlet {
	
	private String DB_URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	private String DB_USER = "scott";
	private String DB_PASSWORD = "tiger";
	
	/*
	 * GenericServlet의 init() 메소드
	 * init(ServletConfig config) 메소드 구현부에서 이 메소드를 호출하도록 구현되어 있다.
	 * 따라서 굳이 init(ServletConfig config) 메소드를 오버라이딩하지 않아도 된다.
	 */
	@Override
	public void init() throws ServletException {
		try {
			Class.forName( "oracle.jdbc.driver.OracleDriver" );
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String sql = "select * from emp";
		
		try {
			// Connection 레퍼런스를 획득
			con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			// Statement를 생성
			stmt = con.createStatement();
			// SQL문 실행
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				
				out.println( empno + " : " + ename + " : " + job + " : " + mgr + 
				" : " + hiredate + " : " + sal + " : " + comm+" : " + depno + "&lt;br /&gt;" );
			}

		} catch (SQLException e) {
			e.printStackTrace(out);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {

					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

}
</pre>

명령 프롬프트를 이용해서 ROOT 애플리케이션의 /WEB-INF/src/example 디렉토리로 이동 한 후 컴파일한다.<br />

<pre>
javac -d C:/www/myapp/WEB-INF/classes ^ 
-cp "C:/Program Files/Apache Software Foundation/Tomcat 7.0/lib/servlet-api.jar" ^
GetEmpServlet.java
</pre>

컴파일 후에는 web.xml 파일을 편집한다.<br />
web.xml 열고 아래와 같이 서블릿 선언과 매핑을 추가한다.<br /> 

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;GetEmpServlet&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.GetEmpServlet&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;GetEmpServlet&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/empList&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

이미 설명한 대로 톰캣 클래스로더는 환경변수 CLASSPATH 를 참조하지 않는다.<br />
JDBC 드라이버 파일은 특별한 이유로 반드시 {톰캣홈}/lib 두어야 한다.<br />
<br />
톰캣을 재시작한 후, http://localhost:8989<span class="emphasis">/empList</span>를 방문하여 확인한다.

<pre>
7369 : SMITH : CLERK : 7902 : 1980-12-17 00:00:00.0 : 800 : null : 20
7499 : ALLEN : SALESMAN : 7698 : 1981-02-20 00:00:00.0 : 1600 : 300 : 30
7521 : WARD : SALESMAN : 7698 : 1981-02-22 00:00:00.0 : 1250 : 500 : 30
7566 : JONES : MANAGER : 7839 : 1981-04-02 00:00:00.0 : 2975 : null : 20
7654 : MARTIN : SALESMAN : 7698 : 1981-09-28 00:00:00.0 : 1250 : 1400 : 30
7698 : BLAKE : MANAGER : 7839 : 1981-05-01 00:00:00.0 : 2850 : null : 30
7782 : CLARK : MANAGER : 7839 : 1981-06-09 00:00:00.0 : 2450 : null : 10
7788 : SCOTT : ANALYST : 7566 : 1987-04-19 00:00:00.0 : 3000 : null : 20
7839 : KING : PRESIDENT : null : 1981-11-17 00:00:00.0 : 5000 : null : 10
7844 : TURNER : SALESMAN : 7698 : 1981-09-08 00:00:00.0 : 1500 : 0 : 30
7876 : ADAMS : CLERK : 7788 : 1987-05-23 00:00:00.0 : 1100 : null : 20
7900 : JAMES : CLERK : 7698 : 1981-12-03 00:00:00.0 : 950 : null : 30
7902 : FORD : ANALYST : 7566 : 1981-12-03 00:00:00.0 : 3000 : null : 20
7934 : MILLER : CLERK : 7782 : 1982-01-23 00:00:00.0 : 1300 : null : 10
</pre>

원하는 결과가 나오지 않을 때에는 아래 리스트를 체크한다.

<ul>
	<li>web.xml 파일에서 서블릿 선언과 서블릿 매핑정보가 올바른지 확인한다.</li>
	<li>/WEB-INF/classes/example 에 GetEmpServlet 바이트코드 있는지 확인한다.</li>
	<li>{톰캣홈}/lib 에 오라클 JDBC 드라이버 파일(ojdbc6.jar)이 있는지 확인한다.</li>
	<li>웹 애플리케이션이 성공적으로 로드되었는지 확인한다.</li>
</ul>

<h2>ServletConfig 초기화 파라미터를 이용하는 예제</h2>

위 예제에서 서블릿의 메소드 구현부에서 JDBC 코드가 있었다.<br />
이번 예제는 JDBC 설정을 ServletConfig 초기화 파라미터를 이용하도록 만든다.<br />
아래 서블릿을 /WEB-INF/src/example 폴더에 만든다.<br /> 

<em class="filename">InitParamServlet 서블릿</em>
<pre class="prettyprint">
package example;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InitParamServlet extends HttpServlet {
	
	private String url;
	private String user;
	private String passwd;
	private String driver;
	
	@Override
	public void init() throws ServletException {
		url = this.getInitParameter("url");
		user = this.getInitParameter("user");
		passwd = this.getInitParameter("passwd");
		driver = this.getInitParameter("driver");
		
		try {
			Class.forName(driver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM emp";
		
		try {
			con = DriverManager.getConnection(url, user, passwd);
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				
				out.println(empno + " : " + ename + " : " + job + " : " + mgr + 
				  " : " + hiredate + " : " + sal + " : " + comm+" : " + depno + "&lt;br /&gt;");
			}
		} catch (SQLException e) {
			e.printStackTrace(out);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
}
</pre>

ServletConfig 초기화 파라미터 선언은 web.xml 파일에서 아래와 같이 servlet 엘리먼트의 
자식 엘리먼트 init-param 를 이용한다.

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
  &lt;servlet-name&gt;InitParamServlet&lt;/servlet-name&gt;
  &lt;servlet-class&gt;example.InitParamServlet&lt;/servlet-class&gt;

  &lt;init-param&gt;
    &lt;param-name&gt;driver&lt;/param-name&gt;
    &lt;param-value&gt;oracle.jdbc.driver.OracleDriver&lt;/param-value&gt;
  &lt;/init-param&gt;
  &lt;init-param&gt;
    &lt;param-name&gt;url&lt;/param-name&gt;
    &lt;param-value&gt;jdbc:oracle:thin:@127.0.0.1:1521:XE&lt;/param-value&gt;
  &lt;/init-param&gt;
  &lt;init-param&gt;
    &lt;param-name&gt;user&lt;/param-name&gt;
    &lt;param-value&gt;scott&lt;/param-value&gt;
  &lt;/init-param&gt;
  &lt;init-param&gt;
    &lt;param-name&gt;passwd&lt;/param-name&gt;
    &lt;param-value&gt;tiger&lt;/param-value&gt;
  &lt;/init-param&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
  &lt;servlet-name&gt;InitParamServlet&lt;/servlet-name&gt;
  &lt;url-pattern&gt;/initParam&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

위에서 설정한 ServletConfig 의 초기화 파라미터의 값은 ServletConfig 의 
getInitParameter(String name) 메소드를 이용하면 얻어진다.


톰캣을 재시작한 후에<br />
http://localhost:8989<span class="emphasis">/initParam</span>을 방문하여 테스트한다.

<h2>ServletContext 초기화 파라미터를 이용하는 예제</h2>
위에서 ServletConfig 의 초기화 파라미터는 해당 서블릿에서만 참조 할 수 있다.<br />
ServletContext 초기화 파라미터는 웹 애플리케이션 내 모든 서블릿과 JSP에서 참조할 수 있다.<br />
ServletContext 초기화 파라미터는 context-param 엘리먼트를 이용한다.<br />
엘리먼트의 위치는 <a href="Servlet.php#web-app">web.xml 엘리먼트 순서</a>를 참조한다.<br />
기존의 servlet 선언부보다 먼저 있어야 한다.<br />
web.xml 열고 아래 내용을 추가한다.<br />

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;context-param&gt;
    &lt;param-name&gt;url&lt;/param-name&gt;
    &lt;param-value&gt;jdbc:oracle:thin:@127.0.0.1:1521:XE&lt;/param-value&gt;
&lt;/context-param&gt;
</pre>

ServletContext 객체의 레퍼런스는 서블릿에서 getServletContext() 메소드를 이용하면 얻을 수 있다.<br />
위에서 선언한 ServletContext 의 초기화 파라미터 url 의 값은 ServletContext 의 getInitParameter(String name) 
메소드를 이용하여 구한다.<br /> 
따로 예제를 만들지 않고 위에서 작성한 SimpleSerlvet 에 다음과 같이 코드를 적당한 위치에 추가한 후 다시 컴파일한다.<br />

<h5>SimpleServlet 서블릿 편집</h5>
<pre class="prettyprint">
ServletContext sc = getServletContext();
String url = sc.getInitParameter("url");
out.println(url);
</pre>

톰캣을 재실행하고<br />
http://localhost:8989/simple을 방문하여 테스트한다.<br />
InitParamServlet 에서 url 을 이 ServletContext 초기화 파라미터를 이용해서 설정하도록 코드를 수정하고 테스트해 보자.<br /> 

<h2>리슨너</h2>
리슨너는 웹 애플리케이션의 이벤트에 실행된다.<br />
웹 애플리케이션 이벤트는 서블릿 스펙 2.3 이후 등장했다.<br />
웹 애플리케이션 이벤트는 다음과 같이 나뉜다.<br />

<ul>
	<li>애플리케이션 스타트업과 셧다운</li>
	<li>세션 생성 및 세션 무효</li>
</ul>

애플리케이션 스타트업 이벤트는 톰캣과 같은 서블릿 컨테이너에 의해 웹 애플리케이션이 처음 로드되어 스타트될 때 발생한다.<br />
애플리케이션 셧다운 이벤트는 웹 애플리케이션이 셧다운될 때 발생한다.<br />
<br />
세션 생성 이벤트는 새로운 세션이 생성될 때 발생한다.<br />
세션 무효 이벤트는 세션이 무효화 될때 매번 발생한다.<br />
<br />
이벤트를 이용하기 위해서는 리슨너라는 클래스를 작성해야 한다.<br />
리슨너 클래스는 순수 자바 클래스로 다음의 인터페이스를 구현한다.<br />

<ul>
	<li>javax.servlet.ServletContextListener</li>
	<li>javax.servlet.http.HttpSessionListener</li>
</ul>

애플리케이션 스타트업 또는 셧다운 이벤트를 위한 리슨너를 원한다면 ServletContextListener 
인터페이스를 구현한다.<br />
세션 생성 및 세션 무효 이벤트를 위한 리슨너를 원한다면 HttpSessionListener 인터페이스를 구현한다.<br />
<br />
ServletContextListener 인터페이스는 다음 2개의 메소드로 구성되어 있다.<br />
<ul>
	<li>public void contextInitialized(ServletContextEvent sce);</li>
	<li>public void contextDestroyed(ServletContextEvent sce);</li>
</ul>
<br />
HttpSessionListener 인터페이스는 다음 2개의 메소드로 구성되어 있다.<br />
<ul>
	<li>public void sessionCreated(HttpSessionEvent se);	</li>
	<li>public void sessionDestroyed(HttpSessionEvent se);</li>
</ul>

다음은 애플리케이션 스타트업과 셧다운 이벤트를 이용하는 예제이다.<br />
우리의 웹 애플리케이션이 스타트업되면 OracleConnectionManager 객체를 생성하여 ServletContext 에 저장하기 위해 
아래와 같은 클래스를 작성한다.

<em class="filename">MyServletContextListener.java</em>
<pre class="prettyprint">
package net.java_school.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import net.java_school.db.dbpool.OracleConnectionManager;

public class MyServletContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		OracleConnectionManager dbMgr = new OracleConnectionManager();
		sc.setAttribute("dbMgr", dbMgr);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		sc.removeAttribute("dbMgr");
	}

}
</pre>

이 클래스가 제 기능을 다하도록 하려면 web.xml 에 아래를 web-app 엘리먼트의 자식 엘리먼트로 추가한다.<br />
이때 다음 http://java.sun.com/dtd/web-app_2_3.dtd 를 참고하여 엘리먼트의 순서에 맞게 추가해야 한다.<br />
context-param 보다는 아래에 servlet 보다는 위에 추가해야 함을 알 수 있다.<br />
<br />

<div id="web-app" class="codebox">
&lt;!ELEMENT web-app (icon?, display-name?, description?, distributable?,
<strong>context-param*</strong>, filter*, filter-mapping*, <strong>listener*</strong>, <strong>servlet*</strong>,
servlet-mapping*, session-config?, mime-mapping*, welcome-file-list?,
error-page*, taglib*, resource-env-ref*, resource-ref*, security-constraint*,
login-config?, security-role*, env-entry*, ejb-ref*,  ejb-local-ref*)&gt;
</div>

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;listener&gt;
    &lt;listener-class&gt;net.java_school.listener.MyServletContextListener&lt;/listener-class&gt;
&lt;/listener&gt;
</pre>

JDBC 메뉴의 ConnectionPool 소스를 WEB-INF/src 에 추가한다.<br />
net.java_school.util.Log.java 파일에서 다음 부분을 수정한다.<br />
<em>public String dbgFile = "C:/www/myapp/WEB-INF/debug.txt";</em><br />
orcale.properties 파일은 WEB-INF 폴더에 위치시킨다.<br />
ConnectionManager.java 파일에서 다음 부분을 수정한다.<br />
<em>configFile = "C:/www/myapp/WEB-INF/"+poolName+".properties";</em><br />

이제 우리의 웹 애플리케이션이 시작될 때 OracleConnectionManager 객체를 생성되고 그 레퍼런스가 ServletContext 에 저장될 것이다.<br />
테스트를 위해 GetEmpServlet.java 파일을 아래와 같이 수정한다.

<em class="filename">GetEmpServlet.java</em>
<pre class="prettyprint">
package example;

import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import net.java_school.db.dbpool.*;

public class GetEmpServlet extends HttpServlet {

	<strong>private OracleConnectionManager dbMgr;</strong>
	
	@Override
	public void init() throws ServletException {
		<strong>ServletContext sc = getServletContext();
		dbMgr = (OracleConnectionManager) sc.getAttribute("dbMgr");</strong>
	}
	
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM emp";
		
		try {
			con = <strong>dbMgr.getConnection();</strong>
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while (rs.next()) {
				String empno = rs.getString(1);
				String ename = rs.getString(2);
				String job = rs.getString(3);
				String mgr = rs.getString(4);
				String hiredate = rs.getString(5);
				String sal = rs.getString(6);
				String comm = rs.getString(7);
				String depno = rs.getString(8);
				
				out.println( empno + " : " + ename + " : " + job + " : " + mgr +
					" : " + hiredate + " : " + sal + " : " + comm+" : " + depno + "&lt;br&gt;" );
			}
		} catch (SQLException e) {
			e.printStackTrace(out);
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	
	}
	
}
</pre>

GetEmpServlet를 컴파일하고 톰캣을 재가동 후 <em>http://localhost:8989</em>/empList를 방문한다.<br />
(GetEmpServlet 서블릿에 대한 선언과 매핑은 이미 이전 예제 테스트에서 설정했다.)<br />
<br />
다음은 HttpSessionListener 에 대한 설명과 예제이다.<br />
HttpSessionListener 인터페이스 역시 2개의 메소드로 구성되어 있는데 하나는 세션 생성되는 이벤트와 세션이 무효화 되는 이벤트를 위한 것이다.<br />

<ul>
	<li>public void sessionCreated(HttpSessionEvent se);</li>
	<li>public void sessionDestroyed(HttpSessionEvent se);</li>
</ul>

<em class="filename">SessionCounterListener.java</em>
<pre class="prettyprint">
package net.java_school.listener;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionCounterListener implements HttpSessionListener {
	public static int totalCount;
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		totalCount++;
		System.out.println("세션증가 총세션수:" + totalCount);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		totalCount--;
		System.out.println("세션감수 총세션수:" + totalCount);
	}

}
</pre>

web.xml 에 다음을 추가한다.<br />

<pre class="prettyprint">
&lt;listener&gt;
    &lt;listener-class&gt;net.java_school.listener.SessionCounterListener&lt;/listener-class&gt;
&lt;/listener&gt;
</pre>

설정파일인 web.xml이 변경되었으므로 톰캣을 재실행한 후<br />
http://localhost:8989/simple를 방문한다.<br />
다른 웹브라우저로 http://localhost:8989/simple를 방문한다.<br />
톰캣 로그 파일에서 로그 메시지를 확인한다.<br />
 
<h2>Filter</h2>
필터란 사용자의 요청이 서버 자원에 전달되기 전에 언제나 수행되어야 하는 코드 조각이 있을 때 사용한다.<br />
필터는 web.xml 에서 선언과 매핑을 해야 한다.<br />
web.xml 에 필터1 다음에 필터2 가 순서대로 선언되고 매핑되었다면<br />
필터1-필터2-서버 자원 순으로 실행될 것이다.<br />
필터는 응답이 사용자의 웹브라우저에 도달되기 전에도 필터링 할 수 있다.<br />
필터2-필터1-웹브라우저 순서로 응답이 도달된다.<br />
<br />
여기서 서버 자원은 서블릿,JSP는 물론이고 HTML페이지와 이미지와 같은 정적인 자원를 
포함하며, web.xml 에서 필터 관련 매핑 설정에서 URL 패턴에 부합하는 자원을 말한다.<br />
필터 클래스를 작성하기 위해서는 javax.servlet.Filter 인터페이스를 구현해야 한다.<br />

<h3>Filter 인터페이스</h3>
<ul>
	<li>init (FilterConfig filterConfig) throws ServletException<br />
	서블릿 컨테이너에 의해 호출되면 필터는 서비스 상태가 됨</li>
	<li>doFilter (ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException<br />
	서블릿 컨테이너에 의해 호출되어 필터링 작업을 수행
	</li>
	<li>destroy()<br />
	서블릿 컨테이너에 의해 호출되면 해당 필터는 더 이상 서비스를 할 수 없음. 주로 자원반납을 위해 사용
	</li>
</ul>

doFilter 메소드의 아규먼트를 보면, 필터가 요청이나 응답을 가로챌 때 
ServletRequest 와 ServletResponse 그리고 javax.servlet.FilterChain 객체를 접근할 수 있음을 알 수 있다.<br /> 
여기서 FilterChain 객체는 순서대로 호출되어야 하는 필터의 리스트를 담고 있다.<br />
필터의 doFilter 메소드에서 FilterChain 의 doFilter 메소드를 호출하기 전까지가 요청전에 실행되는 필터링 코드이며
FilterChain의 doFilter 메소드 호출다음은 응답전에 호출되는 필터링 코드이다.<br />
이와 같이 작동하는 이유가 궁금하면 아래 필터를 흉내낸 자바 순수 애플리케이션을 실행해 본다.<br />

<h3>필터 매커니즘을 흉내낸 예제</h3>

<em class="filename">ChainFilter.java</em>
<pre class="prettyprint">
package net.java_school.filter;

import java.util.ArrayList;
import java.util.Iterator;

public class ChainFilter {
	private ArrayList&lt;Filter&gt; filters;
	private Iterator&lt;Filter&gt; iterator;

	public void doFilter() {
		if (iterator.hasNext()) {
			iterator.next().doFilter(this);
		} else {
			System.out.println("서버 자원을 호출한다.");
		}
	}

	public ArrayList&lt;Filter&gt; getFilters() {
		return filters;
	}

	public void setFilters(ArrayList&lt;Filter&gt; filters) {
		this.filters = filters;
		this.iterator = filters.iterator();
	}
	
}
</pre>

<em class="filename">Filter.java</em>
<pre class="prettyprint">
package net.java_school.filter;

public interface Filter {
	
	public void doFilter(ChainFilter chain);

}
</pre>

<em class="filename">Filter1.java</em>
<pre class="prettyprint">
package net.java_school.filter;

public class Filter1 implements Filter {

	@Override
	public void doFilter(ChainFilter chain) {
		System.out.println("서버 자원 실행전에 필터1 실행부");
		chain.doFilter();
		System.out.println("서버 자원 실행후에 필터1 실행부");
	}

}
</pre>

<em class="filename">Filter2.java</em>
<pre class="prettyprint">
package net.java_school.filter;

public class Filter2 implements Filter {

	@Override
	public void doFilter(ChainFilter chain) {
		System.out.println("서버 자원 실행전에 필터2 실행부");
		chain.doFilter();
		System.out.println("서버 자원 실행후에 필터2 실행부");
	}

}
</pre>

<em class="filename">Tomcat.java</em>
<pre class="prettyprint">
package net.java_school.filter;

import java.util.ArrayList;

public class Tomcat {

	public static void main(String[] args) {
		ChainFilter chain = new ChainFilter();
		ArrayList&lt;Filter&gt; filters = new ArrayList&lt;Filter&gt;();
		Filter f1 = new Filter1();
		Filter f2 = new Filter2();
		filters.add(f1);
		filters.add(f2);
		chain.setFilters(filters);
		chain.doFilter();
	}

}
</pre>

<pre class="console">
<strong class="console-result">서버 자원 실행전에 필터1 실행부
서버 자원 실행전에 필터2 실행부
서버 자원을 호출한다.
서버 자원 실행후에 필터2 실행부
서버 자원 실행후에 필터1 실행부
</strong>
</pre>

<h3>Filter 예제</h3>
다음은 모든 요청에 대해 ServletRequest 의 setCharacterEncoding("UTF-8"); 가 먼저 수행되도록 하려 한다.<br /> 
아래와 같이 CharsetFilter.java 파일을 작성한다.<br />

<em class="filename">/WEB-INF/src/net/java_school/filter/CharsetFilter.java</em>
<pre class="prettyprint">
package net.java_school.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharsetFilter implements Filter {

	private String charset = null;
	
	@Override
	public void init(FilterConfig config) throws ServletException {
		this.charset = config.getInitParameter("charset");
	}
	
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) 
		throws IOException, ServletException {
		
		if (req.getCharacterEncoding() == null) {
			req.setCharacterEncoding(charset);
			chain.doFilter(req,resp);
		}
	}

	@Override
	public void destroy() {
		//반납할 자원이 있다면 작성한다.
	}

}
</pre>

/WEB-INF/src/net/java_school/filter/ 폴더로 이동해서 아래와 같이 컴파일한다.<br />

<pre>
javac -d C:/www/myapp/WEB-INF/classes ^
-cp "C:/Program Files/Apache Software Foundation/Tomcat 7.0/lib/servlet-api.jar" ^
CharsetFilter.java
</pre>

<br />
다음 web.xml 파일을 열고 아래를 추가한다. 이때 기존 엘리먼트와의 순서에 주의한다.<br />
context-param 엘리먼트와 listener 엘리먼트 사이에 아래 코드가 위치해야 한다. 

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;filter&gt;
   &lt;filter-name&gt;CharsetFilter&lt;/filter-name&gt;
   &lt;filter-class&gt;net.java_school.filter.CharsetFilter&lt;/filter-class&gt;
   &lt;init-param&gt;
      &lt;param-name&gt;charset&lt;/param-name&gt;
      &lt;param-value&gt;UTF-8&lt;/param-value&gt;
   &lt;/init-param&gt;
&lt;/filter&gt;

&lt;filter-mapping&gt;
   &lt;filter-name&gt;CharsetFilter&lt;/filter-name&gt;
   &lt;url-pattern&gt;/*&lt;/url-pattern&gt;
&lt;/filter-mapping&gt;
</pre>

<h3>테스트</h3>
위에서 실행했던 회원가입 예제의 RegisterServlet.java 소스에서<br />
req.setCharacterEncoding( "UTF-8" );을 주석처리 한 후 RegisterServlet 서블릿을 재컴파일한다.<br />
http://localhost:8989/example/join.jsp를 방문하여 아이디에 한글을 입력하고 좋아하는 운동을 
선택한 후 전송을 클릭한다.<br /> 
이때 RegisterServlet 이 사용자가 입력한 한글 아이디 값을 제대로 출력하는지 테스트한다.

<h3>소스 설명</h3>
필터의 초기화 파라미터를 읽기 위해서는 FilterConfig의 getInitParameter()메소드나 getInitParameters()메소드를 이용한다.<br />
filter-mapping엘리먼트를 이용해서 URL패턴이나 서블릿 이름으로 이들 자원에 앞서 필터링 작업을 수행할 필터를 정의한다.<br />
필터는 배치 정의자에 나와 있는 순으로 FilterChain에 추가된다.<br />이때 서블릿 이름과 매핑된 필터는 URL 패턴에 매칭되는 필터 다음에 추가된다.<br /> 
필터 클래스 코드내에서 FilterChain.doFilter() 메소드를 이용하면 FilterChain의 다음 아이템을 호출하게 된다.<br />


<h2>파일 업로드</h2>

<h3>MultipartRequest</h3>

MultipartRequest 팩키지는 파일 업로드에 널리 이용되고 있는 팩키지이다.<br />
<a href="http://www.servlets.com/cos/index.html">http://www.servlets.com/cos/index.html</a>
에서 가장 최신 버전인 cos-26Dec2008.zip 를 다운로드 하여 압축을 푼 후 서브 디렉토리 lib 에 
있는 cos.jar 파일을 /WEB-INF/lib 디렉토리에 복사한다.<br /><br />
MultipartRequest 클래스의 생성자는 아래 링크에서 확인할 수 있듯이 8개가 있다.<br />
<a href= "http://www.servlets.com/cos/javadoc/com/oreilly/servlet/MultipartRequest.html">http://www.servlets.com/cos/javadoc/com/oreilly/servlet/MultipartRequest.html</a>
<br />
그 중 아래의 생성자는 한글 인코딩 문제를 해결할 수 있고 업로드하는 파일이 중복될 때 
파일명을 변경해서 업로드한다.
예제에서는 이 생성자를 이용한다.

<pre class="prettyprint">
public MultipartRequest(
	HttpServletRequest request,
	String saveDirectory,
	int maxPostSize,
	String encoding,
	FileRenamePolicy policy) throws IOException
</pre>

<h4>MultipartRequest 메소드</h4>
MultipartRequest 객체가 성공적으로 생성되었다면 이미 업로드는 성공한 것이다.<br />
아래 메소드는 서버의 파일 시스템에 파일을 업로드 된 후 이용하는 
MultipartRequest 멤버 메소드를 소개하고 있다.<br /> 
&lt;input type="file" name="photo"/&gt;를 이용해서 logo.gif 를 업로드했다고 가정하에 설명한다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 220px">메소드</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">getContentType("photo");</td>
	<td class="table-in-article-td">업로드된 파일의 MIME 타입 리턴, 예를 들어 확장자가 gif 이미지라면 "image/gif" 가 반환</td>
</tr>
<tr>
	<td class="table-in-article-td">getFile("photo");</td>
	<td class="table-in-article-td">업로드되어 서버에 저장된 파일의 File 객체 리턴</td>
</tr>
<tr>
	<td class="table-in-article-td">getFileNames();</td>
	<td class="table-in-article-td">폼 요소 중 input 태그 속성이 file 로 된 파라미터의 이름을 Enumeration 타입으로 리턴</td>
</tr>
<tr>
	<td class="table-in-article-td">getFilesystemName("photo");</td>
	<td class="table-in-article-td">업로드되어 서버 파일시스템에 존재하는 실제 파일명을 리턴</td>
</tr>
<tr>
	<td class="table-in-article-td">getOriginalFileName("photo");</td>
	<td class="table-in-article-td">원래의 파일명을 리턴</td>
</tr>
<tr>
	<td class="table-in-article-td" colspan="2">HttpServletRequest 구현체와 같은 인터페이스를 제공하기 위한 메소드</td>
</tr>
<tr>
	<td class="table-in-article-td">getParameter(String name);</td>
	<td class="table-in-article-td">name 에 해당하는 파라미터의 값을 String 타입으로 리턴</td>
</tr>
<tr>
	<td class="table-in-article-td">getParameterNames();</td>
	<td class="table-in-article-td">모든 파라미터의 이름을 String으로 구성된 Enumeration 타입으로 리턴</td>
</tr>
<tr>
	<td class="table-in-article-td">getParameterValues(String name);</td>
	<td class="table-in-article-td">name 에 해당하는 파라미터의 값들을 String[] 타입으로 리턴</td>
</tr>
</table>

<h4>MultipartRequest 예제</h4>
사용자로 부터 업로드 파일을 선택하도록 유도하는 페이지를 ROOT 애플리케이션의 
최상위 디렉토리의 서브 디렉토리 example 에 작성한다.

<em class="filename">/example/MultipartRequest.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html 
     PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
   &lt;title&gt;MultipartRequest 서블릿 예제&lt;/title&gt;
   &lt;meta http-equiv="content-type" content="text/html; charset=UTF-8" /&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h2&gt;MultipartRequest 를 이용한 파일 업로드 테스트&lt;/h2&gt;
&lt;form action="../servlet/UploadTest" method="post" enctype="multipart/form-data"&gt;
  &lt;p&gt;
    이름 : &lt;input type="text" name="name" /&gt;&lt;br /&gt;
    파일1 : &lt;input type="file" name="file1" /&gt;&lt;br /&gt;
    파일2 : &lt;input type="file" name="file2" /&gt;&lt;br /&gt;
  &lt;input type="submit" value="전송" /&gt;
  &lt;/p&gt;  
&lt;/form&gt;
&lt;/body&gt;&lt;/html&gt;
</pre>

업로드를 실행할 서블릿을 아래와 같이 작성하고 컴파일한다.<br />
컴파일 할 때에 자바 컴파일러는 cos.jar 파일에 대한 경로를 알아야 한다.

<em class="filename">UploadTest.java</em>
<pre class="prettyprint">
package example;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UploadTest extends HttpServlet {
	
	@Override	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws IOException, ServletException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		
		ServletContext cxt = getServletContext();
		String dir = cxt.getRealPath("/upload");
		
		try {
			MultipartRequest multi = 
				new MultipartRequest(
					req,
					dir,
					5*1024*1024,
					"UTF-8",
					new DefaultFileRenamePolicy());
					
			out.println("&lt;html&gt;");
			out.println("&lt;body&gt;");
			out.println("&lt;h1&gt;사용자가 전달한 파라미터들&lt;/h1&gt;");
			out.println("&lt;ol&gt;");
			Enumeration&lt;?&gt; params = multi.getParameterNames();
			
			while (params.hasMoreElements()) {
				String name = (String) params.nextElement();
				String value = multi.getParameter(name);
				out.println("&lt;li&gt;" + name + "=" + value + "&lt;/li&gt;");
			}
			
			out.println("&lt;/ol&gt;");
			out.println("&lt;h1&gt;업로드된 파일&lt;/h1&gt;");
			
			
			Enumeration&lt;?&gt; files = multi.getFileNames();
			
			while (files.hasMoreElements()) {
				out.println("&lt;ul&gt;");
				String name = (String) files.nextElement();
				String filename = multi.getFilesystemName(name);
				String orginalname =multi.getOriginalFileName(name);
				String type = multi.getContentType(name);
				File f = multi.getFile(name);
				out.println("&lt;li&gt;파라미터 이름 : "  + name + "&lt;/li&gt;");
				out.println("&lt;li&gt;파일 이름 : " + filename + "&lt;/li&gt;");
				out.println("&lt;li&gt;원래 파일 이름 : " + orginalname + "&lt;/li&gt;");
				out.println("&lt;li&gt;파일 타입 : " + type + "&lt;/li&gt;");
				
				if (f != null) {
					out.println("&lt;li&gt;크기: " + f.length() + "&lt;/li&gt;");
				}
				out.println("&lt;/ul&gt;");
			}
		} catch(Exception e) {
			out.println("&lt;ul&gt;");
			e.printStackTrace(out);
			out.println("&lt;/ul&gt;");
		}
		out.println("&lt;/body&gt;&lt;/html&gt;");
	}
}
</pre>

다음으로 web.xml 파일을 열고 작성한 서블릿을 등록하고 매핑한다.

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;UploadTest&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.UploadTest&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
    &lt;servlet-name&gt;UploadTest&lt;/servlet-name&gt;
    &lt;url-pattern&gt;/servlet/UploadTest&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

예제를 실행하기 전에 ROOT 웹 애플리케이션의 최상위 디렉토리에 upload 라는 서브 디렉토리를 만든다.<br />
톰캣을 재가동하고 http://localhost:8989/example/upload.html 를 방문하여 테스트한다.<br />
중복된 파일을 업로드한 후 upload 폴더에서 파일명을 확인한다.<br />
중복된 파일을 업로드하면 확장자를 제외한 파일이름의 끝에 숫자가 붙어서 업로드 되고 있음을 확인할 수 있다.<br />
만약 테스트가 실패했다면 아래 리스트를 체크한다.<br />

<ol>
	<li>UploadTest 서블릿의 바이트 코드가 생성되어 있는지 확인한다.</li>
	<li>ROOT 애플리케이션의 최상위 디렉토리에 upload 라는 서브 디렉토리가 있는지 확인한다.</li>
	<li>톰캣 클래스로더가 찾을 수 있도록 cos.jar 파일이 /WEB-INF/lib 에 위치하는지 확인한다.</li>
	<li>web.xml 파일에 UploadTest 서블릿이 제대로 등록되고 매핑되어 있는지 확인한다.</li>
	<li>웹 애플리케이션이 로드되었는지 확인한다.</li>
</ol>

<h3>commons-fileupload</h3>
<a href="http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi">http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi</a><br />
<a href="http://commons.apache.org/proper/commons-io/download_io.cgi">http://commons.apache.org/proper/commons-io/download_io.cgi</a><br />
에서 최신 바이너리 파일을 다운로드 한 후<br />
/WEB-INF/lib에 commons-fileupload-x.x.jar 와 commons-io-x.x.jar 를 위치시킨다.<br />


<em class="filename">/example/commons-fileupload.html</em>
<pre class="prettyprint">
&lt;!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
	"http://www.w3.org/TR/html4/loose.dtd"&gt;
&lt;html&gt;
&lt;head&gt;
&lt;meta http-equiv="Content-Type" content="text/html; charset=UTF-8"&gt;
&lt;title&gt;commons-fileupload 테스트&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
&lt;h1&gt;파일 업로드 테스트&lt;/h1&gt;
&lt;form action="../CommonsUpload" method="post" enctype="multipart/form-data"&gt;
파일 : &lt;input type="file" name="upload" /&gt;&lt;br /&gt;
&lt;input type="submit" value="전송" /&gt;
&lt;/form&gt;
&lt;/body&gt;
&lt;/html&gt;
</pre>

<em class="filename">CommonsUpload.java 서블릿</em>
<pre class="prettyprint">
package example;

import java.io.*;

import javax.servlet.*;
import javax.servlet.http.*;

import java.util.Iterator;
import java.io.File;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class CommonsUpload extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws IOException, ServletException {
			
		resp.setContentType("text/html; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		//Check that we have a file upload request
		boolean isMultipart = ServletFileUpload.isMultipartContent(req);
		//Create a factory for disk-based file items
		DiskFileItemFactory factory = new DiskFileItemFactory();
		
		//Configure a repository (to ensure a secure temp location is used)
		ServletContext servletContext = this.getServletConfig().getServletContext();
		File repository = (File) servletContext.getAttribute("javax.servlet.context.tempdir");
		factory.setRepository(repository);
		
		//Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setHeaderEncoding("UTF-8");//한글파일명 처리위해 추가
		try {
			//Parse the request
			List&lt;FileItem&gt; items = upload.parseRequest(req);
			//Process a file upload
			Iterator&lt;FileItem&gt; iter = items.iterator();
			while (iter.hasNext()) {
				FileItem item = iter.next();
				String fileName = null;
				if (!item.isFormField()) {
					String fieldName = item.getFieldName();
					out.println(fieldName);
					fileName = item.getName();
					out.println(fileName);
					String contentType = item.getContentType();
					out.println(contentType);
					boolean isInMemory = item.isInMemory();
					out.println(isInMemory);
					long sizeInBytes = item.getSize();
					out.println(sizeInBytes);
				}
				// Process a file upload
				ServletContext cxt = getServletContext();
				String dir = cxt.getRealPath("/upload");
				File uploadedFile = new File(dir + "/" + fileName);
				item.write(uploadedFile);
			}
		} catch (Exception e) {
			out.println("&lt;ul&gt;");
			e.printStackTrace(out);
			out.println("&lt;/ul&gt;");
		}
		out.println("&lt;a href=\"example/commons-fileupload.html\"&gt;파일업로드폼으로&lt;/a&gt;");
	}
}
</pre>

web.xml 파일을 열고 작성한 서블릿을 등록하고 매핑한다.

<em class="filename">web.xml</em>
<pre class="prettyprint">
&lt;servlet&gt;
    &lt;servlet-name&gt;commonsUpload&lt;/servlet-name&gt;
    &lt;servlet-class&gt;example.CommonsUpload&lt;/servlet-class&gt;
&lt;/servlet&gt;

&lt;servlet-mapping&gt;
	&lt;servlet-name&gt;commonsUpload&lt;/servlet-name&gt;
	&lt;url-pattern&gt;/CommonsUpload&lt;/url-pattern&gt;
&lt;/servlet-mapping&gt;
</pre>

톰캣을 재가동하고 http://localhost:8989/example/commons-fileupload.html를 방문하여 테스트한다.<br />
중복된 파일을 업로드한 후 upload 폴더에서 파일명을 확인한다.<br />
중복된 파일을 업로드하면 cos.jar와는 달리 기존 파일을 덮어쓴다는 것을 확인한다.<br />
업로드된 파일을 확인하는 예제는 JSP에서 다룬다.<br />

<h2>쿠키</h2>
HTTP 프로토콜은 상태를 유지할 수 없는 프로토콜이다.<br />
쿠키는 HTTP 프로토콜의 특징상 각각의 웹 브라우저가 서버와의 통신에서 세션을 유지하지 
못하는 것을 보완하기 위한 기술이다.<br />
서버가 쿠키를 전송하면 웹 브라우저는 그 다음 요청마다 쿠키 값을 서버로 전달하여 
사용자 정보를 유지할 수 있게 한다.<br />

<h3>서버 -&gt; 웹 브라우저</h3>
쿠키가 작동하려면 서버에서 쿠키값을 클라이언트로 전송해야 한다.<br />
이것을 쿠키를 굽는다고 표현하는데 아래와 같은 정보가 서버로부터 웹 브라우저에 전달되고 
웹 브라우저가 관리하는 폴더에 파일로 저장된다.

<pre class="prettyprint">
Set-Cookie : name = value ; expires = date ; path = path ; domain = domain ; secure
</pre>

<h3>웹 브라우저 -&gt; 서버</h3>
쿠키가 웹브라우저에 셋팅되면, 웹브라우저는 쿠기를 전달해준 서버로 요청시마다 아래와 같은 문자열을 서버로 보낸다.
 
<pre class="prettyprint">
Cookie ; name = value1 ; name2 = value2 ;
</pre>

쿠키 이름과 값에는 []()="/?@:; 와 같은 문자는 올 수 없다.<br />
다음은 쿠키를 설정하는 절차이다.

<h3>쿠키 설정 절차</h3>
1) Cookie 객체를 만든다. Cookie(String name, String value)<br />
2) 다음 메소드를 이용해 쿠키에 속성을 부여한다.<br />

<table class="table-in-article">
<tr>
	<th class="table-in-article-th" style="width: 150px">메소드</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">setValue(String value)</td>
	<td class="table-in-article-td">생성된 쿠키의 값을 재설정할 때 사용한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">setDomain(String pattern)</td>
	<td class="table-in-article-td">쿠키는 기본적으로 쿠키를 생성한 서버에만 전송된다.<br />
	같은 도메인을 사용하는 서버에 대해서 같은 쿠키를 보내기 위해서 setDomain()을 사용한다.<br />
	주의할 점은 쿠키를 생성한 서버와 관련이 없는 도메인을 setDomain()에 값으로 설정하면 쿠키가 구워지지 않는다는 것이다.</td>
</tr>
<tr>
	<td class="table-in-article-td">setMaxAge(int expiry)</td>
	<td class="table-in-article-td">쿠키의 유효기간을 초단위로 설정한다.<br />
	음수 입력시에는 브라우저가 닫으면 쿠키가 삭제된다.</td>
</tr>
<tr>
	<td class="table-in-article-td">setPath(String uri)</td>
	<td class="table-in-article-td">쿠키가 적용될 경로 정보를 설정한다.<br />
	경로가 설정되면 해당되는 경로로 방문하는 경우에만 웹브라우저가 쿠키를 웹서버에 전송한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">setSecure(boolean flag)</td>
	<td class="table-in-article-td">flag가 true이면 보안채널을 사용하는 서버의 경우에 한해 쿠키를 전송한다.</td>
</tr>
</table>

3) 웹브라우저에 생성된 쿠키를 전송 : resp.addCookie(cookie);

<h3>구워진 쿠키 이용</h3>
위에서 쿠키를 설정했다면 이제 서블릿에서 쿠키 이용하는 방법에 대해 알아본다.<br />

<pre>
Cookie[] cookie = <em>req.getCookies();</em>
</pre>

HttpServletRequest 의 getCookies() 메소드를 사용해서 쿠키배열을 얻는다.<br />
만약 구워진 쿠키가 없다면 getCookies() 메소드는 null 을 리턴한다.<br />
다음 메소드를 이용하면 쿠키에 대한 정보를 얻을 수 있다.<br />
이중 getName()과 getValue()가 주로 쓰인다.

<table class="table-in-article">
<tr>
	<th class="table-in-article-th">Cookie 메소드</th>
	<th class="table-in-article-th">설명</th>
</tr>
<tr>
	<td class="table-in-article-td">getName()</td>
	<td class="table-in-article-td">쿠키의 이름을 구한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">getValue()</td>
	<td class="table-in-article-td">쿠키의 값을 구한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">getDomain()</td>
	<td class="table-in-article-td">쿠키의 도메인을 구한다.</td>
</tr>
<tr>
	<td class="table-in-article-td">getMaxAge()</td>
	<td class="table-in-article-td">쿠키의 유효시간을 구한다.</td>
</tr>
</table>

다음은 서버 사이드에서 쿠키값을 알아내는 코드조각이다.<br />
예에서는 쿠키 이름이 id에 해당하는 쿠키값을 반환하는 예이다.<br />

<pre class="prettyprint">
String id = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
  for (int i = 0; i &lt; cookies.length; i++) {
    String name = cookies[i].getName();
    if (name.equals("id")) {
      id = cookies[i].getValue();
      	break;
    }
  }
}
</pre>

아래는 쿠키를 삭제하는 예이다.<br />
방법은 삭제하고자 하는 쿠키와 같은 이름의 쿠키를 생성하고 setMaxAge(0) 을 호출한다.

<pre class="prettyprint">
Cookie cookie = new Cookie("id","");
cookie.setMaxAge(0);
resp.addCookie(cookie);
</pre>

쿠키에 대한 실습은 <a href="JSP">JSP</a>에서 다룬다.<br />

<h2>세션</h2>
세션은 쿠키 기반 기술로 쿠키의 보안상 약점을 극복하기 위한 기술이다.<br />
쿠키와 다른 점(즉, 보안상 개선된 점)은 웹브라우저는 서버가 정해준 세션ID 만을 쿠키값으로 
저장한다는 것이다.<br />
세션이 생성되면 서버에서는 세션ID에 해당하는 HttpSession 객체를 서블릿 컨테이너가 
연결시켜 준다.<br />
아래는 세션 생성하는 코드이다.<br />

<pre>
HttpSession session = req.getSession(true); //세션이 없으면 생성
HttpSession session = req.getSession(false); //세션이 없다면 null리턴
</pre>

세션 객체가 생성되었으면 세션에 정보를 아래코드처럼 저장할 수 있다.<br />

<pre>
User user = new User("홍길동","1234");
session.setAttribue("user", user); //user 이름으로 user 객체 저장
</pre>

세션에 대한 실습은 <a href="JSP">JSP</a>에서 한다.<br />

<span id="comments">주석</span>
<ol>
	<li>그림(서블릿 기본골격 클래스 다이어그램)이 GenericServlet, HttpServlet 의 모든 속성과 메소드를 모두 나타내고 있지는 않다.
	이어지는 설명을 쉽게 이해하려면 클래스 다이어그램에서 나오는 인퍼페이스,추상클래스,클래스 이름은 기억해야 한다.</li>
	<li>MIME(Multipurpose Internet Mail Extensions)<br />
	.html 또는 .htm 은 text/html, .txt 는 text/plain .gif 는 image/gif 이다.</li>
	<li>쿼리 스트링(Query tring)이라 하는 URL 뒤 ? 다음에 이어지는 문자열은 URL에 해당하는 서버측 자원에 전달된다.
	정보가 1개 이상일 때는 두번째부터는 &amp;를 사용한다.</li>
	<li>Enumeration 인터페이스는 hasMoreElements() 와 nextElement() 2개의 메소드를 이용하여 데이터를 순서대로 접근할 수 있다.</li>
</ol>

<span id="refer">참고</span>
<ul id="references">
	<li><a href="http://docs.oracle.com/javaee/7/api/index.html?overview-summary.html">http://docs.oracle.com/javaee/7/api/index.html?overview-summary.html</a></li>
	<li><a href="http://www.mkyong.com/servlet/a-simple-httpsessionlistener-example-active-sessions-counter/">http://www.mkyong.com/servlet/a-simple-httpsessionlistener-example-active-sessions-counter/</a></li>
	<li><a href="http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi">http://commons.apache.org/proper/commons-fileupload/download_fileupload.cgi</a></li>
	<li><a href="http://commons.apache.org/proper/commons-io/download_io.cgi">http://commons.apache.org/proper/commons-io/download_io.cgi</a></li>
	<li><a href="http://commons.apache.org/proper/commons-fileupload/using.html">http://commons.apache.org/proper/commons-fileupload/using.html</a></li>
	<li><a href="http://www.albumbang.com/board/board_view.jsp?board_name=free&no=292">http://www.albumbang.com/board/board_view.jsp?board_name=free&amp;no=292</a></li>
	<li><a href="http://www.docjar.com/docs/api/javax/servlet/GenericServlet.html">http://www.docjar.com/docs/api/javax/servlet/GenericServlet.html</a></li>
</ul>
