package net.java_school.user;

public class User {
	private String email;
	private String passwd;
	private String name;
	private String mobile;
	
	public User() {}
	
	public User(String email, String passwd) {
		this.email = email;
		this.passwd = passwd;
	}
	
	public User(String email, String passwd, String name, String mobile) {
		this.email = email;
		this.passwd = passwd;
		this.name = name;
		this.mobile = mobile;
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
	
	
}
