package com.model2.mvc.service.basket;

import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Basket;
import com.model2.mvc.service.domain.Product;

public interface BasketService {
	
	public void addBasket(Map<String, Object> map) throws Exception;
	
	public Basket getBasket(Map<String, Object> map) throws Exception;
	
	public Map<String, Object> getBasketList(Search search, String userId) throws Exception;
	
	public void removeBasket(Map<String, Object> map) throws Exception;
	
	public void updateBasket(Map<String, Object> map) throws Exception;
	
}