<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="cropTable" class="table-container">
    <table class="styled-table">
        <thead>
            <tr>
                <th><i class="fa-solid fa-leaf"></i> Crop Name</th>
                <th><i class="fa-solid fa-tags"></i> Category</th>
                <th><i class="fa-solid fa-cloud-sun"></i> Season</th>
                <th><i class="fa-solid fa-mountain"></i> Soil Type</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="crop" items="${cropList}">
                <tr>
                    <td><strong>${crop.cropName}</strong></td>
                    <td><span class="badge">${crop.category}</span></td>
                    <td>${crop.season}</td>
                    <td>${crop.soilType}</td>
                </tr>
            </c:forEach>

            <c:if test="${empty cropList}">
                <tr>
                    <td colspan="4" class="no-data">
                        <i class="fa-solid fa-circle-exclamation"></i> No Crops Found for this category
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>