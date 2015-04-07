package net.java_school.user;

public interface UserService {
    
  //회원가입
  public void addUser(User user);

  //로그인
  public User login(String email, String passwd);

  //내정보 수정
  public int editAccount(User user);

  //비밀번호 변경
  public int changePasswd(String currentPasswd, String newPasswd, String email);

  //탈퇴
  public int bye(String email, String passwd);

  //회원찾기
  public User getUser(String email);
    
}