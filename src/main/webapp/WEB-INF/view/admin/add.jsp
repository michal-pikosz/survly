<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<t:adminlayout>
    <jsp:body>
        <div  id="app">
        <h2>Dodawanie nowej ankiety</h2>
        <!-- Button trigger modal -->
        <div class="actions mt-3">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addField"><i class="fa fa-bars"></i> Dodaj nowe pole</button>
            <button type="button" class="btn btn-success" v-on:click="save()"><i class="fa fa-save"></i> Zapisz</button>
        </div>
        <hr>

        <div>
            <p v-if="fields.length === 0">Brak pól w ankiecie, skorzystaj z przycisku "Dodaj nowe pole".</p>
            <div v-for="(field, index) in fields">
                <button type="button" class="close" aria-label="Close" v-on:click="deleteElement(index)">
                    <span aria-hidden="true">&times;</span>
                </button>
                <div v-if="field.type == 'text'">
                    <div class="form-group">
                        <label :for="field.name">{{ field.label }}</label>
                        <input :type="field.type" class="form-control" :name="field.name" :id="field.name" :aria-describedby="field.name">
                    </div>
                </div>
                <div v-if="field.type == 'checkbox'">
                    <div class="form-group form-check">
                        <input :type="field.type" class="form-check-input" :name="field.name" :id="field.name">
                        <label class="form-check-label" :for="field.name">{{field.label}}</label>
                    </div>
                </div>
                <div v-if="field.type == 'radio'">
                    <label class="form-check-label" :for="field.name">{{field.label}}</label>
                    <div class="form-group">
                        <div class="form-check" v-if="field.options" v-for="option in field.options">
                            <input class="form-check-input" type="radio" :name="field.name" :id="field.name">
                            <label class="form-check-label" :for="field.name">{{option}}</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="addField" tabindex="-1" role="dialog" aria-labelledby="addFieldLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addFieldLabel">Dodaj nowe pole do formularza</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form v-on:submit.prevent="onSubmit">
                                <div class="form-group">
                                    <label for="fieldType">Wybierz typ pola</label>
                                    <select required class="form-control" name="fieldType" id="fieldType" v-model="fieldType">
                                        <option>text</option>
                                        <option>checkbox</option>
                                        <option>radio</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-check-label" for="fieldName">Podaj nazwę pola</label>
                                    <input required type="text" class="form-control" name="fieldLabel" id="fieldLabel" v-model="fieldLabel">
                                </div>
                                <div class="form-group" v-if="fieldType == 'radio'">
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

        </div>
        </div>
        <script  type="module"  src="/resources/js/engine.js"></script>
        <hr>
    </jsp:body>
</t:adminlayout>


