package net.java_school.bank;

import java.util.List;

public interface BankDao {
    
    //계좌 생성
    public void insertAccount(String accountNo, String name, String kind);
    
    //계좌번호로 계좌 찾기
    public Account selectOneAccount(String accountNo);
    
    //소유자로 계좌 찾기
    public List<Account> selectAccountsByName(String name);
    
    //계좌 목록
    public List<Account> selectAllAccounts();
    
    //입금
    public void deposit(String accountNo, long amount);
    
    //출금
    public void withdraw(String accountNo, long amount);
    
    //입출금 명세
    public List<Transaction> selectAllTransactions(String accountNo);

}