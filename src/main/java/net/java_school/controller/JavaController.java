package net.java_school.controller;

import java.util.ArrayList;
import java.util.List;

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
	public List<Post> jdkInstall() {
		List<Post> posts = new ArrayList<Post>();
		
		Post post1 = new Post();

		post1.setTitle("자바 설치");
		post1.setKeywords("JDK,Java 8");
		post1.setDescription("자바 설치에 대해 설명합니다.");
		post1.setContent("<em>자바 8 다운로드</em>");

		Post post2 = new Post();

		post2.setTitle("JDK Install");
		post2.setKeywords("JDK,Java 8");
		post2.setDescription("How to Install Java 8");
		post2.setContent("<em>Java 8 Download</em>");
		
		posts.add(post1);
		posts.add(post2);
		
		return posts;
	}
	
}