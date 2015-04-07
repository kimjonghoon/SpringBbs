<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="자바 홈" />
<meta name="Description" content="자바 홈" />
<title>자바 홈</title>
<link rel="stylesheet" href="../css/screen.css" type="text/css" />
</head>
<body>

<div id="wrap">

    <div id="header">
		<%@ include file="../inc/header.jsp" %>
    </div>
    
    <div id="main-menu">
		<%@ include file="../inc/main-menu.jsp" %>
    </div>
    
	<div id="container">
		<div id="content" style="min-height: 800px;">
			<div id="url-navi">Java Home</div>

<!-- 본문 시작 -->
<h1>JDK 설치</h1>
<p>
www.oracle.com을 방문하여 JDK를 다운로드한다.<br />
설치는 다음 버튼을 클릭하는 것만으로 완료 할 수 있다.<br />  
설치 후 PATH 환경변수에 JDK의 bin 디렉토리를 추가한다.<br />
PATH의 기존 설정 값 맨뒤에 윈도우 환경변수의 구분자 ;를 추가하고 JDK의 bin까지의 경로를 붙여넣기 한다.<br />
이때 기존값은 지우지 않도록 주의한다.<br /> 
</p>

<h2>PATH</h2>
<p>
PATH는 운영체제가 실행 프로그램을 찾을 때 참조하는 환경변수이다.<br />
명령 프롬프트에서 <strong>echo %PATH%</strong>를 실행하면 PATH의 설정값을 확인할 수 있다.<br />
PATH에 JDK의 bin디렉토리를 추가하는 이유는 어느 디렉토리에서나 JDK의 bin에 있는 
실행 프로그램(javac.exe,java.exe,jar.exe 등)을 실행할 수 있도록 하기 위해서이다.<br />
</p>

<h2>테스트</h2>
<p>
아래 내용을 메모장에 작성하고 파일명을 Test.java로 저장한다.<br />
</p>

<pre>
public class Test {
  public static void main(String[] args) {
    System.out.println("Hello World!");
  }
}
</pre>

<ol>
    <li>명령 프롬프트에서 Test.java 파일이 있는 디렉토리로 이동한다.</li>
    <li>javac Test.java로 컴파일한다. Test.class가 현재 디렉토리에 만들어 진다.</li>
    <li>java Test로 실행한다.</li>
</ol>

<pre>
C:\&gt;javac Test.java

C:\&gt;java Test
Hello World!
</pre>

<!-- 본문 끝 -->
		
		</div>
    </div>
    
	<div id="sidebar">
		<h1>Java</h1>
	</div>
    
	<div id="extra">
		<%@ include file="../inc/extra.jsp" %>
	</div>
    
    <div id="footer">
		<%@ include file="../inc/footer.jsp" %>
    </div>
        
</div>

</body>
</html>