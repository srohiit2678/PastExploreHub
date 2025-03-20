
package com.pastexplorehub.model;
import com.pastexplorehub.utils.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ProjectFile {
    private int fileId;
    private int projectId;
    private byte[] fileData;
    private String fileName;
    private String fileType;
    private Timestamp  uploadedAt;

    // Constructors
    public ProjectFile() {}

    public ProjectFile(int fileId, int projectId, byte[] fileData, String fileName, String fileType, Timestamp uploadedAt) {
        this.fileId = fileId;
        this.projectId = projectId;
        this.fileData = fileData;
        this.fileName = fileName;
        this.fileType = fileType;
        this.uploadedAt = uploadedAt;
    }

    public int getFileId() {
        return fileId;
    }

    public int getProjectId() {
        return projectId;
    }

    public byte[] getFileData() {
        return fileData;
    }

    public String getFileName() {
        return fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public Timestamp getUploadedAt() {
        return uploadedAt;
    }

    public void setFileId(int fileId) {
        this.fileId = fileId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public void setFileData(byte[] fileData) {
        this.fileData = fileData;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public void setUploadedAt(Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
    
    public static List<ProjectFile> getProjectByProjectId(int projectId)
    {
        List<ProjectFile> files =  new ArrayList<>();
        try(Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();)
        {   ResultSet rs = st.executeQuery("select * from files where project_id='"+projectId+"'");
            while(rs.next())
            {
            ProjectFile data = new ProjectFile();
            data.setFileId(rs.getInt("file_id"));
            data.setFileData(rs.getBytes("file_data"));
            data.setFileName(rs.getString("file_name"));
            data.setFileType(rs.getString("file_type"));
            data.setUploadedAt(rs.getTimestamp("uploaded_at"));
            files.add(data);
            }               
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        
        return files;
    }

}
