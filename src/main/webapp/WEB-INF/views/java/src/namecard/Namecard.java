package net.java_school.namecard;

public class Namecard {

	static final String lineSeparator = System.getProperty("line.separator");
	private static int seq;
	private int no;
	private String name;
	private String company;
	private String title;
	private String mobile;
	private String phone;
	private String fax;
	private String email;
	private String address;
	
	public Namecard(){}
	
	public Namecard(String name, String company, 
			String title, String mobile, String phone, 
			String fax, String email, String address) {
		this.no = ++seq;
		this.name = name;
		this.company = company;
		this.title = title;
		this.mobile = mobile;
		this.phone = phone;
		this.fax = fax;
		this.email = email;
		this.address = address;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("###################################################################");
		sb.append(lineSeparator);
		sb.append("[번호 : ");
		sb.append(no);
		sb.append("] ");
		sb.append(name);
		sb.append(" ");
		sb.append(company);
		sb.append(" ");
		sb.append(title);
		sb.append(lineSeparator);
		sb.append("손전화:");
		sb.append(mobile);
		sb.append(" 회사전화:");
		sb.append(phone);
		sb.append(" ");
		sb.append(" 팩스:");
		sb.append(fax);
		sb.append(lineSeparator);
		sb.append("이메일:");
		sb.append(email);
		sb.append(lineSeparator);
		sb.append("회사주소:");
		sb.append(address);
		return sb.toString();
	}
}