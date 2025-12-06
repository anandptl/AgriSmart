<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>AgriSmart | Reset Password</title>
		<link rel="stylesheet" href="/css/forget-pass.css">
       <!-- <style>
            body {
                font-family: Inter, -apple-system, BlinkMacSystemFont, Segoe UI, sans-serif;
                background: linear-gradient(rgba(0, 0, 0, .35), rgba(0, 0, 0, .2)), url('../Image/Morning.jpg') center/cover no-repeat;
           
            }

            .container {
                width: 350px;
                margin: 80px auto;
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px #ccc;
            }

            h2 {
                text-align: center;
            }

            input,
            button {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            button {
                background: #dc3545;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            button:hover {
                background: #c82333;
            }

            .msg {
                color: green;
                text-align: center;
                margin-top: 10px;
            }

            .error {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
        </style> -->
    </head>

    <body>
		<!-- NAVBAR -->
		<div class="navbar">
		    <h2 class="nav-logo"><a href="/home">AgriSmart</a></h2>
		    <a href="/login" class="index-btn">Login</a>
		</div>
		
        <div class="container">
            <h2>Reset Password</h2>

            <c:if test="${not empty Error}">
                <p class="error">${Error}</p>
            </c:if>

            <form action="/auth/reset-password" method="post">
                <input type="hidden" name="email" value="${email}">
                <input type="password" name="newPassword" placeholder="Enter New Password" required minlength="6">
                <button type="submit">Update Password</button>
            </form>

        </div>
    </body>

    </html>