package net.java_school.controller;

import java.security.Principal;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.java_school.commons.WebContants;
import net.java_school.user.Password;
import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.context.MessageSource;

@Controller
@RequestMapping("/users")
public class UsersController {

    @Autowired
    private UserService userService;

    @Autowired
    private MessageSource messageSource;
    
    @RequestMapping(value = "/signUp", method = RequestMethod.GET)
    public String signUp(Model model) {
        model.addAttribute(WebContants.USER_KEY, new User());

        return "users/signUp";
    }

    @RequestMapping(value = "/signUp", method = RequestMethod.POST)
    public String signUp(@Valid User user, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "users/signUp";
        }

        String authority = "ROLE_USER";
        userService.addUser(user);
        userService.addAuthority(user.getEmail(), authority);

        return "redirect:/users/welcome";
    }

    @RequestMapping(value = "/welcome", method = RequestMethod.GET)
    public String welcome() {
        return "users/welcome";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "users/login";
    }

    @RequestMapping(value = "/editAccount", method = RequestMethod.GET)
    public String editAccount(Principal principal, Model model) {
        User user = userService.getUser(principal.getName());
        model.addAttribute(WebContants.USER_KEY, user);

        return "users/editAccount";
    }

    @RequestMapping(value = "/editAccount", method = RequestMethod.POST)
    public String editAccount(@Valid User user, BindingResult bindingResult, Principal principal, Locale locale) {

        if (bindingResult.hasErrors()) {
            return "users/editAccount";
        }

        user.setEmail(principal.getName());
        try {
            userService.editAccount(user);
        } catch (AccessDeniedException e) {
            String message =  messageSource.getMessage("passwd.incorrect", null, locale);
            throw new AccessDeniedException(message);
        }    

        return "redirect:/users/changePasswd";

    }

    @RequestMapping(value = "/changePasswd", method = RequestMethod.GET)
    public String changePasswd(Principal principal, Model model) {
        
        User user = userService.getUser(principal.getName());

        model.addAttribute(WebContants.USER_KEY, user);
        model.addAttribute("password", new Password());

        return "users/changePasswd";
    }

    @RequestMapping(value = "/changePasswd", method = RequestMethod.POST)
    public String changePasswd(@Valid Password password,
            BindingResult bindingResult,
            Model model,
            Principal principal,
            Locale locale) {

        if (bindingResult.hasErrors()) {
            User user = userService.getUser(principal.getName());
            model.addAttribute(WebContants.USER_KEY, user);

            return "users/changePasswd";
        }
        
        try {
            userService.changePasswd(password.getCurrentPasswd(), password.getNewPasswd(), principal.getName());
        } catch (AccessDeniedException e) {
            String message =  messageSource.getMessage("passwd.incorrect", null, locale);
            throw new AccessDeniedException(message);
        }    

        return "redirect:/users/changePasswd_confirm";

    }

    @RequestMapping(value = "/changePasswd_confirm", method = RequestMethod.GET)
    public String changePasswd_confirm() {
        return "users/changePasswd_confirm";
    }

    @RequestMapping(value = "/bye", method = RequestMethod.GET)
    public String bye() {
        return "users/bye";
    }

    @RequestMapping(value = "/bye", method = RequestMethod.POST)
    public String bye(String email, String passwd, HttpServletRequest req, Locale locale) throws ServletException {

        User user = new User();
        user.setEmail(email);
        user.setPasswd(passwd);
        try {
            userService.bye(user);
        } catch (AccessDeniedException e) {
            String message =  messageSource.getMessage("passwd.incorrect", null, locale);
            throw new AccessDeniedException(message);
        }

        req.logout();

        return "redirect:/users/bye_confirm";
    }

    @RequestMapping(value = "/bye_confirm", method = RequestMethod.GET)
    public String byeConfirm() {
        return "users/bye_confirm";
    }

}
