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
        editedField: "",
        surveyFieldSelect: "",
        surveyFieldOperator: "",
        surveyFieldValue: [],
        fields: []
    },
    methods: {
        openNewField() {
            this.fieldType = null;
            this.fieldLabel = null;
            this.editedField = "";
            $('#addField').modal('show');
        },
        onSubmit() {
            if(this.editedField === "") {

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

            } else {

                this.fields[this.editedField] = {
                    "type": this.fieldType,
                    "label": this.fieldLabel,
                    "name": this.fields[this.editedField].name,
                    "value": []
                };

                if (this.fieldOptions !== "") {
                    this.fields[this.editedField].options = this.fieldOptions.split('\n').filter(x => x);
                }

                this.fieldType = null;
                this.fieldLabel = null;
                this.fieldOptions = "";
                this.issaved = true;
            }

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
        editElement(id) {
            this.editedField = id;
            this.fieldType = this.fields[id].type;
            this.fieldLabel = this.fields[id].label;
            if(this.fields[id].options) {
                setTimeout(() => {this.fieldOptions = this.fields[id].options.join("\n")}, 0);
            }
            $('#addField').modal('show');
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
        translateLogin(logic) {
            let syntax = logic.split(" ");
            let fieldToCheck = syntax[0]; // pole np "0"
            let operator = syntax[1]; // empty, notempty, =, <>, contains, notcontains
            let value = "";

            if (syntax[2]) {
                value = syntax[2];
            }

            switch (operator) {
                case "empty":
                    return "pole o nazwie \"" + this.fields[fieldToCheck].label + "\" musi być puste";
                    break;
                case "notempty":
                    return "pole o nazwie \"" + this.fields[fieldToCheck].label + "\" nie może być puste";
                    break;
                case "=":
                    return "pole o nazwie \"" + this.fields[fieldToCheck].label + "\" musi być równe " + value;
                    break;
                case "<>":
                    return "pole o nazwie \"" + this.fields[fieldToCheck].label + "\" nie może być równe " + value;
                    break;
                case "contains":
                    return "pole o nazwie \"" + this.fields[fieldToCheck].label + "\" nie musi zawierać " + value;
                    break;
                case "notcontains":
                    return "pole o nazwie \"" + this.fields[fieldToCheck].label + "\" nie może zawierać " + value;
                    break;
            }
        }
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