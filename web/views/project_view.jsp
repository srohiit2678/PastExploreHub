

<%@page import="java.lang.Exception"%>
<%-- 
    Document   : project_view
    Created on : 31 Mar, 2025, 2:47:00 PM
    Author     : Rohit
--%>
<%@page import="com.pastexplorehub.model.ProjectFile"%>
<%@page import="com.pastexplorehub.model.Project"%>
<%@page import="java.util.List"%>

<%-- 
    Document   : prject_view
    Created on : 31 Mar, 2025, 2:30:30 PM
    Author     : Rohit
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project View</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4cc9f0;
            --text-color: #2b2d42;
            --light-text: #8d99ae;
            --background: #f8f9fa;
            --card-bg: #ffffff;
            --border-radius: 12px;
            --box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            --hover-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            --border-color: #e9ecef;
        }

        body {
            background-color: var(--background);
            color: var(--text-color);
            padding: 30px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .main-content {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }

        .project-details {
            flex: 2;
            min-width: 300px;
        }

        .college-info {
            flex: 1;
            min-width: 280px;
            background: var --card-bg;
            padding: 25px;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            border: 1px solid var --border-color;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .college-info:hover {
            transform: translateY(-5px);
            box-shadow: var --hover-shadow;
        }

        .section {
            background: var(--card-bg);
            padding: 25px;
            border-radius: var --border-radius;
            margin-bottom: 25px;
            box-shadow: var --box-shadow;
            border: 1px solid var --border-color;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .section:hover {
            transform: translateY(-5px);
            box-shadow: var --hover-shadow;
        }

        .project-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--primary-color);
            padding-bottom: 10px;
            border-bottom: 2px solid var --accent-color;
        }

        .slideshow-container {
            position: relative;
            max-width: 100%;
            height: 400px;
            margin-bottom: 25px;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--box-shadow);
            border: 1px solid var --border-color;
        }

        .slide {
            display: none;
            width: 100%;
            height: 100%;
        }

        .slide.active {
            display: block;
            animation: fadeIn 0.8s;
        }

        @keyframes fadeIn {
            from { opacity: 0.4; }
            to { opacity: 1; }
        }

        .slide img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .prev, .next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            padding: 12px 18px;
            color: white;
            background-color: rgba(67, 97, 238, 0.7);
            cursor: pointer;
            border: none;
            font-size: 18px;
            border-radius: 50%;
            transition: background-color 0.3s, transform 0.3s;
            z-index: 10;
        }

        .prev:hover, .next:hover {
            background-color: rgba(67, 97, 238, 0.9);
            transform: translateY(-50%) scale(1.1);
        }

        .prev {
            left: 15px;
        }

        .next {
            right: 15px;
        }

        .slideshow-indicators {
            text-align: center;
            position: absolute;
            bottom: 20px;
            width: 100%;
            z-index: 10;
        }

        .indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            background-color: rgba(255, 255, 255, 0.6);
            border-radius: 50%;
            margin: 0 6px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.3s;
        }

        .indicator.active {
            background-color: white;
            transform: scale(1.2);
        }

        .indicator:hover {
            background-color: rgba(255, 255, 255, 0.9);
            transform: scale(1.2);
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--primary-color);
            padding-bottom: 8px;
            border-bottom: 2px solid varb --accent-color;
            display: inline-block;
        }

        .project-description {
            line-height: 1.8;
            color: var(--text-color);
        }

        .project-description p {
            margin-bottom: 15px;
        }

        .project-description ul {
            margin-left: 20px;
            margin-bottom: 15px;
        }

        .project-description li {
            margin-bottom: 8px;
        }

        .project-links {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 20px;
        }

        .project-link {
            padding: 12px 20px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            text-decoration: none;
            border-radius: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
            font-weight: 500;
        }

        .project-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(67, 97, 238, 0.5);
        }

        .college-logo-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .college-logo {
            width: 120px;
            height: 120px;
            object-fit: contain;
            padding: 8px;
            border-radius: 50%;
            background-color: white;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .college-logo:hover {
            transform: scale(1.05);
        }

        .college-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--primary-color);
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 2px solid var --accent-color;
        }

        .mentor-section {
            margin-bottom: 25px;
            padding: 18px;
            border-radius: 10px;
            background-color: rgba(67, 97, 238, 0.05);
            border: 1px solid rgba(67, 97, 238, 0.1);
            transition: transform 0.3s;
        }

        .mentor-section:hover {
            transform: translateY(-5px);
        }

        .mentor-name {
            font-size: 16px;
            color: var(--secondary-color);
            font-weight: 500;
        }

        .team-section {
            margin-bottom: 25px;
            padding: 20px;
            border-radius: 10px;
            background-color: rgba(67, 97, 238, 0.05);
            border: 1px solid rgba(67, 97, 238, 0.1);
        }

        .team-member {
            margin-bottom: 12px;
            cursor: pointer;
            padding: 12px;
            border-radius: 8px;
            transition: all 0.3s;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid var --border-color;
        }

        .team-member:hover {
            background-color: rgba(67, 97, 238, 0.1);
            transform: translateX(5px);
        }

        .team-member .member-name {
            font-weight: 500;
            color: var(--text-color);
            display: flex;
            align-items: center;
        }

        .team-member .member-name::after {
            content: '\f078';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            margin-left: auto;
            font-size: 14px;
            color: var(--primary-color);
            transition: transform 0.3s;
        }

        .team-member.active .member-name::after {
            transform: rotate(180deg);
        }

        .member-details {
            display: none;
            padding: 12px;
            background-color: #f8f9fa;
            border-radius: 8px;
            margin-top: 10px;
            border: 1px solid var --border-color;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .member-details.active {
            display: block;
        }

        .member-email {
            font-size: 14px;
            color: var(--light-text);
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

        .member-email::before {
            content: '\f0e0';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            margin-right: 8px;
            color: var(--primary-color);
        }

        .tech-tag {
            display: inline-block;
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary-color);
            padding: 5px 10px;
            border-radius: 15px;
            margin-right: 8px;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .domain-section {
            margin-bottom: 25px;
            padding: 18px;
            border-radius: 10px;
            background-color: rgba(67, 97, 238, 0.05);
            border: 1px solid rgba(67, 97, 238, 0.1);
            transition: transform 0.3s;
        }

        .domain-section:hover {
            transform: translateY(-5px);
        }

        .domain-name {
            font-size: 16px;
            color: var(--secondary-color);
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .domain-name::before {
            content: '\f5fc';
            font-family: 'Font Awesome 5 Free';
            font-weight: 900;
            margin-right: 10px;
            color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .main-content {
                flex-direction: column;
            }
            
            .slideshow-container {
                height: 300px;
            }
            
            body {
                padding: 15px;
            }
            
            .project-links {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <%try{%>
    <div class="container">
                             <%
                                Project projectDetails = (Project)request.getAttribute("project");
                                
                                if(projectDetails != null){
                              %>
        <div class="main-content">
            <div class="project-details">
                <div class="section">
                    <h1 class="project-title" id="project-title"><%= projectDetails.getTitle() %></h1>
                </div>
                    <%
                        List<ProjectFile> files = projectDetails.getFiles();
                        if (files != null && !files.isEmpty()) {
                    %>
                <div class="slideshow-container">
                      <% for (int i = 0; i < files.size()-1; i++) {{
                          ProjectFile file = files.get(i);
                      %>
                <div class="slide <%= (i == 0) ? "active" : "" %>">
                      <% 
                        if(!(file.getFileName().contains("pdf"))){
                      %>
                <img src="${pageContext.request.contextPath}/GetFileServlet?file_Id=<%= file.getFileId() %>" alt="<%= file.getFileName() %>">
                
                <% } %>
                </div>
                <% } } %>

        <button class="prev" onclick="changeSlide(-1)"><i class="fas fa-chevron-left"></i></button>
        <button class="next" onclick="changeSlide(1)"><i class="fas fa-chevron-right"></i></button>

        <div class="slideshow-indicators">
            <% 
                    for (int i = 0; i < files.size()-1; i++) { 
            %>
                <span class="indicator <%= (i == 0) ? "active" : "" %>" onclick="goToSlide(<%= i %>)"></span>
            <% } %>
        </div>
                </div>
            <%
            }
            %>
                <div class="section">
                    <h2 class="section-title">Project Description</h2>
                    <div class="project-description" id="project-description">
                        <p><%= projectDetails.getDescription() %></p>
                        <div>
                            <span class="tech-tag"><%= projectDetails.getTechStack() %></span>
                            
                        </div>
                    </div>
                </div>
                <div class="section">
                    <h2 class="section-title">Project Links</h2>
                    <div class="project-links">               
                        
                    <a href="<%= projectDetails.getProjectLink() %>" class="project-link" id="live-link" target = "_blank"><i class="fas fa-external-link-alt"></i> <%= projectDetails.getProjectLink() %></a>
                   
                    <% for (int i = 0; i < files.size(); i++) {
                          ProjectFile file = files.get(i);
                        if((file.getFileName().contains("pdf"))){
                      %>    
                        <a href="${pageContext.request.contextPath}/GetFileServlet?file_Id=<%= file.getFileId() %>" class="project-link" id="download-link"><i class="fas fa-download"></i> Download Code</a>
                    
                    <%
                        }}
                    %>
                    </div>
                </div>
            </div>
            
            <div class="college-info">
                <div class="college-logo-container">
                    <img src="${pageContext.request.contextPath}/assets/images/cdgi.png" alt="College Logo" class="college-logo">
                </div>
                <h2 class="college-name">CDGI,Indore</h2>
                
                <div class="mentor-section">
                    <h3 class="section-title">Project Mentor</h3>
                    <p class="mentor-name" id="mentor-name"><i class="fas fa-user-tie"></i> <%= projectDetails.getGuidName() %></p>
                </div>
                <div class="team-section">
                    <h3 class="section-title">Team Members</h3>
                                    
                    <%
                    List<String> mem = projectDetails.getMember();
                    for(int i=0;i<mem.size();i++)
                    {
                    %>
                    <div class="team-member" onclick="toggleMemberDetails(0)" id="team-member-0">
                        <p class="member-nam e"><%= mem.get(i) %></p>
                    </div>

                    <%
                    }
                    %>
                </div>
                    
            </div>
        </div>
    </div>
            
    
<%
}
%>
    <script>
        // Slideshow functionality
        let currentSlide = 0;
        const slides = document.querySelectorAll('.slide');
        const indicators = document.querySelectorAll('.indicator');
        
        function showSlide(index) {
            // Hide all slides
            slides.forEach(slide => {
                slide.classList.remove('active');
            });
            
            // Hide all indicators
            indicators.forEach(indicator => {
                indicator.classList.remove('active');
            });
            
            // Show the selected slide and indicator
            slides[index].classList.add('active');
            indicators[index].classList.add('active');
        }
        
        function changeSlide(direction) {
            currentSlide += direction;
            
            // Loop back to the first slide if at the end
            if (currentSlide >= slides.length) {
                currentSlide = 0;
            }
            
            // Loop to the last slide if going back from the first
            if (currentSlide < 0) {
                currentSlide = slides.length - 1;
            }
            
            showSlide(currentSlide);
        }
        
        function goToSlide(index) {
            currentSlide = index;
            showSlide(currentSlide);
        }
        
        // Auto advance slides every 5 seconds
        setInterval(() => {
            changeSlide(1);
        }, 5000);
        
        // Team member details toggle functionality
        function toggleMemberDetails(index) {
            const memberDetails = document.getElementById(`member-${index}`);
            const teamMember = document.getElementById(`team-member-${index}`);
            
            // Toggle active class
            if (memberDetails.classList.contains('active')) {
                memberDetails.classList.remove('active');
                teamMember.classList.remove('active');
            } else {
                // Close all other details first
                document.querySelectorAll('.member-details').forEach(detail => {
                    detail.classList.remove('active');
                });
                
                document.querySelectorAll('.team-member').forEach(member => {
                    member.classList.remove('active');
                });
                
                // Open the selected details
                memberDetails.classList.add('active');
                teamMember.classList.add('active');
            }
        }
    </script>
    <% }catch(Exception e){ e.printStackTrace(); }%>
</body>
</html>
