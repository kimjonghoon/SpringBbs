package net.java_school.user.spring;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.java_school.commons.WebContants;
import net.java_school.exception.AuthenticationException;
import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    userService.addUser(user);
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
    
  @RequestMapping(value="/login", method=RequestMethod.POST)
  public String login(String email, String passwd, String url, HttpSession session) {
    User user = userService.login(email, passwd);
        
    if (user == null) {
      return "redirect:/users/login?url=" + url + "&msg=Login-Failed";
    } else {
      session.setAttribute(WebContants.USER_KEY, user);
      if (!url.equals("")) {
        return "redirect:" + url;
      }
      
      return "redirect:/";
    }
        
  }
        
  @RequestMapping(value="/editAccount", method=RequestMethod.GET)
  public String editAccount(HttpServletRequest req, HttpSession session) throws Exception {
    User user = (User) session.getAttribute(WebContants.USER_KEY);

    if (user == null) {
       //로그인 후 다시 돌아오기 위해
      String url = req.getServletPath();
      String query = req.getQueryString();
      if (query != null) url += "?" + query;
       //로그인 페이지로 리다이렉트
      url = URLEncoder.encode(url, "UTF-8");
      return "redirect:/users/login?url=" + url;
    }

    return "users/editAccount";
  }
    
  @RequestMapping(value="/editAccount", method=RequestMethod.POST)
  public String editAccount(User user, HttpSession session) {
    User loginUser = (User) session.getAttribute(WebContants.USER_KEY);
    if (loginUser == null) {
      throw new AuthenticationException(WebContants.NOT_LOGIN);
    }

    if (userService.login(loginUser.getEmail(), user.getPasswd()) == null) {
      throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
    }

    user.setEmail(loginUser.getEmail());
        
    int check = userService.editAccount(user);
    if (check > 0) {
      session.setAttribute(WebContants.USER_KEY, user);
      return "users/changePasswd";
    } else {
      throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
    }
        
  }
    
  @RequestMapping(value="/changePasswd", method=RequestMethod.GET)
  public String changePasswd(HttpServletRequest req, HttpSession session) throws Exception {
    User user = (User) session.getAttribute(WebContants.USER_KEY);
        
    if (user == null) {
       //로그인 후 다시 돌아오기 위해
      String url = req.getServletPath();
      String query = req.getQueryString();
      if (query != null) url += "?" + query;
       //로그인 페이지로 리다이렉트
      url = URLEncoder.encode(url, "UTF-8");
      
      return "redirect:/users/login?url=" + url;     
    }
        
    return "users/changePasswd";
  }
    
  @RequestMapping(value="/changePasswd", method=RequestMethod.POST)
  public String changePasswd(String currentPasswd, String newPasswd, HttpSession session) {
    String email = ((User)session.getAttribute(WebContants.USER_KEY)).getEmail();
        
    int check = userService.changePasswd(currentPasswd, newPasswd, email);
    if (check > 0) {
      return "redirect:/users/changePasswd_confirm";
    } else {
      return "redirect:/users/changePasswd?msg=fail";
    }
        
  }
    
  @RequestMapping(value="/changePasswd_confirm", method=RequestMethod.GET)
  public String changePasswd_confirm() {
    return "users/changePasswd_confirm";
  }
    
  @RequestMapping(value="/bye", method=RequestMethod.GET)
  public String bye(HttpServletRequest req, HttpSession session) throws Exception {
    User user = (User)session.getAttribute(WebContants.USER_KEY);
        
    if (user == null) {
       //로그인 후 다시 돌아오기 위해
      String url = req.getServletPath();
      String query = req.getQueryString();
      if (query != null) url += "?" + query;
       //로그인 페이지로 리다이렉트
      url = URLEncoder.encode(url, "UTF-8");
      
      return "redirect:/users/login?url=" + url;     
    }
        
    return "users/bye";
  }

  @RequestMapping(value="/bye", method=RequestMethod.POST)
  public String bye(String email, String passwd, HttpSession session) {
    User user = (User)session.getAttribute(WebContants.USER_KEY);

    if (user == null || !user.getEmail().equals(email)) {
    	throw new AuthenticationException(WebContants.AUTHENTICATION_FAILED);
    }
    
    userService.bye(email, passwd);
    session.removeAttribute(WebContants.USER_KEY);
    
    return "redirect:/users/bye_confirm";
  }

  @RequestMapping(value="/bye_confirm", method=RequestMethod.GET)
  public String bye_confirm() {
    return "users/bye_confirm";	  
  }
  
  @RequestMapping(value="/logout", method=RequestMethod.GET)
  public String logout(HttpSession session) {
    session.removeAttribute(WebContants.USER_KEY);

    return "redirect:/";

  }

}