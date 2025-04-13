package com.pastexplorehub.controller;

import com.pastexplorehub.model.Project;
import com.pastexplorehub.model.User;
import java.io.IOException;
import java.util.List;
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
        
        HttpSession session = request.getSession(false);
        
        List<Project> projects = Project.getALLApprovedProjects();
        List<Project> pending_projects = Project.getALLPendingProjects();
        User user = (User)session.getAttribute("user");
        
        String enroll_id  = (String) session.getAttribute("enroll_id");
        String userRole = (String) session.getAttribute("role");
        
        List<Project> student_projects = Project.getALLApprovedProjectsByStudentEnroll(enroll_id);
        
        List<Project> teacher_projects = Project.getALLApprovedProjectsByTeacherEnroll(user.getUserId());
        
//System.out.println(projects);
        // If session is null or user not logged in, redirect to login page
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        // Fetch projects
         session.setAttribute("projects", projects);
         session.setAttribute("pending_projects", pending_projects);
        if(userRole.equals("Student")){
        session.setAttribute("student_projects", student_projects);
        }
        if(userRole.equals("Teacher")){
        session.setAttribute("teacher_projects", teacher_projects);
        }

        // get Role for redirection
        
        // Forward to JSP
        //RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/views/" + userRole.toLowerCase() + ".jsp");
       // RequestDispatcher dispatcher = request.getRequestDispatcher(request.getContextPath() + "/views/student.jsp");
       // dispatcher.forward(request, response);
    response.sendRedirect(request.getContextPath() + "/views/"+ userRole.toLowerCase() + ".jsp");
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