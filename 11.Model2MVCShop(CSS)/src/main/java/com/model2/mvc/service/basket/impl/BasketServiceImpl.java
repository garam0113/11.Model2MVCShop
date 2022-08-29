package com.model2.mvc.service.basket.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketDao;
import com.model2.mvc.service.basket.BasketService;
import com.model2.mvc.service.domain.Basket;

@Service("basketServiceImpl")
public class BasketServiceImpl implements BasketService {

	@Autowired
	@Qualifier("basketDaoImpl")
	private BasketDao basketDao;
	
	public void setBasketDao(BasketDao basketDao) {
		this.basketDao = basketDao;
	}
	
	public BasketServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addBasket(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[BasketServiceImpl addBasket start]\n");
		
		basketDao.addBasket(map);
				
		System.out.println("\n[BasketServiceImpl addBasket end]\n");

	}
	
	public Basket getBasket(Map<String, Object> map) throws Exception {
		return basketDao.getBasket(map);
	}

	@Override
	public Map<String, Object> getBasketList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[BasketServiceImpl getBasketList start]\n");
		
		List<Basket> list = basketDao.getBasketList(search, userId);
		int totalCount = basketDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		System.out.println("\n[BasketServiceImpl getBasketList end]\n");
		
		return map;
	}

	@Override
	public void removeBasket(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("\n[BasketServiceImpl removeBasket start]\n");
		
		basketDao.removeBasket(map);
		
		System.out.println("\n[BasketServiceImpl removeBasket end]\n");
	}

	@Override
	public void updateBasket(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[BasketServiceImpl updateBasket start]\n");
		
		basketDao.updateBasket(map);
		
		System.out.println("\n[BasketServiceImpl updateBasket end]\n");
		
	}

}
