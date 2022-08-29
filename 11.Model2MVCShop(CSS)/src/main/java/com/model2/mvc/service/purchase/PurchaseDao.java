package com.model2.mvc.service.purchase;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

public interface PurchaseDao {

	public void addPurchase(Map<String, Object> map) throws Exception;

	public Purchase getPurchase(int tranNo) throws Exception;

	public List<Purchase> getPurchaseList(Search search, String userId) throws Exception;

	public void updatePurchase(Purchase purchase) throws Exception;

	public void updateTransCode(Purchase purchase) throws Exception;
	
	public int getTotalCount(String userId) throws Exception;

	public int getOrderNo() throws Exception;
	
	public List<Purchase> getPurchaseByOrder(int orderNo) throws Exception;
}
