package pl.coderslab.survley.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.survley.Service.SurveyService;
import pl.coderslab.survley.Service.UserService;
import pl.coderslab.survley.dao.SurveyDao;
import pl.coderslab.survley.dao.SurveyFieldsDao;
import pl.coderslab.survley.entites.Survey;
import pl.coderslab.survley.entites.SurveyFields;
import pl.coderslab.survley.entites.User;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;

@Controller
public class SurveyController {

    private final SurveyService surveyService;
    private final SurveyDao surveyDao;
    private final SurveyFieldsDao surveyFieldsDao;
    private final UserService userService;

    public SurveyController(SurveyService surveyService, SurveyDao surveyDao, SurveyFieldsDao surveyFieldsDao, UserService userService) {
        this.surveyService = surveyService;
        this.surveyDao = surveyDao;
        this.surveyFieldsDao = surveyFieldsDao;
        this.userService = userService;
    }

    @GetMapping("/survey/{id}")
    public String showSurvey(@PathVariable Long id, Model model) {
        Survey survey = surveyDao.find(id);
        if (survey == null) {
            return "redirect:" + "/404";
        }
        model.addAttribute("survey", survey);
        return "show";
    }

    @PostMapping("/survey/{id}")
    public String postSurvey(HttpServletRequest request, @PathVariable String id) {
        Enumeration e = request.getParameterNames();
        StringBuilder result = new StringBuilder();
        long lastId = surveyFieldsDao.findLastGroupId();

        while (e.hasMoreElements()) {

            String name = (String) e.nextElement();

            if (!name.equals("_csrf")) {
                SurveyFields surveyFields = new SurveyFields();
                surveyFields.setName(name);
                surveyFields.setValue(request.getParameter(name));
                surveyFields.setFields_group(lastId);
                surveyFields.setSurvey_id(Long.parseLong(id));
                surveyFieldsDao.add(surveyFields);
            }

        }

        return "thankyoupage";
    }

    @GetMapping("/makeadmin")
    @ResponseBody
    public String registration() {
        User user = new User();
        user.setUsername("admin00");
        user.setPassword("admin00");
        userService.save(user);
        return "OK";
    }
}
