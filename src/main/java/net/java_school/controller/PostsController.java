package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PostsController {

	@RequestMapping(value="{category}/{posts}", method=RequestMethod.GET)
	public String getPosts(@PathVariable String category, @PathVariable String posts) {
		return category + "/" + posts;
	}
	@RequestMapping(value="{category}", method=RequestMethod.GET)
	public String getIndex(@PathVariable String category) {
		return category + "/index";
	}
}