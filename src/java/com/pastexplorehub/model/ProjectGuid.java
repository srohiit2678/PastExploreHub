package com.pastexplorehub.model;


public class ProjectGuid {
    private int guidId; // user_id is guid id
    private String name;
   
    public int getGuidId() {
        return guidId;
    }

    public String getName() {
        return name;
    }

    public void setGuidId(int guidId) {
        this.guidId = guidId;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public static String getGuidNameById(int GuidId)
    {
        return User.getNameByUserId(GuidId);
    }
    
}
