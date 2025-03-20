package com.pastexplorehub.controller;

import com.pastexplorehub.model.Project;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DashBoardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        //String userRole = request.getParameter("role");
        try
    {
        List<Project> projects = Project.getALLProjects();
        System.out.println(projects);
        HttpSession session = request.getSession(false);
        // If session is null or user not logged in, redirect to login page
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // Fetch projects
        session.setAttribute("projects", projects);
    
        // Forward to JSP
        //RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/views/" + userRole.toLowerCase() + ".jsp");
       // RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/views/student.jsp");
       // dispatcher.forward(request, response);
    response.sendRedirect(request.getContextPath() + "/views/student.jsp");
    }
    catch(Exception e)
    {
        e.printStackTrace();
    }
    }
}

/*
    }
}


*/