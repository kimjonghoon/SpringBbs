package net.java_school.java.spring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/java")
public class JavaController {

    @RequestMapping(method=RequestMethod.GET)
    public String index() {
        return "java/index";
    }
    
    @RequestMapping(value="/jdk-install", method=RequestMethod.GET)
    public String basic() {
        return "java/jdk-install";
    }

}