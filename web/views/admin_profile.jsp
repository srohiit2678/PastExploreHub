<%-- 
    Document   : student_profile
    Created on : 23 Mar, 2025, 12:49:35 PM
    Author     : Rohit
--%>

<%@page import="com.pastexplorehub.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% User user = (User)session.getAttribute("user"); %>
<% String name = (String) session.getAttribute("name"); %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile - Explore Hub</title>
    <!-- <link rel="stylesheet" href="student1.css"> -->
    <link rel="stylesheet" href="../assets/css/student_profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            
            <div class="sidebar-header">
                        <img src="../assets/images/admin.jpeg" alt="Admin Image" class="profile-img">
                
                <% if(name != null) { %>
                <h3 id="sname" style="color: rgb; font-weight: bold;">
                <%= "Hello, "%><%=  name.toUpperCase().substring(0, name.toUpperCase().indexOf(' ')) %></h3>
                <% } %> 

            </div>
            
            
            <ul class="menu">
                <li><a href="<%=request.getContextPath()%>/views/admin.jsp"><i class="fas fa-home"></i> Porjects</a></li>
                <li class="active"><a href="<%=request.getContextPath()%>/views/admin_profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="<%=request.getContextPath()%>/ViewActivityServlet"><i class="fas fa-chart-line"></i> View Activity</a></li>
                <li class="logout-item"><a href="login.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        
        <div class="main-content">
            <header>
                <div class="header-left">
                    <button id="toggle-menu" class="toggle-btn"><i class="fas fa-bars"></i></button>
                    <h1>Profile</h1>
                </div>
            </header>
            
            <!-- Profile Page Section -->
            <section class="profile-container">
                <div class="profile-header">
                
                <img src="../assets/images/admin.jpeg" alt="Admin Image" class="profile-img">
                
                <% if(name != null) { %>
                <h2 id="sname" style="color: rgb; font-weight: bold;">
                <%=  name%></h2>
                <% } %> 

                </div>
                
                <form id="profile-form" action="EditDetailsServlet" method="post">
                    <%if(user!=null){%>
                    <div class="profile-info">
                        <div class="info-item">
                            <div class="info-label">Name</div>
                            <input type="text" class="info-value" id="name-input" value="<%=user.getName() %>" readonly>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Department</div>
                            <input type="text" class="info-value" id="department-input" value="<%=user.getDepartment_name() %>" readonly>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Role</div>
                            <input type="text" class="info-value" id="project-input" value="<%=user.getRole() %>" readonly>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Email ID</div>
                            <input type="email" class="info-value" id="email-input" value="<%=user.getEmail() %>" readonly>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Student ID</div>
                            <input type="text" class="info-value" id="student-id-input" value="<%=user.getEnrollId() %>" readonly>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Profession</div>
                            <input type="text" class="info-value" id="profession-input" value="<%=user.getDepartment_name()+ " " + user.getRole() %>" readonly>
                        </div>
                    </div>
                    
                    <div class="profile-actions">
                        <button type="button" id="edit-profile" class="edit-button">Edit Profile</button>
                        <button type="button" id="save-profile" class="save-button" style="display: none;">Save Profile</button>
                        <button type="button" id="cancel-edit" class="cancel-button" style="display: none;">Cancel</button>
                    </div>
                        <%}
                    else
                    {
                        response.sendRedirect("login.jsp");
                    }
                    %>
                </form>
            </section>
        </div>
    </div>
        <script src="../assets/js/student_profile.js"></script>
</body>
</html>