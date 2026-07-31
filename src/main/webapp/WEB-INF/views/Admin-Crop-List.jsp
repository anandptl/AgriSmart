<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriSmart | Admin – Crop Lists</title>
    <link rel="stylesheet" href="/css/Admin-CropList.css">
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
                            <li><a href="/Manage-Crops"><i class="fa-solid fa-gear"></i> Manage Crops</a></li>
                            <li><a href="" class="active"><i class="fa-solid fa-list"></i> Crops List</a></li>
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
                        <h1>Admin – Crop Lists</h1>
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

                <div class="table-controls">
                    <div class="filter-group">
                        <label for="categoryFilter">Filter by:</label>
                        <select id="categoryFilter">
                            <option value="">All Categories</option>
                            <option>Cereals</option>
                            <option>Vegetables</option>
                            <option>Pulses</option>
                            <option>Cash Crop</option>
                            <option>Oil Seeds</option>
                            <option>Fruits</option>
                        </select>
                    </div>
                    <button onclick="printPage()" class="btn-print">
                        <i class="fa-solid fa-print"></i> Print Report
                    </button>
                </div>

                <div class="table-container">
                    <table class="styled-table" id="tableContainer">
                        <thead>
                            <tr>
                                <th><i class="fa-solid fa-leaf"></i> Crop Name</th>
                                <th><i class="fa-solid fa-tags"></i> Category</th>
                                <th><i class="fa-solid fa-cloud-sun"></i> Season</th>
                                <th><i class="fa-solid fa-mountain"></i> Soil Type</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="crop" items="${cropList}">
                                <tr>
                                    <td><strong>${crop.cropName}</strong></td>
                                    <td><span class="badge category">${crop.category}</span></td>
                                    <td>${crop.season}</td>
                                    <td>${crop.soilType}</td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty cropList}">
                                <tr>
                                    <td colspan="4" class="no-data">
                                        <i class="fa-solid fa-inbox"></i> No Crops Found
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </main>
    </div>
    <script src="/js/Admin-cropList.js"></script>
    <script src="/js/toggle.js"></script>
</body>
</html>