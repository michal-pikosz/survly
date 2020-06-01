package pl.coderslab.survley.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import pl.coderslab.survley.Service.SurveyService;
import pl.coderslab.survley.dao.SurveyDao;
import pl.coderslab.survley.dao.SurveyFieldsDao;
import pl.coderslab.survley.entites.Survey;
import pl.coderslab.survley.entites.SurveyFields;

import javax.servlet.http.HttpServletRequest;
import java.util.Enumeration;
import java.util.List;

@Controller
public class SurveyController {

    private final SurveyService surveyService;
    private final SurveyDao surveyDao;
    private final SurveyFieldsDao surveyFieldsDao;

    public SurveyController(SurveyService surveyService, SurveyDao surveyDao, SurveyFieldsDao surveyFieldsDao) {
        this.surveyService = surveyService;
        this.surveyDao = surveyDao;
        this.surveyFieldsDao = surveyFieldsDao;
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
            SurveyFields surveyFields = new SurveyFields();
            surveyFields.setName(name);
            surveyFields.setValue(request.getParameter(name));
            surveyFields.setFields_group(lastId);
            surveyFields.setSurvey_id(Long.parseLong(id));
            surveyFieldsDao.add(surveyFields);

        }

        return "thankyoupage";
    }

    @PostMapping("/save")
    @ResponseBody
    public String saveForm(@RequestParam("form") String form) {
        long lastId = surveyFieldsDao.findLastGroupId() + 1;
        // Convert JSON to an object that can be saved to the database
        List<SurveyFields> formAnswers = surveyService.parseJsonRequest(form, lastId);
        // Saving results to the database
        for (SurveyFields answer : formAnswers) {
            surveyFieldsDao.add(answer);
        }
        return "BARDZO DOBRA ROBOTA!";
    }

    @GetMapping("/new")
    public String newForm() {
        return "new";
    }

    @GetMapping("/test")
    public String test() {
        return "index";
    }

    @GetMapping("/tagtest")
    public String tagtest() {
        return "adminindex";
    }
}
