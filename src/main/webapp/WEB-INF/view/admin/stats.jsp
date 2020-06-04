<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<t:adminlayout>
    <jsp:body>
        <c:if test="${not empty flashMessage}">
            <div class="alert alert-primary" role="alert">
                    ${flashMessage}
            </div>
        </c:if>
        <h2>Wyniki</h2>
        <hr>
        <div class="row mt-4">
            <div class="col-12">
                <div class="table-responsive">
                    <c:if test="${fn:length(ids) == 0}">
                        <p>Jeszcze nikt nie wypełnił ankiety</p>
                    </c:if>
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <c:forEach var="headerColumn" items="${tableHeader}">
                                <th scope="row"><c:out value="${headerColumn}"/></th>
                            </c:forEach>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="id" items="${ids}">
                            <tr>
                                <c:forEach var="headerColumn" items="${tableHeader}">

                                    <th scope="row">

                                    <c:forEach var="surveyField" items="${allSurveyFields}">

                                        <c:if test="${surveyField.getFields_group() == id}">

                                            <c:if test="${surveyField.getName() == headerColumn}"><c:out value="${surveyField.getValue()}"/></c:if>

                                        </c:if>

                                    </c:forEach>

                                    </th>

                                </c:forEach>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <hr>
        <style>
            .table td, .table th {
                padding: .75rem;
                vertical-align: top;
                border-top: 1px solid #fff;
            }
        </style>
    </jsp:body>
</t:adminlayout>


