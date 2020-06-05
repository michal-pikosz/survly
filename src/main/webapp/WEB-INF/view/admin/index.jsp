<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<t:adminlayout>
    <jsp:body>
        <c:if test="${not empty flashMessage}">
            <div class="alert alert-primary" role="alert">
                    ${flashMessage}
            </div>
        </c:if>
        <h2>Lista ankiet</h2>
        <hr>
        <a href="/admin/survey/add" type="button" class="btn btn-primary">Dodaj nową ankietę</a>
        <div class="row mt-4">
            <div class="col-12">
                <div class="table-responsive">
                <table class="table table-striped ">
                    <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Nazwa</th>
                        <th scope="col">Link</th>
                        <th scope="col">Akcje</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="i" items="${Survey}">
                        <tr>
                            <th scope="row"><c:out value="${i.getId()}"/></th>
                            <th scope="row"><c:out value="${i.getName()}"/></th>
                            <th scope="row"><a target="_blank" href="/survey/${i.getId()}">/survey/${i.getId()}</a></th>
                            <th scope="col">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Akcje
                                    </button>
                                    <div class="dropdown-menu">
                                        <a class="dropdown-item" href="/admin/survey/${i.getId()}"><i class="fas fa-eye"></i> Edytuj</a>
                                        <a class="dropdown-item" href="/admin/survey/${i.getId()}/results"><i class="fas fa-eye"></i> Wyniki</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item text-danger" href="/admin/survey/delete/${i.getId()}"><i class="fas fa-trash-alt"></i> Usuń</a>
                                    </div>
                                </div>
                            </th>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                </div>
                <c:if test="${Survey.size() > 0 }">
                    <div class="panel-footer text-center mt-4 mb-4">
                        Pokazuje ${number+1} z ${totalPages} z ${totalElements}
                        <ul class="pagination justify-content-center">
                            <c:forEach begin="0" end="${totalPages-1}" var="page">
                                <li class="page-item">
                                    <a href="?page=${page}&size=${size}" class="page-link">${page+1}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>
        <hr>
    </jsp:body>
</t:adminlayout>


