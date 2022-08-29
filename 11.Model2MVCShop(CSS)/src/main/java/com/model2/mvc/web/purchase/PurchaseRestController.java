package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	@Autowired
	@Qualifier("basketServiceImpl")
	BasketService basketService;
	
	public PurchaseRestController() {
		// TODO Auto-generated constructor stub
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@Value("#{commonProperties['pageUnit'] ? : 3}")
	// 없다면 ? 3으로 초기화
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@RequestMapping(value = "json/addPurchase/{prodNo}/{prodNo}/{quantity}/{quantity}/{currentPage}", method = RequestMethod.GET)
	public Map<String, Object> addPurchase(@PathVariable int[] prodNo,
								@PathVariable int[] quantity,
								@PathVariable int currentPage) throws Exception {
		
		List<Product> list = new ArrayList<Product>();
		Product product = null;
		
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setPageSize(5);
		search.setPageUnit(5);
		
		System.out.println("prodNo 크기 : " + prodNo.length);
		
		for(int i = 0 ; i < 1 ; i++) {
			product = productService.getProduct(prodNo[i]);
			
			list.add(product);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), quantity.length, search.getPageUnit(), search.getPageSize());
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("quantity", quantity);
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value = "json/addPurchase", method = RequestMethod.POST)
	public Map<String, Object> addPurchase(@RequestBody Map<String, Object> map) throws Exception {
		
		map = (Map<String, Object>) map.get("map");
		
		User user = userService.getUser((String)map.get("userId"));
		
		List<Integer> prodNo = (List<Integer>) map.get("prodNo");
		List<Integer> quantity = (List<Integer>) map.get("quantity");
		
		List<Purchase> list = new ArrayList<Purchase>();
		List<Product> productList = new ArrayList<Product>();
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		boolean flag = true;
		
		Purchase[] defaultPurchase = new Purchase[quantity.size()];
		
		for(int i = 0 ; i < quantity.size() ; i++) {
			Product product = productService.getProduct(prodNo.get(i));
			
			defaultPurchase[i] = new Purchase();
			
			// 구매 수량 > 재고 수량 -> check = 1
			if(quantity.get(i) > product.getProdQuantity()) {
				flag = false;
				break;
			}
			
			product.setProdQuantity(product.getProdQuantity() - quantity.get(i));
			defaultPurchase[i].setBuyQuantity(quantity.get(i));
			defaultPurchase[i].setBuyer(user);
			defaultPurchase[i].setPurchaseProd(product);
			
			defaultPurchase[i].setOrderNo((purchaseService.getOrderNo() + 1));
			
			System.out.println("오더 넘버 : " + (purchaseService.getOrderNo() + 1));
			
			list.add(defaultPurchase[i]);
			
			System.out.println("퍼체이스 : " + defaultPurchase[i]);
			productList.add(product);
		}
		
		returnMap.put("list", list);
		returnMap.put("product", productList);
		returnMap.put("userId", user.getUserId());
		returnMap.put("prodNo", prodNo);
		
		if(flag == true) {
			
			productService.updateProduct(returnMap);
			purchaseService.addPurchase(returnMap);
			basketService.removeBasket(returnMap);
			
		}
		
		return returnMap;
	}
	
	@RequestMapping(value = "json/listPurchase/{value}", method = RequestMethod.GET)
	public Map<String, Object> listPurchase(@PathVariable String value) throws Exception {
		
		Map<String, Object> map = null;
		
		Search search = new Search();
		search.setCurrentPage(1);
	
		search.setPageSize(5);
		search.setPageUnit(5);
		
		if(value.equals("manage")) {
			map = purchaseService.getPurchaseList(search, "manage");
			map.put("menu", value);
		} else {
			map = purchaseService.getPurchaseList(search, value);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), (Integer)map.get("totalCount"), search.getPageUnit(), search.getPageSize());
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		System.out.println(" ::  " + map);
		
		return map;
	}
	
	@RequestMapping(value = "json/listPurchase", method = RequestMethod.POST)
	public Map<String, Object> listPurchase(@RequestBody Object a) {
		
		System.out.println("메뉴 : " + a);
		
		return null;
	}
	
	@RequestMapping(value = "json/updateTranCode/{tranNo}/{tranCode}", method = RequestMethod.GET)
	public int updateTranCode(@PathVariable(name = "tranNo" ,required = false) int tranNo, @PathVariable String tranCode) throws Exception {
		
		Purchase purchase = new Purchase();
		int returnValue = Integer.parseInt(tranCode);
		
		purchase = purchaseService.getPurchase(tranNo);
		
		System.out.println(" :: " + purchase);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTransCode(purchase);
		
		return returnValue;
	}
	
	@RequestMapping(value = "json/updateTranCode/{prodNo}/{tranCode}", method = RequestMethod.POST)
	public int updateTranCode(@PathVariable String tranCode, 
			@PathVariable(name = "prodNo", required = false) int prodNo) throws Exception {
		
		Purchase purchase = new Purchase();
		int returnValue = Integer.parseInt(tranCode);
		
		purchase.setTranCode(tranCode);
			
		purchaseService.updateTransCode(purchase);
		
		return returnValue;
	}
	
	@RequestMapping(value = "json/getPurchaseByOrder", method = RequestMethod.POST)
	public List<Purchase> getPurchaseByOrder(@RequestBody Purchase purchase) throws Exception {
		
		System.out.println("orderNo : " + purchase.getOrderNo());
		
		List<Purchase> list = purchaseService.getPurchaseByOrder(purchase.getOrderNo());
		
		System.out.println("json 리스트 : " + list);
		
		return list;
	}

}
