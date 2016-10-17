package net.java_school.chat;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class ChatClient extends Thread {
	private static final String ENTER = System.getProperty("line.separator");
	private Socket socket;
	
	public ChatClient(String ip, int port) {
		socket = getSocket(ip, port);
	}
	
	@Override
	public void run()  {
		//메시지를 서버로부터 받는다.
		InputStream is = null;
		BufferedReader br = null;
		String receive = null;
		
		try {
			do {
				is = socket.getInputStream();
				br = new BufferedReader(new InputStreamReader(is));
				receive = br.readLine();
				System.out.println(receive);
			} while(true);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if (br != null) {
			try {
				br.close();
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

	public void sendMessage() {
		//서버로 메시지를 전달한다.
		OutputStream os = null;
		BufferedWriter bw = null;
		BufferedReader input = null;
		String send = null;
		
		try {
			do {
				os = socket.getOutputStream();
				bw = new BufferedWriter(new OutputStreamWriter(os));
				input = new BufferedReader(new InputStreamReader(System.in));
				send = input.readLine();
				if (send.equals("q")) {
					bw.write(send + ENTER);
					bw.flush();
					break;
				}
				send += ENTER;
				bw.write(send);
				bw.flush();
			} while(true);
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		if (input != null) {
			try {
				input.close();
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
	
	public static void main(String[] args)  {
		ChatClient chatClient = null;
		chatClient = new ChatClient("localhost", 3000);
		chatClient.start();
		chatClient.sendMessage();
	}
	
}