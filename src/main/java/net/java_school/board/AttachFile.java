package net.java_school.board;

public class AttachFile {
    private int attachFileNo;
    private String filename;    
    private String filetype;    
    private long filesize;    
    private int articleNo;
    private String email;
    
    public int getAttachFileNo() {
        return attachFileNo;
    }
    public void setAttachFileNo(int attachFileNo) {
        this.attachFileNo = attachFileNo;
    }
    public String getFilename() {
        return filename;
    }
    public void setFilename(String filename) {
        this.filename = filename;
    }
    public String getFiletype() {
        return filetype;
    }
    public void setFiletype(String filetype) {
        this.filetype = filetype;
    }
    public long getFilesize() {
        return filesize;
    }
    public void setFilesize(long filesize) {
        this.filesize = filesize;
    }
    public int getArticleNo() {
        return articleNo;
    }
    public void setArticleNo(int articleNo) {
        this.articleNo = articleNo;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    
}