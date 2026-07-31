       <%@ page contentType="text/html;charset=UTF-8" language="java" %>
       <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
       <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
       <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
       <!DOCTYPE html>
       <html lang="en">

       <head>
           <meta charset="UTF-8">
           <meta name="viewport" content="width=device-width, initial-scale=1.0">
           <title>AgriSmart | Contact Messages</title>
           <link rel="stylesheet" href="/css/Admin-Contact.css">
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
                                <h1>Contact Messages</h1>
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
                        <div class="header">
                                📩 Contact Messages
                            </div>

                            <div class="container">

                            <table>

                                <thead>
                                    <tr>
                                        <th class="name-col">Name</th>
                                        <th class="email-col">Email</th>
                                        <th class="message-col">Message</th>
                                        <th class="date-col">Date</th>
                                        <th class="action-cell">Action</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:choose>

                                        <c:when test="${not empty messages}">

                                            <c:forEach var="m" items="${messages}">

                                                <tr class="${!m.isRead ? 'unread' : ''}">

                                                    <td data-label="Name">${m.name}</td>

                                                    <td data-label="Email">${m.email}</td>

                                                    <td data-label="Message" class="message-col">
                                                        ${m.message}
                                                    </td>

                                                    <td data-label="Date">${m.formattedDate}</td>

                                                    <td data-label="Action" class="action-cell">

                                                        <a class="action-btn reply"
                                                           href="mailto:${m.email}?subject=Reply from AgriSmart">
                                                           Reply
                                                        </a>

                                                        <a class="action-btn delete"
                                                           href="/delete-message/${m.id}"
                                                           onclick="return confirm('Delete this message?')">
                                                           Delete
                                                        </a>

                                                    </td>

                                                </tr>

                                            </c:forEach>

                                        </c:when>

                                        <c:otherwise>

                                            <tr>
                                                <td colspan="5" class="empty">
                                                    No messages found
                                                </td>
                                            </tr>

                                        </c:otherwise>

                                    </c:choose>

                                </tbody>

                            </table>

                            </div>
                   </main>
           </div>
           <script>
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