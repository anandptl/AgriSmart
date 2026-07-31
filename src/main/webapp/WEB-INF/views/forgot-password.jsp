<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriSmart | Forgot Password</title>
    <link rel="stylesheet" href="/css/forget-pass.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://kit.fontawesome.com/64d58efce2.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>

<div class="navbar">
    <h2 class="nav-logo"><a href="/home">AgriSmart</a></h2>
    <a href="/login" class="index-btn">Login</a>
</div>

<div class="container">
    <h2>Forgot Password</h2>

    <!-- STEP 1 : EMAIL -->
    <div id="emailStep">
        <input type="email" id="email" placeholder="Enter your email" required>
        <button onclick="sendOtp()">Send OTP</button>
    </div>

    <!-- STEP 2 : OTP -->
    <div id="otpStep" style="display:none;">
        <input type="text" id="otp" placeholder="Enter OTP" maxlength="6">
        <button onclick="verifyOtp()">Verify OTP</button>
        <p id="otpStatus" style="text-align:center;"></p>
    </div>

    <!-- STEP 3 : RESET PASSWORD -->
    <div id="passwordStep" style="display:none;">

        <div class="password-box">
            <i class="fa fa-lock"></i>
            <input type="password" id="newPassword"
                   placeholder="Enter new password" minlength="6">
            <i class="fa fa-eye toggle-eye" onclick="togglePassword()"></i>
        </div>

        <button onclick="resetPassword()">Update Password</button>
    </div>



</div>

<script src="/js/forgot-password.js"></script>
</body>
</html>