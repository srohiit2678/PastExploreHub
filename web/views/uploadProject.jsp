<%-- 
    Document   : student
    Created on : 13 Mar, 2025, 5:21:50 PM
    Author     : Rohit
--%>

<%@page import="com.pastexplorehub.model.ProjectTages"%>
<%@page import="com.pastexplorehub.model.ProjectGuid"%>
<%@page import="com.pastexplorehub.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.pastexplorehub.model.Project"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Dashboard - Explore Hub</title>
    <link rel="stylesheet" href="../assets/css/UploadProject.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            const toggleMenu = document.getElementById("toggle-menu");
            const sidebar = document.querySelector(".sidebar");

            // Toggle sidebar on mobile
            toggleMenu.addEventListener("click", function() {
                sidebar.classList.toggle("active");
            });
            
            // Handle menu clicks
            document.querySelectorAll(".menu a").forEach(function(link) {
                link.addEventListener("click", function(e) {
                    // Don't prevent default for external links
                    if (this.getAttribute("href").startsWith("#")) {
                        e.preventDefault();
                    }
                    
                    // Remove active class from all menu items
                    document.querySelectorAll(".menu li").forEach(function(item) {
                        item.classList.remove("active");
                    });
                    
                    // Add active class to current menu item
                    this.parentElement.classList.add("active");
                });
            });
        });

        function addTeamMember() {
            const teamMembersDiv = document.getElementById("teamMembers");
            const div = document.createElement("div");
            div.classList.add("team-member");
            div.innerHTML = `
                <input type="text" name="teamMember.name" placeholder="Team Member Name" required>
                <input type="text" name="teamMember.enroll" placeholder="Enrollment Number" required>
                <button type="button" onclick="removeTeamMember(this)">Delete</button>
            `;
            teamMembersDiv.appendChild(div);
        }
        
        function removeTeamMember(button) {
            button.parentElement.remove();
        }
        
        document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("projectForm");
    if (form) {
        form.addEventListener("submit", function (event) {
            const files = document.getElementById("projectImages").files;
            if (files.length < 1 || files.length > 5) {
                alert("Please upload between 1 and 5 images.");
                event.preventDefault();
            }
        });
    }
});

    </script>
</head>
<body>
    <div class="dashboard-container">
        <!-- Left sidebar - stays the same -->
        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="../assets/images/student.webp" alt="student Image" class="profile-img">

                <% String name = (String) session.getAttribute("name"); %>
                
                <% if(name != null) { %>
                <h3 id="sname" style="color: rgb(255,255,255); font-weight: bold;">
                <%= "Hello, "%><%=  name.toUpperCase().substring(0, name.toUpperCase().indexOf(' ')) %></h3>
                <% } %> 
           
	    </div>
            <ul class="menu">
                <li><a href="student.jsp"><i class="fas fa-home"></i> Porjects</a></li>
                <li><a href="student_profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                <li class="active"><a href="uploadProject.jsp"><i class="fas fa-upload"></i> Upload Projects</a></li>
                <li class="logout-item"><a href="login.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        
        <!-- Right container - content changes -->
        <div class="main-content">
            <header>
                <div class="header-left">
                    <button id="toggle-menu" class="toggle-btn"><i class="fas fa-bars"></i></button>
                    <h1>Upload Project</h1>
                </div>
            </header>
            
            <!-- Submit Project Content -->
            <div class="content-section">
                <form id="projectForm" action="${pageContext.request.contextPath}/UploadProjectDetails" method="post" enctype="multipart/form-data">
                    <label for="projectTitle" class="required">Project Title:</label>
                    <input type="text" id="projectTitle" name="projectTitle" placeholder="Enter your project title" required>
                    
                    <label for="description" class="required">Project Description (Max 500 characters):</label>
                    <textarea id="description" name="description" placeholder="Write a short description of your project" maxlength="500" required></textarea>
                    
                    <label for="mentorName" class="required">Select Mentor:</label>
                    <select id="mentorName" name="mentorName" required>
                    <option value="" disabled selected>Select Mentor</option>                      
                        <%
                           List<ProjectGuid> GuidesList = ProjectGuid.getAllGuids();
                           for(ProjectGuid all:GuidesList){
                        //de-buged 
                            //   System.out.println(all.getGuidName());
                        %>                      
                    <option value="<%= all.getGuidId() %>"><%= all.getGuidName() %></option>
                         <%}%>
                    </select>
                    
                    <div id="teamMembers">
                        <label class="required">Team Lead:</label>
                        <div class="team-member">
                            <input type="text" name="teamLead.name" placeholder="Team Lead Name" required>
                            <input type="text" name="teamLead.enroll" placeholder="Enrollment Number" required>
                        </div>
                        <label class="required">Team Members:</label>
                        <div class="team-member">
                            <input type="text" name="teamMember.name" placeholder="Team Member Name" required>
                            <input type="text" name="teamMember.enroll" placeholder="Enrollment Number" required>
                            <button type="button" onclick="removeTeamMember(this)">Delete</button>
                        </div>
                    </div>
                    <button type="button" onclick="addTeamMember()">+ Add Team Member</button>
                    
                    <label for="techStack" class="required">Select Tech Stack:</label>
                    <select id="techStack" name="techStack" required>
                        <option value="" disabled selected>Select Tech Stack</option>
                        <%
                           List<ProjectTages> tagList = ProjectTages.getTages();
                           for(ProjectTages list:tagList)
                           {
                        %>
                        <option value="<%= list.getTagName() %>"><%= list.getTagName() %></option>
                    <% } %>
                    </select>
                    <label for="projectLink" class="required">Project Link:</label>
                    <input type="url" id="projectLink" name="projectLink" placeholder="Enter your project GitHub/GitLab link" required>
                    
                    <label for="projectImages" class="required">Upload Project Images (JPG/PNG only, min 1 - max 5):</label>
                    <input type="file" id="projectImages" name="projectImages" accept="image/png, image/jpeg" multiple required>
                    
                    <label for="projectCode" class="required">Upload Project Code (PDF only):</label>
                    <input type="file" id="projectCode" name="projectCode" accept="application/pdf" required>
                    
                    <div class="button-container">
                        <button type="submit">Submit Project</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
