<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>AgriSmart | Smart Farming</title>

  <link rel="stylesheet" href="/css/style.css" />

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <script src="js/script.js"></script>
</head>

<body>
  <div id="container">

    <!-- HERO SECTION -->
    <section class="hero" id="hero">

      <!-- NAVBAR -->
      <div class="navbar">
        <h2 class="logo"><a href ="/home" >AgriSmart</a></h2>

        <ul class="nav-links">
          <li><a href="#hero">Home</a></li>
          <li><a href="#crops">Crops</a></li>
          <li><a href="#tools">Tools</a></li>
          <li><a href="/weather/weather">Weather</a></li>
          <li><a href="/contact">Contact Us</a></li>
          <li><a href="#hero">About Us</a></li>
          <li>
            <select class="language-select" id="languageSelect">
              <option value="en">English</option>
              <option value="hi">हिन्दी</option>
              <option value="ta">தமிழ்</option>
            </select>
          </li>
        </ul>

        <a href="/login" class="login-btn">Login</a>
      </div>

      <div class="hero-content">
        <div class="icon"><i class="fas fa-leaf"></i></div>
        <h1>Smart Farming for <span>Better Tomorrow</span></h1>
        <p>Revolutionize your farming with AI-powered crop recommendations, soil analysis & smart solutions.</p>

        <div class="hero-buttons">
		  <a href="/login" class="btn primary"><span>Get Started</span></a>
          <button class="btn secondary">Explore Features</button>
        </div>
      </div>
    </section>


    <!-- CROPS SECTION -->
    <section class="crops" id="crops">
      <h2>Explore Crop Intelligence</h2>
      <p>Click any crop to view ideal growing conditions & expert farming guidance.</p>

      <div class="crop-grid">

        <div class="crop-card">
          <div class="crop-img">
            <img src="/Image/Rice.jpg" alt="Rice">
            <span class="season-tag">Kharif</span>
          </div>
          <div class="crop-body">
            <div>
              <h3>Rice (Paddy)</h3>
              <p>Season: Kharif</p>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>

        <div class="crop-card">
          <div class="crop-img">
            <img src="/Image/Wheat.jpg" alt="Wheat">
            <span class="season-tag">Rabi</span>
          </div>
          <div class="crop-body">
            <div>
              <h3>Wheat</h3>
              <p>Season: Rabi</p>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>

        <div class="crop-card">
          <div class="crop-img">
            <img src="/Image/Corn.jpg" alt="Maize">
            <span class="season-tag">Kharif</span>
          </div>
          <div class="crop-body">
            <div>
              <h3>Maize (Corn)</h3>
              <p>Season: Kharif</p>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>

        <div class="crop-card">
          <div class="crop-img">
            <img src="/Image/Sugarcane.jpg" alt="Sugarcane">
            <span class="season-tag">Perennial</span>
          </div>
          <div class="crop-body">
            <div>
              <h3>Sugarcane</h3>
              <p>Season: Perennial</p>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>

        <div class="crop-card">
          <div class="crop-img">
            <img src="/Image/Tomato.jpg" alt="Tomato">
            <span class="season-tag">All Season</span>
          </div>
          <div class="crop-body">
            <div>
              <h3>Tomato</h3>
              <p>Season: All Season</p>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>

        <div class="crop-card">
          <div class="crop-img">
            <img src="/Image/cotten.jpg" alt="Cotton">
            <span class="season-tag">Kharif</span>
          </div>
          <div class="crop-body">
            <div>
              <h3>Cotton</h3>
              <p>Season: Kharif</p>
            </div>
            <i class="fas fa-chevron-right"></i>
          </div>
        </div>

      </div>
    </section>


    <!-- TOOLS SECTION -->
    <section class="tools-section" id="tools">
      <h2>Quick Access Tools</h2>
      <p class="tools-subtitle">Jump into smart farming features instantly.</p>

      <div class="tools-grid">

        <div class="tool-card">
		<a href="/weather/weather">
          <div class="tool-icon sky-bg"><i class="fas fa-cloud-sun"></i></div>
          <h3>10-Day Weather Forecast</h3>
          <p>Get weather-based farming recommendations</p>
		  </a>
        </div>

        <div class="tool-card">
          <div class="tool-icon blue-bg"><i class="fas fa-vial"></i></div>
          <h3>Soil Test</h3>
          <p>Upload soil image</p>
        </div>

        <div class="tool-card">
          <div class="tool-icon green-bg"><i class="fas fa-seedling"></i></div>
          <h3>Crop Recommendation</h3>
          <p>Get AI suggestions</p>
        </div>

        <div class="tool-card">
          <div class="tool-icon purple-bg"><i class="fas fa-calendar-alt"></i></div>
          <h3>Growth Calendar</h3>
          <p>Plan your farming</p>
        </div>

        <div class="tool-card">
          <div class="tool-icon orange-bg"><i class="fas fa-headset"></i></div>
          <h3>Virtual Adviser</h3>
          <p>Instant guidance</p>
        </div>

      </div>
    </section>


    <!-- FOOTER -->
    <footer class="main-footer">
      <div class="footer-container">
        <div class="footer-col about">
          <h3><i class="fas fa-seedling"></i> AgriSmart</h3>
          <p>Empowering farmers with AI for profitable and sustainable farming.</p>
        </div>

        <div class="footer-col">
          <h4>Features</h4>
          <ul>
            <li>Crop Recommendation</li>
            <li>Soil Analysis</li>
            <li>Disease Detection</li>
            <li>Growth Calendar</li>
          </ul>
        </div>

        <div class="footer-col">
          <h4>Support</h4>
          <ul>
            <li>Help Center</li>
            <li>Video Tutorials</li>
            <li>Contact Support</li>
            <li>Community Forum</li>
          </ul>
        </div>

        <div class="footer-col">
          <h4>Legal</h4>
          <ul>
            <li>Terms of Service</li>
            <li>Privacy Policy</li>
            <li>Cookie Policy</li>
            <li>About Us</li>
          </ul>
        </div>
      </div>

      <div class="footer-bottom">© 2025 AgriSmart. All Rights Reserved.</div>
    </footer>

  </div>
</body>

</html>