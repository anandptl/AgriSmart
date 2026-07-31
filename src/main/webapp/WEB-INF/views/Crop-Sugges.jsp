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
    <% if (session.getAttribute("user")==null) { 
        response.sendRedirect(request.getContextPath() + "/login" ); 
        return; 
    } %>

        <div class="dashboard">

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
                                <img id="previewImg" class="profile-img" src="/user/photo/${profile.user.id}"
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
                    <a href="/weather/farmer"><i class="fa-solid fa-cloud-sun"></i>Weather</a>
                    <a href="#" class="active"><i class="fa-solid fa-seedling"></i>Crop Suggestions</a>
                    <a href="/crop-Process"><i class="fa-solid fa-seedling"></i><span>Crop Process</span></a>
                    <a href="/disease-check"><i class="fa-solid fa-virus"></i></i>Crop Diseases</a>
                    <a href="/Price/farmer"><i class="fa-solid fa-indian-rupee-sign"></i>Crop Prices</a>
                    <a href="/buyers-details"><i class="fa-solid fa-store"></i>Buyers Details</a>
                </ul>

                <a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i>
                    Logout</a>
            </aside>
            <header class="top-nav">
                <button class="toggle-btn" onclick="toggleSidebar()">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="nav-left">
                    <h1>Farmer - Crop Suggestions</h1>
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
                <div class="filter-section">
                    <div class="filter-header">
                        <i class="fa-solid fa-filter"></i>
                        Filters
                    </div>

                    <div class="filter-group">
                        <label for="soilType">Soil Type</label>
                        <select name="soilType" id="soilType" required>
                            <option value="">All</option>
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
                        <select name="category" id="category">
                            <option value="">All</option>
                            <option value="Cereals">Cereals</option>
                            <option value="Vegetables">Vegetables</option>
                            <option value="Cash Crop">Cash Crop</option>
                            <option value="Pulses">Pulses</option>
                            <option value="Oil Seeds">Oil Seeds</option>
                            <option value="Fruits">Fruits</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Season</label>
                        <select name="season" id="season">
                            <option value="">All</option>
                            <option value="Kharif">Kharif</option>
                            <option value="Rabi">Rabi</option>
                            <option value="Zaid">Zaid</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Water Need</label>
                        <select name="water-need" id="water-need">
                            <option value="">All</option>
                            <option value="Low">Low</option>
                            <option value="Medium">Medium</option>
                            <option value="High">High</option>
                            <option value="veryhigh">Very-High</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Climate</label>
                        <select name="climate" id="climate">
                            <option value="">All</option>
                            <option value="Tropical">Tropical</option>
                            <option value="Temperate">Temperate</option>
                            <option value="Arid">Arid</option>
                            <option value="SemiArid">Semi-Arid</option>
                        </select>
                    </div>

                    <button class="clear-filters-btn">Clear Filters</button>
                </div>

                <div class="crop-results-section">
                    <div id="cropResults">
                        <!-- First time load -->
                        <jsp:include page="fragments/crop-list.jsp" />
                    </div>
                </div>
            </main>

        </div>
        <script src="/js/cropSugg.js"></script>
        <script src="/js/toggle.js"></script>
</body>

</html>