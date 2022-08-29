package com.model2.mvc.service.reply.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.reply.ReplyDao;
import com.model2.mvc.service.reply.ReplyService;

@Service("replyServiceImpl")
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	@Qualifier("replyDaoImpl")
	ReplyDao replyDao;
	
	public ReplyServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		replyDao.addReply(map);
	}

}
