package net.java_school.controller;

import net.java_school.blog.Posts;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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

	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Posts getPosts(@PathVariable String id) {
		Posts posts = new Posts();
		
		switch (id) {
		case "jdk-install":
			posts.setTitle("자바 설치");
			posts.setKeywords("JDK,Java 8");
			posts.setDescription("자바 설치에 대해 설명합니다.");
			posts.setContents("자바 설치하세요");
			break;
		default:
			posts.setTitle("title");
			posts.setKeywords("keywords");
			posts.setDescription("description");
			posts.setContents("contents");
		}
		
		return posts;
	}

}