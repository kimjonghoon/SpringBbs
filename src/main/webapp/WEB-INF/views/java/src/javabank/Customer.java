package net.java_school.javabank;

public class Customer {
	
	private String id;
	private String name;
	private Account[] accounts = new Account[3];    //°èÁÂ 3°³±îÁö
	private int totalAccount;                       //ÃÑ °èÁÂ¼ö
	
	public Customer(String id, String name) {
		this.id = id;
		this.name = name;
	}
	     
    public void addAccount(String accountNo, long balance) {
        Account account = new Account(accountNo, balance);
        accounts[totalAccount++] = account;
    }
     
    public Account getAccount(String accountNo) {
        Account account = null;
        for ( int i = 0; i < totalAccount; i++ ) {
            if ( accountNo.equals(accounts[i].getAccountNo()) ) {
                account = accounts[i];
                break;
            }
        }
         
        return account;
    }
     
    public String getId() {
        return id;
    }
     
    public void setId(String id) {
        this.id = id;
    }
     
    public String getName() {
        return name;
    }
     
    public void setName(String name) {
        this.name = name;
    }
     
    public Account[] getAccounts() {
        return accounts;
    }

	public int getTotalAccount() {
		return totalAccount;
	}
}