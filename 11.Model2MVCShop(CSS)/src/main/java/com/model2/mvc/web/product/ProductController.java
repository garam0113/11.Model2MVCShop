package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


@Controller
@SessionAttributes("user")
@RequestMapping("/product/*")
public class ProductController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
		
	public ProductController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}
		
	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;

	@Value("#{commonProperties['pageUnit'] ?: 10}")
	int pageUnit;
	
//	@RequestMapping("/addProduct.do")
//	, consumes = {MediaType.MULTIPART_FORM_DATA_VALUE}
	@RequestMapping(value = "addProduct", method = RequestMethod.POST)
	public String addProduct(@ModelAttribute Product product, @RequestParam("image") MultipartFile[] file, Model model) throws Exception {
		
		System.out.println("/product/addProduct : POST");
		
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
			
			String path = "C:\\Users\\bitcamp\\git\\09.Model2MVCShop\\09.Model2MVCShop(jQuery_s)\\src\\main\\webapp\\images\\uploadFiles\\";
			File saveFile = new File(path + files.getOriginalFilename());
			
			boolean isExists = saveFile.exists();
			
			if(!isExists) {
				files.transferTo(saveFile);
			}
		}
		
		System.out.println("DB에 저장될 파일 이름 : " + sb.toString());
		
		product.setFileName(sb.toString());
		
		productService.addProduct(product);
		model.addAttribute("product", product);
		
		return "forward:/product/addProduct.jsp";
	}
	
//	@RequestMapping("/addProduct.do")
	@RequestMapping(value = "addProduct_")
	public String addProduct(HttpServletRequest request) throws Exception {
		System.out.println("/product/addProduct : GET & POST");
		
		if(FileUpload.isMultipartContent(request)) {
			String temDir = "C:\\Users\\bitcamp\\git\\00.Model2MVCShop\\00.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			
			fileUpload.setRepositoryPath(temDir);
			
			// 100MB
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				Product product = new Product();
				
				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				System.out.println(fileItemList);
				int size = fileItemList.size();
				
				System.out.println("사이즈 : " + size);
				
				for(int i = 0 ; i < size ; i++) {
					FileItem fileItem = (FileItem) fileItemList.get(i);
					
					if(fileItem.isFormField()) {
						
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"), "-");
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							product.setManuDate(manuDate);
						} 
						else if(fileItem.getFieldName().equals("prodName"))
							product.setProdName(fileItem.getString("euc-kr"));
						else if(fileItem.getFieldName().equals("prodDetail"))
							product.setProdDetail(fileItem.getString("euc-kr"));
						else if(fileItem.getFieldName().equals("price"))
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						else if(fileItem.getFieldName().equals("prodQuantity"))
							product.setProdQuantity(Integer.parseInt(fileItem.getString("euc-kr")));
					} else {
						if(fileItem.getSize() > 0) {
							int index = fileItem.getName().lastIndexOf("\\");
							if(index == -1) {
								index = fileItem.getName().lastIndexOf("\\");
							}
							
							String fileName = fileItem.getName().substring(index + 1);
							
							product.setFileName(fileName);
							
							try {
								File uploadedFile = new File(temDir, fileName);
								fileItem.write(uploadedFile);
							} catch (IOException e) {
								System.out.println(e);
							}
						} else {
							product.setFileName("../../images/empty.GIF");
						}
					} 
				} // for
				
				productService.addProduct(product);
				
				request.setAttribute("product", product);
				
			} else {
				int overSize = (request.getContentLength() / 1000000);
				
				System.out.println("<script>alert('파일의 크기는 1MB까지인데 올리신 파일은 " + overSize + "MB입니다.');");
				System.out.println("history.back();</script>");
			}
		} else {
			System.out.println("인코딩 타입 multipart/form-data 아님");
		}
		
		return "/product/listProduct";
	}
		
	//@RequestMapping("/getProduct.do")
	@RequestMapping(value = "getProduct")
	public String getProduct(@ModelAttribute Product product, @RequestParam(value = "menu", defaultValue = "search") String menu, 
								@CookieValue(name = "history", defaultValue = "") String history, Model model, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET & POST");
		
		product = productService.getProduct(product.getProdNo());
		
		System.out.println("쿠키 값 이전 : " + history);
		
		if(!history.equals("")) {
			history = URLDecoder.decode(history, "EUC-KR") + "," + Integer.toString(product.getProdNo());
		} else {
			history = Integer.toString(product.getProdNo());
		}
		
		Cookie cookie = new Cookie("history", URLEncoder.encode(history, "EUC-KR"));

		response.addCookie(cookie);
		
		String URI = null;
		
		System.out.println("쿠키 값 이후 : " + history);
		
		model.addAttribute("product", product);
		model.addAttribute("menu", menu);
		model.addAttribute("history", history);
		
		if(menu.equals("manage")) {
			URI = "forward:/product/updateProduct";
		} else if (menu.equals("search")) {
			URI = "forward:/product/getProduct.jsp";
		}
		
		return URI;
	}
	

	//@RequestMapping("/updateProductView.do")
	@RequestMapping(value = "updateProduct", method = RequestMethod.GET)
	public String updateProduct(@ModelAttribute Product product, Model model) throws Exception {
		
		System.out.println("/product/updateProduct : GET");
		
		product = productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}

	//@RequestMapping("/updateProduct.do")
	@RequestMapping(value = "updateProduct", method = RequestMethod.POST)
	public String updateProduct(@ModelAttribute Product product, Model model,
								@RequestParam("image") MultipartFile[] file) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Product> list = new ArrayList<Product>();
		
		StringBuilder sb = new StringBuilder();

		int fileCount = 0;
		
		for(MultipartFile files : file) {
			
			if(!files.getOriginalFilename().equals("")) {
				fileCount++;
				System.out.println("파일 이름 : " + files.getOriginalFilename());
				sb.append(files.getOriginalFilename());
				
				if(fileCount != file.length) {
					sb.append("*");
				}
				
				String path = "C:\\Users\\bitcamp\\git\\10.Model2MVCShop\\10.Model2MVCShop(AjaxForStudy)\\src\\main\\webapp\\images\\uploadFiles\\";
	//			String path = "C:\\Users\\H2\\git\\00.Model2MVCShop\\00.Model2MVCShop\\src\\main\\webapp\\images\\uploadFiles\\";
				File saveFile = new File(path + files.getOriginalFilename());
				
				boolean isExists = saveFile.exists();
				
				if(!isExists) {
					files.transferTo(saveFile);
				}
			}
		}
		sb.append("*" + product.getFileName());
		
		if(sb.charAt(0) == '*') {
			sb.deleteCharAt(0);
		}
		product.setFileName(sb.toString());
		
		list.add(product);
		
		map.put("product", list);
		productService.updateProduct(map);
		
		System.out.println("업데이트 후의 product " + product);
		
		product = productService.getProduct(product.getProdNo());
		
		model.addAttribute("product", product);
		
		return "forward:/product/getProduct.jsp";
	}
	
	//@RequestMapping("/listProduct.do")
	@RequestMapping(value = "listProduct")
	public String listProduct(@ModelAttribute("search") Search search, @RequestParam(value = "menu", defaultValue = "search") String menu, 
								Model model) throws Exception {
		
		System.out.println("/product/listProduct : GET & POST");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		System.out.println("서치 : " + search);
		Map<String, Object> map = productService.getProductList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", menu);
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value = "removeFileProduct", method = RequestMethod.GET)
	public String removeFileProduct(@ModelAttribute Product product, @RequestParam("fileName") String fileName,
									@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		product = productService.getProduct(prodNo);
		
		int length = product.getFileName().length();
		
		if(product.getFileName().contains(fileName)) {
			
			// 파일이 제일 처음 위치 했을 경우
			if(product.getFileName().indexOf(fileName) == 0) {
				product.setFileName(product.getFileName().replaceAll(fileName, ""));
				System.out.println("잘라낸 파일 이름 : " + product.getFileName());
			} else if (product.getFileName().indexOf(fileName) + fileName.length() == length) {
				
			// 파일이 제일 마지막 위치 했을 경우				
				product.setFileName(product.getFileName().replaceAll(fileName, ""));
				product.setFileName(product.getFileName().substring(0, product.getFileName().length()-1));
				
				System.out.println("잘라낸 파일 이름 : " + product.getFileName());
					
			} else {
			// 파일이 중간에 위치 했을 경우
				
				product.setFileName(product.getFileName().replaceAll(fileName+"[*]", ""));
				System.out.println("잘라낸 파일 이름 : " + product.getFileName());
			}
			
		}else {
			
			System.out.println("없는 이유가 있나");
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<Product> list = new ArrayList<Product>();
		
		list.add(product);
		map.put("product", list);
		
		productService.updateProduct(map);
		
		model.addAttribute(product);
		
		return "/product/getProduct.jsp";
	}
}
