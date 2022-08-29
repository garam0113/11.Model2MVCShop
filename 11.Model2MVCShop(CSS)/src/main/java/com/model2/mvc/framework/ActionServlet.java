package com.model2.mvc.framework;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;

import com.model2.mvc.common.util.HttpUtil;

//0 : �Ǹ���
//1 : ���ſϷ�
//2 : �����
//3 : ��ۿϷ�

public class ActionServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private RequestMapping mapper;

	@Override
	public void init() throws ServletException {
		super.init();
		String resources = getServletConfig().getInitParameter("resources");
		mapper = RequestMapping.getInstance(resources);
		
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) 
																									throws ServletException, IOException {
		
		String url = request.getRequestURI();
		String contextPath = request.getContextPath();
		String path = url.substring(contextPath.length());
		
		System.out.println("\nActionServlet url : " + url);
		System.out.println("ActionServlet contextPath : " + contextPath);
		System.out.println(path);
		
		try{
			Action action = mapper.getAction(path);
			System.out.println("getServletContext() : " + getServletContext());
			action.setServletContext(getServletContext());
			
			String resultPage = action.execute(request, response);
			String result = resultPage.substring(resultPage.indexOf(":")+1);
			
			if(resultPage.startsWith("forward:"))
				HttpUtil.forward(request, response, result);
			else
				HttpUtil.redirect(response, result);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
}