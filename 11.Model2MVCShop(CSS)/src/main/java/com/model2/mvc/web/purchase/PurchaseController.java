package com.model2.mvc.web.purchase;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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

@Controller
@SessionAttributes("user")
@RequestMapping("/purchase/*")
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	
	@Autowired
	@Qualifier("basketServiceImpl")
	private BasketService basketService;
	
	public PurchaseController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}

	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping(value = "addPurchase", method = RequestMethod.POST)
	public ModelAndView addPurchase(@RequestParam("prodNo") String[] prodNo , @RequestParam("Quantity") int[] quantity,
									@ModelAttribute User user, @ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/addPurchase : POST");
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Purchase> list = new ArrayList<Purchase>();
		List<Product> productList = new ArrayList<Product>();
		
		ModelAndView modelAndView = new ModelAndView();
		
		boolean flag = true;
		
		Purchase[] defaultPurchase = new Purchase[quantity.length];
		
		for(int i = 0 ; i < quantity.length ; i++) {
			Product product = productService.getProduct(Integer.parseInt(prodNo[i]));
			
			defaultPurchase[i] = new Purchase();
			
			// 구매 수량 > 재고 수량 -> check = 1
			if(quantity[i] > product.getProdQuantity()) {
				flag = false;
				modelAndView.setViewName("/common/default.jsp");
				break;
			}
			
			product.setProdQuantity(product.getProdQuantity() - quantity[i]);
			defaultPurchase[i].setPaymentOption(purchase.getPaymentOption());
			defaultPurchase[i].setReceiverName(purchase.getReceiverName());
			defaultPurchase[i].setReceiverPhone(purchase.getReceiverPhone());
			defaultPurchase[i].setDivyAddr(purchase.getDivyAddr());
			defaultPurchase[i].setDivyRequest(purchase.getDivyRequest());
			defaultPurchase[i].setDivyDate(purchase.getDivyDate());
			defaultPurchase[i].setBuyQuantity(quantity[i]);
			defaultPurchase[i].setBuyer(user);
			defaultPurchase[i].setPurchaseProd(product);
			
			defaultPurchase[i].setOrderNo((purchaseService.getOrderNo() + 1));
			
			System.out.println("오더 넘버 : " + (purchaseService.getOrderNo() + 1));
			
			list.add(defaultPurchase[i]);
			
			System.out.println("퍼체이스 : " + defaultPurchase[i]);
			productList.add(product);
		}
		
		map.put("list", list);
		map.put("product", productList);
		map.put("userId", user.getUserId());
		map.put("prodNo", prodNo);
		
		if(flag == true) {				
			modelAndView.setViewName("/purchase/addPurchase.jsp");
			
			productService.updateProduct(map);
			purchaseService.addPurchase(map);
			basketService.removeBasket(map);
			
		}
		
		modelAndView.addObject("list", map.get("list"));
		
		return modelAndView;
	}
	
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping(value = "addPurchase", method = RequestMethod.GET)
	public ModelAndView addPurchase(@ModelAttribute User user, @ModelAttribute Search search, 
										@RequestParam("prodNo") int[] prodNo ,
										@RequestParam("Quantity") int[] quantity) throws Exception {
		
		System.out.println("/purchase/addPurchase : GET");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
	
		List<Product> list = new ArrayList<Product>();
		Product product = null;
		
		for(int i = 0 ; i < quantity.length ; i++) {
			product = productService.getProduct(prodNo[i]);
			
			list.add(product);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), quantity.length, pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/addPurchaseView.jsp");
		modelAndView.addObject("list", list);
		modelAndView.addObject("quantity", quantity);
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		return modelAndView;
	}
	
	@RequestMapping(value = "getPurchaseByOrder")
	public ModelAndView getPurchaseByOrder(@RequestParam(value = "orderNo") int orderNo) throws Exception{
		
		List<Purchase> list = purchaseService.getPurchaseByOrder(orderNo);
		
		System.out.println("리스트 : " + list);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("list", list);
		
		return modelAndView;
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping(value = "getPurchase")
	public ModelAndView getPurchase(@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET & POST");
		
		List<Purchase> list = new ArrayList<Purchase>();
		
		purchase = purchaseService.getPurchase(purchase.getTranNo());
		
		list.add(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("list", list);
				
		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value = "updatePurchase", method = RequestMethod.GET)
	public ModelAndView updatePurchase(@RequestParam("tranNo") int tranNo) throws Exception {
		
		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/updatePurchase.do")
	@RequestMapping(value = "updatePurchase", method = RequestMethod.POST)
	public ModelAndView updatePurchase(@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/updatePurchase : POST");
		
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping(value = "listPurchase")
	public ModelAndView listPurchase(@ModelAttribute Search search, @ModelAttribute User user
										, @RequestParam(name = "menu", required = false) String menu) throws Exception {
		
		System.out.println("/purchase/listPurchase : GET & POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = null;
		
		if(menu != null && menu.equals("manage")) {
			map = purchaseService.getPurchaseList(search, "manage");
		} else {
			map = purchaseService.getPurchaseList(search, user.getUserId());
		}
		
		Page resultPage = new Page(search.getCurrentPage(), (Integer)map.get("totalCount"), pageUnit, pageSize);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/purchase/listPurchase.jsp");
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("menu", menu);
		
		return modelAndView;
	}
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping(value = "updateTranCode")
	public ModelAndView updateTranCode(@RequestParam(value = "tranCode") String tranCode, 
										@RequestParam(value = "prodNo", defaultValue = "0") int prodNo, 
										@RequestParam(value = "tranNo", defaultValue = "0") int tranNo, 
										@ModelAttribute Purchase purchase) throws Exception {
		
		System.out.println("/purchase/updateTranCode : GET & POST");
		
		ModelAndView modelAndView = new ModelAndView();
		
		if(tranNo == 0) {
			Product product = productService.getProduct(prodNo);
			
			purchase.setTranCode(tranCode);
			purchase.setPurchaseProd(product);
			
			modelAndView.setViewName("/purchase/listPurchase?menu=manage");
		} else if(prodNo == 0) {
			purchase.setTranNo(tranNo);
			purchase.setTranCode(tranCode);
			
			modelAndView.setViewName("/purchase/listPurchase");
		}
		
		purchaseService.updateTransCode(purchase);
		
		return modelAndView;
	}
	
	//@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value = "updateTranCodeByProd", method = RequestMethod.GET)
	public ModelAndView updateTranCodeByProd() {
		
		System.out.println("/purchase/updateTranCodeByProd : GET & POST");
		
		ModelAndView modelAndView = new ModelAndView();
		
		return modelAndView;
	}
	
}
