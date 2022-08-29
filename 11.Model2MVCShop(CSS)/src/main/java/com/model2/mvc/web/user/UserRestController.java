package com.model2.mvc.web.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public UserRestController() {
		// TODO Auto-generated constructor stub
		System.out.println("::" + this.getClass());
	}
	
	//@Value("#{commonProperties['pageSize'] ? : 2}")
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@Value("#{commonProperties['pageUnit'] ? : 3}")
	// 없다면 ? 3으로 초기화
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;

	@RequestMapping(value = "json/addUser", method = RequestMethod.GET)
	public User addUser() {
		return null;
	}
	
	@RequestMapping(value = "json/addUser", method = RequestMethod.POST)
	public User addUser(@RequestBody User user) throws Exception {
		
		System.out.println("/user/json/addUser : POST");
		
		System.out.println("::" + user);
		
		if(userService.getUser(user.getUserId()) == null) {
			userService.addUser(user);
		}
		
		return user;
	}
	
	@RequestMapping(value = "json/getUser/{userId}", method = RequestMethod.GET)
	public User getUser(@PathVariable String userId) throws Exception {
		
		System.out.println("/user/json/getUser : GET");
		
		return userService.getUser(userId);
	}
	
	
	@RequestMapping(value = "json/updateUser/{userId}", method = RequestMethod.GET)
	public User updateUser(@PathVariable String userId) throws Exception {
		
		System.out.println("/user/json/updateUser : GET");
		
		return userService.getUser(userId);
	}
	
	@RequestMapping(value = "json/updateUser", method = RequestMethod.POST)
	public User updateUser(@RequestBody User user) throws Exception {
		
		System.out.println("/user/json/updateUser : POST");
		
		userService.updateUser(user);
		
		user = userService.getUser(user.getUserId());
		
		return user;
	}
	
	@RequestMapping(value = "json/login", method = RequestMethod.POST)
	public User login(@RequestBody User user, HttpSession session) throws Exception {
		
		System.out.println("/user/json/login : POST");
		
		System.out.println("::" + user);
		User dbUser = userService.getUser(user.getUserId());
		
		if(user.getPassword().equals(dbUser.getPassword())) {
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping(value = "json/logoutUser", method = RequestMethod.GET)
	public void logoutUser(HttpSession session) {
		
		System.out.println("/user/json/logoutUser : GET");
		
		session.invalidate();
	}
	
	@RequestMapping(value = "json/checkDuplication", method = RequestMethod.POST)
	public boolean checkDuplication(@RequestBody User user) throws Exception {
		
		System.out.println("/user/json/checkDuplication : POST");
		System.out.println("클라이언트로부터 받은 데이터 " + user.getUserId());
		
		boolean result = userService.checkDuplication(user.getUserId());
		
		return result;
	}
	
	@RequestMapping(value = "json/listUser")
	public List<User> listUser(@RequestBody Search search) throws Exception {
		
		System.out.println("/user/json/listUser : GET & POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		return (List<User>)userService.getUserList(search).get("list");
		
	}
}
