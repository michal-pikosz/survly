<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<t:adminlayout>
    <jsp:body>
        <div id="app">
            <h2 v-on:>Podgląd ankiety <span v-if="issaved === true" class="badge badge-secondary">Masz nie zapisane zmiany</span></h2>
            <!-- Button trigger modal -->
            <div class="actions mt-3">
                <a v-bind:href="'/admin/survey/' + id + '/results'" class="btn btn-info"><i class="fa fa-bars"></i> Zobacz wyniki</a>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addField"><i class="fa fa-bars"></i> Dodaj nowe pole</button>
                <button type="button" class="btn btn-success" v-on:click="save()"><i class="fa fa-save"></i> Zapisz</button>
            </div>
            <hr>

            <div>
                <p v-if="fields.length === 0">Brak pól w ankiecie, skorzystaj z przycisku "Dodaj nowe pole".</p>
                <div class="my-3" v-for="(field, index) in fields">
                    <button type="button" class="close" aria-label="Close" v-on:click="deleteElement(index)">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <span v-if="field.visibleif" class="badge badge-secondary">Istnieje logika: {{translateLogin(field.visibleif)}}</span> <button v-on:click="selectedSurveyField = index" type="button" class="btn btn-info" data-toggle="modal" data-target="#addLogic" style="float: right;z-index: 99;position: relative;">Dodaj logikę do pola</button>
                    <div v-if="field.type == 'text'">
                        <div class="form-group">
                            <label :for="field.name">{{ field.label }}</label>
                            <input :type="field.type" class="form-control" :name="field.name" :id="field.name" :aria-describedby="field.name">
                        </div>
                    </div>
                    <div v-if="field.type == 'checkbox'">
                        <div class="form-group form-check" style="padding-left: 0;">
                            <label class="form-check-label">{{field.label}}</label>
                            <div class="form-group">
                                <div class="form-check" v-if="field.options" v-for="(option, index) in field.options">
                                    <input :value="index" class="form-check-input" type="checkbox" :name="field.name + index" :id="field.name + index">
                                    <label class="form-check-label" :for="field.name + index">{{option}}</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div v-if="field.type == 'radio'">
                        <label class="form-check-label" :for="field.name">{{field.label}}</label>
                        <div class="form-group">
                            <div class="form-check" v-if="field.options" v-for="(option, index) in field.options">
                                <input class="form-check-input" type="radio" :name="field.name + index" :id="field.name + index">
                                <label class="form-check-label" :for="field.name + index">{{option}}</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dodaj pole -->
                <div class="modal fade" id="addField" tabindex="-1" role="dialog" aria-labelledby="addFieldLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addFieldLabel">Dodawanie nowego pola do formularza</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form v-on:submit.prevent="onSubmit">
                                    <div class="form-group">
                                        <label for="fieldType">Wybierz typ pola</label>
                                        <select required class="form-control" name="fieldType" id="fieldType" v-model="fieldType">
                                            <option value="text">Pole tekstowe</option>
                                            <option value="checkbox">Pole wielokrotnego wyboru</option>
                                            <option value="radio">Pole jednorazowego wyboru</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-check-label" for="fieldName">Podaj nazwę pola</label>
                                        <input required type="text" class="form-control" name="fieldLabel" id="fieldLabel" v-model="fieldLabel">
                                    </div>
                                    <div class="form-group" v-if="fieldType == 'radio' || fieldType == 'checkbox'">
                                        <label for="radioOptions">Podaj możliwe odpowiedzi</label>
                                        <textarea class="form-control" id="radioOptions" rows="5" name="radioOptions" v-model="fieldOptions"></textarea>
                                        <small id="radioOptions" class="form-text text-muted">Jedna opcja na linię (Shift + enter)</small>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Dodaj logikę -->
                <div class="modal fade" id="addLogic" tabindex="-1" role="dialog" aria-labelledby="addLogicLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addLogicLabel">Dodajesz logikę do pola {{selectedSurveyField}}</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form v-on:submit.prevent>
                                    <div class="form-group">
                                        <label for="surveyFieldSelect">Wybierz pole formularza na którego podstawie będzie tworzona logika</label>
                                        <select required v-model="surveyFieldSelect" class="form-control" id="surveyFieldSelect">
                                            <option v-for="(field, index) in fields" :value="index" v-if="index !== selectedSurveyField">{{field.label}}</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="surveyFieldSelect">Wybierz operator</label>
                                        <select required v-model="surveyFieldOperator" class="form-control" id="surveyFieldOperator">
                                            <option value="empty">puste</option>
                                            <option value="notempty">nie puste</option>
                                            <option value="=">równa się</option>
                                            <option value="<>">nie równa się</option>
                                            <option value="contains">zawiera</option>
                                            <option value="notcontains">nie zawiera</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <div v-if="surveyFieldSelect !== ''">
                                            <div v-if="surveyFieldOperator === '=' || surveyFieldOperator === '<>' || surveyFieldOperator === 'contains' || surveyFieldOperator === 'notcontains'">
                                                <p>Wartość do porównania</p>

                                                <div v-if="fields[surveyFieldSelect].type == 'text'">
                                                    <div class="form-group">
                                                        <input v-model="surveyFieldValue" type="text" class="form-control" :name="fields[surveyFieldSelect].name" :id="fields[surveyFieldSelect].name" :aria-describedby="fields[surveyFieldSelect].name">
                                                    </div>
                                                </div>
                                                <div v-if="fields[surveyFieldSelect].type == 'checkbox'">
                                                    <div class="form-group">
                                                        <div class="form-check" v-if="fields[surveyFieldSelect].options" v-for="(option, index) in fields[surveyFieldSelect].options">
                                                            <input :value="index" v-model="surveyFieldValue" class="form-check-input" type="checkbox" :name="fields[surveyFieldSelect].name + index" :id="fields[surveyFieldSelect].name + index">
                                                            <label class="form-check-label" :for="fields[surveyFieldSelect].name">{{option}}</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div v-if="fields[surveyFieldSelect].type == 'radio'">
                                                    <div class="form-group">
                                                        <div class="form-check" v-if="fields[surveyFieldSelect].options" v-for="(option, index) in fields[surveyFieldSelect].options">
                                                            <input :value="index" v-model="surveyFieldValue" class="form-check-input" type="radio" :name="fields[surveyFieldSelect].name" :id="fields[surveyFieldSelect].name">
                                                            <label class="form-check-label" :for="fields[surveyFieldSelect].name">{{option}}</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                        <button type="submit" v-on:click="onSubmitLogic()" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <script type="module" src="/resources/js/engine.js"></script>
        <hr>
    </jsp:body>
</t:adminlayout>


