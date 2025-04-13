<%-- 
    Document   : view_activity
    Created on : 11 Apr, 2025, 11:06:08 PM
    Author     : Rohit
--%>

<%@page import="com.pastexplorehub.model.AdminActivity"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project Status Table</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/view_activity.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar from admin page -->
        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="<%=request.getContextPath()%>/assets/images/admin.jpeg" alt="Admin Image" class="profile-img">
                <% String name = (String) session.getAttribute("name"); %>
                <% if(name != null) { %>
                <h3 id="sname" style="color: rgb; font-weight: bold;">
                <%= "Hello, "%><%=  name.toUpperCase().substring(0, name.toUpperCase().indexOf(' ')) %></h3>
                <% } %> 
            </div>
            <ul class="menu">
                <li><a href="<%=request.getContextPath()%>/views/admin.jsp"><i class="fas fa-home"></i> Porjects</a></li>
                <li><a href="<%=request.getContextPath()%>/views/admin_profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                <li class="active"><a href="<%=request.getContextPath()%>/view_activity.jsp"><i class="fas fa-chart-line"></i> View Activity</a></li>
                <li class="logout-item"><a href="login.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        
        <!-- Main content with the toggle button -->
        <div class="main-content">
            <header>
                <div class="header-left">
                    <button id="toggle-menu" class="toggle-btn"><i class="fas fa-bars"></i></button>
                    <%
                    List<AdminActivity> activita_Data =(List<AdminActivity>) request.getAttribute("activita_Data");
                    %>
                    <h1>Project Status Dashboard</h1>
                </div>
            </header>
            
            <div class="container">
                <table id="projectTable">
                    <thead>
                        <tr>
                            <th>Guide</th>
                            <th>Department</th>
                            <th>Approved</th>
                            <th>Pending</th>
                            <th>Rejected</th>
                            <th>Total Projects</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        for(AdminActivity details:activita_Data)
                        {
                        %>
                        <tr>
                            <td><%= details.getGuide_name() %></td>
                            <td><%= details.getGuide_department() %></td>
                            <td class="count"><%= details.getApproved_count() %></td>
                            <td class="count"><%= details.getPending_count() %></td>
                            <td class="count"><%= details.getRejected_count() %></td>
                            <td class="total"><%= details.getTotal_projects() %></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="<%=request.getContextPath()%>/assets/js/view_activity.js"></script>
    <!-- Add sidebar toggle functionality -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const toggleMenu = document.getElementById("toggle-menu");
            const sidebar = document.querySelector(".sidebar");
            const mainContent = document.querySelector(".main-content");

            // Toggle sidebar on mobile
            toggleMenu.addEventListener("click", function() {
                sidebar.classList.toggle("active");
            });

            // Close sidebar when clicking on main content (mobile only)
            mainContent.addEventListener("click", function(e) {
                if (window.innerWidth <= 992 && sidebar.classList.contains("active")) {
                    sidebar.classList.remove("active");
                }
            });
        });
    </script>
</body>
</html>
