package net.java_school.user;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotBlank;

public class User {
	@NotBlank(message="이메일 형식이 아닙니다.")
	@Email(message="이메일 형식이 아닙니다.")
	private String email;
	@Size(min=4, message="{passwd.validation.error}")
	private String passwd;
	@Size(min=2, message="{fullname.validation.error}")
	private String name;
	@Size(min=6, message="{mobile.validation.error}")
	private String mobile;
	private String authority;
	
	public User() {}
	
	public User(String email, String passwd) {
		this.email = email;
		this.passwd = passwd;
	}
	
	public User(String email, String passwd, String name, String mobile, String authority) {
		this.email = email;
		this.passwd = passwd;
		this.name = name;
		this.mobile = mobile;
		this.authority = authority;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	
}
