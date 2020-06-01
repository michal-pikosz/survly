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
        <h2>Lista użytkowników</h2>
        <hr>
        <a href="/admin/users/add" type="button" class="btn btn-primary">Dodaj nowego użytkownika</a>
        <div class="row mt-4">
            <div class="col-12">
                <div class="table-responsive">
                    <table class="table table-striped ">
                        <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Nazwa</th>
                            <th scope="col">Akcje</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" items="${Users}">
                            <tr>
                                <th scope="row"><c:out value="${i.getId()}"/></th>
                                <th scope="row"><c:out value="${i.getUsername()}"/></th>
                                <th scope="row"><a class="dropdown-item text-danger" href="/admin/user/${i.getId()}/delete"><i class="fas fa-trash-alt"></i> Usuń</a></th>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <c:if test="${Users.size() > 0 }">
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


