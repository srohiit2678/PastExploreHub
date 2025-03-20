package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

public class Project {

 private int projectId;
 private String title;
 private String description;
 private int studentId;
 private Integer guideId; // Nullable field
 private String status;
 private Integer departmentId; // Nullable field
 private Timestamp createdAt;
 private String projectLink;
 private String techStack;
 private String enroll_id;
 private List<ProjectFile> files;  // Store all files for this project
 private String tages;  // tag  for this project
 private String guidName;

    public Project() { }

    
    public Project(int projectId, String title, String description, int studentId, Integer guideId, String guidName, String status, Integer departmentId, Timestamp createdAt, String projectLink, String techStack, String enroll_id, List<ProjectFile> files, String tages) {
        this.projectId = projectId;
        this.title = title;
        this.description = description;
        this.studentId = studentId;
        this.guideId = guideId;
        this.guidName = guidName;
        this.status = status;
        this.departmentId = departmentId;
        this.createdAt = createdAt;
        this.projectLink = projectLink;
        this.techStack = techStack;
        this.enroll_id = enroll_id;
        this.files = files;
        this.tages = tages;
    }

    public String getGuidName() {
        return guidName;
    }

    public String getTages() {
        return tages;
    }
  
    public int getProjectId() {
        return projectId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public int getStudentId() {
        return studentId;
    }

    public Integer getGuideId() {
        return guideId;
    }

    public String getStatus() {
        return status;
    }

    public Integer getDepartmentId() {
        return departmentId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public String getProjectLink() {
        return projectLink;
    }

    public String getTechStack() {
        return techStack;
    }

    public String getEnroll_id() {
        return enroll_id;
    }

    public List<ProjectFile> getFiles() {
        return files;
    }

    public String gettages() {
        return tages;
    }

    public void setGuidName(String guidName) {
        this.guidName = guidName;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public void setGuideId(Integer guideId) {
        this.guideId = guideId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setDepartmentId(Integer departmentId) {
        this.departmentId = departmentId;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public void setProjectLink(String projectLink) {
        this.projectLink = projectLink;
    }

    public void setTechStack(String techStack) {
        this.techStack = techStack;
    }

    public void setEnroll_id(String enroll_id) {
        this.enroll_id = enroll_id;
    }

    public void setFiles(List<ProjectFile> files) {
        this.files = files;
    }

    public void setTages(String tages) {
        this.tages = tages;
    }

 
    
// get all Projects from database for dashbords
    public static List<Project> getALLProjects()throws SQLException
    {   List<Project> projects = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection();
            Statement st = conn.createStatement())
        {
           ResultSet rs = st.executeQuery("Select * from projects");
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            int guid_id = rs.getInt("guide_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guid_id,ProjectGuid.getGuidNameById(guid_id),"Approved",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByTagId(project_id));
            projects.add(project);             
           }
        }
     return projects;
    }
    public static List<Project> getALLApprovedProjects()throws SQLException
    {   List<Project> projects = new ArrayList<>();
        try(Connection conn = DBConnection.getConnection();
            Statement st = conn.createStatement())
        {
           ResultSet rs = st.executeQuery("Select * from projects where status = 'Approved'");
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            int guid_id = rs.getInt("guide_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guid_id,ProjectGuid.getGuidNameById(guid_id),"Approved",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByTagId(project_id));
            projects.add(project);             
           }
        }
     return projects;
    }

    @Override
    public String toString() {
        return "Project{" + "projectId=" + projectId + ", title=" + title + ", description=" + description + ", studentId=" + studentId + ", guideId=" + guideId + ", guidName=" + guidName + ", status=" + status + ", departmentId=" + departmentId + ", createdAt=" + createdAt + ", projectLink=" + projectLink + ", techStack=" + techStack + ", enroll_id=" + enroll_id + ", files=" + files + ", tages=" + tages + '}';
    }
}


