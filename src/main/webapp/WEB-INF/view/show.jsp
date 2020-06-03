<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:front>
    <jsp:body>
        <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
        <div class="container" id="app">
            <div class="row">
                <div class="col-12">
                    <img style="max-height: 150px;margin: 0 auto;display: block;" class="my-4" src="/resources/logo.png">
                    <form method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div v-for="(field, index) in fields">
                            <div v-show="validate(field, index)">
                                <div v-if="field.type == 'text'">
                                    <div class="form-group">
                                        <label :for="field.name">{{ field.label }}</label>
                                        <input v-model="field.value" value="" :type="field.type" class="form-control" :name="field.name" :id="field.name" :aria-describedby="field.name">
                                    </div>
                                </div>
                                <div v-if="field.type == 'checkbox'">
                                    <div class="form-group form-check" style="padding-left: 0;">
                                        <label class="form-check-label" :for="field.name">{{field.label}}</label>
                                        <div class="form-group">
                                            <div class="form-check" v-if="field.options" v-for="(option, index) in field.options">
                                                <input v-model="field.value" :value="index" class="form-check-input" type="checkbox" :name="field.name" :id="field.name">
                                                <label class="form-check-label" :for="field.name">{{option}}</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div v-if="field.type == 'radio'">
                                    <label class="form-check-label" :for="field.name">{{field.label}}</label>
                                    <div class="form-group">
                                        <div class="form-check" v-if="field.options" v-for="(option, index) in field.options">
                                            <input v-model="field.value" :value="index" class="form-check-input" type="radio" :name="field.name" :id="field.name">
                                            <label class="form-check-label" :for="field.name">{{option}}</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Wyślij</button>
                    </form>
                </div>
            </div>
        </div>
        <script>
            new Vue({
                el: '#app',
                data: {
                    id: "",
                    name: "",
                    fields: ${survey.getFields()}
                        // {
                        //     "type": "text",
                        //     "label": "Pole 0",
                        //     "name": "pole1",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "checkbox",
                        //     "label": "Pole 0 empty",
                        //     "name": "pole1",
                        //     "visibleif": "0 empty",
                        //     "value": [],
                        //     "options": [
                        //         "opcja1",
                        //         "opcja2",
                        //         "opcja3"
                        //     ]
                        // },
                        // {
                        //     "type": "text",
                        //     "label": "Pole 0 notempty",
                        //     "visibleif": "0 notempty",
                        //     "name": "pole2",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "text",
                        //     "label": "Pole 0 równa się (=) pupa",
                        //     "visibleif": "0 = pupa",
                        //     "name": "pole2",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "text",
                        //     "label": "Pole 0 nie równa się (!==) pupa",
                        //     "visibleif": "0 <> pupa",
                        //     "name": "pole2",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "text",
                        //     "label": "Pole 0 nie zawiera (includes) pupa",
                        //     "visibleif": "0 contains pupa",
                        //     "name": "pole2",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "text",
                        //     "label": "Pole 0 nie zawiera (includes) pupa",
                        //     "visibleif": "0 notcontains pupa",
                        //     "name": "pole2",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "text",
                        //     "label": "Pole 1 równa się (includes) 0,1",
                        //     "visibleif": "1 = 0,1",
                        //     "name": "pole2",
                        //     "value": ""
                        // },
                        // {
                        //     "type": "radio",
                        //     "label": "Pole radio",
                        //     "name": "pole3",
                        //     "value": "",
                        //     "options": [
                        //         "opcja1",
                        //         "opcja2",
                        //         "opcja3"
                        //     ]
                        // }
                },
                methods: {
                    validate(field, index) {
                        if (field.visibleif) {

                            let syntax = field.visibleif.split(" ");
                            let fieldToCheck = syntax[0]; // pole np "0"
                            let operator = syntax[1]; // empty, notempty, =, <>, contains, notcontains
                            let value = "";

                            if (syntax[2]) {
                                value = syntax[2];
                            }

                            switch (operator) {
                                case "empty":
                                    if(this.fields[fieldToCheck].value.toString() !== "") return false;
                                    break;
                                case "notempty":
                                    if(this.fields[fieldToCheck].value.toString() === "") return false;
                                    break;
                                case "=":
                                    if(this.fields[fieldToCheck].value.toString() !== value) return false;
                                    break;
                                case "<>":
                                    if(this.fields[fieldToCheck].value.toString() === value) return false;
                                    break;
                                case "contains":
                                    if(!this.fields[fieldToCheck].value.toString().includes(value)) return false;
                                    break;
                                case "notcontains":
                                    if(this.fields[fieldToCheck].value.toString().includes(value)) return false;
                                    break;
                            }
                        }
                        return true;
                    }
                }
            });
        </script>
    </jsp:body>
</t:front>


