package net.java_school.user;

import javax.validation.constraints.Size;

public class Password {
    
    @Size(min=4, message="패스워드는 4자 이상이어야 합니다.")
    private String currentPasswd;
    
    @Size(min=4, message="패스워드는 4자 이상이어야 합니다.")
    private String newPasswd;
    
    public String getCurrentPasswd() {
        return currentPasswd;
    }
    public void setCurrentPasswd(String currentPasswd) {
        this.currentPasswd = currentPasswd;
    }
    public String getNewPasswd() {
        return newPasswd;
    }
    public void setNewPasswd(String newPasswd) {
        this.newPasswd = newPasswd;
    }

} 
