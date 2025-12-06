<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>AgriSmart | Crop-Suggestions</title>
    <link rel="stylesheet" href="/css/crop-sugges.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
</head>

<body>
    <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login"
        ); return; } %>
		
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
					
            <aside class="sidebar">
                <div class="brand">
					<i class="fa-solid fa-seedling"></i>
					<span>AgriSmart</span></div>

                <div class="user">
                    <div class="profile-photo-img">
                        <c:choose>
                            <c:when test="${not empty profile and not empty profile.profilePhoto}">
                                <img id="previewImg" class="profile-img" src="/user/photo/${profile.id}"
                                    alt="Profile Photo">
                            </c:when>
                            <c:otherwise>
                                <div class="avatar"><i class="fa-solid fa-user"></i></div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <h3> ${user.firstName} ${user.lastName}</h3>
                    <p>${profile.phone}</p>
                </div>

                <ul class="menu">
                    <a href="/dashboard"><i class="fa-solid fa-chart-line"></i>Dashboard</a>
                    <a href="/Far-profile"><i class="fa-solid fa-user-gear"></i>My Profile</a>
                    <a href="/Fweather"><i class="fa-solid fa-cloud-sun"></i>Weather</a>
                    <a href="#" class="active"><i class="fa-solid fa-seedling"></i>Crop Suggestions</a>
					<a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
                    <a href="#"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
                    <a href="/FarmerPrice"><i class="fa-solid fa-indian-rupee-sign"></i>Crop Prices</a>
                    <a href="#"><i class="fa-solid fa-store"></i>Buyers</a>
                </ul>

                <a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i>
                    Logout</a>
            </aside>

            <main class="main">
                <div class="main-content">
                    <div class="filter-section">
                        <div class="filter-header">
                            <i class="fa-solid fa-filter"></i>
                            Filters
                        </div>

                        <div class="filter-group">
                            <label for="soilType">Soil Type</label>
                            <select name="soilType" id="soilType" required>
                                <option value="" disabled selected>All</option>

                                <option value="Black Soil">Black Soil</option>
                                <option value="Alluvial Soil">Alluvial Soil</option>
                                <option value="Red Soil">Red Soil</option>
                                <option value="Loamy Soil">Loamy Soil</option>
                                <option value="Desert Soil">Desert / Arid Soil</option>
                                <option value="Laterite Soil">Laterite Soil</option>
                                <option value="Yellow Soil">Yellow Soil</option>
                                <option value="Mountain Soil">Mountain / Forest Soil</option>
                            </select>

                        </div>

                        <div class="filter-group">
                            <label>Category</label>
                            <select name ="category" id="category">
                                <option value="" disabled selected>All</option>
                                <option value="Cereals">Cereals</option>
                                <option value="Vegetables">Vegetables</option>
                                <option value="Cash Crop">Cash Crop</option>
                                <option value="Pulses">Pulses</option>
                                <option value="Oil Seeds">Oil Seeds</option>
                                </select>
                        </div>

                        <div class="filter-group">
                            <label>Season</label>
                            <select name ="season" id="season">
                                <option value="" disabled selected>All</option>
                                <option value="Kharif">Kharif</option>
                                <option value="Rabi">Rabi</option>
                                <option value="Zaid">Zaid</option>
                                <option value="All Season">All Season</option>
                                </select>
                        </div>

                        <div class="filter-group">
                            <label>Water Need</label>
                            <select name ="water-need" id="water-need">
                                <option value="" disabled selected>All</option>
                                <option value="Low">Low</option>
                                <option value="Medium">Medium</option>
                                <option value="High">High</option>
                                <option value="veryhigh">Very-High</option>
                                </select>
                        </div>

                        <div class="filter-group">
                            <label>Climate</label>
                            <select name ="climate" id="climate">
                                <option value="" disabled selected>All</option>
                                <option value="Tropical">Tropical</option>
                                <option value="Temperate">Temperate</option>
                                <option value="Arid">Arid</option>
                                <option value="SemiArid">Semi-Arid</option>
                                </select>
                        </div>

                        <button class="clear-filters-btn">Clear Filters</button>
                    </div>

                    <div class="crop-results-section">
                        <div class="results-header">
                            Found 4 plants
                        </div>

                        <div class="crop-cards-container">
                            <div class="crop-card">
                                <div class="card-image-wrapper">
                                    <img src="/Image/rice.jpg" alt="Rice Grains">
                                    <span class="crop-tag kharif-tag">Kharif</span>
                                    <div class="rating"><i class="fa-solid fa-star"></i> 4.5</div>
                                </div>
                                <div class="card-content">
                                    <h3>Rice (Paddy)</h3>
                                    <p class="scientific-name">Oryza sativa</p>
                                    <p class="description">Rice is a staple cereal crop grown extensively
                                        across India, particularly in...</p>
                                    <div class="details-row">
                                        <div class="detail-item water-need"><i
                                                class="fa-solid fa-droplet"></i> High</div>
                                        <div class="detail-item duration"><i
                                                class="fa-regular fa-clock"></i> 120-150 days</div>
                                    </div>
                                    <div class="details-row">
                                        <div class="detail-item yield"><i
                                                class="fa-solid fa-layer-group"></i> 4-5 tons/acre</div>
                                        <div class="detail-item difficulty medium-diff">Medium</div>
                                    </div>
                                </div>
                            </div>

                            <div class="crop-card">
                                <div class="card-image-wrapper">
                                    <img src="/Image/wheat.jpg" alt="Wheat Grains">
                                    <span class="crop-tag rabi-tag">Rabi</span>
                                    <div class="rating"><i class="fa-solid fa-star"></i> 4.2</div>
                                </div>
                                <div class="card-content">
                                    <h3>Wheat</h3>
                                    <p class="scientific-name">Triticum aestivum</p>
                                    <p class="description">Wheat is a major cereal crop grown during the
                                        winter season, primarily in northern a...</p>
                                    <div class="details-row">
                                        <div class="detail-item water-need"><i
                                                class="fa-solid fa-droplet"></i> Medium</div>
                                        <div class="detail-item duration"><i
                                                class="fa-regular fa-clock"></i> 110-130 days</div>
                                    </div>
                                    <div class="details-row">
                                        <div class="detail-item yield"><i
                                                class="fa-solid fa-layer-group"></i> 3-2 tons/acre</div>
                                        <div class="detail-item difficulty easy-diff">Easy</div>
                                    </div>
                                </div>
                            </div>

                            <div class="crop-card">
                                <div class="card-image-wrapper">
                                    <img src="/Image/tomato.jpg" alt="Tomatoes">
                                    <span class="crop-tag all-season-tag">All Season</span>
                                    <div class="rating"><i class="fa-solid fa-star"></i> 4</div>
                                </div>
                                <div class="card-content">
                                    <h3>Tomato</h3>
                                    <p class="scientific-name">Solanum lycopersicum</p>
                                    <p class="description">Tomato is a popular vegetable crop that can be
                                        grown year-round with proper car...</p>
                                    <div class="details-row">
                                        <div class="detail-item water-need"><i
                                                class="fa-solid fa-droplet"></i> Medium</div>
                                        <div class="detail-item duration"><i
                                                class="fa-regular fa-clock"></i> 90-120 days</div>
                                    </div>
                                    <div class="details-row">
                                        <div class="detail-item yield"><i
                                                class="fa-solid fa-layer-group"></i> 15-20 tons/acre</div>
                                        <div class="detail-item difficulty hard-diff">Hard</div>
                                    </div>
                                </div>
                            </div>

                            <div class="crop-card">
                                <div class="card-image-wrapper">
                                    <img src="/Image/sugarcane.jpg" alt="Sugarcane field">
                                    <span class="crop-tag perennial-tag">Perennial</span>
                                    <div class="rating"><i class="fa-solid fa-star"></i> 3.8</div>
                                </div>
                                <div class="card-content">
                                    <h3>Sugarcane</h3>
                                    <p class="scientific-name">Saccharum officinarum</p>
                                    <p class="description">Sugarcane is a long-duration cash crop that
                                        provides excellent returns with proper...</p>
                                    <div class="details-row">
                                        <div class="detail-item water-need"><i
                                                class="fa-solid fa-droplet"></i> Very High</div>
                                        <div class="detail-item duration"><i
                                                class="fa-regular fa-clock"></i> 12-18 months</div>
                                    </div>
                                    <div class="details-row">
                                        <div class="detail-item yield"><i
                                                class="fa-solid fa-layer-group"></i> 45-60 tons/acre</div>
                                        <div class="detail-item difficulty medium-diff">Medium</div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </main>

        </div>
		<script src="/js/toggle.js"></script>
</body>

</html>