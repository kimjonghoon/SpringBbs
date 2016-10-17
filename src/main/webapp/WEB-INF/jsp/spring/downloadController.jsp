<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>

<div id="last-modified">Last Modified : 2016.6.27</div>

<h1>다운로드 컨트롤러</h1>

파일 다운로드를 담당하는 컨트롤러를 작성한다.
(지금까지 파일 다운로드는 /WEB-INF/jsp/inc/download.jsp 파일을 사용했다.)

<em class="filename">DownloadController.java</em>
<pre class="prettyprint">
package net.java_school.commons.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.java_school.commons.WebContants;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/file")
public class DownloadController {
	
	@RequestMapping(value="/download",method=RequestMethod.POST)
	public void download(String filename, 
			HttpServletRequest req, 
			HttpServletResponse resp) {
			
		OutputStream outputStream = null;
		
		try {
			File file = new File(WebContants.UPLOAD_PATH + filename);
	
			String filetype = filename.substring(filename.indexOf(".") + 1, filename.length());
	
			if (filetype.trim().equalsIgnoreCase("txt")) {
				resp.setContentType("text/plain");
			} else {
				resp.setContentType("application/octet-stream");
			}
	
			resp.setContentLength((int) file.length());
	
			boolean ie = req.getHeader("User-Agent").indexOf("MSIE") != -1;
			if (ie) {
				filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
			} else {
				filename = new String(filename.getBytes("UTF-8"), "8859_1");
			}
	
			resp.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
	
			outputStream = resp.getOutputStream();
			FileInputStream fis = null;
			
			try {
				fis = new FileInputStream(file);
				FileCopyUtils.copy(fis, outputStream);
			} finally {
				if (fis!= null) {
					fis.close();
				}
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally {
			try {
				outputStream.close();
				resp.flushBuffer();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
</pre>

view.jsp에서 #form-group 부분의 파일 다운로드 폼 엘리먼트의 action 속성을 수정한다.

<em class="filename">view.jsp</em>
<pre class="prettyprint">
&lt;form id="downForm" action="<strong>../file/download</strong>" method="post"&gt;
&lt;p&gt;
	&lt;input type="hidden" name="filename" /&gt;
&lt;/p&gt;
&lt;/form&gt;
</pre>

파일 다운로드 컨트롤러가 자동 스캔되도록 스프링 설정 파일을 수정한다.

<em class="filename">spring-bbs-servlet.xml</em>
<pre class="prettyprint">
	&lt;context:component-scan
		base-package="net.java_school.board.spring,
			net.java_school.user.spring,
			net.java_school.home.spring,
			net.java_school.java.spring,
			net.java_school.javascript.spring,
			<strong>net.java_school.commons.controller</strong>,
			net.java_school.board,
			net.java_school.user" /&gt;
</pre>

로그인 사용자만 파일을 다운로드할 수 있게 하려면 스프링 시큐리티 설정 파일에 다음을 추가한다.
<em class="filename">security.xml</em>
<pre class="prettyprint">
&lt;intercept-url pattern="/file/**" access="hasAnyRole('ROLE_ADMIN','ROLE_USER')" /&gt;
</pre>

<h3>실패한 테스트</h3>

GET 방식의 /file/{fileName}와 같은 요청으로 파일을 내려받는 테스트를 했다. 

<em class="filename">FileController.java</em>
<pre class="prettyprint">
@RequestMapping(value="<strong>/{filename}</strong>",method=RequestMethod.GET)
public void download(<strong>@PathVariable String filename</strong>, HttpServletRequest req, HttpServletResponse resp) {
	//생략..
}
</pre>

view.jsp에서 파일 다운로드 링크 부분을 아래처럼 수정한다. 

<em class="filename">view.jsp</em>
<pre class="prettyprint">
&lt;a href="<strong>../file/{file.filename}</strong>" class="download"&gt;${file.filename }&lt;/a&gt;
</pre>

bbs-view.js에서 아래 부분을 주석 처리한다.

<em class="filename">bbs-view.js</em>
<pre class="prettyprint">
$(document).ready(function() {
&lt;!-- 주석 처리한다.
	$('#file-list a.download').click(function() {
	var $filename = this.title;
	$('#downForm input[name*=filename]').val($filename);
	$('#downForm').submit();
	return false;
	});
--&gt;

	//..이하 생략..
 
}  
</pre>


하지만 전달되는 파일명 파라미터는 확장자가 빠져 있다.
검색을 해보니 파일을 확장자를 파라미터로 함께 전송하거나 설정 파일을 수정하는 해결책이 있다고 한다.<br />
다음 링크 참조<br /> 
<ul>
	<li><a href="http://stackoverflow.com/questions/12395115/spring-missing-the-extension-file">http://stackoverflow.com/questions/12395115/spring-missing-the-extension-file</a></li>
	<li><a href="https://github.com/resthub/resthub-spring-stack/issues/217">https://github.com/resthub/resthub-spring-stack/issues/217</a></li>
</ul>


