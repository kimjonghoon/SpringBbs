<!DOCTYPE html>
<html lang="ko">
<? require('../inc/common_start.php'); ?>
<head>
<meta charset="UTF-8" />
<title>주소록 관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="Keywords" content="자바 프로그래밍 실습,주소록 관리,line.separator,toString(),StringBuilder(),생성자,ArrayList,add(),remove(),get(),AddressBook.java,AddressBookManager.java,AddressBookUI.java" />
<meta name="Description" content="구글 주소록과 호환되는 주소록 관리 프로그램을 자바로 구현합니다." />
<link rel="stylesheet" href="/css/screen.css" type="text/css" media="screen" />
<link rel="stylesheet" href="/css/print.css" type="text/css" media="print" />
<link rel="stylesheet" href="/css/prettify.css" type="text/css" />
<script src="/js/jquery-1.10.2.min.js"></script>
<script src="/js/prettify.js"></script>
<script src="/js/commons.js"></script>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function() {

	prettyPrint();	

	$('pre.prettyprint').html(function() {
		return this.innerHTML.replace(/\t/g,'&nbsp;&nbsp;&nbsp;&nbsp;');
	});

	$('pre.prettyprint').dblclick(function() {
		selectRange(this);
	});

});	
//]]>
</script>
</head>
<body>

<div id="wrap">
	
	<header>
		<? require('../inc/header.php'); ?>	
	</header>
	
	<nav id="mainNav">
		<? require('../inc/main_menu.php'); ?>
	</nav>

	<div id="login">
		<form id="frm_login" action="../inc/login.php" method="post">
			<? require('../inc/membership.php'); ?>
		</form>
	</div>

	<div id="content-wrap">
	
<!--  본문 시작 -->	
<article>
<div id="navigator">Java - Lab</div>
<div id="last-modified" class="floatstop">Last Modified : 2012.11.29</div>

<h1>주소록 관리</h1>

명함관리 예제를 참고하여 주소록 관리를 작성한다.
<em class="filename">AddressBook.java</em>
<pre class="prettyprint">
package net.java_school.addressbook;

public class AddressBook {
	private static int TOTAL_ADDRESS = 0;
	private int no;
	private String name;
	private String mobile;
	private String email;
	private String company;
	
	public AddressBook(){}
	
	public AddressBook(String name,String mobile,
			String email,String company) {
		this.no = ++TOTAL_ADDRESS;
		this.name = name;
		this.mobile = mobile;
		this.email = email;
		this.company = company;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append(no);
		sb.append("|");
		sb.append(name);
		sb.append("|");
		sb.append(mobile);
		sb.append("|");
		sb.append(email);
		sb.append("|");
		sb.append(company);
		
		return sb.toString();
	}
	
	public String toCSV() {
		StringBuilder sb = new StringBuilder();
		sb.append(name);
		sb.append(",");
		sb.append(mobile);
		sb.append(",");
		sb.append(email);
		sb.append(",");
		sb.append(company);
		
		return sb.toString();
	}
}
</pre>

<em class="filename">AddressBookManager.java</em>
<pre class="prettyprint">
package net.java_school.addressbook;

import java.util.ArrayList;

public class AddressBookManager {
	
	private ArrayList&lt;AddressBook&gt; addressBooks = new ArrayList&lt;AddressBook&gt;();
	
	public AddressBookManager(){}

	//새로운 주소록을 등록한다.
	public void addAddressBook(AddressBook addressBook) {
		addressBooks.add(addressBook);
	}
	
	//주소록을 번호로 찾는다.
	public AddressBook findAddressBook(int no) {
		AddressBook addressBook = null;
		int total = addressBooks.size();
		for (int i = 0; i &lt; total; i++) {
			if (no == addressBooks.get(i).getNo()) {
				addressBook = addressBooks.get(i);
			}
		}
		return addressBook;
	}
		
	//주소록을 검색어로 찾는다.
	public ArrayList&lt;AddressBook&gt; findAddressBook(String keyword) {
		ArrayList&lt;AddressBook&gt; matchedAddressBooks = new ArrayList&lt;AddressBook&gt;();
		int total = addressBooks.size();
		for(int i = 0; i &lt; total; i++) {
			AddressBook addressBook = addressBooks.get(i);
			if (addressBook.getName().indexOf(keyword) != -1 || 
					addressBook.getMobile().indexOf(keyword) != -1 || 
					addressBook.getEmail().indexOf(keyword) != -1 || 
					addressBook.getCompany().indexOf(keyword) != -1) {
				matchedAddressBooks.add(addressBook);
			}
		}
		
		return matchedAddressBooks;
	}

	//주소록을 삭제한다.
	public void deleteAddressBook(int no) {
		AddressBook addressBook = findAddressBook(no);
		if (addressBook != null) {
			addressBooks.remove(addressBook);
		}
	}
	
	//모든 주소록 목록을 본다.
	public ArrayList&lt;AddressBook&gt; getAddressBooks() {
		return addressBooks;
	}

}
</pre>

<em class="filename">AddressBookUI.java</em>
<pre class="prettyprint">
package net.java_school.addressbook;

import java.io.*;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class AddressBookUI {
	
	private AddressBookManager mgr = new AddressBookManager();
	private static final String ADDRESS_FILE = "/home/kim/java/주소록관리/google.csv";
	private static final String ENTER = System.getProperty("line.separator");
	
	private void readCSV() throws IOException {
		FileReader fr = null;
		try {
			fr = new FileReader(ADDRESS_FILE);
		} catch (FileNotFoundException e) {
			throw new FileNotFoundException("CSV 파일이 없습니다.");
		}
		BufferedReader br = new BufferedReader(fr);
		String addrStr = null;

		
		try {
			br.readLine(); //첫번째 줄은 그냥 넘어간다.
			while ((addrStr = br.readLine()) != null) {
				/*
				 * 간단한 주소록 테스트에 대한 코드
				 * 테스트 후 구글 주소록을 가지고 테스트한다.
				StringTokenizer st = new StringTokenizer(addrStr, ",");
				String name = st.nextToken();
				String mobile = st.nextToken();
				String email = st.nextToken();
				String company = st.nextToken();
				*/
				String[] addrArray = addrStr.split(",", -1);
				String name = addrArray[0];
				String mobile = addrArray[30];
				String email = addrArray[28];
				String company = addrArray[34];
				AddressBook addressBook = new AddressBook(name,mobile,email,company);
				mgr.addAddressBook(addressBook);
			}
		} catch (IOException e) {
			throw new IOException("CSV 파일을 읽는데 실패했습니다.");
		} finally {
			if (br != null) {
				try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fr != null) {
				try {
					fr.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	public void startWork() {
		try {
			readCSV();
		} catch (IOException e) {
			System.out.println(e.getMessage());
			System.out.println("파일로부터 주소록을 로딩하는데 실패했지만 프로그램을 진행합니다.");
		}
		
		String menu = null;
		
		do {
			System.out.println(" ** 메뉴를 선택하세요 ** ");
			System.out.println(" 1 *** 등록   ");
			System.out.println(" 2 *** 목록   ");
			System.out.println(" 3 *** 찾기(키워드)   ");
			System.out.println(" 4 *** 수정   ");
			System.out.println(" 5 *** 삭제   ");
			System.out.println(" q *** 종료   ");
			System.out.println(" ********************** ");
			System.out.print("&gt;&gt;");
			
			try {
				BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
				menu = br.readLine();

				if (menu.equals("1")) {
					// 등록
					System.out.print("이름을 입력하세요&gt;&gt;");
					String name = br.readLine();
					System.out.print("손전화를 입력하세요&gt;&gt;");
					String mobile = br.readLine();
					System.out.print("이메일을 입력하세요&gt;&gt;");
					String email = br.readLine();
					System.out.print("회사를 입력하세요&gt;&gt;");
					String company = br.readLine();
					AddressBook addressBook = new AddressBook(name, mobile, email, company);
					mgr.addAddressBook(addressBook);
				} else if ( menu.equals("2") ) {
					// 목록
					ArrayList&lt;AddressBook&gt; addressBooks = mgr.getAddressBooks();
					int total = addressBooks.size();
					for (int i = 0; i &lt; total; i++) {
						System.out.println(addressBooks.get(i));
					}
				} else if ( menu.equals("3") ) {
					// 찾기(키워드)
					System.out.print("키워드를 입력하세요&gt;&gt;");
					String keyword = br.readLine();
					ArrayList&lt;AddressBook&gt; matchedAddressBooks = mgr.findAddressBook(keyword);
					int total = matchedAddressBooks.size();
					for (int i = 0; i &lt; total;i++) {
						System.out.println(matchedAddressBooks.get(i));
					}
				} else if (menu.equals("4")) {
					//수정
					System.out.print("번호를 입력하세요&gt;&gt;");
					int no = Integer.parseInt(br.readLine());
					AddressBook addressBook = mgr.findAddressBook(no);
					if (addressBook != null) {
						System.out.print("변경하려는 이름을 입력하세요.[변경하지 않으려면 그냥 엔터]&gt;&gt;");
						String name = br.readLine();
						if (!name.equals("")) {
							addressBook.setName(name);
						}
						System.out.print("변경하려는 손전화를 입력하세요.[변경하지 않으려면 그냥 엔터]&gt;&gt;");
						String mobile = br.readLine();
						if (!mobile.equals(mobile)) {
							addressBook.setMobile(mobile);
						}
						System.out.print("변경하려는 이메일을 입력하세요.[변경하지 않으려면 그냥 엔터]&gt;&gt;");
						String email = br.readLine();
						if (!email.equals("")) {
							addressBook.setEmail(email);
						}
						System.out.print("변경하려는 회사를 입력하세요.[변경하지 않으려면 그냥 엔터]&gt;&gt;");
						String company = br.readLine();
						if (!company.equals("")) {
							addressBook.setCompany(company);
						}
					} else {
						System.out.println("번호를 잘못입력하셨습니다.");
					}
				} else if (menu.equals("5")) {
					// 삭제
					System.out.print("삭제할 주소록 번호를 입력하세요&gt;&gt;");
					int no = Integer.parseInt(br.readLine());
					AddressBook addressBook = mgr.findAddressBook(no);
					if (addressBook != null) {
						System.out.print("정말로 삭제하려면 1을 입력하세요&gt;&gt;");
						int chk = Integer.parseInt(br.readLine());
						if (chk == 1) {
							mgr.deleteAddressBook(no);
						}
					} else {
						System.out.println("번호를 잘못 입력하셨습니다.");
					}
				}
				System.out.println();
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while (!menu.equals("q"));
		
	}
	
	public void endWork() {
		StringBuilder sb = new StringBuilder();
		ArrayList&lt;AddressBook&gt; addressBooks = mgr.getAddressBooks();
		int total = addressBooks.size();
		sb.append("Name,Mobile Phone,E-mail Address,Company");
		sb.append(ENTER);
		for (int i = 0; i &lt; total; i++) {
			sb.append(addressBooks.get(i).toCSV());
			sb.append(ENTER);
		}
		FileWriter fw = null;
		BufferedWriter bw = null;
		try {
			fw = new FileWriter(ADDRESS_FILE, false);
			bw = new BufferedWriter(fw);
			bw.write(sb.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (bw != null) {
				try {
					bw.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (fw != null) {
				try {
					fw.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public static void main(String[] args) {
		AddressBookUI ui = null;
		try {
			ui = new AddressBookUI();
			ui.startWork();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ui.endWork();
		}
		System.out.println("프로그램이 정상적으로 종료되었습니다.");
	}
	
}
</pre>
<h3>테스트</h3>
www.gmail.com 에서 주소록을 내보내기로 google.csv 파일을 다운로드한다.<br />
이 파일은 반드시 백업한다.<br />
이 파일을 ADDRESS_FILE 이 가리키는 곳에 위치시킨다.<br />
윈도우 시스템에서는 google.csv 파일의 인코딩을 에디트 플러스를 이용해서 <strong>Korean (EUC) 51949</strong> 로 바꾸어 주어야 
아래와 같은 에러를 피할 수 있다.<br />
참고로 우분투에서는 UTF-8 로 바꾸어 주면 된다.<br />
<pre class="prettyprint">
java.lang.ArrayIndexOutOfBoundsException: 30 
at net.java_school.addressbook.AddressBookUI.readCSV(AddressBookUI.java:38)
at net.java_school.addressbook.AddressBookUI.startWork(AddressBookUI.java:67)
at net.java_school.addressbook.AddressBookUI.main(AddressBookUI.java:210)
</pre>
프로그램을 종료하면 google.csv 파일은 헤더가 Name,Mobile Phone,E-mail Address,Company 로 단순화한 파일로 바뀐다.<br />
이 파일을 구글 주소록에 병합 테스트 해본다.<br />
만일 병합하여 기존 주소록에 문제가 발생하면 백업 파일을 이용한다.<br />
<span id="refer">참고</span>
<ul id="references">
	<li>New 알기쉬운 자바2(개정판) 저자: 김철회 출판사: 정보문화사</li>
	<li><a href="http://seungillee.blogspot.kr/2010/01/csv.html">http://seungillee.blogspot.kr/2010/01/csv.html</a></li> 
</ul>		

			
			<div id="prev-next">
				<ul>
					<li>이전 : <a href="namecard.php">명함관리</a></li>
				</ul>
			</div>

</article>
<!--  본문 끝 -->
		
	</div>
		
	<div id="sidebar">
		<nav id="secondaryNav">
			<? require('java_menu.php'); ?>
		</nav>
	</div>
	
	<aside>
		<?// require('../inc/product_menu.php'); ?>
		<? require('../inc/showAds.php'); ?>
	</aside>
	
	<footer class="floatstop">
		<? require('../inc/footer.php'); ?>
	</footer>

</div>

<div id="form_grp">
	<? require('../inc/forms.php'); ?>
</div>

</body>
</html>