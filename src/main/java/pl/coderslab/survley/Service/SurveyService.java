package pl.coderslab.survley.Service;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import pl.coderslab.survley.entites.SurveyFields;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Service
public class SurveyService {

    public List<SurveyFields> parseJsonRequest(String jsonString, Long formNumber) {
        
        List<SurveyFields> formAnswers = new ArrayList<>();

        JSONObject jsonObject = null;

        try {
            // Convert JSON string to object
            jsonObject = new JSONObject(jsonString);
        } catch (JSONException e) {
            e.printStackTrace();
        }

        // Exit if the string did not turn out to be JSON
        if (jsonObject == null) return null;

        // Creating an iterator that you can walk on
        Iterator<?> iterator = jsonObject.keys();

        while (iterator.hasNext()) {
            // Capture the JSON object key
            Object key = iterator.next(); // Iterate

            Object value = null;
            try {
                value = jsonObject.get(key.toString());
            } catch (JSONException e) {
                e.printStackTrace();
            }

            SurveyFields surveyFields = new SurveyFields();
            surveyFields.setName(key.toString());
            surveyFields.setValue(value != null ? value.toString() : null);
            surveyFields.setFields_group(formNumber);
            surveyFields.setSurvey_id(Long.parseLong("1"));

            formAnswers.add(surveyFields);
        }

        return formAnswers;
    }

}
