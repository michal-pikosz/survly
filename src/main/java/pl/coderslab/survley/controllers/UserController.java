package pl.coderslab.survley.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.survley.Service.SecurityService;
import pl.coderslab.survley.Service.UserService;
import pl.coderslab.survley.entites.User;
import pl.coderslab.survley.validator.UserValidator;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    @GetMapping("/login")
    public String login(Model model, String error, String logout) {
        if (error != null)
            model.addAttribute("error", "Nazwa użytkownika lub hasło jest nie prawidłowe");

        if (logout != null)
            model.addAttribute("message", "Zostałeś pomyślnie wylogowany");

        return "login";
    }
}
