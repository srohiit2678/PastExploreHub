<%-- 
    Document   : register
    Created on : 13 Mar, 2025, 11:08:58 AM
    Author     : Rohit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Hub - Register</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/register.css">

</head>
<body>
    <div class="container">
        <!-- Welcome Section with Logo -->
        <div class="welcome-section">
            <h2>Join Explore Hub</h2>
			<img src="../assets/images/cdgi.png" alt="Explore College Logo"><br><br><br><br><br><br>
			<h2 style="color:yellow;" id="x"></h2><br><br><br><br>
            <p>Sign up and start exploring amazing projects with expert guidance.</p>
        </div>
        
        <!-- Register Section -->
        <div class="register-section">
            <h2>Register</h2>
            <%--<form action="<%= request.getContextPath() %>/UserRegisterServlet" method="POST">
 --%>
            <form action="<%=request.getContextPath()%>/UserRegisterServlet" id="registerForm" method="POST">
                <!-- Full Name Input -->
                <label for="name">Full Name<span style="color:red;">*</span>:</label>
                <input type="text" id="name" name="name" placeholder="Enter your full name" required>
                
                <!-- Enrollment ID Input -->
                <label for="enroll_id">Enrollment ID<span style="color:red;">*</span>:</label>
                <input type="text" id="enroll_id" name="enroll_id" placeholder="Enter your enrollment ID" required>
                
                <!-- Email Input -->
                <label for="email">Email<span style="color:red;">*</span>:</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                
                <!-- Department Selection Dropdown -->
                <label for="department">Department<span style="color:red;">*</span>:</label>
                <select id="department" name="department_id" required>
                    <option value="">Select Department</option>
                    <option value="1">Computer Science</option>
                    <option value="2">Information Technology</option>
                    <option value="3">Artificial Intelligence</option>
                </select>
                
                <!-- Role Type Selection Dropdown -->
                <label for="type">Role Type<span style="color:red;">*</span>:</label>
                <select id="type" name="role_type" required>
                    <option value="">Select Role</option>
                    <option value="student">Student</option>
                    <option value="teacher">Teacher</option>
                    <option value="admin">Admin</option>
                </select>
                
                <!-- Password Input -->
                <label for="password">Password<span style="color:red;">*</span>:</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
                <span id="password-error" style="color:red;"></span>  

                <!-- Confirm Password Input -->
                <label for="confirm-password">Confirm Password<span style="color:red;">*</span>:</label>
                <input type="password" id="confirm-password" name="confirm_password" placeholder="Confirm your password" required>
                <span id="confirm-password-error" style="color:red;"></span>  

                <!-- Register Button -->
                <button type="button" onclick="validateForm()">Register</button>
            </form>
            
            <!-- Link to Login Page -->
            <p>Already have an account? <a href="<%=request.getContextPath()%>/views/login.jsp">Login</a></p>
      <% String errorMessage = (String) request.getAttribute("error"); %>
<% if (errorMessage != null) { %>
    <p style="color: red; font-weight: bold;"><%= errorMessage %></p>
<% } %>
        </div>
    
    </div>
            <!-- js validation -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/assets/js/validation.js"></script>

</body>
</html>