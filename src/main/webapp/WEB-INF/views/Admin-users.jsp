<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriSmart | Admin User Control</title>
    <link rel="stylesheet" href="/css/Admin-users.css">
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
                    <a href="#" class="active"><i class="fa-solid fa-users"></i> Users</a>
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
                        <h1>Admin User Control</h1>
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
                <div class="container">
                    <div class="stats-grid">
                        <div class="card">
                            <div class="card-header">
                                <div class="icon-box farmer-icon"><i class="fa-solid fa-person-digging"></i></div>
                                <span class="badge green">+5.2%</span>
                            </div>
                            <p class="label">Total Farmers</p>
                            <h1 class="value">${totalFarmers}</h1>
                        </div>

                        <div class="card">
                            <div class="card-header">
                                <div class="icon-box store-icon"><i class="fa-solid fa-store"></i></div>
                                <span class="badge green">+12.5%</span>
                            </div>
                            <p class="label">Total Buyers</p>
                            <h1 class="value">${totalBuyers}</h1>
                        </div>
                    </div>

                    <div class="directories-row">

                        <div class="directory">
                            <div class="dir-header">
                                <h2>Farmers Directory</h2>
                                <div class="search-box">
                                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                                    <input type="text" id="activeFarmersSearch" placeholder="Search name..."
                                    autocomplete="off">
                                </div>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>PROFILE</th>
                                        <th>NAME</th>
                                        <th>STATUS</th>
                                        <th>ACTION</th>
                                    </tr>
                                </thead>
                                <tbody id="farmersTableBody">
                                    <c:forEach var="farmer" items="${farmersList}">
                                        <tr>
                                            <td>
                                                <div class="user-avatar">
                                                    <c:choose>
                                                        <c:when test="${not empty farmer.profile and not empty farmer.profile.profilePhoto}">
                                                            <img src="/user/photo/${farmer.id}"
                                                                 class="profile-img-status"
                                                                 alt="Profile Photo" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa-solid fa-user"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>

                                            <td>
                                                <strong>${farmer.firstName} ${farmer.lastName}</strong><br>
                                                <small>${farmer.email}</small>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty farmer.activity and farmer.activity.block}">
                                                        <span class="status-blocked">BLOCKED</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-active">ACTIVE</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty farmer.activity and farmer.activity.block}">
                                                        <a href="/admin/user/unblock/${farmer.id}"
                                                            class="btn-unblock">UNBLOCK</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/admin/user/block/${farmer.id}"
                                                            class="btn-block">BLOCK</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty farmersList}">
                                        <tr>
                                            <td colspan="4" style="text-align:center;color:#777;">
                                                No Farmers found
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>

                            </table>
                        </div>

                        <div class="directory">
                            <div class="dir-header">
                                <h2>Buyers Directory</h2>
                                <div class="search-box">
                                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                                    <input type="text" id="activeBuyersSearch" placeholder="Search name...">
                                </div>
                            </div>
                            <table>
                                <thead>
                                    <tr>
                                        <th>PROFILE</th>
                                        <th>NAME</th>
                                        <th>STATUS</th>
                                        <th>ACTION</th>
                                    </tr>
                                </thead>
                                <tbody id="buyersTableBody">
                                    <c:forEach var="buyer" items="${buyersList}">
                                        <tr>
                                            <td>
                                                <div class="user-avatar">
                                                    <c:choose>
                                                        <c:when test="${not empty buyer.profile and not empty buyer.profile.profilePhoto}">
                                                            <img src="/user/photo/${buyer.id}"
                                                                 class="profile-img-status"
                                                                 alt="Profile Photo" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fa-solid fa-user"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>

                                            <td>
                                                <strong>${buyer.firstName} ${buyer.lastName}</strong><br>
                                                <small>${buyer.email}</small>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty buyer.activity and buyer.activity.block}">
                                                        <span class="status-blocked">BLOCKED</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-active">ACTIVE</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty buyer.activity and buyer.activity.block}">
                                                        <a href="/admin/user/unblock/${buyer.id}"
                                                            class="btn-unblock">UNBLOCK</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/admin/user/block/${buyer.id}"
                                                            class="btn-block">BLOCK</a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <c:if test="${empty buyersList}">
                                        <tr>
                                            <td colspan="4" style="text-align:center;color:#777;">
                                                No buyers found
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>

                            </table>
                        </div>

                    </div>
                </div>
            </main>
    </div>
    <script>
        const ctx = "${pageContext.request.contextPath}";
    </script>
    <script src="/js/admin-users.js"></script>
    <script src="/js/toggle.js"></script>

</body>

</html>