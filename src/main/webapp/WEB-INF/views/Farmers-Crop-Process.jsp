<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta content="width=device-width,initial-scale=1" name="viewport" />
		<title>AgriSmart | Farmer-Crops Process</title>
		<link href="/css/farmerCrop-Process.css" rel="stylesheet" />
  		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	</head>
	<body>
		<div class="dashboard">
			<% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login" ); return; } %>
			<script>
				<c:if test="${not empty Successfull}">
	                Swal.fire({
	                icon: 'success',
	                title: 'Success',
	                text: '${Successfull}',
	                timer: 3000,
	                timerProgressBar: true,
	                confirmButtonColor: '#3085d6'
	                });
	              </c:if>
	              <c:if test="${not empty Error}">
	                Swal.fire({
	                icon: 'error',
	                title: 'Error',
	                text: '${Error}',
	                timer: 3000,
	                timerProgressBar: true,
	                confirmButtonColor: '#d33'
	                });
              </c:if>
			</script>
			<aside class="sidebar">
				<div class="brand">
					<i class="fa-solid fa-seedling"></i>
					<span>AgriSmart</span>
				</div>
				<div class="user">
					<div class="profile-photo-img">
						<c:choose>
							<c:when test="${not empty profile and not empty profile.profilePhoto}">
								<img src="/user/photo/${profile.user.id}" alt="Profile Photo" class="profile-img" id="previewImg" />
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
                    <a href="/dashboard"><i class="fa-solid fa-chart-line"></i>Dashboard</a>
                    <a href="/Far-profile"><i class="fa-solid fa-user-gear"></i>My Profile</a>
                    <a href="/weather/farmer"><i class="fa-solid fa-cloud-sun"></i>Weather</a>
                    <a href="/crop-Sugges" ><i class="fa-solid fa-seedling"></i>Crop Suggestions</a>
					<a href="" class="active"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
                    <a href="/disease-check"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
                    <a href="/Price/farmer"><i class="fa-solid fa-indian-rupee-sign"></i>Crop Prices</a>
                    <a href="/buyers-details"><i class="fa-solid fa-store"></i>Buyers Details</a>
                </ul>
				<a href="/logout" class="logout-btn">
					<i class="fa-solid fa-right-from-bracket"></i>
					Logout
				</a>
			</aside>
			<header class="top-nav">
			    <button class="toggle-btn" onclick="toggleSidebar()">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="nav-left">
                    <h1>Farmer | Crops - Process</h1>
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
			<main class="main">

                <div class="sec-title green">
                    <i class="fa fa-leaf"></i> Crop Process Details
                </div>

                <div class="controls-wrapper">
                    <div class="field">
                        <label>Select Your Crop</label>
                        <select id="cropSelect">
                            <option value="">-- Select Crop --</option>
                            <c:forEach var="crop" items="${appliedCrops}">
                                <option value="${crop.id}">${crop.cropName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="field">
                        <label>Search Any Crop</label>
                        <div class="search-group">
                            <input type="text" id="cropSearch" placeholder="e.g. Organic Rice process">
                            <button class="btn primary" onclick="searchCrop()">
                                <i class="fa fa-search"></i> Search
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Process Display -->
               <div id="processContainer">
                <!-- First time load
                <jsp:include page="fragments/farmer-process-table.jsp" /> -->
               </div>
			</main>
		</div>
		<script src="/js/toggle.js"></script>
		<script src="/js/Farmer-Crop-Process.js"></script>
	</body>
</html>
