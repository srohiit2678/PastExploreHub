<%-- 
    Document   : admin
    Created on : 13 Mar, 2025, 5:24:34 PM
    Author     : Rohit
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Explore Hub</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	
	<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("search");
    const tableRows = document.querySelectorAll("tbody tr");
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

    // Search Functionality
    searchInput.addEventListener("keyup", function () {
        let filter = searchInput.value.toLowerCase();
        tableRows.forEach(row => {
            let title = row.children[1].textContent.toLowerCase();
            row.style.display = title.includes(filter) ? "" : "none";
        });
    });
});
</script>	
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="../assets/images/admin.jpeg" alt="Admin Image" class="profile-img">
                <% String name = (String) session.getAttribute("user"); %>
<% if(name != null) { %>
<h3 id="sname" style="color: rgb; font-weight: bold;"><%= "Hello, "%><%=  name.toUpperCase().substring(0, name.toUpperCase().indexOf(' ')) %></h3>
<% } %>
            </div>
            <ul class="menu">
                <li><a href="#"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="#"><i class="fas fa-chart-line"></i> View Activity</a></li>
                <li class="logout-item"><a href="#"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        
        <div class="main-content">
            <header>
                <div class="header-left">
                    <button id="toggle-menu" class="toggle-btn"><i class="fas fa-bars"></i></button>
                    <h1>Dashboard</h1>
                </div>
                <input type="text" id="search" placeholder="Search projects...">
            </header>
            
            <section class="project-list">
                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th style="text-align: center;">S.NO.</th>
                                <th style="text-align: center;">Project Title</th>
                                <th style="text-align: center;">Guide</th>
                                <th style="text-align: center;">Submission Date</th>
                                <th style="text-align: center;">Status</th>
                                <th style="text-align: center;">Actions</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                                  
                            <tr>
                                <td style="text-align: center;">1</td>
                                <td style="text-align: center;">AI-Based Chatbot</td>
                                <td style="text-align: center;">Dr. John Doe</td>
                                <td style="text-align: center;">12 Feb 2025</td>
                                <td style="text-align: center;"><span class="status approved" title="Approved"></span></td>
                                <td>
                                    <button class="view"><i class="fas fa-eye"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center;">2</td>
                                <td style="text-align: center;">Smart Traffic System</td>
                                <td style="text-align: center;">Prof. Jane Smith</td>
                                <td style="text-align: center;">20 Jan 2025</td>
                                <td style="text-align: center;"><span class="status approved" title="Approved"></span></td>
                                <td>
                                    <button class="view"><i class="fas fa-eye"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center;">3</td>
                                <td style="text-align: center;">Blockchain Voting System</td>
                                <td style="text-align: center;">Dr. Alice Brown</td>
                                <td style="text-align: center;">5 Dec 2024</td>
                                <td style="text-align: center;"><span class="status approved" title="Approved"></span></td>
                                <td>
                                    <button class="view"><i class="fas fa-eye"></i></button>
                                </td>
                            </tr>
                            <!--more Rows-->
                        
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination Controls -->
                <div class="pagination">
                    <a href="#" class="prev">Previous</a>
                    <span>Page 1 of 5</span>
                    <a href="#" class="next">Next</a>
                </div>
            </section>
        </div>
    </div>
</body>
</html>