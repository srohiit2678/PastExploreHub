package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Rohit
 */
public class AdminActivity {
    private String guide_name; 
    private String guide_department; 
    private int approved_count; 
    private int rejected_count; 
    private int pending_count; 
    private int total_projects;

    public AdminActivity() {    }

    
    public AdminActivity(String guide_name, String guide_department, int approved_count, int rejected_count, int pending_count, int total_projects) {
        this.guide_name = guide_name;
        this.guide_department = guide_department;
        this.approved_count = approved_count;
        this.rejected_count = rejected_count;
        this.pending_count = pending_count;
        this.total_projects = total_projects;
    }

    public String getGuide_name() {
        return guide_name;
    }

    public void setGuide_name(String guide_name) {
        this.guide_name = guide_name;
    }

    public String getGuide_department() {
        return guide_department;
    }

    public void setGuide_department(String guide_department) {
        this.guide_department = guide_department;
    }

    public int getApproved_count() {
        return approved_count;
    }

    public void setApproved_count(int approved_count) {
        this.approved_count = approved_count;
    }

    public int getRejected_count() {
        return rejected_count;
    }

    public void setRejected_count(int rejected_count) {
        this.rejected_count = rejected_count;
    }

    public int getPending_count() {
        return pending_count;
    }

    public void setPending_count(int pending_count) {
        this.pending_count = pending_count;
    }

    public int getTotal_projects() {
        return total_projects;
    }

    public void setTotal_projects(int total_projects) {
        this.total_projects = total_projects;
    }
    
    
    public static List<AdminActivity> getAdminActivity()
    {
        List<AdminActivity> adminActivity = new ArrayList<>();
        AdminActivity temp = null;
        try
        {
            Connection con = DBConnection.getConnection();
            CallableStatement p = con.prepareCall("{call admin_activity()}");
            ResultSet rs = p.executeQuery();
            while(rs.next())
            {
                temp = new AdminActivity(rs.getString(1),rs.getString(2),rs.getInt(3),rs.getInt(4),rs.getInt(5),rs.getInt(6));
                 adminActivity.add(temp);
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return adminActivity;
    }
}
