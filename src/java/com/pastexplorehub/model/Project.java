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
import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.util.StringTokenizer;

public class Project implements Serializable {

    private static final long serialVersionUID = 1L; // Add a unique ID// Your fields, constructors, getters, and setters
    private int projectId;
    private String title;
    private String description;
    private int studentId;
    private int guideId; // Nullable field
    private String status;
    private int departmentId; // Nullable field
    private Timestamp createdAt;
    private String projectLink;
    private String techStack;
    private String enroll_id;
    private List<ProjectFile> files;  // Store all files for this project
    private String tages;  // tag  for this project
    private String guidName;
    private List<String> member;

    
    
 // private List teamMembersName<String>;
 // private List teamMembersEnroll<String>;
    
/* 
 INSERT INTO explorehub.requests (student_id, enroll_id, project_id, guide_id, status, requested_at) 
VALUES 
(34, 'CS2024034', 6, 10, 'pending', NOW());

    
 */
    public Project() { }

    
    public Project(int projectId, String title, String description, int studentId, int guideId, String guidName, String status, int departmentId, Timestamp createdAt, String projectLink, String techStack, String enroll_id, List<ProjectFile> files, String tages) {
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


    public List<String> getMember() {
        return member;
    }

    public void setMember(List<String> member) {
        this.member = member;
    }
    
    
    
    public static long getSerialVersionUID() {
        return serialVersionUID;
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

    public int getGuideId() {
        return guideId;
    }

    public String getStatus() {
        return status;
    }

    public int getDepartmentId() {
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

    public void setGuideId(int guideId) {
        this.guideId = guideId;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setDepartmentId(int departmentId) {
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

    public int submitProject()
    {
        int projectID = 0;
        try
        {//title, description, student_id, guide_id, status, department_id, created_at, project_link, tech_stack, enroll_id
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement("INSERT INTO projects(title, description, student_id, guide_id, status, department_id, project_link, tech_stack, enroll_id) values (?,?,?,?,?,?,?,?,?)");
//            System.out.println(getTitle());
//            System.out.println(getDescription());
//            System.out.println(User.getIdByEnroll(getEnroll_id()));
//            System.out.println(getGuideId());
//
//            System.out.println(User.getDepartmentIdByEnroll(getEnroll_id()));
//            System.out.println(getProjectLink());
//            System.out.println(getTechStack());
//            System.out.println(getEnroll_id());

            st.setString(1,getTitle());
            st.setString(2,getDescription());
            st.setInt(3,User.getIdByEnroll(getEnroll_id()));
            st.setInt(4,getGuideId());
            st.setString(5, "Pending");
            st.setInt(6, User.getDepartmentIdByEnroll(getEnroll_id()));
            st.setString(7, getProjectLink());
            st.setString(8, getTechStack());
            st.setString(9, getEnroll_id());
            
            int update = st.executeUpdate();
        //    System.out.println("yes project inserted : "+ update);
            if(update != 0)
            {
                try
                {
                PreparedStatement st2 = con.prepareStatement("Select project_id from projects where title = ?");
                st2.setString(1, getTitle());
                ResultSet rs = st2.executeQuery();
                if(rs.next())
                {
                    projectID = rs.getInt(1);
                }
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
            
            }
        con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return projectID;
    }
    
// get all Projects from database for dashbords
    public static List<Project> getALLProjects()throws SQLException
    {   List<Project> projects = new ArrayList<>();
        try
        {
           Connection conn = DBConnection.getConnection();
           Statement st = conn.createStatement();
           ResultSet rs = st.executeQuery("Select * from projects");
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            int guid_id = rs.getInt("guide_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guid_id,ProjectGuid.getGuidNameById(guid_id),"Approved",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByProjectId(project_id));
            projects.add(project);             
           }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
                
     return projects;
    }
    
    public static List<Project> getALLPendingProjects()
    {
         List<Project> projects = new ArrayList<>();
        try
        {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
           ResultSet rs = st.executeQuery("Select * from projects where status = 'Pending'");
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            int guid_id = rs.getInt("guide_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guid_id,ProjectGuid.getGuidNameById(guid_id),"Pendding",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByProjectId(project_id));
            projects.add(project);             
           }
           st.close();
           rs.close();
           con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
     return projects;
    }
    
    public static List<Project> getALLApprovedProjects()
    {   List<Project> projects = new ArrayList<>();
        try
        {
            Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();
           ResultSet rs = st.executeQuery("Select * from projects where status = 'Approved'");
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            int guid_id = rs.getInt("guide_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guid_id,ProjectGuid.getGuidNameById(guid_id),"Approved",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByProjectId(project_id));
            projects.add(project);             
           }
           st.close();
           rs.close();
           con.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
     return projects;
    }
    
    public static List<Project> getALLApprovedProjectsByStudentEnroll(String enroll_id)
    {
        List<Project> projects = new ArrayList<>();
        try{
            Connection conn = DBConnection.getConnection();
            Statement st = conn.createStatement();                    
           ResultSet rs = st.executeQuery("Select * from projects where status = 'Approved' and project_id='"+getApprovedProjectsIdByStudentEnroll(enroll_id)+"'");
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            int guid_id = rs.getInt("guide_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guid_id,ProjectGuid.getGuidNameById(guid_id),"Approved",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByProjectId(project_id));
            projects.add(project);             
           }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
     return projects;
    }
    
    public static List<Project> getALLApprovedProjectsByTeacherEnroll(int guide_id)
    {
        List<Project> projects = new ArrayList<>();
        try{
            Connection conn = DBConnection.getConnection();
            Statement st = conn.createStatement();                    
           ResultSet rs = st.executeQuery("Select * from projects where status = 'Approved' and guide_id='"+guide_id+"'");
           
           while(rs.next())
           {
            int project_id = rs.getInt("project_id");
            Project project = new Project(project_id,rs.getString("title"),rs.getString("description"),rs.getInt("student_id"),guide_id,ProjectGuid.getGuidNameById(guide_id),"Approved",rs.getInt("department_id"),rs.getTimestamp("created_at"),rs.getString("project_link"),rs.getString("tech_stack"),rs.getString("enroll_id"),ProjectFile.getProjectByProjectId(project_id),ProjectTages.getTagesByProjectId(project_id));
            projects.add(project);             
           }
           // System.out.print("All projects are these = "+projects);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        //System.out.print(projects);
     return projects;
    }
    
    public static int getApprovedProjectsIdByStudentEnroll(String enroll_Id)
    { int project_id=0;
        String sql = "SELECT p.project_id, p.title, p.status, "
           + "p.student_id AS lead_id, "
           + "u_lead.name AS lead_name, "
           + "GROUP_CONCAT(DISTINCT u_member.name SEPARATOR ', ') AS team_members "
           + "FROM projects p "
           + "LEFT JOIN project_team pt ON p.project_id = pt.project_id "
           + "LEFT JOIN users u_lead ON p.student_id = u_lead.user_id "
           + "LEFT JOIN users u_member ON pt.student_id = u_member.user_id "
           + "LEFT JOIN users u ON (p.student_id = u.user_id OR pt.student_id = u.user_id) "
           + "WHERE p.status = 'Approved' "
           + "AND u.enroll_id = ? "
           + "GROUP BY p.project_id, p.title, p.status, p.student_id, u_lead.name "
           + "ORDER BY p.project_id";
        try{
            Connection conn = DBConnection.getConnection();
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, enroll_Id);  // Set enroll_id dynamically
            ResultSet rs = st.executeQuery();
           if(rs.next())
           {
            project_id = rs.getInt("project_id");
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
     return project_id;
    }


    public static Project getProjectById(int projectId)
    {
        Project project = new Project();
        List<ProjectFile> files = new ArrayList<>();
        String TeamMembersWithEnroll = null;
        try
        {
            Connection con = DBConnection.getConnection();
            CallableStatement st = con.prepareCall("{call GetProjectDetails(?)}");
            st.setInt(1, projectId);
            ResultSet rs = st.executeQuery();
            while(rs.next())
            {
                //project_id, title, description, tech_stack, project_link, guide_name, team_members, tags, file_id, file_name, file_type
               
                project.setProjectId(Integer.parseInt(rs.getString(1)));
                project.setTitle(rs.getString(2));
                project.setDescription(rs.getString(3));
                project.setTechStack(rs.getString(4));
                project.setProjectLink(rs.getString(5));
                project.setGuidName(rs.getString(6));
                // All Team Memberes
                TeamMembersWithEnroll = rs.getString(7); // have all members with enroll which need to saprate

                project.setTages(rs.getString(8));

                ProjectFile temprary = new ProjectFile();
                
                temprary.setFileId(Integer.parseInt(rs.getString(9)));
                temprary.setFileName(rs.getString(10));
                temprary.setFileType(rs.getString(11));
                files.add(temprary);
            }
            List<String> members = separateTeamMemberString(TeamMembersWithEnroll);
            project.setMember(members);
            project.setFiles(files);   
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return project;
    }
    
    public static List<String> separateTeamMemberString(String TeamMembersWithEnroll)
    {       
        List<String> members = new ArrayList<>();
        if(TeamMembersWithEnroll != null)
        {
            TeamMembersWithEnroll = TeamMembersWithEnroll.trim();
            
            StringTokenizer st = new StringTokenizer(TeamMembersWithEnroll,",");
            while(st.hasMoreTokens()){
				String s1 = st.nextToken();
			//	String s2 = s1;
			//	s1 = s1.substring(0,s1.indexOf('('));
			//	s2 = s2.substring(s2.indexOf('('),s2.length());
            members.add(s1);
            //members.add(s2);
        }
        }
        return members;
    }
   
    
    
    public static void setStatus(int project_id,String Status)
    {
        try
        {
            Connection con = DBConnection.getConnection();
            PreparedStatement st = con.prepareStatement("UPDATE projects SET status = ? WHERE project_id = ?");
            
            st.setString(1, Status);
            st.setInt(2, project_id);
            st.executeUpdate();
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
    }
    
    @Override
    public String toString() {
        return "Project{" + "projectId=" + projectId + ", title=" + title + ", description=" + description + ", studentId=" + studentId + ", guideId=" + guideId + ", guidName=" + guidName + ", status=" + status + ", departmentId=" + departmentId + ", createdAt=" + createdAt + ", projectLink=" + projectLink + ", techStack=" + techStack + ", enroll_id=" + enroll_id + ", files=" + files + ", tages=" + tages + '}';
    }
}


