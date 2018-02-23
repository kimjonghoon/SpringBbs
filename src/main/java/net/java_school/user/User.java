package net.java_school.user;

import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;

public class User {

    @NotNull
    @Email(message = "{email.validation.error}")
    private String email;

    @NotNull
    @Size(min = 4, message = "{passwd.validation.error}")
    private String passwd;

    @NotNull
    @Size(min = 2, message = "{fullname.validation.error}")
    private String name;

    @NotNull
    @Size(min = 6, message = "{mobile.validation.error}")
    private String mobile;

    private List<String> authorities;

    public User() {
    }

    public User(String email, String passwd, String name, String mobile, List<String> authorities) {
        this.email = email;
        this.passwd = passwd;
        this.name = name;
        this.mobile = mobile;
        this.authorities = authorities;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email.trim();
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name.trim();
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile.trim();
    }

    public List<String> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(List<String> authorities) {
        this.authorities = authorities;
    }

}
