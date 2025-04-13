package com.pastexplorehub.controller;

import com.pastexplorehub.utils.DBConnection;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.pastexplorehub.model.User;


/**
 *
 * @author Rohit
 */
public class UserLoginServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        User user = new User();// take request from user
        String enroll_id = request.getParameter("enroll_id");
        String password = request.getParameter("password"); 
      
        //PrintWriter out = response.getWriter();
        //out.println(enroll_id+"<br>"+password);
            // if user found with Wrong pass ir wright info
      //  System.out.println(enroll_id);
      //  System.out.println(password);
        HttpSession session = request.getSession(false);
        if(session!=null)
         session.invalidate();
        if(user.isValidUser(enroll_id,password)) 
        {           
               
            // Create a new session only after successful login
                session = request.getSession(true);
                
                session.setAttribute("user", user);
                session.setAttribute("name", user.getName());
                session.setAttribute("role", user.getRole());
                session.setAttribute("enroll_id", enroll_id);            
                session.setAttribute("user_id", user.getUserId());            

                // Redirect based on role
                //System.out.println("see path"+request.getContextPath());
                  
               // => /PastEcploreHub/views/student.jsp
               // response.sendRedirect(request.getContextPath() + "/views/" + user.getRole().toLowerCase() + ".jsp");
               // response.sendRedirect("DashBoardServlet?role="+user.getRole());
                response.sendRedirect("DashBoardServlet");
        }
        else // if Incorrect user OR password
        {
                request.setAttribute("loginError", "Invalid User & Password!"); 
                //response.sendRedirect(request.getContextPath() + "/views/login.jsp?loginError=Invalid User & Password!");
                 request.getRequestDispatcher("/views/login.jsp").forward(request, response);
  
//              request.getRequestDispatcher(request.getContextPath() + "/views/login.jsp").forward(request, response);
        }
    }
}

/*

*/


