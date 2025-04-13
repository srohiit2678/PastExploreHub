package com.pastexplorehub.controller;

import com.pastexplorehub.model.AdminActivity;
import com.pastexplorehub.model.Project;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rohit
 */
public class ViewActivityServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        List<AdminActivity> activita_Data = AdminActivity.getAdminActivity();
        request.setAttribute("activita_Data", activita_Data);                      // set attribute
        request.getRequestDispatcher("/views/view_activity.jsp").forward(request, response);  // forward to JSP
    }
}
