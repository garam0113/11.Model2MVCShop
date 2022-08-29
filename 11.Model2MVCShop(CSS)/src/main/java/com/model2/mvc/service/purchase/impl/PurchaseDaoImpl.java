package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PurchaseDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPurchase(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		List<Purchase> list = (List<Purchase>)map.get("list");
		
		for(int i = 0 ; i < list.size() ; i++) {
			sqlSession.insert("PurchaseMapper.addPurchase", list.get(i));
		}	
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}

	@Override
	public List<Purchase> getPurchaseList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("userId", userId);
		
		return sqlSession.selectList("PurchaseMapper.getOrderList", map);

	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	@Override
	public void updateTransCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateTransCode", purchase);
	}

	@Override
	public int getTotalCount(String userId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("userId : " + userId);
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", userId);
	}

	@Override
	public int getOrderNo() throws Exception{
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PurchaseMapper.getOrderNo");
	}

	@Override
	public List<Purchase> getPurchaseByOrder(int orderNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PurchaseMapper.getPurchaseByOrder", orderNo);
	}

}
