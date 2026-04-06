package com.pastexplorehub.controller;

import com.pastexplorehub.model.Project;
import com.pastexplorehub.model.ProjectFile;
import com.pastexplorehub.model.TeamMembers;
import com.pastexplorehub.model.User;
import com.pastexplorehub.utils.DBConnection;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.Savepoint;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class UploadProjectDetails extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>Received Form Data</title></head><body>");
            out.println("<h2><Center>Received Form Data</Center></h2>");

            // Get form fields
            String projectTitle = request.getParameter("projectTitle");
            String description = request.getParameter("description");
            int mentorNameAsID = Integer.parseInt(request.getParameter("mentorName"));
            String techStack = request.getParameter("techStack");
            String projectLink = request.getParameter("projectLink");
            String teamLeadName = request.getParameter("teamLead.name");
            String teamLeadEnrollment = request.getParameter("teamLead.enroll");
            
            // For Project Detals in db
            Project addNewProject = new Project();
            addNewProject.setTitle(projectTitle);
            addNewProject.setDescription(description);
            addNewProject.setGuideId(mentorNameAsID);
            addNewProject.setTechStack(techStack);
            addNewProject.setProjectLink(projectLink);
            addNewProject.setEnroll_id(teamLeadEnrollment);
            Connection connection;
            try{
             connection = DBConnection.getConnection();
            connection.setAutoCommit(false);
            Savepoint project = connection.setSavepoint("project");
            int projectID = addNewProject.submitProject();
             // add Team lead
            TeamMembers.addTeamMember(projectID,teamLeadEnrollment);
              // Handle Team Members (Multiple Members) pre- Registerd only allowed
            String[] teamMembers = request.getParameterValues("teamMember.name"); // Fetch multiple values
            String[] teamMembersEnroll = request.getParameterValues("teamMember.enroll"); // Fetch multiple values
            out.println("<h3>Team Members:</h3>");
            //  Project id is genrates after submitting the project
            if (teamMembers != null && teamMembers.length > 0)
            {
                int i =0 ;
                for (String EnrollEember : teamMembersEnroll) {
                     TeamMembers.addTeamMember(projectID,EnrollEember);
                }
            }else{
                connection.rollback(project);
                connection.commit();
                out.println("<p>No team members provided.</p>");                
            }
            Collection<Part> imageParts = request.getParts();// multipal images 
            boolean hasImage = false;
            ProjectFile pf = new ProjectFile();    
            for (Part part : imageParts) {
                if (part.getName().equals("projectImages") && part.getSize() > 0) {
                hasImage = true;
                String contentType = part.getContentType();
                InputStream imageContent = part.getInputStream();
                String imageFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        pf.saveFile(projectID,imageContent,imageFileName,contentType);
    }
}
             if(!hasImage){
                 connection.rollback(project);
                out.println("<h3>Project Images Field:</h3>");
                out.println("<p>No file uploaded.</p>");
            }
        Part pdfPart = request.getPart("projectCode");
            if (pdfPart != null && pdfPart.getSize() > 0) {
                String pdfFileName = Paths.get(pdfPart.getSubmittedFileName()).getFileName().toString();
                InputStream pdfFileData = pdfPart.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int bytesRead;
                byte[] data = new byte[1024]; // Buffer of 1KB
                while ((bytesRead = pdfFileData.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, bytesRead);
                }
              boolean isSave =   pf.saveFile(projectID,pdfFileData,pdfFileName,"application/pdf");
                pdfFileData.close(); // Close stream after reading
           if(isSave)
            {
                connection.commit();
                connection.releaseSavepoint(project);
                    out.println("<h3><Center>Your Project Submited sussesfully wait for Your Guid Approvel... :)</Center></h3>");
            }
            } else {
                connection.rollback(project);
            }
            out.println("</body></html>");
        
            }catch(Exception e){
            e.printStackTrace();
            }
        }
    }
}

