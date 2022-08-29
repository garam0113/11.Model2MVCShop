package com.model2.mvc.service.board.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.board.BoardDao;
import com.model2.mvc.service.domain.Board;

@Repository("boardDaoImpl")
public class BoardDaoImpl implements BoardDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public BoardDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	public List<Board> getBoardList(Map<String, Object> map) throws Exception {
		
		return sqlSession.selectList("BoardMapper.getBoardList", map);
	}
	
	public int getTotalCount(Search search) throws Exception {
		
		return sqlSession.selectOne("BoardMapper.getTotalCount", search);
	}

	@Override
	public void addBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("BoardMapper.addBoard", map);
	}

	@Override
	public Board getBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("BoardMapper.getBoard", map);
	}

	@Override
	public void updateBoard(Board board) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.selectOne("BoardMapper.updateBoard", board);
	}

	@Override
	public void deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		sqlSession.selectOne("BoardMapper.deleteBoard", boardNo);
	}

}
