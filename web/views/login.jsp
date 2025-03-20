<%-- 
    Document   : login
    Created on : 13 Mar, 2025, 11:05:23 AM
    Author     : Rohit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Hub - Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
</head>
<body>
    <div class="container">
        <div class="welcome-section">
            <h2>Welcome to Explore Hub</h2>
    <img src="${pageContext.request.contextPath}/assets/images/cdgi.png"><br>
            <h2 style="color:yellow;" id="x"></h2><br>
            <p>Join us and explore amazing projects with guidance from seniors and teachers.</p>
        </div>
        <div class="login-section">
            <h2>Login</h2>
       
           <form action="${pageContext.request.contextPath}/UserLoginServlet" method="POST" onsubmit="return validateLogin()">
                <label for="enroll_id">Enrollment ID:</label>
                <input type="text" id="enroll_id" name="enroll_id" placeholder="Enter your Enrollment ID" required>
                
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" placeholder="Enter your Password" required>
                                        
                <button type="submit">Login</button>
            </form>
            <p>New User? <a href="${pageContext.request.contextPath}/views/register.jsp">Sign Up</a>| <a href="forgot_password.jsp">Forgot your password?</a></p>
           <% String errorMessage = (String) request.getAttribute("loginError"); %>
<% if (errorMessage != null) { %>
    <p style="color: red; font-weight: bold;"><%= errorMessage %></p>
<% } %>

        </div>
    </div>
<script src="${pageContext.request.contextPath}/assets/js/validation.js"></script>

</body>
</html>
