package com.model2.mvc.service.purchase.test;

import java.text.SimpleDateFormat;
import java.util.Date;
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
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;
import com.model2.mvc.service.user.UserService;


/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class PurchaseServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	Purchase purchase = new Purchase();
	Product product = new Product();
	User user = new User();
	
	@Test
	public void testAddProduct() throws Exception {
		
		System.out.println("\n[AddPurchaseAction execute start]\n");
		
		int prod_no = 10000;
		Date orderDate = new Date();
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String formatDate = simpleDateFormat.format(orderDate);
		
		java.sql.Date sqlDate = java.sql.Date.valueOf(formatDate);
		
		Product product = new Product();
		Purchase purchase = new Purchase();
		
		product = productService.getProduct(prod_no);
		
		int prodQuantity = product.getProdQuantity();
		
		User user = new User();
		user = userService.getUser("user07");
		
		purchase.setBuyer(user);
		purchase.setDivyAddr("seoul");
		purchase.setDivyDate("2022-08-01");
		purchase.setDivyRequest("fast");
		purchase.setOrderDate(sqlDate);
		purchase.setPaymentOption("1");
		purchase.setPurchaseProd(product);
		purchase.setReceiverName("H2");
		purchase.setReceiverPhone("000-1111-2222");
		purchase.setTranCode("1");
//		purchase.setPurchaseQuantity(1);
//		
//		if(prodQuantity >= purchase.getPurchaseQuantity()) {
//			product.setProdQuantity(prodQuantity - purchase.getPurchaseQuantity());
//			productService.updateProduct(product);
//			
//			purchaseService.addPurchase(purchase);
//			
//		} else {
//		
//		}
	}
	
	//@Test
	public void testGetPurchase() throws Exception {
		
		purchase = purchaseService.getPurchase(10047);
		//==> console 확인
		//System.out.println(user);
		
		//==> API 확인
		Assert.assertEquals(10047, purchase.getTranNo());
		Assert.assertEquals(10048, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user06", purchase.getBuyer().getUserId());
		Assert.assertEquals("3", purchase.getTranCode());
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		 
		purchase = purchaseService.getPurchase(10047);
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(10047, purchase.getTranNo());
		Assert.assertEquals(10048, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user06", purchase.getBuyer().getUserId());
		
		purchaseService.updatePurchase(purchase);
		
		purchase = purchaseService.getPurchase(10047);
		Assert.assertNotNull(purchase);
		
		//==> console 확인
		//System.out.println(purchase);
			
		//==> API 확인
	 }
	 
	//@Test
	public void testUpdatePurchaseCode() throws Exception{
		 
		purchase = purchaseService.getPurchase(10047);
		Assert.assertNotNull(purchase);
		
		Assert.assertEquals(10047, purchase.getTranNo());
		Assert.assertEquals(10048, purchase.getPurchaseProd().getProdNo());
		Assert.assertEquals("user06", purchase.getBuyer().getUserId());
		
		System.out.println(purchase);
		
		purchaseService.updateTransCode(purchase);
		
		purchase = purchaseService.getPurchase(10047);
		Assert.assertNotNull(purchase);
		
		//==> console 확인
		//System.out.println(purchase);
		
		//==> API 확인
		Assert.assertEquals("4", purchase.getTranCode());
	}
		
	//==>  주석을 풀고 실행하면....
	@Test
	public void testGetPurchaseListAll() throws Exception{
		 
		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(5);
		
		Map<String, Object> map = new HashMap<String, Object>();
			 	
		map = purchaseService.getPurchaseList(search, "user06");
		
		List<Object> list = (List<Object>)map.get("list");
		Assert.assertEquals(5, list.size());
		
		//==> console 확인
		//System.out.println(list);
		
		Integer totalCount = (Integer)map.get("totalCount");
		System.out.println(totalCount);
		
		System.out.println("=======================================");
		
		search.setCurrentPage(1);
		search.setPageSize(3);
		search.setSearchCondition("0");
		search.setSearchKeyword("");
		map = purchaseService.getPurchaseList(search, "user06");
		
		list = (List<Object>)map.get("list");
		Assert.assertEquals(3, list.size());
		
		//==> console 확인
		System.out.println(list);
		
		totalCount = (Integer)map.get("totalCount");
		 	System.out.println(totalCount);
	 }

}