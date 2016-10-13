package net.java_school.user;

import java.util.List;

import net.java_school.mybatis.UserMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@Override
	public void addUser(User user) {
		user.setPasswd(this.bcryptPasswordEncoder.encode(user.getPasswd()));
		userMapper.insert(user);
	}

	@Override
	public void addAuthority(String email, String authority) {
		userMapper.insertAuthority(email, authority);
	}

/*	@Override
	public User login(String email, String passwd) {
		return userMapper.login(email, passwd);
	}

*/	@Override
	public int editAccount(User user) {
		String encodedPassword = this.getUser(user.getEmail()).getPasswd();   
		boolean check = this.bcryptPasswordEncoder.matches(user.getPasswd(), encodedPassword);

		if (check == false) {
			throw new AccessDeniedException("현재 비밀번호가 틀립니다.");
		}
		
		user.setPasswd(encodedPassword);

		return userMapper.update(user);
	}

	@Override
	public int changePasswd(String currentPasswd, String newPasswd, String email) {
		String encodedPassword = this.getUser(email).getPasswd();
		boolean check = this.bcryptPasswordEncoder.matches(currentPasswd, encodedPassword);

		if (check == false) {
			throw new AccessDeniedException("현재 비밀번호가 틀립니다.");
		}
		
		newPasswd = this.bcryptPasswordEncoder.encode(newPasswd);
		
		return userMapper.updatePasswd(encodedPassword, newPasswd, email);
	}

	@Override
	public void bye(User user) {
		String encodedPassword = this.getUser(user.getEmail()).getPasswd();
		boolean check = this.bcryptPasswordEncoder.matches(user.getPasswd(), encodedPassword);

		if (check == false) {
			throw new AccessDeniedException("현재 비밀번호가 틀립니다.");
		}
		
		userMapper.deleteAuthority(user.getEmail());
		userMapper.delete(user);
	}

	@Override
	public User getUser(String email) {
		return userMapper.selectOne(email);
	}

	@Override
	public List<User> getAllUser(String search, Integer startRecord, Integer endRecord) {
		return userMapper.selectAll(search, startRecord, endRecord);
	}
	
	@Override
	public int getTotalCount(String search) {
		return userMapper.selectTotalCount(search);
	}
	

}