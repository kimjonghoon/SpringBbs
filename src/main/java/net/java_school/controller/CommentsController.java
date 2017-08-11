package net.java_school.controller;

import java.security.Principal;
import java.util.List;

import net.java_school.board.BoardService;
import net.java_school.board.Comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/comments")
public class CommentsController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/{articleNo}", method=RequestMethod.GET)
	public List<Comment> getAllComments(@PathVariable Integer articleNo) {
		List<Comment> comments = boardService.getCommentList(articleNo);
		return comments;
	}

	@RequestMapping(value="/{articleNo}", method=RequestMethod.POST)
	public void addComment(String memo, @PathVariable Integer articleNo, Principal principal) {
		Comment comment = new Comment();
		comment.setMemo(memo);
		comment.setArticleNo(articleNo);
		comment.setEmail(principal.getName());

		boardService.addComment(comment);
	}
	
	@RequestMapping(value="/{articleNo}/{commentNo}", method=RequestMethod.PUT)
	public void updateComment(String memo, @PathVariable Integer articleNo, @PathVariable Integer commentNo, Principal principal) {
		Comment comment = boardService.getComment(commentNo);
		comment.setMemo(memo);
		boardService.modifyComment(comment);
	}

	@RequestMapping(value="/{articleNo}/{commentNo}", method=RequestMethod.DELETE)
	public void deleteComment(@PathVariable Integer articleNo, @PathVariable Integer commentNo) {
		Comment comment = boardService.getComment(commentNo);
		boardService.removeComment(comment);
	}	
	
}