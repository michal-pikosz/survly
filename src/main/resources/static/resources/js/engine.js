import {surveyQuerysClass} from '/resources/js/surveyQuerys.js'; // Or it could be simply `hello.js`

const surveyQuerys = new surveyQuerysClass();

var app = new Vue({
    el: '#app',
    data: {
        issaved: false,
        id: "",
        name: "",
        fieldType: null,
        fieldLabel: null,
        fieldOptions: "",
        selectedSurveyField: "",
        surveyFieldSelect: "",
        surveyFieldOperator: "",
        surveyFieldValue: [],
        fields: []
    },
    methods: {
        onSubmit() {
            let newField = {
                "type": this.fieldType,
                "label": this.fieldLabel,
                "name": "pole" + new Date().valueOf(),
                "value": []
            };

            if (this.fieldOptions !== "") {
                newField.options = this.fieldOptions.split('\n').filter(x => x);
            }

            this.fields.push(newField);
            this.fieldType = null;
            this.fieldLabel = null;
            this.issaved = true;
            $('#addField').modal('hide');
        },
        onSubmitLogic() {
            if (!this.fields[this.selectedSurveyField]["visibleif"]) {
                this.fields[this.selectedSurveyField]["visibleif"] = "";
            }
            this.fields[this.selectedSurveyField]["visibleif"] = this.surveyFieldSelect + " " + this.surveyFieldOperator + " " + this.surveyFieldValue.toString();
            this.selectedSurveyField = "";
            this.surveyFieldSelect = "";
            this.surveyFieldOperator = "";
            this.surveyFieldValue = [];
            $('#addLogic').modal('hide');
        },
        deleteElement(id) {
            this.fields.splice(id, 1);
        },
        load() {
            let id = window.location.pathname.match(/survey\/(\d+)/);

            if (id) {
                this.id = id[1];
                surveyQuerys.getSurveyJson(this.id).then((res) => {
                    if (res === null) surveyQuerys.return404();
                    this.fields = JSON.parse(res.fields);
                    this.name = res.name;
                });
            }
        },
        save() {
            let that = this;
            surveyQuerys.askForSurveyName(that, this.name).then((result) => {

                if (!result.value) {
                    this.showMessage("error", "Pole nazwa nie może być puste :(", "");
                    return;
                }

                let fieldsJson = JSON.stringify(this.fields);

                if (this.id !== "") {
                    surveyQuerys.updateSurvey(this.id, fieldsJson, that).then(() => {
                        this.issaved = false;
                        this.showMessage("success", "Aktualizacja powiodła się", "");
                    });
                    return;
                }


                surveyQuerys.saveSurvey(fieldsJson, this.name).then(() => {
                    this.issaved = false;
                    this.showMessage("success", "Zapis powiódł się", "Za chwilę zostaniesz przekierowany na listę ankiet", () => {
                        window.location.replace("/admin/survey");
                        console.log("TUTAJ!");
                    });
                });

            })
        },
        showMessage(status, title, message, callback = () => {
        }) {
            Swal.fire({
                icon: status,
                title: title,
                text: message,
                confirmButtonText: 'Oki doki!'
            }).then((result) => callback());
        },
    },
    watch: {
        fieldType: function () {
            this.fieldOptions = "";
        },
        surveyFieldSelect: function () {
            this.surveyFieldValue = [];
        }
    },
    mounted() {
        this.load();
    }
});