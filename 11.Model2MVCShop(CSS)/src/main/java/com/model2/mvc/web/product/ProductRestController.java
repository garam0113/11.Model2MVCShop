package com.model2.mvc.web.product;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	public ProductRestController() {
		// TODO Auto-generated constructor stub
		
		System.out.println(":: ProductRestController default Constructor");
		
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@Value("#{commonProperties['pageUnit'] ? : 3}")
	// 없다면 ? 3으로 초기화
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@RequestMapping(value = "/json/addProduct/{value}", method = RequestMethod.POST)
	public Product addProduct(@RequestBody Product product, @PathVariable MultipartFile[] file) throws Exception {
		
		System.out.println("/product/json/addProduct : POST");
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		StringBuilder sb = new StringBuilder();
		
		int fileCount = 0;
		// 최대 3개 까지 입력 가능
		for(MultipartFile files : file) {
			fileCount++;
			System.out.println("파일 이름 : " + files.getOriginalFilename());
			sb.append(files.getOriginalFilename());
			
			if(fileCount != file.length) {
				sb.append("*");
			}
			
			String path = "C:\\Users\\bitcamp\\git\\00.Model2MVCShop\\00.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
			File saveFile = new File(path + files.getOriginalFilename());
			
			files.transferTo(saveFile);
		}
		
		System.out.println("DB에 저장될 파일 이름 : " + sb.toString());
		
		product.setFileName(sb.toString());
		productService.addProduct(product);
		
		return product;
		
	}
	
	@RequestMapping(value = "/json/listProduct", method = RequestMethod.POST)
	public Map<String, Object> listProduct(@RequestBody Search search) throws Exception {
		
		System.out.println("/product/json/listProduct : POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		
		System.out.println("/product/json/listProduct : POST");
		
		return map;
		
	}
	
	@RequestMapping(value = "/json/getProduct/{prodNo}", method = RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception {
		
		System.out.println("/product/json/getProduct : GET");
		
		System.out.println("/product/json/getProduct : GET");
		
		return productService.getProduct(prodNo);
		
	}
	
	@RequestMapping(value = "/json/updateProduct/{prodNo}", method = RequestMethod.GET)
	public Product updateProduct(@PathVariable int prodNo) throws Exception {
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping(value = "/json/updateProduct/{value}", method = RequestMethod.POST)
	public Product updateProduct(@RequestBody Product product, @PathVariable MultipartFile[] file) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Product> list = new ArrayList<Product>();
		
		StringBuilder sb = new StringBuilder();

		int fileCount = 0;
		
		for(MultipartFile files : file) {
			fileCount++;
			System.out.println("파일 이름 : " + files.getOriginalFilename());
			sb.append(files.getOriginalFilename());
			
			if(fileCount != file.length) {
				sb.append("*");
			}
			
			String path = "C:\\Users\\H2\\git\\00.Model2MVCShop\\00.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
			File saveFile = new File(path + files.getOriginalFilename());
			
			files.transferTo(saveFile);
		}
		sb.append("*" + product.getFileName());
		product.setFileName(sb.toString());
		
		list.add(product);
		
		map.put("product", list);
		productService.updateProduct(map);
		
		System.out.println("업데이트 후의 product " + product);
		
		product = productService.getProduct(product.getProdNo());
				
		return product;
	}
	
	@RequestMapping(value = "/json/productAutoComplete", method = RequestMethod.POST)
	public List<Product> productAutoComplete(@RequestBody Search search) throws Exception {
		
		System.out.println("오토 컴플릿 : " + search.getSearchKeyword() + " " + search.getSearchCondition());
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map = productService.getProductList(search);
		
		return (List<Product>) map.get("list");
	}
}