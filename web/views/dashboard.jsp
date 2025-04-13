<%-- 
    Document   : dashboard
    Created on : 22 Mar, 2025, 9:39:44 AM
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
        <%
        List<Project> ProjectList = (List<Project>) session.getAttribute("projects");
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
                <td><span class="status approved" title="Approved"></span></td>
                <td>
                    <button class="view" type="submit" name = "id" onclick="openPopup(<%= project.getProjectId() %>)"><i class="fas fa-eye"></i></button>
                    </td>
            </tr>
        <%}}else{%><th>Error:your Session might be End</th><%response.sendRedirect("login.jsp");}%>
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
    
    <script>
      function openPopup(projectId) {
                 // Set iframe source with project ID
        const iframe = document.querySelector("#popupContainer iframe");
        iframe.src = "${pageContext.request.contextPath}/FatchProjectDetails?id=" + projectId;
       
          document.getElementById("popupContainer").style.display = "flex";
       }

      function closePopup() {
          document.getElementById("popupContainer").style.display = "none";
      }
  </script>