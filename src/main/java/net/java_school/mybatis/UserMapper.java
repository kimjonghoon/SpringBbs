package net.java_school.mybatis;

import org.apache.ibatis.annotations.Param;

import net.java_school.user.User;

public interface UserMapper {
    
  public void addUser(User user);

  public User login(
    @Param("email") String email, 
    @Param("passwd") String passwd);

  public int editAccount(User user);

  public int changePasswd(
    @Param("currentPasswd") String currentPasswd, 
    @Param("newPasswd") String newPasswd, 
    @Param("email") String email);

  public int bye(
    @Param("email") String email, 
    @Param("passwd") String passwd);

  public User getUser(String email);
    
}