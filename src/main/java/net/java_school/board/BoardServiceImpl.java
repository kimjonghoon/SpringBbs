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

	//게시판
	@Override
	public Board getBoard(String boardCd) {
		return boardMapper.selectOneBoard(boardCd);
	}
	
	//게시판 목록
	@Override
	public List<Board> getBoards() {
		return boardMapper.selectAllBoard();
	}
	
	//게시판 생성
	@Override
	public void createBoard(Board board) {
		boardMapper.insertBoard(board);
	}
	
	//게시판 수정
	@Override
	public void editBoard(Board board) {
		boardMapper.updateBoard(board);
	}
	
	//목록
	@Override
	public List<Article> getArticleList(HashMap<String, String> hashmap) {
		return boardMapper.selectListOfArticles(hashmap);
	}
	
	//총 레코드수
	@Override
	public int getTotalRecord(String boardCd, String searchWord) {
		HashMap<String, String> hashmap = new HashMap<String, String>();
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
	public void increaseHit(Integer articleNo, String ip, String yearMonthDayHour) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("articleNo", articleNo.toString());
		map.put("ip", ip);
		map.put("yearMonthDayHour", yearMonthDayHour);
		
		boardMapper.insertOneViews(map);
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
	
	//댓글 editable를 true로 세팅
	@Override
	public void setEditableTrue(List<Comment> comments) {
		for (Comment comment : comments) {
			comment.setEditable(true);
		}
	}
	
	//조회수 for 상세보기
	@Override
	public int getTotalViews(int articleNo) {
		return boardMapper.selectCountOfViews(articleNo);
	}

}