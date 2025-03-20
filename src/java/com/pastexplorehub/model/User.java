package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.*;

/**
 *
 * @author Rohit
 */
public class User {
    private int userId;
    private String enrollId;
    private String name;
    private String email;
    private String password;
    private String role; // Student, Teacher, Admin
    private int department_id;

    public void setUserId(int userId) {
        this.userId = userId;
    }
    public int getUserId() {
        return userId;
    }
    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }
    public int getDepartment_id() {
        return department_id;
    }
    public String getEnrollId() { return enrollId; }
    public void setEnrollId(String enrollId) { this.enrollId = enrollId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }   
    
    public boolean isValidUser(String enroll_id,String password){
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement st = conn.prepareStatement("SELECT name, role, email, department_id, password FROM users WHERE enroll_id = ?"))
        {
            st.setString(1, enroll_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()){
                this.password  = rs.getString("password");
                this.role = rs.getString("role");
                this.name = rs.getString("name");
                this.email = rs.getString("email");
                this.department_id = rs.getInt("department_id");
              
            }
            else
            {
                return false;
            }
        conn.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return false;         
        }
        return this.password.equals(password);
    }
   
    public boolean registerUser() {
    
        try (Connection conn = DBConnection.getConnection();
         PreparedStatement st = conn.prepareStatement("INSERT INTO users (enroll_id, name, email, password, role, department_id) VALUES (?, ?, ?, ?, ?, ?)")) {
        
        st.setString(1, this.enrollId);
        st.setString(2, this.name);
        st.setString(3, this.email);
        st.setString(4, this.password); // Password is stored as plain text, as per your requirement.
        st.setString(5, this.role);
        st.setInt(6, this.department_id);
        
        int rowsAffected = st.executeUpdate();
        return rowsAffected > 0; // Return true if the user was registered successfully.
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
    }
    
    public static String getNameByUserId(int userId)
    {
        String name = null;
        try (Connection conn = DBConnection.getConnection();
         PreparedStatement st = conn.prepareStatement("select name from users where user_id = ?"))
        {   
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            if(rs.next())
            {
                name = rs.getString("name");
            }
            else
            {
                name = "invlid guid id";
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }      
         return name;
    }
}

/*

*/
