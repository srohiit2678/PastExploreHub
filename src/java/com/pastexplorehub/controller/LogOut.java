/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pastexplorehub.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Rohit
 */
public class LogOut extends HttpServlet {

        public void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("views/login.jsp");
        }
}
