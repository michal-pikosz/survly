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
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div v-for="(field, index) in fields">
                            <div v-if="field.type == 'text'">
                                <div class="form-group">
                                    <label :for="field.name">{{ field.label }}</label>
                                    <input value="" :type="field.type" class="form-control" :name="field.name" :id="field.name" :aria-describedby="field.name">
                                </div>
                            </div>
                            <div v-if="field.type == 'checkbox'">
                                <div class="form-group form-check">
                                    <input value="" :type="field.type" class="form-check-input" :name="field.name" :id="field.name">
                                    <label class="form-check-label" :for="field.name">{{field.label}}</label>
                                </div>
                            </div>
                            <div v-if="field.type == 'radio'">
                                <label class="form-check-label" :for="field.name">{{field.label}}</label>
                                <div class="form-group">
                                    <div class="form-check" v-if="field.options" v-for="option in field.options">
                                        <input value="true" class="form-check-input" type="radio" :name="field.name" :id="field.name">
                                        <label class="form-check-label" :for="field.name">{{option}}</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Wyślij</button>
                    </form>
                </div>
            </div>
        </div>
        <script !src="">
            new Vue({
                el: '#app',
                data: {
                    id: "",
                    name: "",
                    fields: ${survey.getFields()}
                }
            });
        </script>
    </jsp:body>
</t:front>


