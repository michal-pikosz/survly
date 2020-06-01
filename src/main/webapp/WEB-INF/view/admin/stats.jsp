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
                            <c:forEach var="answers" items="${results}" begin="${biggest}" end="${biggest}">
                                <c:forEach var="answer" items="${answers}">
                                        <th scope="row"><c:out value="${answer[0]}"/></th>
                                </c:forEach>
                            </c:forEach>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" items="${ids}">
                            <tr>
                                <c:forEach var="answers" items="${results}">
                                    <c:forEach var="answer" items="${answers}">
                                        <c:if test="${answer[2] == i}">
                                            <th scope="row"><c:out value="${answer[1]}"/></th>
                                        </c:if>
                                    </c:forEach>
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


