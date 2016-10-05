package net.java_school.board;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.java_school.mybatis.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardMapper boardMapper;
	
	//게시판 목록
	@Override
	public List<Board> getListOfBoardCodeAndBoardName() {
		return boardMapper.selectListOfBoardCodeBoardName();
	}

	//게시판 목록
	@Override
	public List<Board> getListOfBoardCodeAndBoardKoreanName() {
		return boardMapper.selectListOfBoardCodeBoardKoreanName();
	}
	
	//목록
	@Override
	public List<Article> getArticleList(String boardCd, String searchWord, Integer startRecord, Integer endRecord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		hashmap.put("start", startRecord.toString());
		hashmap.put("end", endRecord.toString());
		
		return boardMapper.selectListOfArticles(hashmap);
	}
	
	//총 레코드수
	@Override
	public int getTotalRecord(String boardCd, String searchWord) {
		HashMap<String,String> hashmap = new HashMap<String,String>();
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.selectCountOfArticles(hashmap);
	}

	//글쓰기
	@Override
	public int addArticle(Article article) {
		return boardMapper.insert(article);
	}

	//첨부파일 추가
	@Override
	public void addAttachFile(AttachFile attachFile) {
		boardMapper.insertAttachFile(attachFile);
	}
	
	//글수정
	@Override
	public void modifyArticle(Article article) {
		boardMapper.update(article);
	}

	//글삭제
	@Override
	public void removeArticle(Article article) {
		boardMapper.delete(article.getArticleNo());
	}

	//조회수 증가
	@Override
	public void increaseHit(int articleNo) {
		boardMapper.updateHitPlusOne(articleNo);
	}

	//상세보기
	@Override
	public Article getArticle(int articleNo) {
		return boardMapper.selectOne(articleNo);
	}

	//다음글
	@Override
	public Article getNextArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.selectNextOne(hashmap);
	}
	
	//이전글
	@Override
	public Article getPrevArticle(int articleNo, String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
		Integer no = articleNo;
		hashmap.put("articleNo", no.toString());
		hashmap.put("boardCd", boardCd);
		hashmap.put("searchWord", searchWord);
		
		return boardMapper.selectPrevOne(hashmap);
	}

	//첨부파일 리스트
	@Override
	public List<AttachFile> getAttachFileList(int articleNo) {
		return boardMapper.selectListOfAttachFiles(articleNo);
	}

	//첨부파일 삭제
	@Override
	public void removeAttachFile(AttachFile attachFile) {
		boardMapper.deleteFile(attachFile.getAttachFileNo());
	}

	//게시판 이름
	@Override
	public Board getBoardNm(String boardCd) {
		return boardMapper.selectOneBoardName(boardCd);
	}

	//댓글 쓰기
	@Override
	public void addComment(Comment comment) {
		boardMapper.insertComment(comment);
	}
	
	//댓글 수정
	@Override
	public void modifyComment(Comment comment) {
		boardMapper.updateComment(comment);
	}
	
	//댓글 삭제
	@Override
	public void removeComment(Comment comment) {
		boardMapper.deleteComment(comment.getCommentNo());
	}
	
	//댓글 리스트
	@Override
	public List<Comment> getCommentList(int articleNo) {
		return boardMapper.selectListOfComments(articleNo);
	}

	//첨부파일 찾기
	@Override
	public AttachFile getAttachFile(int attachFileNo) {
		return boardMapper.selectOneAttachFile(attachFileNo);
	}

	//댓글 찾기
	@Override
	public Comment getComment(int commentNo) {
		return boardMapper.selectOneComment(commentNo);
	}

}