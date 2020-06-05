<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>


<t:front>
    <jsp:body>
        <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <div class="container" id="app">
            <div class="row">
                <div class="col-12">
                    <img style="max-height: 150px;margin: 0 auto;display: block;" class="my-4" src="/resources/logo.png">
                    <h1>${survey.getName()}</h1>
                    <form id="survey" method="post" style="padding-bottom: 150px;">
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
                                    <div class="form-group form-check" style="padding-left: 0;">
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
                                    if (this.fields[fieldToCheck].value.toString() !== "") return false;
                                    break;
                                case "notempty":
                                    if (this.fields[fieldToCheck].value.toString() === "") return false;
                                    break;
                                case "=":
                                    if (this.fields[fieldToCheck].value.toString() !== value) return false;
                                    break;
                                case "<>":
                                    if (this.fields[fieldToCheck].value.toString() === value) return false;
                                    break;
                                case "contains":
                                    if (!this.fields[fieldToCheck].value.toString().includes(value)) return false;
                                    break;
                                case "notcontains":
                                    if (this.fields[fieldToCheck].value.toString().includes(value)) return false;
                                    break;
                            }
                        }
                        return true;
                    }
                }
            });
        </script>


        <script>
            $("form").submit(function(event){
                let list = [...new Set(document.querySelectorAll("input[type=checkbox]:checked"))];
                list.forEach((e) => {
                    let checked = Array.from(document.querySelectorAll('[name='+ e.name +']:checked'));
                    e.value = checked.map(el => el.value);
                })
            });
        </script>

        <style>
            .form-group > label {
                font-weight: bold;
            }
        </style>
    </jsp:body>
</t:front>


