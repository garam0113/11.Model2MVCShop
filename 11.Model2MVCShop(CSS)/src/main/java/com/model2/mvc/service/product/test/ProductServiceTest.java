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
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
//@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
//		"classpath:config/context-aspect.xml",
//		"classpath:config/context-mybatis.xml",
//		"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
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
		
		product.setProdName("�쵷 ����");
		product.setProdDetail("�������� ����");
		product.setManuDate("20220729");
		product.setPrice(6800);
		product.setFileName("why");
		product.setProdQuantity(10);
		
		productService.addProduct(product);
		
		System.out.println("\n[AddProductAction execute end]\n");
		
		product = productService.getProduct(10056);
		
		//==> API Ȯ��
		Assert.assertEquals(10056, product.getProdNo());
		Assert.assertEquals("�쵷 ����", product.getProdName());
		Assert.assertEquals("�������� ����", product.getProdDetail());
		Assert.assertEquals("20220729", product.getManuDate());
		Assert.assertEquals(6800, product.getPrice());
		Assert.assertEquals("why", product.getFileName());
		Assert.assertEquals(10, product.getProdQuantity());
	}
	
	 //==>  �ּ��� Ǯ�� �����ϸ�....
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