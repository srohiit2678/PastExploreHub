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

    public static String getTagesByTagId(int project_id)
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
}
