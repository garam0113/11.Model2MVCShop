package com.model2.mvc.service.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.board.BoardDao;
import com.model2.mvc.service.board.BoardService;
import com.model2.mvc.service.domain.Board;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService {

	@Autowired
	@Qualifier("boardDaoImpl")
	private BoardDao boardDao;
	
	public BoardServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Map<String, Object> listBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		List<Board> list = boardDao.getBoardList(map);
		int totalCount = boardDao.getTotalCount((Search)map.get("search"));
		
		returnMap.put("list", list);
		returnMap.put("totalCount", totalCount);
		
		return returnMap;
	}

	@Override
	public void addBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		boardDao.addBoard(map);
	}

	@Override
	public Board getBoard(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("boardNo", boardNo);
		
		return boardDao.getBoard(map);
	}

	@Override
	public void updateBoard(Board board) throws Exception {
		// TODO Auto-generated method stub
		boardDao.updateBoard(board);
	}

	@Override
	public void deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		boardDao.deleteBoard(boardNo);
	}

}
