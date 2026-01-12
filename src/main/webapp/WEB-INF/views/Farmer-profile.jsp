<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>AgriSmart | My Profile</title>
    <link rel="stylesheet" href="/css/F-profile.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
    <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login" ); return; }
        %>
        <div class="dashboard-wrapper">
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
			
			<button class="toggle-btn" onclick="toggleSidebar()">
				<i class="fa-solid fa-bars"></i>
			</button>
            <!-- SIDEBAR -->
            <aside class="sidebar">
                <div class="brand"><i class="fa-solid fa-seedling"></i><span>AgriSmart</span></div>
					
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
                    <a href="/dashboard"><i class="fa-solid fa-chart-line"></i>Dashboard</a>
                    <a href="#" class="active"><i class="fa-solid fa-user-gear"></i>My Profile</a>
                    <a href="/weather/farmer"><i class="fa-solid fa-cloud-sun"></i>Weather</a>
                    <a href="/crop-Sugges"><i class="fa-solid fa-seedling"></i>Crop Suggestions</a>
					<a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
                    <a href="#"><i class="fa-solid fa-virus"></i>Crop Diseases</a>
                    <a href="/Price/farmer"><i class="fa-solid fa-indian-rupee-sign"></i>Crop Prices</a>
                    <a href="/buyers-details"><i class="fa-solid fa-store"></i>Buyers</a>
                </ul>

                <a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
            </aside>

            <!-- MAIN PROFILE FORM -->
            <main class="main">
                <div class="profile-card">
                    <h2>Manage Profile</h2>
					
					<div class="profile-photo-container">
					    <c:choose>
					        <c:when test="${not empty profile and not empty profile.profilePhoto}">
					            <img id="previewImg" class="profile-photo" src="/user/photo/${profile.user.id}" alt="Profile Photo">
					        </c:when>
					        <c:otherwise>
					            <img id="previewImg" class="profile-photo" src="/images/default-user.png" alt="Default Photo">
					        </c:otherwise>
					    </c:choose>
					</div>
					
					<form action="/updateProfile" method="POST" enctype="multipart/form-data">
						
						<div class="name">
							<div class="Fname">
								<label><i class="fas fa-user"></i> First Name</label>
								<input type="text" name="firstName" value="${user.firstName}">
							</div>
							<div class="lname">
								<label><i class="fas fa-user"></i> Last Name</label>
								<input type="text" name="lastname" value="${user.lastName}">
							</div>
						</div>
					    
					    <label><i class="fas fa-phone"></i> Phone Number</label>
					    <input type="text" name="phone"
					           value="${profile.phone != null ? profile.phone : '+91'}"
					           minlength="13" maxlength="13"
					           pattern="\+91[0-9]{10}"
							   placeholder = "+91808186XXXX"
					           required>

					    <!-- ✅ Updated Address with Icons -->
						<div class="address-group">
						    <div>
						        <label><i class="fa-solid fa-location-dot"></i> Village / Mohalla</label>
						        <input type="text" name="village" value="${profile.village}">
						    </div>

						    <div>
						        <label><i class="fa-solid fa-city"></i> City / Town</label>
						        <input type="text" name="city" value="${profile.city}">
						    </div>
						</div>

						<div class="address-group">
						    <div>
						        <label><i class="fa-solid fa-map"></i> District</label>
						        <input type="text" name="district" value="${profile.district}">
						    </div>

						    <div>
						        <label><i class="fa-solid fa-location-arrow"></i> State</label>
						        <input type="text" name="state" value="${profile.state}">
						    </div>
						</div>

						<div class="address-group">
						    <div>
						        <label><i class="fa-solid fa-earth-asia"></i> Country</label>
						        <input type="text" name="country" value="${profile.country}">
						    </div>

						    <div>
						        <label><i class="fa-solid fa-hashtag"></i> Pincode</label>
						        <input type="text" name="pincode" value="${profile.pincode}">
						    </div>
						</div>

					    
					    <label><i class="fas fa-language"></i> Select Language</label>
					    <select name="language" required>
					        <option value="" disabled selected>-- Choose Language --</option>
					        <option value="Hindi" ${user.language eq 'Hindi' ? 'selected' : ''}>हिन्दी</option>
					        <option value="English" ${user.language eq 'English' ? 'selected' : ''}>English</option>
					        <option value="Gujarati" ${user.language eq 'Gujarati' ? 'selected' : ''}>ગુજરાતી</option>
					        <option value="Marathi" ${user.language eq 'Marathi' ? 'selected' : ''}>मराठी</option>
					        <option value="Tamil" ${user.language eq 'Tamil' ? 'selected' : ''}>தமிழ்</option>
					    </select>

					    <div class="input-group">
					        <label><i class="fas fa-image"></i> Profile Photo</label>
					        <div class="file-upload">
					            <c:if test="${not empty profile.profilePhoto}">
					                <div class="file-info">Current File: ${profile.profilePhotoName}</div>
					            </c:if>
					            <input type="file" id="profilePhoto" name="profilePhoto" accept="image/*">
					        </div>
					    </div>

					    <div class="button-row">
					        <button class="save-btn">
					            <i class="fa-solid fa-floppy-disk"></i> Save
					        </button>
					    </div>

					</form>
                </div>
            </main>
        </div>
	<script src="/js/imageSize.js"></script>
	<script src="/js/toggle.js"></script>
</body>
</html>