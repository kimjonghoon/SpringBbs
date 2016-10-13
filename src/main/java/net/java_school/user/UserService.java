package net.java_school.user;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

public interface UserService {

	//회원가입
	public void addUser(User user);

	//회원권한 추가
	public void addAuthority(String email, String authority);

	//로그인
	/*  public User login(String email, String passwd);*/

	//내 정보 수정
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public int editAccount(User user);

	//비밀번호 변경
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public int changePasswd(String currentPasswd, String newPasswd, String email);

	//탈퇴
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER') and #user.email == principal.username")
	public void bye(User user);

	//회원찾기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public User getUser(String email);

	//회원목록
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public List<User> getAllUser(String search, Integer startRecord, Integer endRecord);

	//회원수
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public int getTotalCount(String search);

}