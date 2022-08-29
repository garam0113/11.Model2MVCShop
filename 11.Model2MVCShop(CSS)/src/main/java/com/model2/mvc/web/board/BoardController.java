package com.model2.mvc.web.board;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.board.BoardService;
import com.model2.mvc.service.domain.Board;
import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.domain.User;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;

	@Value("#{commonProperties['pageUnit'] ?: 10}")
	int pageUnit;
	
	public BoardController() {
		// TODO Auto-generated constructor stub
	}

	//@RequestMapping("/addBoard.do")
	@RequestMapping(value = "addBoard")
	public ModelAndView addBoard(HttpSession session, @ModelAttribute Board board) throws Exception {
		
		System.out.println("/board/addBasket : GET & POST");
		User user = (User) session.getAttribute("user");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(user != null) {
			board.setPassword("");
			board.setUserId(user.getUserId());
		}
		
		map.put("board", board);
		
		boardService.addBoard(map);
		
		modelAndView.setViewName("/board/listBoard");
		
		return modelAndView;
	}
	
	//@RequestMapping("/deleteBoard.do")
	@RequestMapping(value = "deleteBoard")
	public ModelAndView deleteBoard(@RequestParam("boardNo") int boardNo) {
		
		System.out.println("/board/deleteBoard : GET & POST");
		
		boardService.deleteBoard(boardNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/board/listBoard");
		
		
		return modelAndView;
	}
	
	@RequestMapping(value = "getBoard")
	public ModelAndView getBoard(HttpSession session, @RequestParam("boardNo") int boardNo) throws Exception {
		
		System.out.println("/board/getBoard");
		
		User user = (User)session.getAttribute("user");
		
		Board board = boardService.getBoard(boardNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/board/getBoard.jsp");
		modelAndView.addObject("board", board);
		modelAndView.addObject("user", user);
		
		return modelAndView;
	}
	
	//@RequestMapping("/listBoard.do")
	@RequestMapping(value = "listBoard")
	public ModelAndView listBoard(@ModelAttribute Search search) throws Exception {
		
		System.out.println("/board/listBoard : GET & POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		ModelAndView modelAndView = new ModelAndView();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map = boardService.listBoard(map);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")), pageUnit, pageSize);
		
		System.out.println(map.get("list"));
		
		modelAndView.setViewName("/board/listBoard.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	@RequestMapping(value = "modifyBoard", method = RequestMethod.GET)
	public String modifyBoard(@RequestParam("boardNo") int boardNo, Model model) throws Exception {
		
		System.out.println("/board/modifyBoard : GET");
		
		Board board = boardService.getBoard(boardNo);
		
		model.addAttribute("board", board);
		
		return "/board/modifyBoard.jsp";
	}
	
	@RequestMapping(value = "modifyBoard", method = RequestMethod.POST)
	public String modifyBoard(@ModelAttribute Board board, HttpSession session, Model model) throws Exception {
		
		System.out.println("/board/modifyBoard : POST");
		User user = (User)session.getAttribute("user");
		boardService.updateBoard(board);
		System.out.println("보드 정보 : " + board);
		System.out.println("유저 정보 : " + user);
		
		model.addAttribute("user", user);
		
		board.setUserId(user.getUserId());
		
		model.addAttribute("board", board);
		
		return "/board/getBoard.jsp";
	}
}
