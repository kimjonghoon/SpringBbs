package net.java_school.user;

import net.java_school.mybatis.UserMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    
  @Autowired
  private UserMapper userMapper;
  
  @Override
  public void addUser(User user) {
    userMapper.insert(user);
  }

  @Override
  public void addAuthority(String email, String authority) {
    userMapper.insertAuthority(email, authority);  	
  }
  
  @Override
  public User login(String email, String passwd) {
    return userMapper.login(email, passwd);
  }
  
  @Override
  public int editAccount(User user) {
    return userMapper.update(user);
  }

  @Override
  public int changePasswd(String currentPasswd, String newPasswd, String email) {
    return userMapper.updatePasswd(currentPasswd, newPasswd, email);
  }

  @Override
  public void bye(String email, String passwd) {
    userMapper.deleteAuthority(email);  
    userMapper.delete(email, passwd);
  }

  @Override
  public User getUser(String email) {
    return userMapper.selectOne(email);
  }

}