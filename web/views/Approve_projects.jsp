<%-- 
    Document   : Approve_projects
    Created on : 12 Apr, 2025, 11:54:48 AM
    Author     : Rohit
--%>
<%@page import="com.pastexplorehub.model.Project"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Approval - Explore Hub</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/teacher_approve.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .popup {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100vh;
            background: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
            z-index: 999;
        }

        .popup-content {
            background: white;
            width: 70%; height: 80vh;
            position: relative;
            border-radius: 10px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }
        
        
        .popup-content2 {
            background: white;
            width: 50%; height: 35vh;
           
        }

        .popup-content iframe {
            flex: 1;
            width: 100%;
            border: none;
        }

        .close-btn {
            background: crimson;
            color: white;
            padding: 8px 16px;
            font-weight: bold;
            text-align: center;
            cursor: pointer;
        }

        /* Optional: Visual feedback on row status */
        .approved-row { background-color: #d4edda; }
        .rejected-row { background-color: #f8d7da; }
        .pending-row { background-color: #fff3cd; }

   .no-border {
    border: none;
    outline: none;
    background-color: transparent; /* optional, for fully clean look */
    font-family: inherit;
    font-size: inherit;
  }

    </style>
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="<%=request.getContextPath()%>/assets/images/teacher.jpeg" alt="Teacher" class="profile-img">
<% String name = (String) session.getAttribute("name"); %>                
<% Integer user_id = (Integer) session.getAttribute("user_id"); %>                
                <% if(name != null) { %>
                <h3 id="sname" style="color: rgb; font-weight: bold;"><%= "Hello, "%><%=  name.toUpperCase().substring(0, name.toUpperCase().indexOf(' ')) %></h3>
                <% } %>
            </div>
            <ul class="menu">
                <li><a href="teacher.jsp"><i class="fas fa-home"></i> Porjects</a></li>
                <li><a href="teacher_profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="Approve_projects.jsp" class="active"><i class="fas fa-check-circle"></i> Approve Projects</a></li>
            </ul>
        </nav>

        <div class="main-content">
            <header>
                <div class="header-left">
                    <button id="toggle-menu" class="toggle-btn"><i class="fas fa-bars"></i></button>
                    <h1>Project Approvals</h1>
                </div>
                <input type="text" id="search" placeholder="Search projects...">
            </header>

            <section class="project-list">
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>S.NO.</th>
                                <th>Project Title</th>
                                <th>Submission Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Project> projectList = (List<Project>) session.getAttribute("pending_projects");
                                if (projectList != null) {
                                    int count = 1;
                                    for (Project project : projectList) {
                                      if(project.getGuideId()==user_id)  {
                            %>
                            <tr data-project-id="<%= project.getProjectId() %>">
                                <td><%= count++ %></td>
                                <td><%= project.getTitle() %></td>
                                <td><%= project.getCreatedAt().getDate() %>-<%= project.getCreatedAt().getMonth() + 1 %>-<%= project.getCreatedAt().getYear() + 1900 %></td>
                                <td class="status-cell">
                                    <button class="view" onclick="openPopup2(<%= project.getProjectId()%>)">
                                        <i class="fas fa-edit"></i>
                                    </button>                                   
                                </td>
                                <td>
                                    <button class="view" onclick="openPopup(<%= project.getProjectId() %>)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <% 
                                    } } 
                                } else {
                                    response.sendRedirect("login.jsp");
                                } 
                            %>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>

    <!-- Popup Container -->
    <div id="popupContainer" class="popup">
        <div class="popup-content">
            <div class="close-btn" onclick="closePopup()"> Close</div>
            <iframe src=""></iframe>
        </div>
    </div>

    
    <!-- Popup Container2 -->
    <div id="popupContainer2" class="popup">
        <div class="popup-content2">
            <div class="close-btn" onclick="closePopup()"> Close</div>
           <form action="\PastExploreHub\TeacherAction">
            <table cellpadding="20px">
                <tr>
                    <td>
                      <lable for="project_id">Project ID : </lable>
                      <input type="text" name = "project_id" id="_id" readonly class ="no-border">
                    </td>
                </tr>
                <tr>
                    <td>
                    <textarea name="message" style="width: 100%; height: 15vh" placeholder="Type your message..."></textarea>         
                    </td>
                </tr>
                <tr>
                     <td>
                       <input type="Submit" name="resion-status" value="Approve">
                       <input type="Submit" name="resion-status" value="Pending">
                       <input type="Submit" name="resion-status" value="Reject">        
                     </td>
                </tr>
            </table> 
               
           </form>
        </div>
    </div>

    
    <!-- Scripts -->
    <script>
        function openPopup(projectId) {
            const iframe = document.querySelector("#popupContainer iframe");
            iframe.src = "${pageContext.request.contextPath}/FatchProjectDetails?id=" + projectId;
            document.getElementById("popupContainer").style.display = "flex";
        }
        
        function openPopup2(projectId) {
            const iframe = document.querySelector("#popupContainer iframe");
            document.getElementById("popupContainer2").style.display = "flex";
            document.getElementById('_id').value=projectId+100;            

    }
        
        function closePopup() {
            document.getElementById("popupContainer").style.display = "none";
            document.getElementById("popupContainer2").style.display = "none";

        }
          
        document.addEventListener("DOMContentLoaded", function () {
            const statusDropdowns = document.querySelectorAll(".status-dropdown");
            const tableRows = document.querySelectorAll("tbody tr");
            const searchInput = document.getElementById("search");
            const toggleMenu = document.getElementById("toggle-menu");
            const sidebar = document.querySelector(".sidebar");
            const mainContent = document.querySelector(".main-content");

            toggleMenu.addEventListener("click", () => sidebar.classList.toggle("active"));
            mainContent.addEventListener("click", () => {
                if (window.innerWidth <= 992) sidebar.classList.remove("active");
            });

            searchInput.addEventListener("keyup", () => {
                const filter = searchInput.value.toLowerCase();
                tableRows.forEach(row => {
                    const title = row.children[1].textContent.toLowerCase();
                    row.style.display = title.includes(filter) ? "" : "none";
                });
            });

            statusDropdowns.forEach(dropdown => {
                const contextPath = "<%= request.getContextPath() %>";
                dropdown.addEventListener("change", function () {
           // alert("your Action is saved will show you effect on next visite");
                    const row = this.closest("tr");
                    const projectId = row.getAttribute("data-project-id");
                    const newStatus = this.value;
                    console.log(projectId);
                    console.log(newStatus);
                    
                    row.classList.remove("approved-row", "rejected-row", "pending-row");
                    row.classList.add(newStatus + "-row");

                    // AJAX call
                    fetch(contextPath+"/ProjectApprovalServlet", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/x-www-form-urlencoded"
                        },
                        body: `projectId=`+projectId+`&status=`+newStatus
                    })
                    .then(response => response.text())
                    .then(data => console.log("Response:", data))
                    .catch(error => console.error("Error:", error));
                });
            });
        });
    </script>
</body>
</html>
