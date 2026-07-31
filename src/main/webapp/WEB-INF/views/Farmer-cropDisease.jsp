<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta content="width=device-width,initial-scale=1" name="viewport" />
		<title>AgriSmart | Farmer-Crops Disease Detection</title>
		<link href="/css/cropDisease.css" rel="stylesheet" />
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
					<a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
                    <a href="#" class="active"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
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
                    <h1>Crops - Disease Detection</h1>
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
                <div class="container">

                <h2><i class="fa-solid fa-leaf"></i> Crop Disease Detection</h2>

                <form action="/detect-disease" method="post" enctype="multipart/form-data">
                    <label><i class="fa-solid fa-image icon"></i>Upload Crop Image</label>
                    <input type="file" name="image" required>
                    <br>
                    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i> Detect Disease</button>
                </form>

                <!-- Disease Result -->

                <c:if test="${not empty crop}">
                    <div class="result-box">

                        <h3><i class="fa-solid fa-stethoscope"></i> Detection Result</h3>

                        <p><i class="fa-solid fa-seedling"></i> <b>Crop:</b> ${crop}</p>

                        <p><i class="fa-solid fa-virus"></i> <b>Disease:</b> ${disease}</p>

                        <p><i class="fa-solid fa-chart-line"></i> <b>Confidence:</b> ${confidence}%</p>

                        <p><i class="fa-solid fa-leaf"></i> <b>Organic Solution:</b><br>${organic}</p>

                        <p><i class="fa-solid fa-flask"></i> <b>Chemical Solution:</b><br>${chemical}</p>

                        <p><i class="fa-solid fa-shield-halved"></i> <b>Prevention:</b><br>${prevention}</p>

                    </div>
                </c:if>

                </div>
			</main>
		</div>
		<script src="/js/toggle.js"></script>
	</body>
</html>
