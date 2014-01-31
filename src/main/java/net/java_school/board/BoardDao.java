package net.java_school.board;

import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;

import net.java_school.mybatis.BoardMapper;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class BoardDao {
	private static BoardDao instance = new BoardDao();
	
	private String resource = "net/java_school/mybatis/Configuration.xml";
	private Reader reader;
	private SqlSessionFactory sqlSessionFactory;
	
	public static BoardDao getInstance() {
		return instance;
	}
	
	private BoardDao() {
		try {
			reader = Resources.getResourceAsReader(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/*
	 * 게시판 목록
	 */
	public ArrayList<Article> getArticleList(HashMap<String, String> hashmap) {
		ArrayList<Article> articleList = new ArrayList<Article>();
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			articleList = mapper.getArticleList(hashmap);
		} finally {
			session.close();
		}
		
		return articleList;
	}

	/*
	 * 게시판의 총 게시물 갯수 구하기
	 */
	public int getTotalRecord(HashMap<String, String> hashmap) {
		int totalRecord = 0;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			totalRecord = mapper.getTotalRecord(hashmap);
		} finally {
			session.close();
		}
		
		return totalRecord;
	}

	/* 
	 * 새로운 게시글 추가
	 */
	public int insert(Article article) {
		SqlSession session = sqlSessionFactory.openSession();
		int ret = -1;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			ret = mapper.insert(article);
			session.commit();
		} finally {
			session.close();
		}
		return ret;
	}
	
	/*
	* 첨부파일
	*/
	public AttachFile getAttachFile(int attachFileNo) {
		AttachFile attachFile = null;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			attachFile = mapper.getAttachFile(attachFileNo);
		} finally {
			session.close();
		}		
		return attachFile;
	}

	/* 
	 * 새로운 첨부파일 추가 
	 */
	public void insertAttachFile(AttachFile attachFile) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.insertAttachFile(attachFile);
			session.commit();
		} finally {
			session.close();
		}
	}
	
	/*
	 * 게시글 수정
	 */
	public void update(Article article) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.update(article);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/* 
	 * 게시글 삭제
	 */
	public void delete(int articleNo) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.delete(articleNo);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/*
	 * 조회수 증가

	 */
	public void increaseHit(int articleNo) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.increaseHit(articleNo);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/*
	 * 게시글 상세보기
	 */
	public Article getArticle(int articleNo) {
		Article article = null;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			article = mapper.getArticle(articleNo);
		} finally {
			session.close();
		}		
		return article;
	}
	
	/*
	 * 다음글 보기
	 */
	public Article getNextArticle(HashMap<String, String> hashmap) {
		Article article = null;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			article = mapper.getNextArticle(hashmap);
		} finally {
			session.close();
		}
		return article;
		
	}
	
	/*
	 * 이전글 보기
	 */
	public Article getPrevArticle(HashMap<String, String> hashmap) {
		Article article = null;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			article = mapper.getPrevArticle(hashmap);
		} finally {
			session.close();
		}
		return article;
		
	}
	
	/*
	 * 게시글의 첨부파일 리스트
	 */
	public ArrayList<AttachFile> getAttachFileList(int articleNo) {
		ArrayList<AttachFile> attachFileList = new ArrayList<AttachFile>();
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			attachFileList = mapper.getAttachFileList(articleNo);
		} finally {
			session.close();
		}
		return attachFileList;
	}
	
	/*
	 * 첨부파일 삭제
	 */
	public void deleteFile(int attachFileNo) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.deleteFile(attachFileNo);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/*
	 * 게시판이름 구하기
	 */
	public String getBoardNm(String boardCd) {
		String boardNm = null;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			boardNm = mapper.getBoardNm(boardCd);
		} finally {
			session.close();
		}		
		return boardNm;
	}
	
	/*
	 * 게시판종류 리스트 구하기
	 */
	public ArrayList<Board> getBoardList() {
		ArrayList<Board> boardList = new ArrayList<Board>();
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			boardList = mapper.getBoardList();
		} finally {
			session.close();
		}		
		return boardList;
	}

	/*
	 * 덧글쓰기
	 */
	public void insertComment(Comment comment) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.insertComment(comment);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/*
	 * 덧글수정
	 */
	public void updateComment(Comment comment) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.updateComment(comment);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/*
	 * 덧글삭제
	 */
	public void deleteComment(int commentNo) {
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			mapper.deleteComment(commentNo);
			session.commit();
		} finally {
			session.close();
		}		
	}
	
	/*
	 * 덧글 가져오기
	 */
	public Comment getComment(int commentNo) {
		Comment comment = null;
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			comment = mapper.getComment(commentNo);
		} finally {
			session.close();
		}		
		return comment;
	}
	
	/*
	 * 게시글의 덧글리스트 구하기
	 */
	public ArrayList<Comment> getCommentList(int articleNo) {
		ArrayList<Comment> commentList = new ArrayList<Comment>();
		SqlSession session = sqlSessionFactory.openSession();
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			commentList = mapper.getCommentList(articleNo);
		} finally {
			session.close();
		}		
		return commentList;
	}
	
}