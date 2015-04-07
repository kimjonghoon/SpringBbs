package net.java_school.board;

import java.util.List;

import net.java_school.commons.PagingHelper;

public interface BoardService {
	
	//목록
	public List<Article> getArticleList(String boardCd, String searchWord);
	
	//총 레코드 수
	public int getTotalRecord(String boardCd, String searchWord);

	//글쓰기
	public int addArticle(Article article);

	//첨부파일 추가
	public void addAttachFile(AttachFile attachFile);
	
	//글수정
	public void modifyArticle(Article article);
	
	//글삭제
	public void removeArticle(int articleNo);

	//조회수 증가
	public void increaseHit(int articleNo);
	
	//상세보기 
	public Article getArticle(int articleNo);
	
	//다음글
	public Article getNextArticle(int articleNo, 
			String boardCd, String searchWord);
	
	//이전글
	public Article getPrevArticle(int articleNo, 
			String boardCd, String searchWord);
	
	//첨부파일 리스트
	public List<AttachFile> getAttachFileList(int articleNo);
	
	//첨부파일 삭제
	public void removeAttachFile(int attachFileNo);

	//게시판 이름
	public String getBoardNm(String boardCd);

	//댓글 쓰기
	public void addComment(Comment comment);
	
	//댓글 수정
	public void modifyComment(Comment comment);
	
	//댓글 삭제
	public void removeComment(int commentNo);

	//댓글 리스트
	public List<Comment> getCommentList(int articleNo);
	
	//첨부파일 찾기
	public AttachFile getAttachFile(int attachFileNo);

	//댓글 찾기
	public Comment getComment(int commentNo);
	
	public int getListItemNo();
	
	public int getPrevPage();
	
	public int getFirstPage();
	
	public int getLastPage();
	
	public int getNextPage();

	public void setPagingHelper(PagingHelper pagingHelper);
	
}