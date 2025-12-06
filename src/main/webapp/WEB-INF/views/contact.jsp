<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AgriSmart | Contact Us |</title>
  <link rel="stylesheet" href="/css/contact.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>

<body>

  <div class="navbar">
    <h2 class="nav-logo">AgriSmart</h2>
    <a href="/home" class="home-btn">Home</a>
  </div>

  <section class="contact-section">

    <div class="contact-box">

      <h2>Contact Us</h2>
      <p class="subtitle">We’d love to hear from you!</p>

      <form id="contactForm">
        
        <label>Name</label>
        <div class="input-box">
          <i class="fas fa-user"></i>
          <input type="text" id="name" placeholder="Enter your name">
        </div>

        <label>Email</label>
        <div class="input-box">
          <i class="fas fa-envelope"></i>
          <input type="email" id="email" placeholder="Enter your email">
        </div>

        <label>Message</label>
        <textarea id="message" placeholder="Write your message..."></textarea>

        <button type="submit" class="send-btn">Send Message</button>

        <p id="formStatus"></p>
      </form>

    </div>

  </section>

<script src="js/contact.js"></script>
</body>
</html>
