package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	@Autowired
	@Qualifier("purchaseDaoImpl")
	private PurchaseDao purchaseDao;
	
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}

	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("PurchaseServiceImple default Constructor");
	}

	@Override
	public void addPurchase(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[PurchaseServiceImpl addPurchase start]\n");
		
		purchaseDao.addPurchase(map);
		
		System.out.println("\n[PurchaseServiceImpl addPurchase end]\n");
		
	}
	
	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[PurchaseServiceImpl getPurchase start]\n");
		
		Purchase purchase = purchaseDao.getPurchase(tranNo);
		
		System.out.println("\n[PurchaseServiceImpl getPurchase end]\n");
		
		return purchase;
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[PurchaseServiceImpl getPurchaseList start]\n");
		
		List<Purchase> list = purchaseDao.getPurchaseList(search, userId);
		int totalCount = purchaseDao.getTotalCount(userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		System.out.println("\n[PurchaseServiceImpl getPurchaseList end]\n");
		
		return map;
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[PurchaseServiceImpl updatePurchase start]\n");
		
		purchaseDao.updatePurchase(purchase);
		
		System.out.println("\n[PurchaseServiceImpl updatePurchase end]\n");
		
	}

	@Override
	public void updateTransCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[PurchaseServiceImpl updateTransCode start]\n");
		
		purchaseDao.updateTransCode(purchase);
		
		System.out.println("\n[PurchaseServiceImpl updateTransCode end]\n");

	}

	@Override
	public int getOrderNo() throws Exception {
		// TODO Auto-generated method stub
		
		System.out.println("\n[PurchaseServiceImpl getOrderNo start]\n");
			
		System.out.println("\n[PurchaseServiceImpl getOrderNo end]\n");
		
		return purchaseDao.getOrderNo();
	}

	@Override
	public List<Purchase> getPurchaseByOrder(int orderNo) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.getPurchaseByOrder(orderNo);
	}

}
