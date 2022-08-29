package com.model2.mvc.service.basket.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketService;
import com.model2.mvc.service.domain.Basket;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class BasketServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	
	@Autowired
	@Qualifier("basketServiceImpl")
	private BasketService basketService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	//@Test
	public void testAddBasket() throws Exception {
		
		Product product = productService.getProduct(10000);
		User user = userService.getUser("user06");
		
//		basketService.addBasket(product, user.getUserId());
		
		//==> API Ȯ��
	}
	
	//@Test
	public void testGetBasket() throws Exception {
		
		Product product = productService.getProduct(10000);
		User user = userService.getUser("user06");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userId", user.getUserId());
		map.put("prodNo", product.getProdNo());
		
		Basket basket = basketService.getBasket(map);
		
		Assert.assertEquals(1, basket.getBasketCount());
		
		//==> API Ȯ��
	}
	
	//@Test
	public void testUpdateBasket() throws Exception{
		Product product = productService.getProduct(10000);
		User user = userService.getUser("user06");
			
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userId", user.getUserId());
		map.put("prodNo", product.getProdNo());
		
		Basket basket = basketService.getBasket(map);
		
		Assert.assertEquals(1, basket.getBasketCount());
		
		
	 }
	 
	 //@Test
	 public void testRemoveBasket() throws Exception{
		 
		String[] removeBasket = null;
		 
		removeBasket = new String[2];
		removeBasket[0] = "10002";
		removeBasket[1] = "10003";
		
		Map<String, Object> map = new HashMap<String, Object>();
			
		map.put("removeBasketProdNo", removeBasket);
		map.put("userId", "user06");
		 
		basketService.removeBasket(map);
	 
	 }
}