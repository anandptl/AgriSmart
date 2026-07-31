<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty userList}">
    <p style="text-align:center;color:#777;">No users found</p>
</c:if>

<c:forEach var="ua" items="${userList}">
    <div class="user-item">

        <!-- Avatar -->
        <div class="user-avatar">
            <c:choose>
                <c:when test="${not empty ua.profile and not empty ua.profile.profilePhoto}">
                    <img src="/user/photo/${ua.id}"
                         class="profile-img-status"
                         alt="Profile Photo" />
                </c:when>
                <c:otherwise>
                    <i class="fa-solid fa-user"></i>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Info -->
        <div class="user-info">
            <h4>${ua.firstName} ${ua.lastName}</h4>
            <p>${ua.role}
                <c:if test="${not empty ua.activity}">
                    • ${ua.activity.lastSeenFormatted}
                </c:if>
            </p>
        </div>

        <!-- Status -->
        <c:choose>
            <c:when test="${not empty ua.activity and ua.activity.online}">
                <span class="status-badge online">
                    <span class="dot green"></span> ONLINE
                </span>
            </c:when>
            <c:otherwise>
                <span class="status-badge offline">
                    <span class="dot gray"></span> OFFLINE
                </span>
            </c:otherwise>
        </c:choose>

    </div>
</c:forEach>

