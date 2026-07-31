<%@ page contentType="text/html;charset=UTF-8" language="java" %>   
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriSmart | Admin Dashboard</title>
    <link rel="stylesheet" href="/css/AdminDash.css">
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
                    <a href="#" class="active"><i class="fa-solid fa-house"></i> Dashboard</a>
                    <a href="/Admin-Users"><i class="fa-solid fa-users"></i> Users</a>
                    <li class="dropdown">
                        <a href="javascript:void(0)" class="dropdown-btn" onclick="toggleDropdown('cropSubmenu', this)">
                            <span><i class="fa-solid fa-seedling"></i> Crops</span>
                            <i class="fa-solid fa-chevron-down arrow"></i>
                        </a>
                        <ul class="submenu" id="cropSubmenu">
                            <li><a href="/Manage-Crops"><i class="fa-solid fa-gear"></i> Manage Crops</a></li>
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
                <header class="top-nav">
                    <button class="toggle-btn" onclick="toggleSidebar()">
                        <i class="fa-solid fa-bars"></i>
                    </button>
                    <div class="nav-left">
                        <h1>Admin Dashboard</h1>
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

                <div class="container-fluid">
                    <div class="section-header">
                        <h2>Overview</h2>
                        <select class="date-filter">
                            <option>Last 30 Days</option>
                            <option>Last 7 Days</option>
                        </select>
                    </div>

                    <div class="stats-grid">
                        <div class="stat-card">
                            <div class="card-header">
                                <div class="icon-box green-bg"><i class="fa-solid fa-person-digging"></i></div>
                                <p class="trend up">↗ 12%</p>
                            </div>
                            <p class="label">Farmers</p>
                            <h2 class="value">${totalFarmers}</h2>
                        </div>
                        <div class="stat-card">
                            <div class="card-header">
                                <div class="icon-box blue-bg"><i class="fa-solid fa-store"></i></div>
                                <p class="trend up">↗ 5%</p>
                            </div>
                            <p class="label">Buyers</p>
                            <h2 class="value">${totalBuyers}</h2>
                        </div>
                        <div class="stat-card">
                            <div class="card-header">
                                <div class="icon-box light-green-bg"><i class="fa-solid fa-seedling"></i></div>
                                <p class="trend up">↗ 2%</p>
                            </div>
                            <p class="label">Crops</p>
                            <h2 class="value">${totalCrops}</h2>
                                
                        </div>
                        <div class="stat-card">
                            <div class="card-header">
                                <div class="icon-box orange-bg"><i class="fa-solid fa-bolt"></i></div>
                                <p class="trend up">↗ 7%</p>
                            </div>
                            <p class="label">Active Users</p>
                            <h2 class="value">${activeUsers}</h2>
                        </div>
                    </div>

                    <div class="dashboard-grid">
                        <div class="card active-users-card">
                            <div class="card-header">
                                <h3>Active Users</h3>
                                <a href="#" class="view-all">View All ❯</a>
                            </div>
                            <div class="search-container">
                                <i class="fa-solid fa-magnifying-glass"></i>
                                <input type="text" id="activeUserSearch" placeholder="Search user..."
                                    autocomplete="off">
                                <button class="filter-btn"><i class="fa-solid fa-sliders"></i></button>
                            </div>

                            <div class="user-list" id="activeUserResult">
                                <c:forEach var="ua" items="${userList}">
                                    <div class="user-item">

                                        <div class="user-avatar">
                                            <img src="/user/photo/${ua.user.id}" class="profile-img-status"
                                                alt="Profile Photo"
                                                onerror="this.style.display='none'; this.nextElementSibling.style.display='grid';">
                                            <i class="fa-solid fa-user"></i>
                                        </div>


                                        <!-- Info -->
                                        <div class="user-info">
                                            <h4>${ua.user.firstName} ${ua.user.lastName}</h4>
                                            <p>${ua.user.role} • ${ua.lastSeenFormatted}</p>
                                        </div>

                                        <!-- Status -->
                                        <c:choose>
                                            <c:when test="${ua.online}">
                                                <span class="status-badge online">
                                                    <span class="dot green"></span> ONLINE
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge offline">
                                                    <span class="dot gray"></span> OFFLINE
                                                </span>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </c:forEach>
                                <c:if test="${empty userList}">
                                    <p style="text-align:center;color:#777;">No users found</p>
                                </c:if>
                            </div>

                        </div>

                        <div class="card crop-dist-card">
                            <div class="card-header">
                                <h3>Crop Distribution</h3>
                            </div>
                            <div class="chart-placeholder">
                                <p>Chart/Graph content goes here...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
    </div>
    <script>
        
    let debounceTimer;
    const ctx = "<%= request.getContextPath() %>"; // /auth

    document.getElementById("activeUserSearch").addEventListener("keyup", function () {

        clearTimeout(debounceTimer);
        const keyword = this.value.trim();

        debounceTimer = setTimeout(() => {

            fetch(ctx + "/users/search/name?keyword=" + encodeURIComponent(keyword))
                .then(res => {
                    if (!res.ok) throw new Error("HTTP " + res.status);
                    return res.text();
                })
                .then(html => {
                    document.getElementById("activeUserResult").innerHTML = html;
                })
                .catch(err => console.error("AJAX ERROR:", err));

        }, 300);
    });

    function toggleDropdown(id, element) {

        var submenu = document.getElementById(id);

        submenu.classList.toggle("show");
        element.querySelector(".arrow").classList.toggle("rotate");
    }

    document.addEventListener("DOMContentLoaded", function () {

        let currentUrl = window.location.pathname;

        // Crop Process Pages
        if (currentUrl.includes("Organic") ||
            currentUrl.includes("Inorganic")) {

            document.getElementById("processSubmenu").classList.add("show");

            document
                .querySelector("[onclick*='processSubmenu'] .arrow")
                .classList.add("rotate");
        }

        // Crop Manage Pages
        if (currentUrl.includes("Manage-Crops") ||
            currentUrl.includes("Crops-List") ) {

            document.getElementById("cropSubmenu").classList.add("show");

            document
                .querySelector("[onclick*='cropSubmenu'] .arrow")
                .classList.add("rotate");
        }

    });


    </script>
    <script src="/js/toggle.js"></script>
</body>

</html>