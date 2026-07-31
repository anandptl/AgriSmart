<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>AgriSmart | Mandi Prices</title>
	<link rel="stylesheet" href="/css/price.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
	<div class="dashboard">

		<% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login" );
			return; } %>

			<!-- Sidebar -->
			<aside class="sidebar">
				<div class="brand">
					<i class="fa-solid fa-seedling"></i>
					<span>AgriSmart</span>
				</div>

				<div class="user">
					<div class="profile-photo-img">
						<c:choose>
							<c:when test="${not empty profile.profilePhoto}">
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
					<a href="/dashboard"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
					<a href="/Far-profile"><i class="fa-solid fa-user-gear"></i><span>My Profile</span></a>
					<a href="/weather/farmer"><i class="fa-solid fa-cloud-sun"></i><span>Weather</span></a>
					<a href="/crop-Sugges"><i class="fa-solid fa-seedling"></i><span>Crop Suggestions</span></a>
					<a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
					<a href="/disease-check"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
					<a href="#" class="active"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
					<a href="/buyers-details"><i class="fa-solid fa-store"></i><span>Buyers Details</span></a>
				</ul>

				<a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
			</aside>

			<header class="top-nav">
				<button class="toggle-btn" onclick="toggleSidebar()">
					<i class="fa-solid fa-bars"></i>
				</button>
				<div class="nav-left">
					<h1>Farmer | Crop Price</h1>
				</div>
				<div class="nav-right">
					<div class="notification">
						<i class="fa-solid fa-bell"></i>
						<span class="dot"></span>
					</div>
					<div class="user-profile">
						<span>Farmer</span>
						<img src="https://ui-avatars.com/api/?name=Farmer&background=random" alt="Profile">
					</div>
				</div>
			</header>

			<!-- Main -->
			<main class="main">

            <section class="prices">
                <div class="section-head">
                    <h1>Mandi Prices (₹/Quintal)</h1>
                    <p>Today’s indicative market prices for major crops.</p>
                </div>

                <!-- Default Crop Grid -->
                <div class="price-grid">
                    <c:forEach var="entry" items="${allCropPrices}">
                        <c:set var="cropName" value="${entry.key}" />
                        <c:set var="resp" value="${entry.value}" />

                        <div class="price-card
                            ${selectedCrop != null && selectedCrop.equalsIgnoreCase(cropName)
                              ? 'highlight-card' : ''}">

                            <div class="price-left">
                                <div class="price-icon green">
                                    <i class="fa-solid fa-leaf"></i>
                                </div>
                                <div class="price-name">${cropName}</div>
                            </div>

                            <div class="price-rate">
                                <c:choose>
                                    <c:when test="${not empty resp and not empty resp.records}">
                                        ₹ ${resp.records[0].modal_price}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </div>

                        </div>
                    </c:forEach>
                </div>

            </section>

            <!-- Search Section -->
            <section class="search-section">
                <h2>Search Crop Price</h2>
                <form action="/Price/farmerCrop" method="GET">
                    <div class="search-box">
                        <input type="text" name="crop" placeholder="Enter crop (Wheat, Rice)">
                        <button type="submit">Search</button>
                    </div>
                </form>
            </section>

            <!-- Extra Search Result (if crop not in list) -->
                <c:if test="${not empty searchCropData}">
                    <div class="search-highlight-card">
                        <h2><i class="fa-solid fa-magnifying-glass"></i> Search Result</h2>
                        <div class="highlight-content">
                            <div class="highlight-name">${selectedCrop}</div>
                            <div class="highlight-price">
                                <c:choose>
                                    <c:when test="${not empty searchCropData.records}">
                                        ₹ ${searchCropData.records[0].modal_price}
                                    </c:when>
                                    <c:otherwise>
                                        N/A
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:if>

            </main>
	</div>

	<script src="/js/toggle.js"></script>

</body>

</html>