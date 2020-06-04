package pl.coderslab.survley.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import pl.coderslab.survley.entites.SurveyFields;

import java.awt.print.Book;
import java.util.List;

public interface SurveyFieldsRepository extends JpaRepository<SurveyFields, Long> {

    @Query("SELECT max(e.fields_group) from SurveyFields e")
    Long findMaxGroupId();

    @Query("select b from SurveyFields b where b.survey_id = ?1")
    List<SurveyFields> findAllByWhereId(Long id);

}
