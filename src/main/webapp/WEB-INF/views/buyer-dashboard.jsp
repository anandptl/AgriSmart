<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AgriSmart | Buyer-Dashboard</title>
  <link rel="stylesheet" href="/css/dashboard.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
  <div class="dashboard">
	
		<%
		    if (session.getAttribute("user") == null) {
		        response.sendRedirect(request.getContextPath() + "/login");
		        return;
		    }
		%>
		<button class="toggle-btn" onclick="toggleSidebar()">
			<i class="fa-solid fa-bars"></i>
		</button>
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

    <!-- Sidebar -->
    <aside class="sidebar">

      <div class="brand">
        <i class="fa-solid fa-seedling"></i>
        <span>AgriSmart</span>
      </div>

      <div class="user">
		<div class="profile-photo-img">
		<c:choose>
			<c:when test="${not empty profile and not empty profile.profilePhoto}">
				<img id="previewImg" class="profile-img" src="/user/photo/${profile.id}" alt="Profile Photo">
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
        <a class="active"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
        <a href="/buyer-profile"><i class="fa-solid fa-user-gear"></i><span>My Profile</span></a>
        <a href="/weather/buyer"><i class="fa-solid fa-cloud-sun"></i><span>Weather</span></a>
		    <a href="prices.html"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
		    <a href="/farmer-list"><i class="fa-solid fa-person-digging"></i><span>Farmers Details</span></a>
      </ul>
      <!-- Logout Button Bottom -->
      <a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>

    </aside>

    <!-- Main -->
    <main class="main">

      <!-- Header + Weather -->
      <header class="topbar">
        <div>
          <h1>Farm Overview</h1>
		  <p id="todayText">
		  	<%= java.time.LocalDate.now().format(java.time.format.DateTimeFormatter.ofPattern("EEE, dd MMM yyyy")) %>
		  </p>
        </div>
		<div class="weather-hero" id="weatherHero">
		  <div class="left">
		    <div class="city" id="cityName"><i class="fa-solid fa-location-dot"></i> ${weather.location.name}</div>
		    <div class="temp" id="tempNow">${weather.current.temp_c}°C</div>
		    <div class="cond" id="condNow">
		      <img src="https:${weather.current.condition.icon}" style="width:30px;">
		      ${weather.current.condition.text}
		    </div>
		  </div>

		  <div class="stats">
		    <div><i class="fa-solid fa-droplet"></i><span id="humNow">${weather.current.humidity}%</span><small>Humidity</small></div>
		    <div><i class="fa-solid fa-wind"></i><span id="windNow">${weather.current.wind_kph} km/h</span><small>Wind</small></div>
		  </div>
		</div>

      </header>

      <!-- Quick KPI Cards -->
      <section class="kpis">
        <div class="kpi">
          <div class="kpi-icon green"><i class="fa-solid fa-leaf"></i></div>
          <div>
            <h4>Crop Health</h4>
            <p><strong>92%</strong> Excellent</p>
          </div>
        </div>
        <div class="kpi">
          <div class="kpi-icon blue"><i class="fa-solid fa-cloud-showers-heavy"></i></div>
          <div>
            <h4>Irrigation</h4>
            <p><strong>Scheduled</strong> tonight</p>
          </div>
        </div>
        <div class="kpi">
          <div class="kpi-icon amber"><i class="fa-solid fa-bug"></i></div>
          <div>
            <h4>Pest Risk</h4>
            <p><strong>Low</strong> across fields</p>
          </div>
        </div>
      </section>

      <!-- Organic vs Non-Organic (Banner style B) -->
      <section class="compare-banner">
        <div class="tile left">
          <div class="overlay">
            <h3>Organic Farming</h3>
            <p>Natural inputs, soil health & sustainability.</p>
            <button class="btn light">Learn More</button>
          </div>
        </div>
        <div class="tile right">
          <div class="overlay">
            <h3>Non-Organic Farming</h3>
            <p>Higher yields with synthetic inputs when needed.</p>
            <button class="btn light outline">Learn More</button>
          </div>
        </div>
      </section>

      <!-- Organic vs Non-Organic (Card style A) -->
      <section class="compare-cards">
        <div class="card organic">
          <div class="tag">Organic</div>
          <h3><i class="fa-solid fa-leaf"></i> Benefits</h3>
          <ul>
            <li>Improves soil biodiversity</li>
            <li>Lower chemical residue</li>
            <li>Often better price premium</li>
          </ul>
        </div>
        <div class="card nonorganic">
          <div class="tag">Non-Organic</div>
          <h3><i class="fa-solid fa-tractor"></i> Benefits</h3>
          <ul>
            <li>Faster growth & yield</li>
            <li>Flexible input management</li>
            <li>Scales efficiently</li>
          </ul>
        </div>
      </section>

      <!-- 6 Crops (3 up + 3 down) -->
      <section class="crops">
        <div class="section-head">
          <h2>Crop Intelligence</h2>
          <p>Tap a crop to view sowing, soil, irrigation & disease tips.</p>
        </div>

        <div class="crop-grid">
          <!-- 1 -->
          <article class="crop-card">
            <div class="img">
              <img src="/Image/Rice.jpg" alt="Rice">
              <span class="season">Kharif</span>
            </div>
            <div class="meta">
              <div>
                <h4>Rice (Paddy)</h4>
                <small>Water-intensive | Loamy soil</small>
              </div>
              <i class="fa-solid fa-chevron-right"></i>
            </div>
          </article>

          <!-- 2 -->
          <article class="crop-card">
            <div class="img">
              <img src="/Image/Wheat.jpg" alt="Wheat">
              <span class="season">Rabi</span>
            </div>
            <div class="meta">
              <div>
                <h4>Wheat</h4>
                <small>Cool dry | Well-drained</small>
              </div>
              <i class="fa-solid fa-chevron-right"></i>
            </div>
          </article>

          <!-- 3 -->
          <article class="crop-card">
            <div class="img">
              <img src="/Image/Corn.jpg" alt="Maize">
              <span class="season">Kharif</span>
            </div>
            <div class="meta">
              <div>
                <h4>Maize (Corn)</h4>
                <small>Warm | Sandy-loam</small>
              </div>
              <i class="fa-solid fa-chevron-right"></i>
            </div>
          </article>

          <!-- 4 -->
          <article class="crop-card">
            <div class="img">
              <img src="/Image/Sugarcane.jpg" alt="Sugarcane">
              <span class="season">Perennial</span>
            </div>
            <div class="meta">
              <div>
                <h4>Sugarcane</h4>
                <small>High water | Fertile soil</small>
              </div>
              <i class="fa-solid fa-chevron-right"></i>
            </div>
          </article>

          <!-- 5 -->
          <article class="crop-card">
            <div class="img">
              <img src="/Image/Tomato.jpg" alt="Tomato">
              <span class="season">All Season</span>
            </div>
            <div class="meta">
              <div>
                <h4>Tomato</h4>
                <small>Moderate water | pH 6–7</small>
              </div>
              <i class="fa-solid fa-chevron-right"></i>
            </div>
          </article>

          <!-- 6 -->
          <article class="crop-card">
            <div class="img">
              <img src="/Image/cotten.jpg" alt="Cotton">
              <span class="season">Kharif</span>
            </div>
            <div class="meta">
              <div>
                <h4>Cotton</h4>
                <small>Warm | Black soil</small>
              </div>
              <i class="fa-solid fa-chevron-right"></i>
            </div>
          </article>
        </div>
      </section>

      <!-- Prices (₹/Quintal) -->
      <section class="prices">
        <div class="section-head">
          <h2>Mandi Prices (₹/Quintal)</h2>
          <p>Today’s indicative market prices for major crops.</p>
        </div>

        <div class="price-grid" id="priceGrid">
          <!-- JS fills cards -->
        </div>
      </section>

      <!-- Activity -->
      <section class="activity">
        <h2><i class="fa-regular fa-clock"></i> Recent Activity</h2>
        <ul>
          <li>Irrigation completed — Field A</li>
          <li>Disease scan requested — Tomato</li>
          <li>Fertilizer schedule updated — Wheat</li>
        </ul>
      </section>

    </main>
  </div>

  <script src="/js/toggle.js"></script>
</body>

</html>