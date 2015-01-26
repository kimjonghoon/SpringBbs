package net.java_school.board;

import java.util.*;

import net.java_school.commons.PagingHelper;

public interface BoardService {

	/*
	 * 게시판 목록
	 */
	public ArrayList<Article> getArticleList(String boardCd, String searchWord, int start, int end);
	
	/*
	 * 특정 게시판의 총 게시물 갯수 구하기
	 */
	public int getTotalRecord(String boardCd, String searchWord);

	/*
	 * 새로운 게시글  추가
	 */
	public int insert(Article article);

	/*
	 * 첨부파일
	 */
	public AttachFile getAttachFile(int attachFileNo);

	/*
	 * 새로운 첨부파일 추가 
	 */
	public void insertAttachFile(AttachFile attachFile);
	
	/*
	 * 게시글 수정
	 */
	public void update(Article article);
	
	/*
	 * 게시글 삭제
	 */
	public void delete(int articleNo);
	
	/*
	 * 조회수 증가
	 */
	public void increaseHit(int articleNo);
	
	/*
	 * 게시글 상세보기
	 */
	public Article getArticle(int articleNo);
	
	/*
	 * 다음글 보기
	 */
	public Article getNextArticle(int articleNo, String boardCd, String searchWord);
	
	/*
	 * 이전글 보기
	 */
	public Article getPrevArticle(int articleNo, String boardCd, String searchWord);
	
	/*
	 * 게시글의 첨부파일 리스트
	 */
	public ArrayList<AttachFile> getAttachFileList(int articleNo);
	
	/*
	 * 첨부파일 삭제
	 */
	public void deleteFile(int attachFileNo);
	
	/*
	 * 게시판이름 구하기
	 */
	public String getBoardNm(String boardCd);
	
	/*
	 * 게시판종류 리스트 구하기
	 */
	public ArrayList<Board> getBoardList();
	
	/*
	 * 덧글쓰기
	 */
	public void insertComment(Comment comment);
	
	/*
	 * 덧글수정
	 */
	public void updateComment(Comment comment);
	
	/*
	 * 덧글삭제
	 */
	public void deleteComment(int commentNo);
	
	/*
	 * 덧글가져오기
	 */
	public Comment getComment(int commentNo);
	
	/*
	 * 게시글의 덧글리스트 구하기
	 */
	public ArrayList<Comment> getCommentList(int articleNo);

	public int getListNo();
	
	public int getPrevLink();
	
	public int getFirstPage();
	
	public int getLastPage();
	
	public int getNextLink();

	public int[] getPageLinks();

	public void setPagingHelper(PagingHelper pagingHelper);
	
}