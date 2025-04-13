package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ProjectGuid {
    private int guidId; // user_id is guid id
    private String guidName;
    private String guidEnroll;//user_enroll is guid enroll
    private String guidEmail;
    private int guidDepartmentId;
    private String guidDepartment;

    public ProjectGuid(){}
    
    public ProjectGuid(int guidId, String guidName, String guidEnroll, String guidEmail, int guidDepartmentId, String guidDepartment) {
        this.guidId = guidId;
        this.guidName = guidName;
        this.guidEnroll = guidEnroll;
        this.guidEmail = guidEmail;
        this.guidDepartmentId = guidDepartmentId;
        this.guidDepartment = guidDepartment;
    }

    
    
    public String getGuidEmail() {
        return guidEmail;
    }

    public void setGuidEmail(String guidEmail) {
        this.guidEmail = guidEmail;
    }

    public int getGuidDepartmentId() {
        return guidDepartmentId;
    }

    public void setGuidDepartmentId(int guidDepartmentId) {
        this.guidDepartmentId = guidDepartmentId;
    }

    
    
    public int getGuidId() {
        return guidId;
    }

    public void setGuidId(int guidId) {
        this.guidId = guidId;
    }

    public String getGuidName() {
        return guidName;
    }

    public void setGuidName(String guidName) {
        this.guidName = guidName;
    }

    public String getGuidEnroll() {
        return guidEnroll;
    }

    public void setGuidEnroll(String guidEnroll) {
        this.guidEnroll = guidEnroll;
    }

    public String getGuidDepartment() {
        return guidDepartment;
    }

    public void setGuidDepartment(String guidDepartment) {
        this.guidDepartment = guidDepartment;
    }
   
   
    
    public static String getGuidNameById(int GuidId)
    {
        return User.getNameByUserId(GuidId);
    }
    
    public static List<ProjectGuid> getAllGuids()
    {
        List<ProjectGuid> guids = null;
        try
        {
          Connection con =   DBConnection.getConnection();
          PreparedStatement st = con.prepareStatement("select user_id, enroll_id, name, department_id, email from users where role=?");
          st.setString(1,"Teacher");
          ResultSet rs = st.executeQuery();
          guids = new ArrayList();
          while(rs.next())
          {//int guidId, String guidName, String guidEnroll, String guidEmail, int guidDepartmentId, String guidDepartment
              int department_id = rs.getInt("department_id");
              ProjectGuid guid = new  ProjectGuid(rs.getInt("user_id"),rs.getString("name"),rs.getString("enroll_id"),rs.getString("email"),department_id,getGuidNameById(department_id));
              guids.add(guid);
          }
          con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return guids;
    }
    
}
