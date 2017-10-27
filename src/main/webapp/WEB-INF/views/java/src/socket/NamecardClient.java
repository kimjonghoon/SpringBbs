package net.java_school.socket.test;

import java.io.*;
import java.net.*;
public class NamecardClient {
	static final String enter = System.getProperty("line.separator");
	private Socket socket;
	
	public NamecardClient(String ip, int port) throws IOException {
		socket = getSocket(ip, port);
	}
	
	public void showMenu() throws IOException {
		OutputStream os = null;
		InputStream is = null;
		BufferedWriter bw = null;
		BufferedReader br = null;
		BufferedReader input = null;
		String menu = null;
		String result = null;
		String send = null;
		
		do {
			System.out.println("메뉴를 선택하세요");
            System.out.println("1.명함등록");
            System.out.println("2.명함목록");
            System.out.println("3.명함삭제");
            System.out.println("4.명함수정");
            System.out.println("5.명함검색");
            System.out.println("q.종료");
            
			os = socket.getOutputStream();
			is = socket.getInputStream();
			bw = new BufferedWriter(new OutputStreamWriter(os));
			br = new BufferedReader(new InputStreamReader(is));
			input = new BufferedReader(new InputStreamReader(System.in));
			menu = input.readLine();
			if (menu.equals("1")) {
				System.out.print("이름을 입력하세요>>");
                String name = input.readLine();
                System.out.print("회사명을 입력하세요>>");
                String company = input.readLine();
                System.out.print("손전화를 입력하세요>>");
                String mobile = input.readLine();
                System.out.print("이메일을 입력하세요>>");
                String email = input.readLine();
                send = "add$"+name+"$"+company+"$"+mobile+"$"+email;
			} else if (menu.equals("2")) {
				send = "list";
			} else if (menu.equals("3")) {
				send = "del";
			} else if (menu.equals("4")) {
				send = "edit";
			} else if (menu.equals("5")) {
				send = "find";
			} else if (menu.equals("q")) {
				send = "q";
			}
			send += enter;
			bw.write(send);
			bw.flush();
			if (menu.equals("q")) {
				break;
			}
			result = br.readLine();
			System.out.println(result);
		} while(true);
		input.close();
		bw.close();
		br.close();
		socket.close();
	}
	
	public Socket getSocket(String ip, int port) {
		Socket socket = null;
		try {
			socket = new Socket(ip, port);
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(0);
		}
		return socket;
	}
	
	public static void main(String[] args) throws IOException {
		NamecardClient namecardClient = new NamecardClient("localhost", 3000);
		namecardClient.showMenu();
	}
	
}
