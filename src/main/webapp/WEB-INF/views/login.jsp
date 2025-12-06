<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AgriSmart | Login</title>

        <link rel="stylesheet" href="/css/login.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
      </head>

      <body>

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

        <!-- NAVBAR -->
        <div class="navbar">
          <h2 class="nav-logo"><a href="/home">AgriSmart</a></h2>
          <a href="/home" class="index-btn">Home</a>
        </div>

        <!-- LOGIN / SIGNUP BOX -->
        <div class="login-box">

          <div class="logo-box"><i class="fas fa-seedling"></i></div>
          <h2>FarmerAI</h2>

          <!-- Switch Tabs -->
          <div class="switch-btn">
            <button id="signinTab" class="active">Sign In</button>
            <button id="signupTab">Sign Up</button>
          </div>

          <!-- Sign In Section -->
          <form action="/auth/login" method="POST" name="signinForm" class="sign-in-form" id="signinSection">

            <button class="google-btn" type="button">
              <img src="/Image/google.png">
              Continue with Google
            </button>


            <div class="divider"><span>or</span></div>

            <label>Login As</label>
            <div class="input-box">
              <i class="fas fa-user-tag"></i>
              <select name="role" required>
                <option value="FARMER">Farmer</option>
                <option value="BUYER">Buyer</option>
                <option value="ADMIN">Admin</option>
              </select>
            </div>

            <label>Email</label>
            <div class="input-box">
              <i class="fas fa-envelope"></i>
              <input type="email" name="email" placeholder="Enter email" required>
            </div>

            <label>Password</label>
            <div class="input-box password-box">
              <i class="fas fa-lock"></i>
              <input type="password" name="password" placeholder="Enter your password" required>
              <i class="fas fa-eye toggle-eye"></i>
            </div>

            <div class="options">
              <label><input type="checkbox" name="remember"> Remember me</label>
              <a href="/auth/forget">Forgot password?</a>
            </div>

            <button class="signin-btn" type="submit">Sign In</button>

            <p class="signup-text">Don't have an account? <a id="goSignup" href="#">Sign up here</a></p>

          </form>

          <!-- Sign Up Section -->
          <form action="/auth/signup" method="POST" name="signupForm" class="sign-up-form" id="signupSection"
            style="display:none;">

            <button class="google-btn" type="button">
              <img src="/Image/google.png">
              Sign up with Google
            </button>

            <div class="divider"><span>or</span></div>

            <label>Register As</label>
            <div class="input-box">
              <i class="fas fa-user-tag"></i>
              <select name="role" required>
                <option value="FARMER">Farmer</option>
                <option value="BUYER">Buyer</option>
              </select>
            </div>
        <%-- name input bod or div --%>
            <div class="name-row">
              <div class="input-group">
                <label>First Name</label>
                <div class="input-box">
                  <i class="fas fa-user"></i>
                  <input type="text" name="firstName" placeholder="First Name" required>
                </div>
              </div>

              <div class="input-group">
                <label>Last Name</label>
                <div class="input-box">
                  <i class="fas fa-user"></i>
                  <input type="text" name="lastName" placeholder="Last Name" required>
                </div>
              </div>
            </div>

            <div class="otp-row">
              <div class="input-button">
                <label>Email</label>
                <div class="input-box">
                  <i class="fas fa-envelope"></i>
                  <input type="email" name="email" placeholder="Enter your email" required>
                </div>
              </div>
              <div class="input-button">
                <label></label>
                <div class="otp-button">
                  <a href="/auth/">Sent OTP</a>
                </div>
              </div>
            </div>

            <div class="otp-row">
              <div class="input-button">
                <label>Enter OTP</label>
                <div class="input-box">
                  <i class="fas fa-envelope"></i>
                  <input type="text" name="otp" placeholder="Enter OTP" required>
                </div>
              </div>
              <div class="input-button">
                <label></label>
                <div class="otp-button">
                  <a href="/auth/">Verify OTP</a>
                </div>
              </div>
            </div>

            <label>Select Language</label>
            <div class="input-box">
              <i class="fas fa-language"></i>
              <select name="language" required>
                <option value="English">English</option>
                <option value="Hindi">हिन्दी (Hindi)</option>
                <option value="Gujarati">ગુજરાતી (Gujarati)</option>
                <option value="Marathi">मराठी (Marathi)</option>
                <option value="Tamil">தமிழ் (Tamil)</option>
              </select>
            </div>

            <label>Password</label>
            <div class="input-box password-box">
              <i class="fas fa-lock"></i>
              <input type="password" name="password" placeholder="Create password" required>
              <i class="fas fa-eye toggle-eye"></i>
            </div>

            <small>Password must be at least 8 characters long</small>

            <button class="signin-btn" type="submit" onclick="">Create Account</button>

            <p class="signup-text">Already have an account? <a id="goSignin" href="#">Sign in here</a></p>

          </form>

        </div>

        <script src="/js/login.js"></script>
      </body>

      </html>