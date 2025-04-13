package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Rohit
 */
public class Department {
private int department_id;
private String department_name;

    public Department() {
    }
    
    public Department(int department_id, String department_name) {
        this.department_id = department_id;
        this.department_name = department_name;
    }

    public int getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }

    public String getDepartment_name() {
        return department_name;
    }

    public void setDepartment_name(String department_name) {
        this.department_name = department_name;
    }

    public static String getDepartmentNameById(int department_id)
    {
        Department forName = new Department();
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement("select * from departments where department_id=?");
            st.setInt(1, department_id);
            ResultSet rs = st.executeQuery();
            if(rs.next())
            {
                forName.department_id = department_id;
                forName.department_name = rs.getString("department_name");
            }
            
        }
        catch(Exception e)
        {
         e.printStackTrace();
        }
        
        
        return forName.department_name;
    }
    public static int getIdByDepartmentName(String name)
    {
        int departmentID = 0;
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement("select * from departments where department_name=?");
            st.setString(1, name);
            ResultSet rs = st.executeQuery();
            if(rs.next())
            {
                departmentID = rs.getInt("department_id");
            }
            
        }
        catch(Exception e)
        {
         e.printStackTrace();
        }
        
        
        return departmentID;
    }        
}
