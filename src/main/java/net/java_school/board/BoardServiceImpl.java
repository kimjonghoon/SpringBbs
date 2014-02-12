package net.java_school.board;

import java.util.HashMap;
import java.util.List;

import net.java_school.commons.PagingHelper;
import net.java_school.mybatis.BoardMapper;

public class BoardServiceImpl implements BoardService {
	private BoardMapper boardMapper;
	private PagingHelper pagingHelper; //페이징 처리 유틸리티 클래스
	
	public void setBoardMapper(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}

	/*
	 * 게시판 목록
	 */
	public List<Article> getArticleList(String boardCd, String searchWord, int start, int end) {
		Integer startRownum = start;
		Integer endRownum = end;
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		hashmap.put("start", startRownum.toString());
		hashmap.put("end", endRownum.toString());
		
		return boardMapper.getArticleList(hashmap);
	}
	
	/*
	 * 특정 게시판의 총 게시물 갯수 구하기
	 */
	public int getTotalRecord(String boardCd, String searchWord) {
		HashMap<String,String> hashmap = new HashMap<String,String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		return boardMapper.getTotalRecord(hashmap);
	}

	/*
	 * 새로운 게시글  추가
	 */
	public int insert(Article article) {
		return boardMapper.insert(article);
	}

	/*
	 * 첨부파일
	 */
	public AttachFile getAttachFile(int attachFileNo) {
		return boardMapper.getAttachFile(attachFileNo);
	}

	/*
	 * 새로운 첨부파일 추가 
	 */
	public void insertAttachFile(AttachFile attachFile) {
		boardMapper.insertAttachFile(attachFile);
	}
	
	/*
	 * 게시글 수정
	 */
	public void update(Article article) {
		boardMapper.update(article);
	}
	
	/*
	 * 게시글 삭제
	 */
	public void delete(int articleNo) {
		boardMapper.delete(articleNo);
	}
	
	/*
	 * 조회수 증가
	 */
	public void increaseHit(int articleNo) {
		boardMapper.increaseHit(articleNo);
	}
	
	/*
	 * 게시글 상세보기
	 */
	public Article getArticle(int articleNo) {
		return boardMapper.getArticle(articleNo);
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
		
		return boardMapper.getNextArticle(hashmap);
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
		
		return boardMapper.getPrevArticle(hashmap);
	}
	
	/*
	 * 게시글의 첨부파일 리스트
	 */
	public List<AttachFile> getAttachFileList(int articleNo) {
		return boardMapper.getAttachFileList(articleNo);
	}
	
	/*
	 * 첨부파일 삭제
	 */
	public void deleteFile(int attachFileNo) {
		boardMapper.deleteFile(attachFileNo);
	}
	
	/*
	 * 게시판이름 구하기
	 */
	public String getBoardNm(String boardCd) {
		return boardMapper.getBoardNm(boardCd);
	}
	
	/*
	 * 게시판종류 리스트 구하기
	 */
	public List<Board> getBoardList() {
		return boardMapper.getBoardList();
	}
	
	/*
	 * 덧글쓰기
	 */
	public void insertComment(Comment comment) {
		boardMapper.insertComment(comment);
	}
	
	/*
	 * 덧글수정
	 */
	public void updateComment(Comment comment) {
		boardMapper.updateComment(comment);
	}
	
	/*
	 * 덧글삭제
	 */
	public void deleteComment(int commentNo) {
		boardMapper.deleteComment(commentNo);
	}
	
	/*
	 * 덧글가져오기
	 */
	public Comment getComment(int commentNo) {
		return boardMapper.getComment(commentNo);
	}
	
	/*
	 * 게시글의 덧글리스트 구하기
	 */
	public List<Comment> getCommentList(int articleNo) {
		return boardMapper.getCommentList(articleNo);
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