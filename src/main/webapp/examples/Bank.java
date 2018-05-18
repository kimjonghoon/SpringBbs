package net.java_school.bank;

import java.io.Serializable;
import java.util.List;

public interface Bank extends Serializable {
    
    //계좌를 생성한다.
    public void addAccount(String accountNo, String name, String kind);
    
    /*//계좌를 생성한다.
    public void addAccount(String accountNo, String name, long balance, String kind);
    */
    //계좌번호로 계좌를 찾는다.
    public Account getAccount(String accountNo);
    
    //소유자 명으로 계좌를 찾는다.
    public List<Account> findAccountByName(String name);
    
    //모든 계좌를 반환한다.
    public List<Account> getAccounts();
    
    //입금
    public void deposit(String accountNo, long amount);
    
    //출금
    public void withdraw(String accountNo, long amount);
    
    //이체
    public void transfer(String from, String to, long amount);
    
    //입출금 명세
    public List<Transaction> getTransactions(String accountNo); 
  
}