package net.java_school.controller;

import java.util.Locale;

import net.java_school.blog.Post;

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
	public Post jdkInstall(Locale locale) {
		String lang = locale.getLanguage();
		
		Post post = new Post();
		
		switch (lang) {
		case "ko":
			post.setTitle("자바 설치");
			post.setKeywords("JDK,Java 8");
			post.setDescription("자바 설치에 대해 설명합니다.");
			post.setContent("<em>자바 8 다운로드</em>");
			break;
		case "en":
			post.setTitle("JDK Install");
			post.setKeywords("JDK,Java 8");
			post.setDescription("How to Install Java 8");
			post.setContent("<em>Java 8 Download</em>");
			break;
		default: 
			post.setTitle("JDK Install");
			post.setKeywords("JDK,Java 8");
			post.setDescription("How to Install Java 8");
			post.setContent("<em>Java 8 Download</em>");			
			break;
		}
		
		return post;
	}
	
}