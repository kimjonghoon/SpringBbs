package net.java_school.board;

import java.util.HashMap;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;

public interface BoardService {
	//게시판
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Board getBoard(String boardCd);

	//게시판 목록
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public List<Board> getBoards();
	
	//게시판 생성
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void createBoard(Board board);

	//게시판 수정
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void editBoard(Board board);
	
	//목록
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public List<Article> getArticleList(HashMap<String, String> hashmap);
	
	//총 레코드 수
	public int getTotalRecord(String boardCd, String searchWord);

	//글쓰기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public int addArticle(Article article);

	//첨부파일 추가
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void addAttachFile(AttachFile attachFile);
	
	//글수정
	@PreAuthorize("#article.email == principal.username or hasRole('ROLE_ADMIN')")
	public void modifyArticle(Article article);
	
	//글삭제
	@PreAuthorize("#article.email == principal.username or hasRole('ROLE_ADMIN')")
	public void removeArticle(Article article);

	//조회수 증가
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void increaseHit(int articleNo);
	
	//상세보기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Article getArticle(int articleNo);
	
	//다음글
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Article getNextArticle(int articleNo, 
			String boardCd, String searchWord);
	
	//이전글
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Article getPrevArticle(int articleNo, 
			String boardCd, String searchWord);
	
	//첨부파일 리스트
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public List<AttachFile> getAttachFileList(int articleNo);
	
	//첨부파일 삭제
	@PreAuthorize("#attachFile.email == principal.username or hasRole('ROLE_ADMIN')")
	public void removeAttachFile(AttachFile attachFile);

	//댓글 쓰기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public void addComment(Comment comment);
	
	//댓글 수정
	@PreAuthorize("#comment.email == principal.username or hasRole('ROLE_ADMIN')")
	public void modifyComment(Comment comment);
	
	//댓글 삭제
	@PreAuthorize("#comment.email == principal.username or hasRole('ROLE_ADMIN')")
	public void removeComment(Comment comment);

	//댓글 리스트
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public List<Comment> getCommentList(int articleNo);
	
	//첨부파일 찾기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public AttachFile getAttachFile(int attachFileNo);

	//댓글 찾기
	@PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	public Comment getComment(int commentNo);
	
	//댓글 editable 세팅
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void setEditableTrue(List<Comment> comments);
	
}