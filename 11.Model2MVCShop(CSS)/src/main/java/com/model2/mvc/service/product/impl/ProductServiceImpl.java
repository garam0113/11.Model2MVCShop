package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDao productDao;
	
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public ProductServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("ProductServiceImpl default Constructor");
	}

	@Override
	public void addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ProductServiceImpl insertProduct start]\n");
		System.out.println("���δ�Ʈ�� ? " + product);
		
		productDao.addProduct(product);
		
		System.out.println("\n[ProductServiceImpl insertProduct end]\n");
		
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ProductServiceImpl findProduct start]\n");
		
		Product product= productDao.getProduct(prodNo);
		
		System.out.println("\n[ProductServiceImpl findProduct end]\n");
		
		return product;
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ProductServiceImpl getProductList start]\n");
		
		List<Product> list = productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		System.out.println("\n[ProductServiceImpl getProductList end]\n");
		
		return map;
	}

	@Override
	public void updateProduct(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[ProductServiceImpl updateProduct start]\n");
		
		List<Product> list = (List<Product>)map.get("product");
		
		for(int i = 0 ; i < list.size(); i++) {
			productDao.updateProduct(list.get(i));
		}
		
		System.out.println("\n[ProductServiceImpl updateProduct end]\n");
		
	}

	@Override
	public void removeFileProduct() {
		// TODO Auto-generated method stub
		productDao.removeFileProduct();
	}
	
}
