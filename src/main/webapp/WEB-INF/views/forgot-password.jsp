<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>

<head>
    <title>AgriSmart | Forgot Password</title>
    <link rel="stylesheet" href="/css/forget-pass.css">
</head>

<body>
    <!-- NAVBAR -->
    <div class="navbar">
        <h2 class="nav-logo"><a href="/home">AgriSmart</a></h2>
        <a href="/login" class="index-btn">Login</a>
    </div>

    <div class="container">
        <h2>Forgot Password</h2>

        <c:if test="${not empty Success}">
            <p class="msg">${Success}</p>
        </c:if>
        <c:if test="${not empty Error}">
        <!-- <p class="error">${Error}</p> -->   
		<div id="toast">${Error}</div>

        </c:if>

        <form action="/auth/forgot-password" method="post">
            <input type="email" name="email" placeholder="Enter your email" required>
            <button type="submit">Send OTP</button>
        </form>
    </div>
</body>
</html>