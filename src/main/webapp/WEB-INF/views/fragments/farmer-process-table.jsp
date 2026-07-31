<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="process-section">
    <div class="process-card organic">
        <div class="card-header">
            <h3>🌱 Organic Process</h3>
            <span class="badge sustainable">SUSTAINABLE</span>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>Stage</th>
                    <th>Days</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${organicList}">
                <tr>
                    <td><strong>${o.stageName}</strong></td>
                    <td>${o.dayRange}</td>
                    <td>${o.description}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="process-card inorganic">
        <div class="card-header">
            <h3>🧪 Inorganic Process</h3>
            <span class="badge high-yield">HIGH YIELD</span>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th>Stage</th>
                    <th>Days</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="i" items="${inorganicList}">
                <tr>
                    <td><strong>${i.stageName}</strong></td>
                    <td>${i.dayRange}</td>
                    <td>${i.description}</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>