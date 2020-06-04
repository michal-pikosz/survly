package pl.coderslab.survley.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import pl.coderslab.survley.entites.SurveyFields;

public interface SurveyFieldsRepository extends JpaRepository<SurveyFields, Long> {

    @Query("SELECT max(e.fields_group) from SurveyFields e")
    Long findMaxGroupId();



}
