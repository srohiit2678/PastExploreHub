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
public class FatchProjectDetails extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        int projectId = Integer.parseInt(request.getParameter("id"));  // get ID from query
        Project project = Project.getProjectById(projectId);        // fetch project
        request.setAttribute("project", project);                      // set attribute
        request.getRequestDispatcher("/views/project_view.jsp").forward(request, response);  // forward to JSP
        
        }
    }

