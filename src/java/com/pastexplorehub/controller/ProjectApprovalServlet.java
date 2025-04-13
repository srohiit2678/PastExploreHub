/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pastexplorehub.controller;

import com.pastexplorehub.model.Project;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rohit
 */
public class ProjectApprovalServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Log the received parameters
            String projectId = request.getParameter("projectId");
            String status = request.getParameter("status");

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProjectApprovalServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProjectApprovalServlet at " + request.getContextPath() + "</h1>");
            
            // Check if parameters are being received correctly
            out.println("<p>projectId: " + projectId + "</p>");
            out.println("<p>status: " + status + "</p>");
            
            
            Project.setStatus(Integer.parseInt(projectId),status); 
            
            out.println("<p>projectId equals 1: " + (projectId != null && projectId.equals("1")) + "</p>");
            out.println("<p>status equals approved: " + (status != null && status.equals("approved")) + "</p>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
