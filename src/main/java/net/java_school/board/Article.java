package net.java_school.board;

import java.util.Date;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class Article {

    private Integer articleNo;
    private String boardCd;

    @NotNull
    @Size(min = 1, max = 100, message = "{bbs.title.validation.error}")
    private String title;

    @NotNull
    @Size(min = 2, message = "{bbs.content.validation.error}")
    private String content;

    private String email;
    private String name;
    private int hit;
    private Date regdate;
    private int attachFileNum;
    private int commentNum;

    public static final String ENTER = System.getProperty("line.separator");

    public Integer getArticleNo() {
        return articleNo;
    }

    public void setArticleNo(Integer articleNo) {
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
}
