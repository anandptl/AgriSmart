<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>Error</title>
  <style>
    body { font-family: Arial; text-align: center; background: #fef0f0; }
    .error-box {
      display: inline-block;
      padding: 20px;
      border-radius: 10px;
      background: white;
      box-shadow: 0 0 10px #ffcccc;
      margin-top: 100px;
    }
  </style>
</head>
<body>
  <div class="error-box">
    <h2>⚠️ Oops! Something went wrong.</h2>
    <p>${message}</p>
    <a href="/weather/errorWeather">🔁 Try Again</a>
  </div>
</body>
</html>
