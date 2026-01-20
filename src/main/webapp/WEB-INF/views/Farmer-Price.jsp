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
				<a href="#"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
				<a href="#" class="active"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
				<a href="/buyers-details"><i class="fa-solid fa-store"></i><span>Buyers Details</span></a>
			</ul>

			<a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
		</aside>

		<!-- Main -->
		<main class="main">
			<section class="prices">
				<div class="section-head">
					<h1>Mandi Prices (₹/Quintal)</h1>
					<p>Today’s indicative market prices for major crops.</p>
				</div>
				
				<!--<div class="price-grid">
				  <c:forEach var="entry" items="${allCropPrices}">
				    <c:set var="cropName" value="${entry.key}" />
				    <c:set var="cropData" value="${entry.value}" />

				    <%-- choose icon color class based on crop name --%>
				    <c:choose>
				      <c:when test="${cropName == 'Wheat'}"><c:set var="iconColor" value="green" /></c:when>
				      <c:when test="${cropName == 'Rice'}"><c:set var="iconColor" value="blue" /></c:when>
				      <c:when test="${cropName == 'Cotton'}"><c:set var="iconColor" value="amber" /></c:when>
				      <c:when test="${cropName == 'Maize'}"><c:set var="iconColor" value="green" /></c:when>
				      <c:when test="${cropName == 'Sugarcane'}"><c:set var="iconColor" value="blue" /></c:when>
				      <c:otherwise><c:set var="iconColor" value="gray" /></c:otherwise>
				    </c:choose>

				    <%-- choose icon class --%>
				    <c:choose>
				      <c:when test="${cropName == 'Wheat'}"><c:set var="iconClass" value="fa-wheat-awn" /></c:when>
				      <c:when test="${cropName == 'Rice'}"><c:set var="iconClass" value="fa-bowl-rice" /></c:when>
				      <c:when test="${cropName == 'Cotton'}"><c:set var="iconClass" value="fa-shirt" /></c:when>
				      <c:when test="${cropName == 'Maize'}"><c:set var="iconClass" value="fa-corn" /></c:when>
				      <c:when test="${cropName == 'Sugarcane'}"><c:set var="iconClass" value="fa-droplet" /></c:when>
				      <c:otherwise><c:set var="iconClass" value="fa-leaf" /></c:otherwise>
				    </c:choose>

				    <div class="price-card">
				      <div class="price-left">
				        <div class="price-icon ${iconColor}"><i class="fa-solid ${iconClass}"></i></div>
				        <div class="price-name">${cropName}</div>
				      </div>

				      <div class="price-rate">
				        <%-- Prefer simplified key if controller produced it --%>
				        <c:choose>
				          <c:when test="${not empty cropData and not empty cropData.displayPrice}">
				            ₹ <c:out value="${cropData.displayPrice}" />
				          </c:when>

				          <%-- Try common top-level fields --%>
				          <c:when test="${not empty cropData and not empty cropData.modal_price}">
				            ₹ <c:out value="${cropData.modal_price}" />
				          </c:when>

				          <c:when test="${not empty cropData and not empty cropData.price}">
				            ₹ <c:out value="${cropData.price}" />
				          </c:when>

				          <%-- If API returns a 'records' array, take first record's modal_price / price --%>
				          <c:when test="${not empty cropData and not empty cropData.records}">
				            <c:choose>
				              <c:when test="${not empty cropData.records[0].modal_price}">
				                ₹ <c:out value="${cropData.records[0].modal_price}" />
				              </c:when>
				              <c:when test="${not empty cropData.records[0].price}">
				                ₹ <c:out value="${cropData.records[0].price}" />
				              </c:when>
				              <c:otherwise>
				                N/A
				              </c:otherwise>
				            </c:choose>
				          </c:when>

				          <c:otherwise>
				            N/A
				          </c:otherwise>
				        </c:choose>
				      </div>
				    </div>

				  </c:forEach>
				</div>-->
				
				<div class="price-grid">
				  <c:forEach var="entry" items="${allCropPrices}">
				    <c:set var="cropName" value="${entry.key}" />
				    <c:set var="resp" value="${entry.value}" />

				    <%-- decide iconColor / iconClass same as before --%>

				    <div class="price-card">
				      <div class="price-left">
				        <div class="price-icon ${iconColor}">
				          <i class="fa-solid ${iconClass}"></i>
				        </div>

				        <div class="price-name">${cropName}</div>
				      </div>

				      <div class="price-rate">
				        <c:choose>
				          <%-- 1) if response contains 'records' array and first record has modal_price or price field --%>
				          <c:when test="${not empty resp and not empty resp.records}">
				            <c:set var="rec" value="${resp.records[0]}" />
				            <c:choose>
				              <c:when test="${not empty rec.modal_price}">
				                ₹ <c:out value="${rec.modal_price}" />
				              </c:when>
				              <c:when test="${not empty rec.price}">
				                ₹ <c:out value="${rec.price}" />
				              </c:when>
				              <c:otherwise>
				                N/A
				              </c:otherwise>
				            </c:choose>
				          </c:when>

				          <%-- 2) fallback if API returned a direct 'price' field --%>
				          <c:when test="${not empty resp and not empty resp.price}">
				            ₹ <c:out value="${resp.price}" />
				          </c:when>

				          <c:otherwise>
				            N/A
				          </c:otherwise>
				        </c:choose>
				      </div>
				    </div>
				  </c:forEach>
				</div>


				<!--<div class="price-grid">
					<div class="price-card">
						<div class="price-left">
							<div class="price-icon green"><i class="fa-solid fa-wheat-awn"></i></div>
							<div class="price-name">Wheat</div>
						</div>
						<div class="price-rate">₹ 2450</div>
					</div>

					<div class="price-card">
						<div class="price-left">
							<div class="price-icon blue"><i class="fa-solid fa-bowl-rice"></i></div>
							<div class="price-name">Rice</div>
						</div>
						<div class="price-rate">₹ 3180</div>
					</div>
					
					<div class="price-card">
						<div class="price-left">
							<div class="price-icon amber"><i class="fa-solid fa-shirt"></i></div>
							<div class="price-name">Cotton</div>
						</div>
						<div class="price-rate">₹ 6550</div>
					</div>

					<div class="price-card">
						<div class="price-left">
							<div class="price-icon green"><i class="fa-solid fa-corn"></i></div>
							<div class="price-name">Maize</div>
						</div>
						<div class="price-rate">₹ 2050</div>
					</div>

					<div class="price-card">
						<div class="price-left">
							<div class="price-icon blue"><i class="fa-solid fa-droplet"></i></div>
							<div class="price-name">Sugarcane</div>
						</div>
						<div class="price-rate">₹ 350</div>
					</div>
				</div> -->
			</section>

			<!-- Search Section -->
			<section class="search-section">
				<h2>Search Crop Price</h2>
				<p>Enter crop name to get real-time mandi price.</p>

				<form action="/Price/farmerCrop" method="GET">
					<div class="search-box">
						<input type="text" name="crop" placeholder="Enter crop (Wheat, Rice)">
						<button type="submit">Search</button>
					</div>
				</form>

				<!-- Backend API Result -->
				<c:if test="${not empty data}">
					<div class="result-card">
						<img class="result-img"
						     src="/img/crops/${data.crop}.jpg"
						     onerror="this.src='/img/crops/default.png'">

						<div>
							<h3>${data.crop} (${data.market}, ${data.state})</h3>
							<p><b>Price:</b> ₹ ${data.price} / ${data.unit}</p>
							<p><b>Date:</b> ${data.date}</p>
						</div>
					</div>
				</c:if>
			</section>
		</main>
	</div>

	<script src="/js/toggle.js"></script>

</body>
</html>