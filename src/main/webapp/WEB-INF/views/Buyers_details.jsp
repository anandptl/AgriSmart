<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AgriSmart | Farmer Details</title>
    <link rel="stylesheet" href="/css/buyers-farmer-details.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
    <div class="dashboard">

        <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login" );
            return; } %>

            <button class="toggle-btn" onclick="toggleSidebar()">
                <i class="fa-solid fa-bars"></i>
            </button>

            <!-- Sidebar -->
            <aside class="sidebar">
                <div class="brand">
                    <i class="fa-solid fa-seedling"></i>
                    <span>AgriSmart</span>
                </div>

                <div class="user">
                    <div class="profile-photo-img">
                        <c:choose>
                            <c:when test="${not empty profile and not empty profile.profilePhoto}">
                                <img id="previewImg" class="profile-img" src="/user/photo/${profile.user.id}"
                                    alt="Profile Photo">
                            </c:when>
                            <c:otherwise>
                                <div class="avatar"><i class="fa-solid fa-user"></i></div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h3>${user.firstName} ${user.lastName}</h3>
                    <p>${profile.phone}</p>
                </div>

                <ul class="menu">
                    <a href="/buyer-dashboard"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
                    <a href="/buyer-profile"><i class="fa-solid fa-user-gear"></i><span>My Profile</span></a>
                    <a href="/weather/buyer"><i class="fa-solid fa-cloud-sun"></i><span>Weather</span></a>
                    <a href="prices.html"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
                    <a href="" class="active"><i class="fa-solid fa-person-digging"></i><span>Farmers Details</span></a>
                </ul>

                <a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i>Logout</a>
            </aside>

            <!-- Main -->
            <main class="main">
                <h2>Verified Farmers</h2>
                <p>Find and connect with trusted farmers near your location</p>

                <!-- Search -->
                <form action="/buyers/farmer/search" method="get" class="farmer-search-form">
                     <div class="search-group">
                            <i class="fa-solid fa-user"></i>
                            <input type="text" name="name" placeholder="Enter Farmer Name (e.g. Anand Patel)">
                     </div>

                    <div class="search-group">
                        <i class="fa-solid fa-location-dot"></i>
                        <input type="text" name="district" placeholder="Enter District (e.g. Indore)">
                    </div>

                    <div class="search-group">
                        <i class="fa-solid fa-seedling"></i>
                        <input type="text" name="crop" placeholder="Enter Crop (e.g. Wheat)">
                    </div>

                    <button type="submit" class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i> Search Farmers
                    </button>
                </form>

                <!-- Farmer List -->
                <div class="farmers-list">
                    <c:forEach var="f" items="${farmers}">
                        <div class="farmer-card">
                            <c:choose>
                                <c:when test="${not empty f.profilePhoto}">
                                    <img class="profile-img" src="/user/photo/${f.user.id}" alt="Farmer Profile">
                                </c:when>
                                <c:otherwise>
                                     <div class="avatar"><i class="fa-solid fa-user"></i></div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Farmer Info -->
                            <div class="farmer-info">
                                <h3>${f.user.firstName} ${f.user.lastName}</h3>
                                <p><i class="fa-solid fa-phone"></i> ${f.phone}</p>
                                <p><i class="fa-solid fa-location-dot"></i> ${f.village}, ${f.city},
                                    ${f.district}</p>

                                <span class="crop">
                                    ${b.user.buyerCrop.crop1}

                                    <c:if test="${not empty b.user.buyerCrop.crop2}">
                                        , ${b.user.buyerCrop.crop2}
                                    </c:if>

                                    <c:if test="${not empty b.user.buyerCrop.crop3}">
                                        , ${b.user.buyerCrop.crop3}
                                    </c:if>
                                </span>
                            </div>

                            <!-- Actions -->
                            <div class="actions">
                                <a href="tel:${f.phone}" class="call-btn"><i class="fa-solid fa-phone"></i> Call</a>
                                <a href="https://wa.me/${f.phone}" target="_blank" class="msg-btn"><i class="fa-brands fa-whatsapp"></i> WhatsApp</a>
                            </div>

                        </div>
                    </c:forEach>
                </div>
            </main>

    </div>

    <script src="/js/toggle.js"></script>

</body>

</html>