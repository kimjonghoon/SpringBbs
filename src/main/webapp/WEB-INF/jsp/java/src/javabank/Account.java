package net.java_school.javabank;

public class Account {
	private String accountNo;	//°èÁÂ¹øÈ£
	private long balance;		//ÀÜ°í

	public Account(String accountNo, long balance) {
		this.accountNo = accountNo;
		this.balance = balance;
	}

	public String getAccountNo() {
		return accountNo;
	}
	 
	public void setAccountNo(String accountNo) {
		this.accountNo = accountNo;
	}
	 
	public long getBalance() {
		return balance;
	}
	 
	public void setBalance(long balance) {
		this.balance = balance;
	}
	 
	public void deposit(long money) {
		balance = balance + money;
	}
	 
	public void withdraw(long money) {
		balance = balance - money;
	}

}