package net.java_school.chat;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class ServerProxy extends Thread {
	private Socket socket;
	private BufferedReader br;
	private BufferedWriter bw;
	private ChatServer server;
	private String ip;
	
	public ServerProxy (Socket socket, ChatServer server) throws IOException {
		this.server = server;
		this.socket = socket;
		ip = socket.getInetAddress().getHostAddress() + "]";
		InputStream is = socket.getInputStream();
		OutputStream os = socket.getOutputStream();
		br = new BufferedReader(new InputStreamReader(is));
		bw = new BufferedWriter(new OutputStreamWriter(os));
	}
	
	@Override
	public void run() {
		receiveMessageFromClient();
	}
	
	//클라이언트로부터 메시지를 받는다.
	public void receiveMessageFromClient() {
		String message = null;
		while(true) {
			try {
				message = br.readLine();
			} catch (IOException e) {
				e.printStackTrace();
			}
			if(message.equals("q")) {
				server.removeProxy(this);
				break;
			}
			//ChatServer 메시지를 전달한다.
			message = ip + message + ChatServer.ENTER;
			server.spreadMessage(message);
		}
	}

	public void sendMessageToClient(String message) {
		try {
			bw.write(message);
			bw.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public void close() {
		if (br != null) {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (bw != null) {
			try {
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (socket != null) {
			try {
				socket.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
}
