package pl.coderslab.survley.controllers;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import pl.coderslab.survley.Service.SecurityService;
import pl.coderslab.survley.Service.UserService;
import pl.coderslab.survley.entites.SurveyFields;
import pl.coderslab.survley.entites.User;
import pl.coderslab.survley.repository.SurveyFieldsRepository;
import pl.coderslab.survley.repository.SurveyRepository;
import pl.coderslab.survley.dao.SurveyDao;
import pl.coderslab.survley.entites.Survey;
import pl.coderslab.survley.repository.UserRepository;
import pl.coderslab.survley.validator.UserValidator;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

import static java.util.stream.Collectors.toList;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final SurveyDao surveyDao;
    private final SurveyRepository surveyRepository;
    private final UserRepository userRepository;
    private final SurveyFieldsRepository surveyFieldsRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private SecurityService securityService;

    @Autowired
    private UserValidator userValidator;

    public AdminController(SurveyDao surveyDao, SurveyRepository surveyRepository, UserRepository userRepository, SurveyFieldsRepository surveyFieldsRepository) {
        this.surveyDao = surveyDao;
        this.surveyRepository = surveyRepository;
        this.userRepository = userRepository;
        this.surveyFieldsRepository = surveyFieldsRepository;
    }

    @GetMapping("/survey")
    public String index(Model model, @RequestParam(required = false, defaultValue="0") String page, @RequestParam(required = false, defaultValue="10") String size) {
        Pageable firstPageWithTwoElements = PageRequest.of(Integer.parseInt(page), Integer.parseInt(size));
        Page<Survey> all = this.surveyRepository.findAll(firstPageWithTwoElements);
        model.addAttribute("Survey", all.getContent());
        model.addAttribute("number", all.getNumber());
        model.addAttribute("totalPages", all.getTotalPages());
        model.addAttribute("totalElements", all.getTotalElements());
        model.addAttribute("size", all.getSize());
        return "admin/index";
    }

    @GetMapping("/survey/add")
    public String surveyAdd() {
        return "admin/add";
    }

    @PostMapping("/survey/save")
    @ResponseBody
    public String surveySave(@RequestParam("form") String form, @RequestParam("name") String name) {
        Survey survey = new Survey();
        survey.setName(name);
        survey.setFields(form);
        surveyDao.add(survey);
        return "ok";
    }

    @GetMapping("/survey/{id}")
    public String surveyView(@PathVariable String id) {
        return "admin/view";
    }

    @GetMapping(value = "/survey/{id}/json", produces = {"application/json"})
    @ResponseBody
    public String surveyViewJson(@PathVariable String id) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        Survey survey = surveyDao.find(Long.parseLong(id));
        return objectMapper.writeValueAsString(survey);
    }

    @PutMapping("/survey/{id}")
    @ResponseStatus(HttpStatus.CREATED)
    @ResponseBody
    public String surveyView(@RequestParam("form") String form, @RequestParam("name") String name, @PathVariable String id) {
        Survey survey = surveyDao.find(Long.parseLong(id));
        survey.setFields(form);
        survey.setName(name);
        surveyDao.update(survey);
        return "ok";
    }

    @RequestMapping("/survey/delete/{id}")
    public String deleteAuthor(RedirectAttributes redirAttrs, @PathVariable long id) {
        Survey survey = surveyDao.find(id);
        surveyDao.delete(survey);
        redirAttrs.addFlashAttribute("flashMessage", "Ankieta została usunięta");
        return "redirect:" + "/admin/survey";
    }

    @GetMapping("/survey/{id}/results")
    public String surveyViewResults(@PathVariable Long id, Model model) {

        List<BigInteger> ids = surveyDao.getResultsIds(id);
        List<SurveyFields> allSurveyFields = surveyFieldsRepository.findAllByWhereId(id);

        List<String> tableHeader = allSurveyFields.stream()
                .map(SurveyFields::getName)
                .distinct()
                .collect(toList());



        model.addAttribute("ids", ids);
        model.addAttribute("tableHeader", tableHeader);
        model.addAttribute("allSurveyFields", allSurveyFields);
        return "admin/stats";
    }


    @GetMapping("/users")
    public String getUsers(Model model, @RequestParam(required = false, defaultValue="0") String page, @RequestParam(required = false, defaultValue="10") String size) {
        Pageable firstPageWithTwoElements = PageRequest.of(Integer.parseInt(page), Integer.parseInt(size));
        Page<User> all = userRepository.findAll(firstPageWithTwoElements);
        model.addAttribute("Users", all.getContent());
        model.addAttribute("number", all.getNumber());
        model.addAttribute("totalPages", all.getTotalPages());
        model.addAttribute("totalElements", all.getTotalElements());
        model.addAttribute("size", all.getSize());
        return "admin/user/index";
    }

    @GetMapping("/users/add")
    public String registration(Model model) {
        model.addAttribute("userForm", new User());
        return "admin/user/registration";
    }

    @PostMapping("/users/add")
    public String registration(@ModelAttribute("userForm") User userForm, BindingResult bindingResult) {
        userValidator.validate(userForm, bindingResult);

        if (bindingResult.hasErrors()) {
            return "admin/user/registration";
        }

        userService.save(userForm);

        return "redirect:/admin/users";
    }

    @GetMapping("/user/{id}/delete")
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirAttrs) {
        User user = userRepository.findUserById(id);
        userRepository.delete(user);
        redirAttrs.addFlashAttribute("flashMessage", "Użytkownik został usunięty");
        return "redirect:" + "/admin/users";
    }

}
