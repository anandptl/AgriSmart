<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>AgriSmart | Buyers Details</title>
	<link rel="stylesheet" href="/css/buyers-farmer-details.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
	<div class="dashboard">

		<% if (session.getAttribute("user")==null) {
		     response.sendRedirect(request.getContextPath() + "/login" );
		     return;
		   } %>

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
                            <img id="previewImg" class="profile-img" src="/user/photo/${profile.user.id}" alt="Profile Photo">
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
				<a href="/dashboard"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
				<a href="/Far-profile"><i class="fa-solid fa-user-gear"></i><span>My Profile</span></a>
				<a href="/weather/farmer"><i class="fa-solid fa-cloud-sun"></i><span>Weather</span></a>
				<a href="/crop-Sugges"><i class="fa-solid fa-seedling"></i><span>Crop Suggestions</span></a>
				<a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
				<a href="#"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
				<a href="#"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
				<a href="" class="active"><i class="fa-solid fa-store"></i><span>Buyers</span></a>
			</ul>

			<a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
		</aside>

		<!-- Main -->
		<main class="main">
            <h2>Verified Crop Buyers</h2>
                <p>Direct access to professional agricultural traders</p>

                <form action="/farmer/buyers/search" method="get" class="buyer-search-form">
                    <div class="search-group">
                        <i class="fa-solid fa-location-dot"></i>
                        <input type="text" name="district" placeholder="District (optional)">
                    </div>

                    <div class="search-group">
                        <i class="fa-solid fa-seedling"></i>
                        <input type="text" name="crop" placeholder="Crop (optional)">
                    </div>

                    <button type="submit" class="search-btn">
                        <i class="fa-solid fa-magnifying-glass"></i> Find Buyers
                    </button>
                </form>


                <div class="buyers-list">

                    <c:forEach var="b" items="${buyers}">
                        <div class="buyer-card">

                            <c:choose>
                                <c:when test="${not empty b.profilePhoto}">
                                    <img class="profile-img" src="/user/photo/${b.user.id}" alt="Profile Photo">
                                </c:when>
                                <c:otherwise>
                                    <div class="avatar"><i class="fa-solid fa-user"></i></div>
                                </c:otherwise>
                            </c:choose>

                            <div class="buyer-info">
                                <h3>${b.user.firstName} ${b.user.lastName}</h3>
                                <p><i class="fa-solid fa-phone"></i> ${b.phone}</p>
                                <p><i class="fa-solid fa-location-dot"></i> ${b.village} ${b.city} ${b.district}</p>
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

                            <div class="actions">
                                <a href="tel:${b.phone}" class="call-btn"><i class="fa-solid fa-phone"></i> Call Buyer</a>
                                <a href="https://wa.me/${b.phone}" class="msg-btn"><i class="fa-brands fa-whatsapp"></i> Send Message</a>
                            </div>

                        </div>
                    </c:forEach>

                </div>
		</main>
	</div>

	<script src="/js/toggle.js"></script>

</body>
</html>