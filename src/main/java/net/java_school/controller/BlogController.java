package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class BlogController {
	
	@GetMapping("/blog")
	public String blogIndex() {
		return "blog";
	}

	@GetMapping("blog/{year}/{article}")
	public String getBlog(@PathVariable String year, @PathVariable String article) {
		return "blog/" + year + "/" + article;
	}
	
}
