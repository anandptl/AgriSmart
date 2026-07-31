<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:forEach var="buyer" items="${buyersList}">
    <tr>
        <td>
            <div class="user-avatar">
                <c:choose>
                    <c:when test="${not empty buyer.profile and not empty buyer.profile.profilePhoto}">
                        <img src="/user/photo/${buyer.id}"
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
            <strong>${buyer.firstName} ${buyer.lastName}</strong><br>
            <small>${buyer.email}</small>
        </td>

        <td>
            <c:choose>
                <c:when test="${not empty buyer.activity and buyer.activity.block}">
                    <span class="status-blocked">BLOCKED</span>
                </c:when>
                <c:otherwise>
                    <span class="status-active">ACTIVE</span>
                </c:otherwise>
            </c:choose>
        </td>

        <td>
            <c:choose>
                <c:when test="${not empty buyer.activity and buyer.activity.block}">
                    <a href="/admin/user/unblock/${buyer.id}" class="btn-unblock">UNBLOCK</a>
                </c:when>
                <c:otherwise>
                    <a href="/admin/user/block/${buyer.id}" class="btn-block">BLOCK</a>
                </c:otherwise>
            </c:choose>
        </td>
    </tr>
</c:forEach>

<c:if test="${empty buyersList}">
    <tr>
        <td colspan="4" style="text-align:center;color:#777;">
            No buyers found
        </td>
    </tr>
</c:if>
