package net.java_school.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class ExampleController {

    private static final String FILE_DIR = "/resources/";

    @GetMapping("/{chapter}/examples/{filename:.+}")
    public String download(@PathVariable String chapter, @PathVariable String filename) {

    	return "redirect:" + FILE_DIR + chapter + "/examples/" + filename; 
                
    }

}
