package net.java_school.socket.test;

import java.io.*;
import java.net.*;
import java.util.StringTokenizer;

import net.java_school.namecard.Namecard;
import net.java_school.namecard.NamecardManager;
public class  NamecardServer{
	static final String enter = System.getProperty("line.separator");
	ServerSocket serverSocket;
	private NamecardManager mgr = new NamecardManager();
	
	public NamecardServer(int port) throws IOException {
		serverSocket = new ServerSocket(port);
		System.out.println("서버 작동");
		Socket socket = serverSocket.accept();

		InputStream is = socket.getInputStream();
		OutputStream os = socket.getOutputStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
		
		do {
			String message = br.readLine();
			if(message.equals("q")) {
				break;
			}
			String result = null;
			//명함추가
			StringTokenizer st = new StringTokenizer(message, "$");
			String protocol = st.nextToken(); 
			if (protocol.equals("add")) {
				String name = st.nextToken();
				String company = st.nextToken();
				String mobile = st.nextToken();
				String email = st.nextToken();
				Namecard namecard = new Namecard(name, company, mobile, email);
				mgr.addNamecard(namecard);
				result = "명함이 추가되었습니다";
			}
			
			result = result + enter;
			bw.write(result);
			bw.flush();
		} while(true);
		br.close();
		bw.close();
		socket.close();
	}
	
    public static void main(String[] args) throws IOException{
        new NamecardServer(3000);
    }
}
