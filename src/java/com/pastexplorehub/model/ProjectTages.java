package com.pastexplorehub.model;

import com.pastexplorehub.utils.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Rohit
 */
public class ProjectTages {
private int tagId;
private String tagName;

    public ProjectTages(){}

    public ProjectTages(int tagId, String tagName) {
        this.tagId = tagId;
        this.tagName = tagName;
    }

    public void setTagId(int tagId) {
        this.tagId = tagId;
    }

    public void setTagName(String tagName) {
        this.tagName = tagName;
    }

    public int getTagId() {
        return tagId;
    }

    public String getTagName() {
        return tagName;
    }

    public static String getTagesByProjectId(int project_id)
    {
        String tag = null;
        try(Connection con = DBConnection.getConnection();
            Statement st = con.createStatement();)
        {   ResultSet rs = st.executeQuery("SELECT t.tag_id, t.tag_name FROM project_tags pt JOIN tags t ON pt.tag_id = t.tag_id WHERE pt.project_id = '"+project_id+"'");
                    
        while(rs.next())
            {
                tag = rs.getString("tag_name");
            }               
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        return tag;
    }

        public static List<ProjectTages> getTages()
    {
        List<ProjectTages> tagList = new ArrayList<>();
        
        try
        {
        Connection con = DBConnection.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("select tag_id, tag_name from tags");
        while(rs.next())
        {
            ProjectTages tags = new ProjectTages(rs.getInt("tag_id"),rs.getString("tag_name"));
            tagList.add(tags);
        }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return tagList;
    }

    
}
