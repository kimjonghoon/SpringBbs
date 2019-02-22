package net.java_school.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import net.java_school.board.Board;
import net.java_school.board.BoardService;
import net.java_school.commons.NumbersForPaging;
import net.java_school.commons.Paginator;
import net.java_school.commons.WebContants;
import net.java_school.user.User;
import net.java_school.user.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController extends Paginator {

    @Autowired
    private UserService userService;

    @Autowired
    private BoardService boardService;

    @GetMapping
    public String index(Integer page, String search, Model model) {
    	
        if (page == null) {
            page = 1;
        }

        int numPerPage = 20;
        int pagePerBlock = 10;

        int totalRecord = userService.getTotalCount(search);
        NumbersForPaging numbers = this.getNumbersForPaging(totalRecord, page, numPerPage, pagePerBlock);

        HashMap<String, String> map = new HashMap<>();

/*        
        //Oracle start
        Integer startRecord = (page - 1) * numPerPage + 1;
        Integer endRecord = page * numPerPage;
        map.put("search", search);
        map.put("startRecord", startRecord.toString());
        map.put("endRecord", endRecord.toString());
        //Oracle end
*/
        
      
        //MySQL and MariaDB start
        Integer offset = (page - 1) * numPerPage;
        Integer rowCount = numPerPage;
        map.put("search", search);
        map.put("offset", offset.toString());
        map.put("rowCount", rowCount.toString());
        //MySQL and MariaDB end


        List<User> list = userService.getAllUser(map);

        Integer listItemNo = numbers.getListItemNo();
        Integer prev = numbers.getPrevBlock();
        Integer next = numbers.getNextBlock();
        Integer firstPage = numbers.getFirstPage();
        Integer lastPage = numbers.getLastPage();

        model.addAttribute("list", list);
        model.addAttribute("listItemNo", listItemNo);
        model.addAttribute("prev", prev);
        model.addAttribute("next", next);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);

        return "admin/index";
    }

    @GetMapping("/editAccount")
    public String editAccountForm(String email, Model model) {
        User user = userService.getUser(email);
        //List<String> authorities = userService.getAuthoritiesOfUser(email);
        model.addAttribute(WebContants.USER_KEY, user);
        //model.addAttribute("authorities", authorities);

        return "admin/editAccount";
    }

    @PostMapping("/editAccount")
    public String editAccount(User user, String page, String search) throws Exception {
        userService.editAccountByAdmin(user);

        if (search != null && !search.equals("")) {
            search = URLEncoder.encode(search, "UTF-8");
        }
        return "redirect:/admin/editAccount?email=" + user.getEmail() + "&page=" + page + "&search=" + search;
    }

    @PostMapping("/changePasswd")
    public String changePasswd(User user, String page, String search) throws Exception {
        userService.changePasswdByAdmin(user);

        if (search != null && !search.equals("")) {
            search = URLEncoder.encode(search, "UTF-8");
        }
        return "redirect:/admin/editAccount?email=" + user.getEmail() + "&page=" + page + "&search=" + search;
    }

    @PostMapping("/delUser")
    public String delUser(User user, String page, String search) throws Exception {
        userService.delUser(user);

        if (search != null && !search.equals("")) {
            search = URLEncoder.encode(search, "UTF-8");
        }
        return "redirect:/admin?email=" + user.getEmail() + "&page=" + page + "&search=" + search;
    }

    @GetMapping("/board")
    public String boardList(Model model) {
        List<Board> boards = boardService.getBoards();
        model.addAttribute("boards", boards);

        return "admin/board";
    }

    @PostMapping("/createBoard")
    public String createBoard(Board board) {
        boardService.createBoard(board);

        return "redirect:/admin/board";
    }

    @PostMapping("/editBoard")
    public String editBoard(Board board) {
        boardService.editBoard(board);

        return "redirect:/admin/board";
    }

    @GetMapping("/delAuthority")
    public String delAuthority(String authority, String email, String page, String search) throws Exception {

        userService.delAuthorityOfUser(email, authority);
        if (search != null && !search.equals("")) {
            search = URLEncoder.encode(search, "UTF-8");
        }
        return "redirect:/admin/editAccount?email=" + email + "&page=" + page + "&search=" + search;
    }

    @PostMapping("/addAuthority")
    public String addAuthority(String authority, String email, String page, String search) throws Exception {

        userService.addAuthority(email, authority);
        if (search != null && !search.equals("")) {
            search = URLEncoder.encode(search, "UTF-8");
        }
        return "redirect:/admin/editAccount?email=" + email + "&page=" + page + "&search=" + search;
    }

}