package com.model2.mvc.web.basket;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@Controller
@SessionAttributes("user")
@RequestMapping("/basket/*")
public class BasketController {
	
	@Autowired
	@Qualifier("basketServiceImpl")
	private BasketService basketService;

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productServive;
	
	public BasketController() {
		// TODO Auto-generated constructor stub
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	//@RequestMapping("/addBasket.do")
	@RequestMapping(value = "addBasket")
	public ModelAndView addBasket(@ModelAttribute User user,
									@RequestParam("prodNo") int prodNo, @RequestParam("Quantity") int addQuantity) throws Exception {
		
		System.out.println("/basket/addBasket : GET & POST");
		
		ModelAndView modelAndView = new ModelAndView();
		
		Product product = productServive.getProduct(prodNo);
		
		if(user == null) {
			
		} else {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userId", user.getUserId());
			map.put("product", product);
			map.put("addQuantity", addQuantity);
			
			if(basketService.getBasket(map) == null) {
				basketService.addBasket(map);
			} else if (basketService.getBasket(map) != null) {
				basketService.updateBasket(map);
			}
			
			modelAndView.setViewName("/product/getProduct.jsp");
			modelAndView.addObject("addQuantity", addQuantity);
		}
		
		modelAndView.addObject("product", product);
		
		return modelAndView;
	}
	
	//@RequestMapping("/listBasket.do")
	@RequestMapping(value = "listBasket")
	public ModelAndView listBasket(@ModelAttribute User user, @ModelAttribute Search search) throws Exception {
		
		System.out.println("/basket/listBasket : GET & POST");
		
		Map<String, Object> map = null;
		ModelAndView modelAndView = new ModelAndView();
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		if(user == null) {
			
		} else {
			map = basketService.getBasketList(search, user.getUserId());
			
			Page resultPage = new Page(search.getCurrentPage(), (Integer)map.get("totalCount"), pageUnit, pageSize);
			
			modelAndView.addObject("resultPage", resultPage);
		}
		
		modelAndView.setViewName("/basket/listBasket.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("search", search);
		
		return modelAndView;
	}
	
	//@RequestMapping("/removeBasket.do")
	@RequestMapping(value = "removeBasket")
	public ModelAndView removeBasket(@RequestParam(value = "prodNo", defaultValue = "") String[] prodNo,
										@ModelAttribute User user) throws Exception {
		
		System.out.println("/basket/removeBasket : GET & POST");
		
		ModelAndView modelAndView = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userId", user.getUserId());
		map.put("prodNo", prodNo);
		
		basketService.removeBasket(map);
		
		modelAndView.setViewName("/listBasket.do");
		
		return modelAndView;
	}

}
