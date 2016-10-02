package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class HomeController {

	@RequestMapping(method=RequestMethod.GET)
	public String index() {
		return "index";
	}

	@RequestMapping(value="/403", method={RequestMethod.GET,RequestMethod.POST})
	public String error403() {
		return "403";
	}

}