package pl.coderslab.survley.entites;

import javax.persistence.*;

@Entity
public class SurveyFields {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private Long fields_group;
    private Long survey_id;
    private String name;
    private String value;

    public SurveyFields() {
    }

    public SurveyFields(Long fields_group, Long survey_id, String name, String value) {
        this.fields_group = fields_group;
        this.survey_id = survey_id;
        this.name = name;
        this.value = value;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getFields_group() {
        return fields_group;
    }

    public void setFields_group(Long fields_group) {
        this.fields_group = fields_group;
    }

    public Long getSurvey_id() {
        return survey_id;
    }

    public void setSurvey_id(Long survey_id) {
        this.survey_id = survey_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "SurveyFields{" +
                "id=" + id +
                ", survey_id=" + survey_id +
                ", name='" + name + '\'' +
                ", value='" + value + '\'' +
                '}';
    }
}
