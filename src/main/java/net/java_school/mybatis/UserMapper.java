package net.java_school.mybatis;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.java_school.user.User;

public interface UserMapper {

	public void insert(User user);

	public void insertAuthority(
			@Param("email") String email, 
			@Param("authority") String authority);

	public int update(User user);

	public int updatePasswd(
			@Param("currentPasswd") String currentPasswd, 
			@Param("newPasswd") String newPasswd, 
			@Param("email") String email);

	public int delete(User user);

	public void deleteAuthority(@Param("email") String email);

	public User selectOne(@Param("email") String email);

	public List<User> selectAll(
			@Param("search") String search, 
			@Param("offset") Integer offset, 
			@Param("rowCount") Integer rowCount);	

	public int selectTotalCount(@Param("search") String search);

	public String selectOneAuthority(String email);

	public void updatePasswdByAdmin(User user);

	public List<String> selectAuthoritiesOfUser(@Param("email") String email);

	public void deleteAuthorityOfUser(@Param("email") String email, @Param("authority") String authority);

}