<%-- 
    Document   : teacher
    Created on : 13 Mar, 2025, 6:36:05 PM
    Author     : Rohit
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard - Explore Hub</title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	
	<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("search");
    const tableRows = document.querySelectorAll("tbody tr");
    const deleteButtons = document.querySelectorAll(".delete");
    const editButtons = document.querySelectorAll(".edit");
    const toggleMenu = document.getElementById("toggle-menu");
    const sidebar = document.querySelector(".sidebar");

    // Toggle sidebar on mobile
    toggleMenu.addEventListener("click", function() {
        sidebar.classList.toggle("active");
    });

    // Search Functionality
    searchInput.addEventListener("keyup", function () {
        let filter = searchInput.value.toLowerCase();
        tableRows.forEach(row => {
            let title = row.children[1].textContent.toLowerCase();
            row.style.display = title.includes(filter) ? "" : "none";
        });
    });

    // Delete Confirmation
    deleteButtons.forEach(button => {
        button.addEventListener("click", function () {
            if (confirm("Are you sure you want to delete this project?")) {
                this.closest("tr").remove();
            }
        });
    });

    // Edit Functionality (Placeholder)
    editButtons.forEach(button => {
        button.addEventListener("click", function () {
            alert("Edit feature will be implemented soon!");
        });
    });
});
</script>	
</head>
<body>
    <div class="dashboard-container">
        <nav class="sidebar">
            <div class="sidebar-header">
                <img src="../assets/images/teacher.jpeg" alt="Admin Image" class="profile-img">
                <% String name = (String) session.getAttribute("user"); %>
<% if(name != null) { %>
<h3 id="sname" style="color: rgb; font-weight: bold;"><%= "Hello, "%><%=  name.toUpperCase().substring(0, name.toUpperCase().indexOf(' ')) %></h3>
<% } %>
            </div>
            <ul class="menu">
                <li><a href="#"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="#"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="#"><i class="fas fa-check-circle"></i> Approve Projects</a></li>
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
                                <th>S.NO.</th>
                                <th>Project Title</th>
                                <th>Guide</th>
                                <th>Submission Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        
                        <tbody>
                                  
                            <tr>
                                <td>1</td>
                                <td>AI-Based Chatbot</td>
                                <td>Dr. John Doe</td>
                                <td>12 Feb 2025</td>
                                <td class="status-cell"><span class="status approved"></span></td>
                                <td>
                                    <button class="view"><i class="fas fa-eye"></i></button>
                                    <button class="edit"><i class="fas fa-edit"></i></button>
                                    <button class="delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Smart Traffic System</td>
                                <td>Prof. Jane Smith</td>
                                <td>20 Jan 2025</td>
                                <td class="status-cell"><span class="status pending"></span></td>
                                <td>
                                    <button class="view"><i class="fas fa-eye"></i></button>
                                    <button class="edit"><i class="fas fa-edit"></i></button>
                                    <button class="delete"><i class="fas fa-trash"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Blockchain Voting System</td>
                                <td>Dr. Alice Brown</td>
                                <td>5 Dec 2024</td>
                                <td class="status-cell"><span class="status rejected"></span></td>
                                <td>
                                    <button class="view"><i class="fas fa-eye"></i></button>
                                    <button class="edit"><i class="fas fa-edit"></i></button>
                                    <button class="delete"><i class="fas fa-trash"></i></button>
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