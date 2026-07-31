<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:forEach var="farmer" items="${farmersList}">
    <tr>
        <td>
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty farmer.profile and not empty farmer.profile.profilePhoto}">
                        <img src="/user/photo/${farmer.id}"
                             class="profile-img-status"
                             alt="Profile Photo" />
                    </c:when>
                    <c:otherwise>
                        <i class="fa-solid fa-user"></i>
                    </c:otherwise>
                </c:choose>
            </div>
        </td>

        <td>
            <strong>${farmer.firstName} ${farmer.lastName}</strong><br>
            <small>${farmer.email}</small>
        </td>

        <td>
            <c:choose>
                <c:when test="${not empty farmer.activity and farmer.activity.block}">
                    <span class="status-blocked">BLOCKED</span>
                </c:when>
                <c:otherwise>
                    <span class="status-active">ACTIVE</span>
                </c:otherwise>
            </c:choose>
        </td>

        <td>
            <c:choose>
                <c:when test="${not empty farmer.activity and farmer.activity.block}">
                    <a href="/admin/user/unblock/${farmer.id}" class="btn-unblock">UNBLOCK</a>
                </c:when>
                <c:otherwise>
                    <a href="/admin/user/block/${farmer.id}" class="btn-block">BLOCK</a>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>

<c:if test="${empty farmersList}">
    <tr>
        <td colspan="4" style="text-align:center;color:#777;">
            No farmers found
        </td>
    </tr>
</c:if>
