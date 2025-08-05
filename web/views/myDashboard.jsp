<%-- 
    Document   : myDashboard
    Created on : 24 Apr, 2025, 11:12:01 AM
    Author     : Rohit
--%>



<%@page import="com.pastexplorehub.model.Project"%>
<%@page import="java.util.List"%>

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
       <% int user_id = (Integer) session.getAttribute("user_id");
       List<Project> ProjectList = Project.getMyProjects(user_id+""); // declared at my_project.jsp
        if(ProjectList!=null){ int size = 1;
        %>    
        <%
        for(Project project:ProjectList)
            {
        %>
            <tr>
                <td><%= size++ %></td>
                <td><%= project.getTitle()%></td>
                <td><%= project.getGuidName() %></td>
                <td><%= project.getCreatedAt().getDate() %> - <%=project.getCreatedAt().getMonth() %> - <%= project.getCreatedAt().getYear()+1900 %></td>
                <%try {%>
                <td>
                    <button class="view" onclick="openPopup2()">
                                       <i class="fas fa-edit"></i>
                    </button> 
                </td>
                <% }catch(Exception e){} %>
                <td>
                    <button class="view" type="submit" name = "id" onclick="openPopup(<%= project.getProjectId() %>)"><i class="fas fa-eye"></i></button>
                    </td>
            </tr>
    </tbody>
</table>
</div>
    
    
    <!-- Popup Container -->
    <div id="popupContainer" class="popup">
      <div class="popup-content">
          <span class="close-btn" onclick="closePopup()" style="text-align:center;">click here close</span>
          <iframe src="project_view.jsp" frameborder="0"></iframe>
      </div>
  </div>   
    
     
    <!-- Popup Container2 -->
    <div id="popupContainer2" class="popup">
        <div class="popup-content2">
            <div class="close-btn" onclick="closePopup()" align="center"> Close</div>
            <table cellpadding="20px">
                <tr>
                    <td>
                      <p> <%= project.getMessage() %> </p>
                    </td>
                </tr>
                
            </table> 
               
        </div>
    </div>
        <%}}else{%><p>Error:your Session might be End</p><%response.sendRedirect("login.jsp");}%>

    <script>
        function openPopup(projectId) {
            const iframe = document.querySelector("#popupContainer iframe");
            iframe.src = "${pageContext.request.contextPath}/FatchProjectDetails?id=" + projectId;
            document.getElementById("popupContainer").style.display = "flex";
        }
        
        function openPopup2() {
            const iframe = document.querySelector("#popupContainer iframe");
            document.getElementById("popupContainer2").style.display = "flex";

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
    