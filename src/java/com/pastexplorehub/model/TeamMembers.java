/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Rohit
 */
public class TeamMembers {
    private int project_id;
    private int student_id;
    private String enroll_id;

    public TeamMembers() { }
    
    public TeamMembers(int project_id, int student_id, String enroll_id) {
        this.project_id = project_id;
        this.student_id = student_id;
        this.enroll_id = enroll_id;
    }

    public int getProject_id() {
        return project_id;
    }

    public void setProject_id(int project_id) {
        this.project_id = project_id;
    }

    public int getStudent_id() {
        return student_id;
    }

    public void setStudent_id(int student_id) {
        this.student_id = student_id;
    }

    public String getEnroll_id() {
        return enroll_id;
    }

    public void setEnroll_id(String enroll_id) {
        this.enroll_id = enroll_id;
    }
    // Student with Team Members Should be registered before submiting the Project
    public static boolean addTeamMember(int project_id, String enroll_id)
    {   boolean memberAdded = false;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement("SELECT user_id FROM USERS WHERE enroll_id = ?");
            st.setString(1, enroll_id.trim());
            ResultSet rs = st.executeQuery();
            if(rs.next())
            {
                PreparedStatement st2 = con.prepareStatement("INSERT INTO project_team VALUES(?,?,?)");
                st2.setInt(1, project_id);
                st2.setInt(2, rs.getInt(1));
                st2.setString(3,enroll_id);
                int update = st2.executeUpdate();
                if(update!=0)
                {
                    memberAdded = true;
                    System.out.println(memberAdded);
                }
                else
                {
                    memberAdded = false;
                    System.out.println(memberAdded);
                }
                st2.close();
            }
            else
            {
                memberAdded = false;
                System.out.println(memberAdded);
            }
            con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return memberAdded;
    }
     
}
