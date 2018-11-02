package net.java_school.bank;

import java.util.List;

public interface BankDao {

	public void insertAccount(String accountNo, String name, String kind);

	public Account selectOneAccount(String accountNo);

	public List<Account> selectAccountsByName(String name);

	public List<Account> selectAllAccounts();

	public void deposit(String accountNo, long amount);

	public void withdraw(String accountNo, long amount);

	public List<Transaction> selectAllTransactions(String accountNo);

}