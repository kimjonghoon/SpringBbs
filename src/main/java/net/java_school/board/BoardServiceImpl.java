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

	//목록
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
	
	//총 레코드수
	public int getTotalRecord(String boardCd, String searchWord) {
		HashMap<String,String> hashmap = new HashMap<String,String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		return boardMapper.getTotalRecord(hashmap);
	}

	//글쓰기
	public int addArticle(Article article) {
		return boardMapper.insert(article);
	}

	//글수정
	public void modifyArticle(Article article) {
		boardMapper.update(article);
	}

	//글삭제
	public void removeArticle(int articleNo) {
		boardMapper.delete(articleNo);
	}

	//조회수 증가
	public void increaseHit(int articleNo) {
		boardMapper.increaseHit(articleNo);
	}

	//게시글 조회
	public Article getArticle(int articleNo) {
		return boardMapper.getArticle(articleNo);
	}

	//다음글
	public Article getNextArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.getNextArticle(hashmap);
	}
	
	//이전글
	public Article getPrevArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.getPrevArticle(hashmap);
	}

	//첨부파일 리스트
	public List<AttachFile> getAttachFileList(int articleNo) {
		return boardMapper.getAttachFileList(articleNo);
	}

	//첨부파일 조회
	public AttachFile getAttachFile(int attachFileNo) {
		return boardMapper.getAttachFile(attachFileNo);
	}

	//첨부파일 추가
	public void addAttachFile(AttachFile attachFile) {
		boardMapper.insertAttachFile(attachFile);
	}
	
	//첨부파일 삭제
	public void removeAttachFile(int attachFileNo) {
		boardMapper.deleteFile(attachFileNo);
	}

	//게시판 이름
	public String getBoardNm(String boardCd) {
		return boardMapper.getBoardNm(boardCd);
	}

	//댓글 리스트
	public List<Comment> getCommentList(int articleNo) {
		return boardMapper.getCommentList(articleNo);
	}
	
	//댓글 조회
	public Comment getComment(int commentNo) {
		return boardMapper.getComment(commentNo);
	}
	
	//댓글 쓰기
	public void addComment(Comment comment) {
		boardMapper.insertComment(comment);
	}
	
	//댓글 수정
	public void modifyComment(Comment comment) {
		boardMapper.updateComment(comment);
	}
	
	//댓글 삭제
	public void removeComment(int commentNo) {
		boardMapper.deleteComment(commentNo);
	}

	public int getListItemNo() {
		return pagingHelper.getListItemNo(); 
	}
	
	public int getPrevPage() {
		return pagingHelper.getPrevPage();
	}
	
	public int getFirstPage() {
		return pagingHelper.getFirstPage();
	}
	
	public int getLastPage() {
		return pagingHelper.getLastPage();
	}
	
	public int getNextPage() {
		return pagingHelper.getNextPage();
	}

	public void setPagingHelper(PagingHelper pagingHelper) {
		this.pagingHelper = pagingHelper;
	}

}