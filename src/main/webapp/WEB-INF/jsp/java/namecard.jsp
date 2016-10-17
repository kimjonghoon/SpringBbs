<!DOCTYPE html>
<html lang="ko">
<? require('../inc/common_start.php'); ?>
<head>
<meta charset="UTF-8" />
<title>명함관리</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="Keywords" content="자바 프로그래밍 실습,명함관리,line.separator,toString(),StringBuilder(),생성자,ArrayList,add(),remove(),get(),Namecard.java,NamecardManager.java,NamecardUI.java" />
<meta name="Description" content="자바로 구현하는 간단한 명함 관리 프로그램을 실습합니다." />
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
<body>

<div id="wrap">
	
	<header>
		<? require('../inc/header.php'); ?>	
	</header>
	
	<div id="mainNav">
		<? require('../inc/main_menu.php'); ?>
	</div>

	<div id="login">
		<form id="frm_login" action="../inc/login.php" method="post">
			<? require('../inc/membership.php'); ?>
		</form>
	</div>

	<div id="content-wrap">
	
<!-- 본문 시작 -->	
<article>
<div id="navigator">Java - Lab</div>
<div id="last-modified" class="floatstop">Last Modified : 2012.11.28</div>

<h1>명함관리</h1>

자바은행의 예제를 참고하여 명함관리를 작성해 본다.
<em class="filename">Namecard.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

public class Namecard {
	private static int seq;
	private int no;
	private String name;
	private String mobile;
	private String email;
	private String company;
	
	public Namecard() {
		this.no = ++seq;
	}
	
	public Namecard(String name,String mobile,
			String email,String company) {
		this.no = ++seq;
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
	
	@Override
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
	
}
</pre>

<em class="filename">NamecardManager.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

import java.util.ArrayList;

public class NamecardManager {
	private ArrayList&lt;Namecard&gt; cards= new ArrayList&lt;Namecard&gt;();
	
	public NamecardManager() {}
	
	//명함을 등록한다.
	public void addCard(Namecard card) {
		cards.add(card);
	}
	
	//명함을 삭제한다.
	public void deleteCard(int no) {
		Namecard card = findCard(no);
		if (card != null) {
			cards.remove(card);
		}
	}
	
	//명함을 번호로 찾는다.
	public Namecard findCard(int no){
		Namecard card = null;
		int total = cards.size();
		for(int i=0; i &lt; total; i++) {
			if (cards.get(i).getNo()== no) {
				card = cards.get(i);
				break;
			}
		}
		
		return card;
	}
	
	//명함을 검색어로 찾는다.
	public ArrayList&lt;Namecard&gt; findCard(String keyword) {
		ArrayList&lt;Namecard&gt; matchedCards = new ArrayList&lt;Namecard&gt;();
		int total = cards.size();
		for(int i = 0; i &lt; total; i++) {
			Namecard card = cards.get(i);
			if (card.getName().indexOf(keyword) != -1 || 
					card.getMobile().indexOf(keyword) != -1 || 
					card.getEmail().indexOf(keyword) != -1 || 
					card.getCompany().indexOf(keyword) != -1) {
				matchedCards.add(cards.get(i));
			}
		}
		
		return matchedCards;
	}
	
	// 명함객체 참조값을 담고 있는ArrayList cards 에 대한 getter 
	public ArrayList&lt;Namecard&gt; getCards() {
		return cards;
	}

}
</pre>

<em class="filename">NamecardUI.java</em>
<pre class="prettyprint">
package net.java_school.namecard;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class NamecardUI {
	
	private NamecardManager cardMgr = new NamecardManager();;
	
	{
		//인스턴스 블록을 이용한 테스트 자료  
		cardMgr.addCard(new Namecard("김태희","111-1234-5678","taehee@google.org","LUA"));
		cardMgr.addCard(new Namecard("박지성","222-9876-5432","jisung@google.org","QPR"));
	}
	
	public NamecardUI() {}

	public void showMenu() throws IOException {
		
		String menu = null;
		
		do {
			System.out.println("메뉴를 선택하세요");
			System.out.println("1.명함등록");
			System.out.println("2.명함목록");
			System.out.println("3.명함삭제");
			System.out.println("4.명함수정");
			System.out.println("5.명함검색");
			System.out.println("q.종료");
	
			try {
				BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
				menu = br.readLine();
				
				if (menu.equals("1")) {
					System.out.print("이름을 입력하세요&gt;&gt;");
					String name = br.readLine();

					System.out.print("손전화를 입력하세요&gt;&gt;");
					String mobile = br.readLine();
					
					System.out.print("이메일을 입력하세요&gt;&gt;");
					String email = br.readLine();
					
					System.out.print("회사명을 입력하세요&gt;&gt;");
					String company = br.readLine();
					
					Namecard card = new Namecard(name, mobile, email, company);
					cardMgr.addCard(card);
				} else if (menu.equals("2")) {
					ArrayList&lt;Namecard&gt; cards = cardMgr.getCards();
					int totalCard = cards.size();
					for(int i = 0; i &lt; totalCard; i++) {
						System.out.println(cards.get(i));
					}
				} else if (menu.equals("3")) {
					System.out.print("삭제할 번호를 선택하세요&gt;&gt;");
					int no = Integer.parseInt(br.readLine());
					cardMgr.deleteCard(no);
				} else if (menu.equals("4")) {
					System.out.print("수정할 명함번호를 선택하세요&gt;&gt;");
					int no = Integer.parseInt(br.readLine());
					Namecard card = cardMgr.findCard(no);
					if (card != null) {
						System.out.print("수정할 이름을 입력하세요[수정하지 않으려면 엔터]&gt;&gt;");
						String name = br.readLine();
						if (!name.equals("")) {
							card.setName(name);
						}
						System.out.print("수정할 손전화를 입력하세요[수정하지 않으려면 엔터]&gt;&gt;");
						String mobile = br.readLine();
						if (!mobile.equals("")) {
							card.setMobile(mobile);
						}	
						System.out.print("수정할 이메일을 입력하세요[수정하지 않으려면 엔터]&gt;&gt;");
						String email = br.readLine();
						if (!email.equals("")) {
							card.setEmail(email);
						}
						System.out.print("수정할 회사명을 입력하세요[수정하지 않으려면 엔터]&gt;&gt;");
						String company = br.readLine();
						if (!company.equals("")) {
							card.setCompany(company);
						}
					}
				} else if (menu.equals("5")) {
					System.out.print("검색어를 입력하세요&gt;&gt;");
					String keyword = br.readLine();
					ArrayList&lt;Namecard&gt; cards = cardMgr.findCard(keyword);
					int totalCard = cards.size();
					for(int i = 0; i &lt; totalCard; i++) {
						System.out.println(cards.get(i));
					}
				}
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}
		} while(!menu.equals("q"));
	}
	
	public static void main(String[] args) throws IOException {
		NamecardUI cardUI = new NamecardUI();
		cardUI.showMenu();
	}

}
</pre>

<span id="refer">참고</span>
<ul id="references">
	<li>New 알기쉬운 자바2(개정판) 저자: 김철회 출판사: 정보문화사</li> 
</ul>		
			
			<div id="prev-next">
				<ul>
					<li>다음 : <a href="addressbook.php">주소록 관리</a></li>
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