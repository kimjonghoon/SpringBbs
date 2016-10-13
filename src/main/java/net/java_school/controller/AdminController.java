package net.java_school.controller;

import java.util.List;

import net.java_school.commons.NumbersForPagingProcess;
import net.java_school.commons.Paginator;
import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController extends Paginator {

	@Autowired
	private UserService userService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String index(Integer page, String search, Model model) {
		if (page == null) page = 1;

		int numPerPage = 10;
		int pagePerBlock = 10;
		
		int totalRecord = userService.getTotalCount(search);
		NumbersForPagingProcess numbers = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);
		Integer startRecord = numbers.getStartRecord();
		Integer endRecord = numbers.getEndRecord();
		List<User> list = userService.getAllUser(search, startRecord, endRecord);
		
		Integer listItemNo = numbers.getListItemNo();
		Integer prev = numbers.getPrevBlock();
		Integer next = numbers.getNextBlock();
		Integer firstPage = numbers.getFirstPage();
		Integer lastPage = numbers.getLastPage();
		
		model.addAttribute("list", list);
		model.addAttribute("listItemNo", listItemNo);
		model.addAttribute("prev", prev);
		model.addAttribute("nexte", next);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		
		return "admin/index";
	}


}