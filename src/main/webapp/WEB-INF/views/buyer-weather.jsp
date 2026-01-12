<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriSmart | Weather</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="/css/Fweather.css">		
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

</head>
<% if (session.getAttribute("user")==null) { response.sendRedirect(request.getContextPath() + "/login" ); return; } %>

    <body>
        <div class="dashboard-wrapper">
			
			<button class="toggle-btn" onclick="toggleSidebar()">
			  <i class="fa-solid fa-bars"></i>
			</button>

			
            <aside class="sidebar">
                <div class="brand"><i class="fa-solid fa-seedling"></i><span>AgriSmart</span></div>
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
                    <h3>${user.firstName} ${user.lastName}</h3>
                    <p>${profile.phone}</p>
                </div>
                <ul class="menu">
					<a href="/buyer-dashboard"><i class="fa-solid fa-chart-line"></i><span>Dashboard</span></a>
					<a href="/buyer-profile"><i class="fa-solid fa-user-gear"></i><span>My Profile</span></a>
					<a class="active"><i class="fa-solid fa-cloud-sun"></i><span>Weather</span></a>
					<a href="prices.html"><i class="fa-solid fa-indian-rupee-sign"></i><span>Crop Prices</span></a>
					<a href="/farmer-list"><i class="fa-solid fa-person-digging"></i><span>Farmers Details</span></a>
                </ul>
				
                <a href="/logout" class="logout-btn"><i class="fa-solid fa-right-from-bracket"></i>Logout</a>
            </aside>

            <main class="main">
                <div class="container">

                    <header class="header">
                        <form action="/Fweather" method="get" class="search-bar-form">
                            <div class="search-bar">
                                <i class="fas fa-search"></i>
                                <input type="text" name="city" placeholder="Search for your preferred city..."
                                    value="${city}">

                                <button type="submit" class="location-btn">
                                    <i class="fas fa-location-dot"></i> Search
                                </button>
                            </div>
                        </form>

                    </header>

                    <div class="main-content">
                        <div class="left-col">
                            <div class="card time-card">
                                <div class="city-name">${weather.location.name}, ${weather.location.country}</div>
                                <div class="current-time">${weather.location.localtime}</div>
                            </div>

                            <div class="card current-weather-card">
                                <div class="temp-info">
                                    <div class="main-temp">${weather.current.temp_c}°C</div>
                                    <div class="feels-like">Feels like: ${weather.current.feelslike_c}°C</div>

                                    <div class="sun-times">
                                        <c:set var="todayAstro" value="${weather.forecast.forecastday[0].astro}" />

                                        <div>
                                            <i class="fas fa-arrow-up"></i> Sunrise
                                            <span>${todayAstro.sunrise}</span>
                                        </div>
                                        <div>
                                            <i class="fas fa-arrow-down"></i> Sunset
                                            <span>${todayAstro.sunset}</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="weather-icon-info">
                                    <img src="https:${weather.current.condition.icon}"
                                        alt="${weather.current.condition.text}" class="large-icon-img">
                                    <div class="description">${weather.current.condition.text}</div>
                                </div>

                                <div class="details-info">
                                    <div class="detail-row">
                                        <i class="fas fa-water"></i>
                                        <span>${weather.current.humidity}%</span>
                                        <span class="label">Humidity</span>
                                    </div>
                                    <div class="detail-row">
                                        <i class="fas fa-wind"></i>
                                        <span>${weather.current.wind_kph} km/h</span>
                                        <span class="label">Wind Speed (${weather.current.wind_dir})</span>
                                    </div>
                                    <div class="detail-row">
                                        <i class="fas fa-tachometer-alt"></i>
                                        <span>${weather.current.pressure_mb} hPa</span>
                                        <span class="label">Pressure</span>
                                    </div>
                                    <div class="detail-row">
                                        <i class="fas fa-sun"></i>
                                        <span>${weather.current.uv}</span>
                                        <span class="label">UV Index</span>
                                    </div>
                                    <div class="detail-row">
                                        <i class="fas fa-cloud-rain"></i>
                                        <span>${weather.current.precip_mm} mm</span>
                                        <span class="label">Precipitation</span>
                                    </div>
                                    <div class="detail-row">
                                        <i class="fas fa-eye"></i>
                                        <span>${weather.current.vis_km} km</span>
                                        <span class="label">Visibility</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="right-col">

                            <div class="card forecast-card">
                                <h3>10 Days Forecast:</h3>
                                <div class="forecast-list horizontal-scroll">

                                    <c:forEach var="day" items="${weather.forecast.forecastday}">
                                        <div class="forecast-item">
                                            <span class="date-label">${day.date}</span>
                                            <img src="https:${day.day.condition.icon}" alt="${day.day.condition.text}"
                                                class="weather-icon-small">
                                            <span class="temp-range">${day.day.maxtemp_c}°C /
                                                ${day.day.mintemp_c}°C</span>
                                            <span class="condition-text">${day.day.condition.text}</span>
                                        </div>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
       <script>
            function updateTime() {
                let now = new Date();
                let timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                document.getElementById("currentTime").innerText = timeString;
            }
            setInterval(updateTime, 1000);
            updateTime();
        </script>
		<script src="/js/toggle.js"></script>
    </body>

</html>