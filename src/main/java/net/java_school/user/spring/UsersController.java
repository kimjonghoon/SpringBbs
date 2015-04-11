package net.java_school.user.spring;

import java.security.Principal;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import net.java_school.commons.WebContants;
import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/users")
public class UsersController {
    
  @Autowired
  private UserService userService;

  @RequestMapping(value="/signUp", method=RequestMethod.GET)
  public String signUp() {
    return "users/signUp";
  }

  @RequestMapping(value="/signUp", method=RequestMethod.POST)
  public String signUp(User user) {
    String authority = "ROLE_USER";
    
    userService.addUser(user);
    userService.addAuthority(user.getEmail(), authority);
    
    return "redirect:/users/welcome";
  }

  @RequestMapping(value="/welcome", method=RequestMethod.GET)
  public String welcome() {
    return "users/welcome";
  }

  @RequestMapping(value="/login", method=RequestMethod.GET)
  public String login() {
    return "users/login";
  }
    
  @RequestMapping(value="/editAccount", method=RequestMethod.GET)
  public String editAccount(Principal principal, Model model) {
    User user = userService.getUser(principal.getName());
    model.addAttribute(WebContants.USER_KEY, user);
    
    return "users/editAccount";
  }
    
  @RequestMapping(value="/editAccount", method=RequestMethod.POST)
  public String editAccount(User user, Principal principal) {
    user.setEmail(principal.getName());

    int check = userService.editAccount(user);
    if (check < 1) {
    	throw new AccessDeniedException("현재 비밀번호가 틀립니다.");
    }
    
    return "redirect:/users/changePasswd";
        
  }
    
  @RequestMapping(value="/changePasswd", method=RequestMethod.GET)
  public String changePasswd(Principal principal, Model model) {
    User user = userService.getUser(principal.getName());
    
    model.addAttribute(WebContants.USER_KEY, user);
        
    return "users/changePasswd";
  }
    
  @RequestMapping(value="/changePasswd", method=RequestMethod.POST)
  public String changePasswd(String currentPasswd, String newPasswd, Principal principal) {
    int check = userService.changePasswd(currentPasswd, newPasswd, principal.getName());
    
    if (check < 1) {
        throw new AccessDeniedException("현재 비밀번호가 틀립니다.");
    } 
    
    return "redirect:/users/changePasswd_confirm";
        
  }
    
  @RequestMapping(value="/changePasswd_confirm", method=RequestMethod.GET)
  public String changePasswd_confirm() {
    return "users/changePasswd_confirm";
  }
    
  @RequestMapping(value="/bye", method=RequestMethod.GET)
  public String bye() {
    return "users/bye";
  }

  @RequestMapping(value="/bye", method=RequestMethod.POST)
  public String bye(String email, String passwd, HttpServletRequest req) 
		throws ServletException {
    
    User user = userService.login(email, passwd);
    userService.bye(user);
    req.logout();
    
    return "redirect:/users/bye_confirm";
  }

  @RequestMapping(value="/bye_confirm", method=RequestMethod.GET)
  public String bye_confirm() {
    return "users/bye_confirm";	  
  }
  
}