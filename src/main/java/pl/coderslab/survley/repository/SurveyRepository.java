package pl.coderslab.survley.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;
import pl.coderslab.survley.entites.Survey;

import java.awt.print.Pageable;
import java.util.List;

@Repository
public interface SurveyRepository extends JpaRepository<Survey, Long> {
}
