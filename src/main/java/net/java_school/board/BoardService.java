package net.java_school.board;

import java.util.*;

import net.java_school.commons.PagingHelper;

public class BoardService {
	private BoardDao boardDao;
	private PagingHelper pagingHelper; //페이징 처리 유틸리티 클래스
	
	public BoardService() {}
	
	public void setBoardDao(BoardDao boardDao) {
		this.boardDao = boardDao;
	}

	/*
	 * 게시판 목록
	 */
	public ArrayList<Article> getArticleList(String boardCd, String searchWord, int start, int end) {
		Integer startRownum = start;
		Integer endRownum = end;
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		hashmap.put("start", startRownum.toString());
		hashmap.put("end", endRownum.toString());
		
		return boardDao.getArticleList(hashmap);
	}
	
	/*
	 * 특정 게시판의 총 게시물 갯수 구하기
	 */
	public int getTotalRecord(String boardCd, String searchWord) {
		HashMap<String,String> hashmap = new HashMap<String,String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		return boardDao.getTotalRecord(hashmap);
	}

	/*
	 * 새로운 게시글  추가
	 */
	public int insert(Article article) {
		return boardDao.insert(article);
	}

	/*
	 * 첨부파일
	 */
	public AttachFile getAttachFile(int attachFileNo) {
		return boardDao.getAttachFile(attachFileNo);
	}

	/*
	 * 새로운 첨부파일 추가 
	 */
	public void insertAttachFile(AttachFile attachFile) {
		boardDao.insertAttachFile(attachFile);
	}
	
	/*
	 * 게시글 수정
	 */
	public void update(Article article) {
		boardDao.update(article);
	}
	
	/*
	 * 게시글 삭제
	 */
	public void delete(int articleNo) {
		boardDao.delete(articleNo);
	}
	
	/*
	 * 조회수 증가
	 */
	public void increaseHit(int articleNo) {
		boardDao.increaseHit(articleNo);
	}
	
	/*
	 * 게시글 상세보기
	 */
	public Article getArticle(int articleNo) {
		return boardDao.getArticle(articleNo);
	}
	
	/*
	 * 다음글 보기
	 */
	public Article getNextArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardDao.getNextArticle(hashmap);
	}
	
	/*
	 * 이전글 보기
	 */
	public Article getPrevArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardDao.getPrevArticle(hashmap);
	}
	
	/*
	 * 게시글의 첨부파일 리스트
	 */
	public ArrayList<AttachFile> getAttachFileList(int articleNo) {
		return boardDao.getAttachFileList(articleNo);
	}
	
	/*
	 * 첨부파일 삭제
	 */
	public void deleteFile(int attachFileNo) {
		boardDao.deleteFile(attachFileNo);
	}
	
	/*
	 * 게시판이름 구하기
	 */
	public String getBoardNm(String boardCd) {
		return boardDao.getBoardNm(boardCd);
	}
	
	/*
	 * 게시판종류 리스트 구하기
	 */
	public ArrayList<Board> getBoardList() {
		return boardDao.getBoardList();
	}
	
	/*
	 * 덧글쓰기
	 */
	public void insertComment(Comment comment) {
		boardDao.insertComment(comment);
	}
	
	/*
	 * 덧글수정
	 */
	public void updateComment(Comment comment) {
		boardDao.updateComment(comment);
	}
	
	/*
	 * 덧글삭제
	 */
	public void deleteComment(int commentNo) {
		boardDao.deleteComment(commentNo);
	}
	
	/*
	 * 덧글가져오기
	 */
	public Comment getComment(int commentNo) {
		return boardDao.getComment(commentNo);
	}
	
	/*
	 * 게시글의 덧글리스트 구하기
	 */
	public ArrayList<Comment> getCommentList(int articleNo) {
		return boardDao.getCommentList(articleNo);
	}

	public int getListNo() {
		return pagingHelper.getListNo(); 
	}
	
	public int getPrevLink() {
		return pagingHelper.getPrevLink();
	}
	
	public int getFirstPage() {
		return pagingHelper.getFirstPage();
	}
	
	public int getLastPage() {
		return pagingHelper.getLastPage();
	}
	
	public int getNextLink() {
		return pagingHelper.getNextLink();
	}

	public int[] getPageLinks() {
		return pagingHelper.getPageLinks();
	}

	public PagingHelper getPagingHelper() {
		return pagingHelper;
	}

	public void setPagingHelper(PagingHelper pagingHelper) {
		this.pagingHelper = pagingHelper;
	}
	
}