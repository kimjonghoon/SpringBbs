package net.java_school.javascript.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/javascript")
public class JavascriptController {

    @RequestMapping(method=RequestMethod.GET)
    public String index() {
        return "javascript/index";
    }
    
}