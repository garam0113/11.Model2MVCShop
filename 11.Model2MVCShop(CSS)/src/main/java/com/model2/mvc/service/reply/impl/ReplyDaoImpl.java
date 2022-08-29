package com.model2.mvc.service.reply.impl;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.reply.ReplyDao;

@Repository("replyDaoImpl")
public class ReplyDaoImpl implements ReplyDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public ReplyDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.insert("ReplyMapper.addReply", map);
	}

}
