package com.model2.mvc.web.reply;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.service.domain.User;

@Controller
@RequestMapping("/reply/*")
public class ReplyController {
	
	@RequestMapping(value = "addReply", method = RequestMethod.POST)
	public String addReply(@RequestParam("reply") String reply, HttpSession session) {
		
		System.out.println("답변 달기 : " + reply);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		// userId, reply, date, flag 
		
		User user = (User)session.getAttribute("user");
		
		map.put("userId", user.getUserId());
		map.put("reply", reply);
		
//		boardService.addReply(map);
		
		return "/board/getBoard.jsp";
	}
}