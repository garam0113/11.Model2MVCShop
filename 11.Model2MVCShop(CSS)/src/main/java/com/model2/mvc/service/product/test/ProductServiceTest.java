package com.model2.mvc.service.product.test;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
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
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
//@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
//		"classpath:config/context-aspect.xml",
//		"classpath:config/context-mybatis.xml",
//		"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

	@Test
	public void testAddProduct() throws Exception {
		
		System.out.println("\n[AddProductAction execute start]\n");
		
		Product product = new Product();
		Date date = new Date();
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		String formatDate = simpleDateFormat.format(date);
		java.sql.Date sqlDate = java.sql.Date.valueOf(formatDate);
		
		product.setProdName("녹돈 버거");
		product.setProdDetail("녹차먹은 돼지");
		product.setManuDate("20220729");
		product.setPrice(6800);
		product.setFileName("why");
		product.setProdQuantity(10);
		
		productService.addProduct(product);
		
		System.out.println("\n[AddProductAction execute end]\n");
		
		product = productService.getProduct(10056);
		
		//==> API 확인
		Assert.assertEquals(10056, product.getProdNo());
		Assert.assertEquals("녹돈 버거", product.getProdName());
		Assert.assertEquals("녹차먹은 돼지", product.getProdDetail());
		Assert.assertEquals("20220729", product.getManuDate());
		Assert.assertEquals(6800, product.getPrice());
		Assert.assertEquals("why", product.getFileName());
		Assert.assertEquals(10, product.getProdQuantity());
	}
	
	 //==>  주석을 풀고 실행하면....
	 //@Test
	 public void testGetProductListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setOrder(0);
	 	
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());

	 }
	 
	 //@Test
	 public void testGetProductListByProductPrice() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(5);
//	 	search.setMinPrice(10000);
//	 	search.setMaxPrice(100000);
	 	
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 }

}