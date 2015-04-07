package net.java_school.board;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Article {
	private static final SimpleDateFormat LIST_DATE_FORMAT = 
			new SimpleDateFormat("yyyy.MM.dd");
	private static final SimpleDateFormat VIEW_DATE_FORMAT = 
			new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	private int articleNo;
	private String boardCd;
	private String title;
	private String content;
	private String email;
	private String name;
	private int hit;
	private Date regdate;
	private int attachFileNum;
	private int commentNum;
	
	public static final String ENTER = System.getProperty("line.separator");
	
	public int getArticleNo() {
		return articleNo;
	}
	public void setArticleNo(int articleNo) {
		this.articleNo = articleNo;
	}
	public String getBoardCd() {
		return boardCd;
	}
	public void setBoardCd(String boardCd) {
		this.boardCd = boardCd;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public String getHtmlContent() {
		if (content != null) {
			return content.replaceAll(ENTER, "<br />");
		} 
		return null;  
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getAttachFileNum() {
		return attachFileNum;
	}
	public void setAttachFileNum(int attachFileNum) {
		this.attachFileNum = attachFileNum;
	}
	public int getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(int commentNum) {
		this.commentNum = commentNum;
	}
	public String getRegdateForList() {
		return Article.LIST_DATE_FORMAT.format(this.regdate);
	}
	public String getRegdateForView() {
		return Article.VIEW_DATE_FORMAT.format(this.regdate);
	}
	
}