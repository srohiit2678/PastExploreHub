package com.pastexplorehub.controller;

import com.pastexplorehub.model.Project;
import com.pastexplorehub.model.ProjectFile;
import com.pastexplorehub.model.TeamMembers;
import com.pastexplorehub.model.User;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Paths;
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
           
          //  out.println("<p><strong>Project Title:</strong> " + projectTitle + "</p>");
            addNewProject.setTitle(projectTitle);
            
          //  out.println("<p><strong>Description:</strong> " + description + "</p>");
            addNewProject.setDescription(description);
          //  out.println("<p><strong>Mentor Name:</strong> " + mentorNameAsID + "</p>");
            addNewProject.setGuideId(mentorNameAsID);
          //  out.println("<p><strong>Tech Stack:</strong> " + techStack + "</p>");
            addNewProject.setTechStack(techStack);
          //  out.println("<p><strong>Project Link:</strong> " + projectLink + "</p>");
            addNewProject.setProjectLink(projectLink);

            // Display Team Lead Details
          //  out.println("<h3>Team Lead:</h3>");
          //  out.println("<p><strong>Name:</strong> " + teamLeadName + "</p>");
          //  out.println("<p><strong>Enrollment:</strong> " + teamLeadEnrollment + "</p>");
            addNewProject.setEnroll_id(teamLeadEnrollment);

            int projectID = addNewProject.submitProject();
          //  System.out.println(projectID);
            
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
                   // out.println("<p>" + teamMembers[i++] +"\t"+EnrollEember+  "</p>"); 
                  // add team members into project
                    TeamMembers.addTeamMember(projectID,EnrollEember);
                
                }
            } 
            else
            {
                out.println("<p>No team members provided.</p>");
            }

            // Handle Project Images
            //project_id, file_data, file_name, file_type, uploaded_at
            
            
            Collection<Part> imageParts = request.getParts();// multipal images 
        //    out.println("<h3>Project Images:</h3>");
            boolean hasImage = false;
            ProjectFile pf = new ProjectFile();    
            
            for (Part part : imageParts) {
                if (part.getName().equals("projectImages") && part.getSize() > 0) {
                hasImage = true;
                String contentType = part.getContentType();
                InputStream imageContent = part.getInputStream();
                String imageFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        
           //     out.println("<p><strong>File Name:</strong> " + imageFileName + "</p>");
           //     out.println("<p><strong>File Size:</strong> " + part.getSize() + " bytes</p>");
    
       //project_id, file_data, file_name, file_type, uploaded_at

        pf.saveFile(projectID,imageContent,imageFileName,contentType);
    
    }
}
             if(!hasImage){
                out.println("<h3>Project Images Field:</h3>");
                out.println("<p>No file uploaded.</p>");
            }

            // Handle Project Code (PDF)
             
        Part pdfPart = request.getPart("projectCode");
            if (pdfPart != null && pdfPart.getSize() > 0) {
                String pdfFileName = Paths.get(pdfPart.getSubmittedFileName()).getFileName().toString();
    
                // Read PDF data using Java 8-compatible method
                InputStream pdfFileData = pdfPart.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int bytesRead;
                byte[] data = new byte[1024]; // Buffer of 1KB

                while ((bytesRead = pdfFileData.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, bytesRead);
                }
            //     String contentType = pdfPart.getContentType();
            //    out.println(pdfFileName);
            //    out.println(contentType);
            //    out.println(pdfPart.getSize());
            //    out.println(pdfPart.getName());
              boolean isSave =   pf.saveFile(projectID,pdfFileData,pdfFileName,"application/pdf");
    
                pdfFileData.close(); // Close stream after reading
           if(isSave)
            {
                    out.println("<h3><Center>Your Project Submited sussesfully wait for Your Guid Approvel... :)</Center></h3>");
            }
            //    out.println("<h3>Project Code Field:</h3>");
            //    out.println("<p><strong>File Name:</strong> " + pdfFileName + "</p>");
            //    out.println("<p><strong>File Size:</strong> " + pdfPart.getSize() + " bytes</p>");
            } else {
            //    out.println("<h3>Project Code Field:</h3>");
            //    out.println("<p>No file uploaded.</p>");
}
            out.println("</body></html>");
        }
    }
}

