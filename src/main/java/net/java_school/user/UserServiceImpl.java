package net.java_school.user;

import net.java_school.mybatis.UserMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    
  @Autowired
  private UserMapper userMapper;
    
  public void addUser(User user) {
    userMapper.insert(user);
  }

  public User login(String email, String passwd) {
    return userMapper.login(email, passwd);
  }

  public int editAccount(User user) {
    return userMapper.update(user);
  }

  public int changePasswd(String currentPasswd, String newPasswd, String email) {
    return userMapper.updatePasswd(currentPasswd, newPasswd, email);
  }

  public int bye(String email, String passwd) {
    return userMapper.delete(email, passwd);
  }

  public User getUser(String email) {
    return userMapper.selectOne(email);
  }
    
}
