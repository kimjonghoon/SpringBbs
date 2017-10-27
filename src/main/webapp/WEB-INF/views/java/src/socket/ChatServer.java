package net.java_school.chat;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;

public class ChatServer {
	
	public static final String ENTER = System.getProperty("line.separator");
	private ServerSocket serverSocket;
	public ArrayList<ServerProxy> list = new ArrayList<ServerProxy>();
	private int port;
	
	public void startServer() {
		Socket socket = null;
		System.out.println("서버 작동");
		try {
			serverSocket = new ServerSocket(port);
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(0);
		}
		
		while (true){
			try {
				socket = serverSocket.accept();
				String clientIp = socket.getInetAddress().getHostAddress();
				System.out.print("클라이언트의 IP : " +  clientIp + "|");
				System.out.println(socket);
				ServerProxy proxy = new ServerProxy(socket, this);
				list.add(proxy);
				proxy.start();
				System.out.println(clientIp + " 님의 서버 프록시가 정상적으로 등록되었습니다.");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}
	
	public ChatServer(int port) {
		this.port = port;
	}
	
	public void spreadMessage(String message) {
		for (int i = 0; i < list.size(); i++) {
			list.get(i).sendMessageToClient(message);
		}
	}
	
	public void removeProxy(ServerProxy proxy) {
		proxy.close();
		list.remove(proxy);
		System.out.println(proxy.getIp() + "님은 채팅을 그만합니다.");
	}
	
    public static void main(String[] args) {
    	ChatServer server = new ChatServer(3000);
		server.startServer();
	}
    
}