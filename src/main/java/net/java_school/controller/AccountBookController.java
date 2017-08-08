package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/account-book")
public class AccountBookController {

	@RequestMapping(method=RequestMethod.GET)
	public String index() {
		return "account-book/index";
	}
}
