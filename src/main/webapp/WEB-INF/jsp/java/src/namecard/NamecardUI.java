package net.java_school.namecard;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class NamecardUI {
	
	private NamecardManager cardMgr = new NamecardManager();;
	
	{
		cardMgr.addCard(new Namecard("김태희","루아엔터테인먼트 ","배우","010-1234-5678","02-555-0987","02-555-9876","taehee@navar.com","서울 서초구"));
		cardMgr.addCard(new Namecard("박지성","맨체스터유나이티드 ","선수","010-0987-6543","00700-122345678","00700-03938937","jisungpark@navar.com","영국 맨체스터"));
	}
	
	public NamecardUI(){}

	public void showMenu() throws IOException {
		
		String menu = null;
		
		do{
			System.out.println("메뉴를 선택하세요");
			System.out.println("1.명함등록");
			System.out.println("2.명함목록");
			System.out.println("3.명함삭제");
			System.out.println("4.명함수정");
			System.out.println("5.명함검색");
			System.out.println("q.종료");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
			
			menu = br.readLine();	
			try {
				if (menu.equals("1")) {
					System.out.print("이름을 입력하세요>>");
					String name = br.readLine();
					
					System.out.print("회사명을 입력하세요>>");
					String company = br.readLine();
					
					System.out.print("직책을 입력하세요>>");
					String title = br.readLine();
					
					System.out.print("손전화를 입력하세요>>");
					String mobile = br.readLine();
					
					System.out.print("회사전화를 입력하세요>>");
					String phone = br.readLine();

					System.out.print("팩스를 입력하세요>>");
					String fax = br.readLine();
					
					System.out.print("이메일을 입력하세요>>");
					String email = br.readLine();

					System.out.print("회사주소를 입력하세요>>");
					String address = br.readLine();

					Namecard card = new Namecard(name, company, title, mobile, phone, fax, email, address);
					cardMgr.addCard(card);
				} else if (menu.equals("2")) {
					ArrayList<Namecard> cards = cardMgr.getCards();
					int totalCard = cards.size();
					for(int i = 0; i < totalCard; i++) {
						System.out.println(cards.get(i).toString());
					}
					System.out.println();
				} else if (menu.equals("3")) {
					System.out.print("삭제할 이름을 입력하세요>>");
					String name = br.readLine();
					ArrayList<Namecard> searchCards = cardMgr.findCard(name);
					int totalCard = searchCards.size();
					for (int i = 0; i < totalCard; i++) {
						System.out.println(searchCards.get(i).toString());
					}
					if ( totalCard != 0) {
						System.out.print("삭제할 번호를 선택하세요>>");
						int id = Integer.parseInt(br.readLine());
						cardMgr.deleteCard(id);
					}
				} else if (menu.equals("4")) {
					System.out.print("수정할 명함의 이름을 입력하세요>>");
					String name = br.readLine();
					ArrayList<Namecard> searchCards = cardMgr.findCard(name);
					int totalCard = searchCards.size();
					for (int i = 0; i < totalCard; i++) {
						System.out.println(searchCards.get(i).toString());
					}
					if ( totalCard != 0) {
						System.out.print("수정할 명함번호를 선택하세요>>");
						int id = Integer.parseInt(br.readLine());
						Namecard card = cardMgr.getCard(id);

						System.out.print("이름을 수정하려면  입력하세요 >>");
						name = br.readLine();
						if (!name.equals("")) {
							card.setName(name);
						}

						System.out.print("회사명을 수정하려면  입력하세요>>");
						String company = br.readLine();
						if (!company.equals("")) {
							card.setCompany(company);
						}
						
						System.out.print("타이틀을 수정하려면  입력하세요>>");
						String title = br.readLine();
						if (!title.equals("")) {
							card.setTitle(title);
						}
						
						System.out.print("손전화를 수정하려면  입력하세요>>");
						String mobile = br.readLine();
						if (!mobile.equals("")) {
							card.setMobile(mobile);
						}	
						
						System.out.print("회사전화를 수정하려면  입력하세요>>");
						String phone = br.readLine();
						if (!phone.equals("")){
							card.setAddress(phone);
						}
						
						System.out.print("팩스를 수정하려면  입력하세요>>");
						String fax = br.readLine();
						if (!fax.equals("")) {
							card.setFax(fax);
						}
						System.out.print("이메일을 수정하려면  입력하세요>>");
						String email = br.readLine();
						if (!email.equals("")) {
							card.setEmail(email);
						}

						System.out.print("회사주소를 수정하려면  입력하세요>>");
						String address = br.readLine();
						if (!address.equals("")) {
							card.setFax(address);
						}
					}
				} else if (menu.equals("5")) {
					System.out.print("검색할 이름을 입력하세요>>");
					String name = br.readLine();
					ArrayList<Namecard> cards = cardMgr.findCard(name);
					int totalCard = cards.size();
					for(int i = 0; i < totalCard; i++) {
						System.out.println(cards.get(i).toString());
					}
					System.out.println();
				}
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		} while(!menu.equals("q"));
	}
	
	public static void main(String[] args) throws IOException {
		NamecardUI cardUI = new NamecardUI();
		cardUI.showMenu();
	}

}