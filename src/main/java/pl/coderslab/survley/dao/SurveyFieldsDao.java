package pl.coderslab.survley.dao;

import org.springframework.stereotype.Component;
import pl.coderslab.survley.repository.SurveyFieldsRepository;
import pl.coderslab.survley.entites.SurveyFields;

@Component
public class SurveyFieldsDao {
    private SurveyFieldsRepository repository;

    public SurveyFieldsDao(SurveyFieldsRepository surveyRepository) {
        this.repository = surveyRepository;
    }

    public void add(SurveyFields surveyFields) {
        repository.save(surveyFields);
    }

    public Long findLastGroupId() {
        Long group = repository.findMaxGroupId();
        if (group == null) group = 1L;
        return group + 1;
    }
}
