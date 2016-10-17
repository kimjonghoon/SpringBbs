package net.java_school.namecard;

public class Namecard {
	//no,name,company,mobile,email,
	private int no;
	private String name;
	private String company;
	private String mobile;
	private String email;
	
	
	public Namecard(String name, String company, String mobile, String email) {
		super();
		this.name = name;
		this.company = company;
		this.mobile = mobile;
		this.email = email;
	}

	public Namecard(int no, String name, String company, String mobile,
			String email) {
		super();
		this.no = no;
		this.name = name;
		this.company = company;
		this.mobile = mobile;
		this.email = email;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@Override
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("#########################");
		sb.append("/n/r");
		sb.append("[" + no + "]");
		sb.append(" ");
		sb.append(name);
		sb.append(" ");
		sb.append(company);
		sb.append(" ");
		sb.append(mobile);
		sb.append(" ");
		sb.append(email);
		return sb.toString();
	}
	
	
}
