<%@ page contentType="text/html;charset=UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>AgriSmart | Verify OTP</title>
		<link rel="stylesheet" href="/css/forget-pass.css">
         <!--<style>
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
                background: #28a745;
                color: #fff;
                border: none;
                cursor: pointer;
            }

            button:hover {
                background: #218838;
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
            <h2>Verify OTP</h2>

            <c:if test="${not empty Error}">
                <p class="error">${Error}</p>
            </c:if>

            <form action="/auth/verify-otp" method="post">
                <input type="hidden" name="email" value="${email}">
                <input type="text" name="otp" placeholder="Enter OTP" required maxlength="6">
                <button type="submit">Verify OTP</button>
            </form>
			
			<p style="text-align:center; margin-top:10px;">
			    <a href="/forgot-password" style="color:black; font-size:18px; text-decoration:none;">
			        Resend OTP
			    </a>
			</p>

        </div>
    </body>

    </html>