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
							<img id="previewImg" class="profile-img" src="/user/photo/${profile.id}"
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
				<a><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
				<a href="/Far-profile"><i class="fa-solid fa-user-gear"></i><span>My Profile</span></a>
				<a href="/Fweather"><i class="fa-solid fa-cloud-sun"></i><span>Weather</span></a>
				<a href="/crop-Sugges"><i class="fa-solid fa-seedling"></i><span>Crop Suggestions</span></a>
				<a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
				<a href="#" class="active"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
				<a href="buyers.html"><i class="fa-solid fa-store"></i><span>Buyers</span></a>
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

				<div class="price-grid">
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
				</div>
			</section>

			<!-- Search Section -->
			<section class="search-section">
				<h2>Search Crop Price</h2>
				<p>Enter crop name to get real-time mandi price.</p>

				<form action="/FarmerPrice" method="GET">
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
	<script>
		function searchCrop() {
		    let crop = document.getElementById("cropInput").value.trim().toLowerCase();
		    if (!crop) return;

		    const crops = {
		        "wheat": { img: "/img/crops/wheat.jpg", price: 2450 },
		        "rice": { img: "/img/crops/rice.jpg", price: 3180 },
		        "cotton": { img: "/img/crops/cotton.jpg", price: 6550 },
		        "maize": { img: "/img/crops/maize.jpg", price: 2050 },
		        "sugarcane": { img: "/img/crops/sugarcane.jpg", price: 350 }
		    };

		    if (crops[crop]) {
		        document.getElementById("cropImg").src = crops[crop].img;
		        document.getElementById("cropName").innerText = crop.toUpperCase();
		        document.getElementById("cropPrice").innerText = "₹ " + crops[crop].price + " / Quintal";

		        document.getElementById("searchResult").classList.remove("hidden");
		    } else {
		        Swal.fire("Not Found!", "No data available for this crop", "warning");
		    }
		}
		</script>

</body>
</html>
