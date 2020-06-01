package pl.coderslab.survley.entites;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "survey")
public class Survey {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private String name;
    @Column(columnDefinition = "TEXT")
    private String fields;

    @OneToMany(mappedBy = "survey_id")
    private Set<SurveyFields> surveyFields;

    public Survey() {
    }

    public Survey(String name, String fields) {
        this.name = name;
        this.fields = fields;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFields() {
        return fields;
    }

    public void setFields(String fields) {
        this.fields = fields;
    }

    @Override
    public String toString() {
        return "Survey{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", fields='" + fields + '\'' +
                '}';
    }
}
