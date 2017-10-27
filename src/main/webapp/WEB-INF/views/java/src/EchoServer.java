
import java.io.*;
import java.net.*;
public class  EchoServer{
	static final String enter = System.getProperty("line.separator");
	ServerSocket serverSocket;
    
	public EchoServer(int port) {
		try {
			serverSocket = new ServerSocket(port);
		} catch(IOException e) {
			e.printStackTrace();
			System.exit(0);
		}
		
		while(true) {
			try {
				System.out.println("클라이언트를 요청을 기다리는 중");
				Socket socket = serverSocket.accept();
				System.out.println("클라이언트의 IP 주소 : " + socket.getInetAddress().getHostAddress());
				InputStream is = socket.getInputStream();
				OutputStream os = socket.getOutputStream();
				BufferedReader br = new BufferedReader(new InputStreamReader(is));
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
				String message = br.readLine();
				System.out.println("수신메시지 : "+ message);
				message = message + enter;
				bw.write(message);
				bw.flush();
				br.close();
				bw.close();
				socket.close();
			}catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
    public static void main(String[] args){
        new EchoServer(3000);
    }
}
