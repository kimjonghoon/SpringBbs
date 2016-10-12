package net.java_school.controller;

import net.java_school.blog.Posts;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/java")
public class JavaController {

	@RequestMapping(method=RequestMethod.GET)
	public String index() {
		return "java/index";
	}

	@RequestMapping(value="/jdk-install", method=RequestMethod.GET)
	@ResponseBody
	public Posts jdkInstall() {
		Posts posts = new Posts();

		posts.setTitle("자바 설치");
		posts.setKeywords("JDK,Java 8");
		posts.setDescription("자바 설치에 대해 설명합니다.");
		posts.setContents("<h1>자바 8 다운로드</h1>");
		
		return posts;
	}
	
}