package net.java_school.mybatis;

import org.apache.ibatis.annotations.Param;

import net.java_school.user.User;

public interface UserMapper {
    
  public void insert(User user);

  public void insertAuthority(
		  @Param("email") String email, 
		  @Param("authority") String authority);
  
  public User login(
    @Param("email") String email, 
    @Param("passwd") String passwd);

  public int update(User user);

  public int updatePasswd(
    @Param("currentPasswd") String currentPasswd, 
    @Param("newPasswd") String newPasswd, 
    @Param("email") String email);

  public int delete(User user);

  public void deleteAuthority(@Param("email") String email);
  
  public User selectOne(String email);
    
}