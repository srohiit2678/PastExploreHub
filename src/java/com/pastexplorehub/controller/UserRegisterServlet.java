/**
 *
 * @author Rohit
 */
package com.pastexplorehub.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.pastexplorehub.model.User;


public class UserRegisterServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        User newUser = new User();
        try
       {
        newUser.setName(request.getParameter("name"));
        newUser.setEnrollId(request.getParameter("enroll_id"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setDepartment_id(Integer.parseInt(request.getParameter("department_id")));  
        newUser.setRole(request.getParameter("role_type"));
        newUser.setPassword(request.getParameter("password"));
       }
        catch(Exception e)
       {
        System.out.println("User registration failed. Forwarding to register.jsp.");
        request.setAttribute("error", "Invalid user details");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
        dispatcher.forward(request, response);
       }
        if(newUser.registerUser())
        {
            //login sussessfully
           response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
        else
        {
        System.out.println("User registration failed. Forwarding to register.jsp.");
        request.setAttribute("error", "Invalid user details");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/register.jsp");
    if (dispatcher == null) {
    }
    dispatcher.forward(request, response);
        }
    }
}


/*

*/