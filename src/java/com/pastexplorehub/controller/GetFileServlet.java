/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pastexplorehub.controller;

import com.pastexplorehub.model.ProjectFile;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Rohit
 */
public class GetFileServlet extends HttpServlet {

 
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int file_Id = Integer.parseInt(request.getParameter("file_Id"));
        ProjectFile file = ProjectFile.getFileById(file_Id);
        
        if (file != null && file.getFileType().startsWith("image")||file.getFileType().startsWith("image/")||file.getFileType().startsWith("image/jpg")||file.getFileType().startsWith("image/png")||file.getFileType().startsWith("png")||file.getFileType().startsWith("jpg")) {
            response.setContentType(file.getFileType()); // e.g., image/jpeg
            OutputStream out = response.getOutputStream();
            out.write(file.getFileData()); // byte[] from DB or file
            out.close();
            out.flush();

        } else if(file != null && file.getFileType().startsWith("application/pdf")||file.getFileType().startsWith("/pdf")||file.getFileType().startsWith("application")||file.getFileType().startsWith("application/")||file.getFileType().startsWith("pdf")||file.getFileType().startsWith("jpg"))
        {
            response.setContentType(file.getFileType()); // e.g., image/jpeg
            OutputStream out = response.getOutputStream();
            out.write(file.getFileData()); // byte[] from DB or file
            out.close();
            out.flush();

        }
        else
        {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
        
    }
}
