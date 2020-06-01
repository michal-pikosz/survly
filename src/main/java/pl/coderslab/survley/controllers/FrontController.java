package pl.coderslab.survley.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FrontController {
    @GetMapping("/404")
    public String notFound() {
        return "notfound";
    }

    @GetMapping("/")
    public String home() {
        return "index";
    }
}
