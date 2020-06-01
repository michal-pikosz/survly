package pl.coderslab.survley.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import pl.coderslab.survley.entites.Survey;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.math.BigInteger;
import java.util.List;

@Repository
@Transactional
public class SurveyDao {

    @PersistenceContext
    EntityManager entityManager;

    public void add(Survey survey) {
        entityManager.persist(survey);
    }

    public Survey find(Long id) {
        return entityManager.find(Survey.class, id);
    }

    public void update(Survey survey) {
        entityManager.merge(survey);
    }

    public List<Survey> findAll() {
        Query query = entityManager.createQuery("SELECT a FROM Survey a");
        return query.getResultList();
    }

    public void delete(Survey survey) {
        Survey toDelete = entityManager.contains(survey) ? survey : entityManager.merge(survey);
        entityManager.remove(toDelete);
    }

    public List<BigInteger> getResultsIds(long id) {
        Query q = entityManager.createNativeQuery("select fields_group from survey_fields where survey_id = ?1 group by fields_group");
        q.setParameter(1, id);
        return q.getResultList();
    }

    public List<Object[]> getResultValues(BigInteger id) {
        Query q = entityManager.createNativeQuery("SELECT name, value, fields_group from survey_fields where fields_group = ?1");
        q.setParameter(1, id);
        List<Object[]> objects = q.getResultList();
        return objects;
    }



}
