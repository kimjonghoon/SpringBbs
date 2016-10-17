import java.io.*;//
import java.net.*;
public class EchoClient {
	static final String enter = System.getProperty("line.separator");
	
	public EchoClient(String ip, int port) throws IOException {
		Socket socket = getSocket(ip, port);
		OutputStream os = socket.getOutputStream();
		InputStream is = socket.getInputStream();
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(os));
		BufferedReader br = new BufferedReader(new InputStreamReader(is));
		System.out.print("ют╥б : ");
		BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
		String str = input.readLine();
		str += enter;
		bw.write(str);
		bw.flush();
		str = br.readLine();
		System.out.println("Echo Result : " + str);
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
		new EchoClient("localhost", 3000);
	}
	
}
