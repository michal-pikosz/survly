export class surveyQuerysClass {

    return404() {
        window.location.href = "/404";
    }

    getSurveyJson(id) {
        return $.getJSON(`/admin/survey/${id}/json`);
    }

    saveSurvey(fieldsJson, name) {
        return $.post("/admin/survey/save", {"form": fieldsJson, "name": name});
    }

    updateSurvey(id, fieldsJson, scope) {
        return $.ajax({
            url: `/admin/survey/${scope.id}`,
            data: {"form": fieldsJson, "name": scope.name, "id": scope.id},
            type: 'PUT',
        });
    }

    askForSurveyName(scope, name) {
        return Swal.fire({
            title: 'Podaj nazwę ankiety',
            input: 'text',
            inputValue: name,
            inputAttributes: { autocapitalize: 'off'},
            confirmButtonText: 'Zapisz',
            showLoaderOnConfirm: true,
            preConfirm: (login) => { scope.name = login; },
            allowOutsideClick: () => !Swal.isLoading()
        });
    }

}