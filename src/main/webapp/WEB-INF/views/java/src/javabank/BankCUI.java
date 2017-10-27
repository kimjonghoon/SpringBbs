package net.java_school.javabank;

import java.io.*;

public class BankCUI {
	
	private Bank bank = new Bank();
	
	{
		// 테스트 데이터
		bank.addCustomer("kim", "김태희");
		bank.addCustomer("park", "박지성");
		Customer customer = bank.getCustomer("kim");
		customer.addAccount("111", 1000);
		customer = bank.getCustomer("park");
		customer.addAccount("222", 500);
	}
	
	public BankCUI() throws IOException {
		showMenu();
	}
	
	public void showMenu() throws IOException {
		String menu = null;
		String id = null;
		String name = null;
		
		do {
			System.out.println(" ** 메뉴를 선택하세요 ** ");
			System.out.println(" 1 *** 고객 등록   ");
			System.out.println(" 2 *** 고객 검색   ");
			System.out.println(" 3 *** 고객 목록   ");
			System.out.println(" 4 *** 계좌 생성   ");
			System.out.println(" 5 *** 입금   ");
			System.out.println(" 6 *** 출금   ");
			System.out.println(" q *** 종료   ");
			System.out.println(" ********************** ");
			System.out.print(">>");
			BufferedReader br = 
				new BufferedReader(new InputStreamReader(System.in));
			menu = br.readLine();
			
			try {
				if ( menu.equals("1") ) {
					// 고객 등록
					System.out.print("아이디를 입력하세요>>");
					id = br.readLine();
					System.out.print("이름을 입력하세요>>");
					name = br.readLine();
					bank.addCustomer(id, name);
					Customer customer = bank.getCustomer(id);
					System.out.print("계좌번호를 입력하세요>>");
					String accountNo = br.readLine();
					System.out.print("초기 잔액을 입력하세요>>");
					long balance = Long.parseLong(br.readLine());
					customer.addAccount(accountNo, balance);
				} else if ( menu.equals("2") ) {
					// 고객 검색
					System.out.print("아이디를 입력하세요>>");
					id = br.readLine();
					Customer customer = bank.getCustomer(id);
					System.out.println(
							customer.getId() + ":" + 
							customer.getName());
					Account[] accounts = customer.getAccounts();
					int totalAccount = customer.getTotalAccount();
					for ( int i = 0; i < totalAccount; i++ ) {
						System.out.println(
								"\t" + "계좌번호:" + 
								accounts[i].getAccountNo() + " 잔고:" +
								accounts[i].getBalance() + "원");
					}
				} else if ( menu.equals("3") ) {
					// 고객 목록
					Customer[] customers = bank.getCustomers();
					int totalCustomer = bank.getTotalCustomer();
					for ( int i = 0; i < totalCustomer; i++ ) {
						System.out.println(
								customers[i].getId() + ":" + 
								customers[i].getName());
						Account[] accounts = customers[i].getAccounts();
						int totalAccount = customers[i].getTotalAccount();
						for ( int j = 0; j < totalAccount; j++ ) {
							System.out.println(
									"\t" + "계좌번호:" + 
									accounts[j].getAccountNo() + " 잔고:" +
									accounts[j].getBalance() + "원");
						}
						System.out.println("--------------------------------");
					}
				} else if (menu.equals("4")) {
					// 계좌 생성
				} else if (menu.equals("5")) {
					// 입금
				} else if (menu.equals("6")) {
					// 출금
				}
				System.out.println();
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while ( !menu.equals("q") );
	}
	
	public static void main(String[] args) throws IOException {
		new BankCUI();
	}
	
}