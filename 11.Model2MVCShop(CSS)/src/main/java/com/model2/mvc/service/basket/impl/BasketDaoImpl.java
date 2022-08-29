package com.model2.mvc.service.basket.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.basket.BasketDao;
import com.model2.mvc.service.domain.Basket;

@Repository("basketDaoImpl")
public class BasketDaoImpl implements BasketDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public BasketDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addBasket(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.insert("BasketMapper.addBasket", map);
	}
	
	public Basket getBasket(Map<String, Object> map) {		
		return sqlSession.selectOne("BasketMapper.getBasket", map);
	}

	@Override
	public List<Basket> getBasketList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("userId", userId);
		
		return sqlSession.selectList("BasketMapper.getBasketList", map);
	}

	// 미구현 좀 더 구조를 정하고 구현 예정
	@Override
	public void updateBasket(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub	
		sqlSession.update("BasketMapper.updateBasket", map);
	}
	
	@Override
	public void removeBasket(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("BasketMapper.removeBasket", map);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("BasketMapper.getTotalCount", search);
	}

}
