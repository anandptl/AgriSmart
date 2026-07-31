<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriSmart | Admin – Crop Management</title>
    <link rel="stylesheet" href="/css/CropManage.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>

    <div class="dashboard">
        <% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login" );
            return; } %>
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
                                <img src="/user/photo/${profile.user.id}" alt="Profile Photo" class="profile-img"
                                    id="previewImg" />
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
                    <a href="/Admin-Dash"><i class="fa-solid fa-house"></i> Dashboard</a>
                    <a href="/Admin-Users"><i class="fa-solid fa-users"></i> Users</a>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropdown-btn active" onclick="toggleDropdown('cropSubmenu', this)">
                            <span><i class="fa-solid fa-seedling"></i> Crops</span>
                            <i class="fa-solid fa-chevron-down arrow"></i>
                        </a>
                        <ul class="submenu" id="cropSubmenu">
                            <li><a href="" class="active"><i class="fa-solid fa-gear"></i> Manage Crops</a></li>
                            <li><a href="/Crops-List"><i class="fa-solid fa-list"></i> Crops List</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropdown-btn" onclick="toggleDropdown('processSubmenu', this)">
                            <span><i class="fa-solid fa-arrows-spin"></i> Crop Process</span>
                            <i class="fa-solid fa-chevron-down arrow"></i>
                        </a>
                        <ul class="submenu" id="processSubmenu">
                            <li><a href="/Admin-Organic-Process"><i class="fa-solid fa-circle-dot"></i> Organic Process</a></li>
                            <li><a href="/Admin-Inorganic-Process"><i class="fa-solid fa-circle-dot"></i> Inorganic Process</a></li>
                        </ul>
                    </li>
                    <a href="/admin/messages"><i class="fa-solid fa-bell"></i> Notification</a>
                    <a href="/Analysis"><i class="fa-solid fa-chart-line"></i> Analytics</a>
                    <a href="#"><i class="fa-solid fa-gear"></i> Settings</a>
                </ul>
                <a href="/logout" class="logout-btn"> <i class="fa-solid fa-right-from-bracket"></i>
                    Logout</a>
            </aside>

            <main class="main">
                <!-- headers -->
                <header class="top-nav">
                    <button class="toggle-btn" onclick="toggleSidebar()">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                    <div class="nav-left">
                        <h1>Admin – Crop Management</h1>
                    </div>
                    <div class="nav-right">
                        <a href="/admin/messages" class="notification">
                            <i class="fa-solid fa-bell"></i>

                            <c:if test="${unreadCount > 0}">
                                <span class="notif-count">${unreadCount}</span>
                            </c:if>
                        </a>
                        <div class="user-profile">
                            <span>Admin</span>
                            <img src="https://ui-avatars.com/api/?name=Admin&background=random" alt="Profile">
                        </div>
                    </div>
                </header>

                <!-- Start Cards-->

                <div class="crop-stats">
                    <c:forEach var="row" items="${cropCounts}">
                        <div class="stats-card">
                            <div class="card-top">
                                <div class="icon-box
                                    ${row[0] == 'Cereals' ? 'icon-cereal' :
                                      row[0] == 'Pulses' ? 'icon-pulse' :
                                      row[0] == 'Oil Seeds' ? 'icon-oilseed' :
                                      row[0] == 'Vegetables' ? 'icon-veg' :
                                      row[0] == 'Cash Crop' ? 'icon-cash' :
                                      row[0] == 'Fruits' ? 'icon-fruit' : 'icon-default'}">

                                    <c:choose>

                                        <c:when test="${row[0] == 'Cereals'}">
                                            <i class="fa-solid fa-wheat-awn"></i>
                                        </c:when>

                                        <c:when test="${row[0] == 'Pulses'}">
                                            <i class="fa-solid fa-seedling"></i>
                                        </c:when>

                                        <c:when test="${row[0] == 'Oil Seeds'}">
                                            <i class="fa-solid fa-droplet"></i>
                                        </c:when>

                                        <c:when test="${row[0] == 'Vegetables'}">
                                            <i class="fa-solid fa-carrot"></i>
                                        </c:when>

                                        <c:when test="${row[0] == 'Cash Crop'}">
                                            <i class="fa-solid fa-money-bill-trend-up"></i>
                                        </c:when>

                                        <c:when test="${row[0] == 'Fruits'}">
                                            <i class="fa-solid fa-apple-whole"></i>
                                        </c:when>

                                        <c:otherwise>
                                            <i class="fa-solid fa-layer-group"></i>
                                        </c:otherwise>

                                    </c:choose>

                                </div>

                                <div class="category">
                                    <span class="category-label">CATEGORY</span>
                                </div>
                            </div>

                            <div class="card-content">
                                <h4 class="crop-name">${row[0]}</h4>
                                <h2 class="crop-count">${row[1]}</h2>
                            </div>
                        </div>
                    </c:forEach>
                </div>


                <div class="card">

                    <!-- TABS -->
                    <div class="tabs">
                        <button class="tab active" onclick="switchTab(event,'add')">
                            <i class="fa fa-plus-circle"></i> Add Crop
                        </button>
                        <button class="tab" onclick="switchTab(event,'update')">
                            <i class="fa fa-edit"></i> Update
                        </button>
                        <button class="tab" onclick="switchTab(event,'delete')">
                            <i class="fa fa-trash"></i> Delete
                        </button>
                    </div>

                    <!-- ADD -->
                    <section id="add" class="tab-box active">
                        <form action="/admin/crop/save" method="post" enctype="multipart/form-data">

                            <div class="sec-title green">
                                <i class="fa fa-check-circle"></i> Mandatory Fields
                            </div>

                            <div class="field">
                                <label class="required">Crop Name</label>
                                <input type="text" name="cropName" placeholder="Wheat, Rice">
                            </div>

                            <!-- IMAGE UPLOAD -->
                            <div class="field">
                                <label class="required">Crop Image</label>
                                <input type="file" id="cropName" name="imageFile" accept="image/*" required>
                            </div>

                            <div class="grid">
                                <div class="field">
                                    <label class="required">Soil Type</label>
                                    <select name="soilType">
                                        <option>Select</option>
                                        <option>Alluvial Soil</option>
                                        <option>Black Soil</option>
                                        <option>Red soil</option>
                                        <option>Loamy Soil</option>
                                        <option>Desert Soil</option>
                                        <option>Laterite Soil</option>
                                        <option>Yellow Soil</option>
                                        <option>Mountain / Forest Soil</option>
                                    </select>
                                </div>

                                <div class="field">
                                    <label class="required">Category</label>
                                    <select name="category">
                                        <option>Select</option>
                                        <option>Cereals</option>
                                        <option>Vegetables</option>
                                        <option>Pulses</option>
                                        <option>Cash Crop</option>
                                        <option>Oil Seeds</option>
                                        <option>Fruits</option>
                                    </select>
                                </div>

                                <div class="field">
                                    <label class="required">Season</label>
                                    <select name="season">
                                        <option>Select</option>
                                        <option>Kharif</option>
                                        <option>Rabi</option>
                                        <option>Zaid</option>
                                    </select>
                                </div>

                                <div class="field">
                                    <label class="required">Water Need</label>
                                    <select name="waterNeed">
                                        <option>Select</option>
                                        <option>Low</option>
                                        <option>Medium</option>
                                        <option>High</option>
                                        <option>Very-High</option>
                                    </select>
                                </div>
                            </div>

                            <div class="field">
                                <label class="required">Climate</label>
                                <select name="climate">
                                    <option>Tropical</option>
                                    <option>Temperate</option>
                                    <option>Arid</option>
                                    <option>Semi-Arid</option>
                                </select>
                            </div>

                                <!-- PRICE SECTION -->
                            <div class="sec-title orange">
                                  &#8377; Price Range
                            </div>

                            <div class="grid">

                                <div class="field">
                                    <label class="required">Minimum Price (₹/quintal)</label>
                                    <input type="number" name="minPrice" required>
                                </div>

                                <div class="field">
                                    <label class="required">Maximum Price (₹/quintal)</label>
                                    <input type="number" name="maxPrice" required>
                                </div>

                            </div>

                            <div class="sec-title orange">
                                <i class="fa fa-star"></i> Recommended
                            </div>

                            <div class="field half">
                                <label>Growth Duration (Days)</label>
                                <input type="number" name="growthDuration" placeholder="120">
                            </div>

                            <div class="sec-title blue">
                                <i class="fa fa-info-circle"></i> Optional
                            </div>

                            <div class="grid">
                                <div class="field">
                                    <label>Temperature (°C)</label>
                                    <input type="text" id="temp" name="temperature" placeholder="20 - 35">
                                </div>

                                <div class="field">
                                    <label>Rainfall (mm)</label>
                                    <input type="text" id="rain" name="rainfall" placeholder="600 - 1000">
                                </div>

                                <div class="field">
                                    <label>Fertilizer</label>
                                    <input type="text" name="fertilizer" placeholder="NPK">
                                </div>

                                <div class="field">
                                    <label>Pest Resistance</label>
                                    <div class="radio">
                                        <label><input type="radio" name="pestResistance" value="Low"> Low</label>
                                        <label><input type="radio" name="pestResistance" value="Mid"> Mid</label>
                                        <label class="active"><input type="radio" name="pestResistance" value="High" checked> High</label>
                                    </div>
                                </div>
                            </div>

                            <div class="actions">
                                <button type="reset" class="btn light">Cancel</button>
                                <button class="btn primary">Save</button>
                            </div>

                        </form>
                    </section>

                    <!-- UPDATE -->

                    <section id="update" class="tab-box">

                        <h3><i class="fa fa-edit"></i> Update Crop</h3>

                        <!-- TYPE CROP NAME -->
                        <div class="field half">
                            <label>Enter Crop Name</label>
                            <input type="text" id="cropNameInput" placeholder="Enter crop name">
                        </div>

                        <button type="button" id="fetchButton" class="btn primary" onclick="fetchCrop()">Fetch</button>

                        <hr style="margin:20px 0">

                        <!-- UPDATE FORM -->
                        <form id="updateCropForm" enctype="multipart/form-data">

                            <div id="updateForm" style="display:none;">

                                <input type="hidden" id="cropId">

                                <div class="field">
                                    <label>Min Price (₹ / Quintal)</label>
                                    <input type="number" id="minPrice" step="0.01" min="0">
                                </div>

                                <div class="field">
                                    <label>Max Price (₹ / Quintal)</label>
                                    <input type="number" id="maxPrice" step="0.01" min="0">
                                </div>

                                <div class="field">
                                    <label>Current Image</label>
                                    <p id="imageName"></p>
                                </div>

                                <div class="field">
                                    <label>Update Image</label>
                                    <input type="file" id="imageFile" accept="image/*">
                                </div>
                                <button type="button" class="btn primary" onclick="updateCrop()">
                                    Update Crop
                                </button>

                            </div>

                        </form>

                    </section>

                    <!-- DELETE -->
                    <section id="delete" class="tab-box">
                        <h3><i class="fa fa-trash"></i> Delete Crop</h3>

                        <div class="field half">
                            <label>Enter Crop Name</label>
                            <input type="text" id="deleteCropName" placeholder="Enter crop name">
                        </div>
                        
                        <input type="hidden" id="deleteCropId">

                        <button type="button" id="deleteFetchBtn" class="btn primary" onclick="fetchDeleteCrop()">Fetch</button>
                        
                        <!-- Confirmation Box -->
                        <div id="confirmBox" style="display:none; margin-top:15px;">
                            <p id="confirmText" style="margin-bottom: 10px; color:orange"></p>

                            <button type="button" class="btn danger" onclick="confirmDelete()">
                                Delete
                            </button>

                            <button type="button" class="btn light" onclick="cancelDelete()">
                                Cancel
                            </button>
                        </div>

                        <p class="warn">⚠ This action cannot be undone</p>
                    </section>

                </div>
            </main>
    </div>
    <script src="/js/cropManage.js"></script>
    <script src="/js/toggle.js"></script>
</body>
</html>