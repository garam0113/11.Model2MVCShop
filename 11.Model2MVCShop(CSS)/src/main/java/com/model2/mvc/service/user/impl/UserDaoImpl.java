package com.model2.mvc.service.user.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserDao;

@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public UserDaoImpl() {
		// TODO Auto-generated constructor stub
		super();
		
		System.out.println("UserDaoImpl default Constructor");
	}
	
	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("UserMapper.addUser", user);
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}

	@Override
	public List<User> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.updateUser", user);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

}
