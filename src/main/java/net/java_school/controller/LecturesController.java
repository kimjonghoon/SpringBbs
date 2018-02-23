package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LecturesController {

    @RequestMapping(value = "{category}/{lecture}", method = RequestMethod.GET)
    public String getPosts(@PathVariable String category, @PathVariable String lecture) {
        return category + "/" + lecture;
    }
}
