package com.model2.mvc.service.board;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Board;

public interface BoardDao {
	
	public List<Board> getBoardList(Map<String, Object> map) throws Exception;

	public int getTotalCount(Search search) throws Exception;

	public void addBoard(Map<String, Object> map) throws Exception;

	public Board getBoard(Map<String, Object> map) throws Exception;

	public void updateBoard(Board board) throws Exception;

	public void deleteBoard(int boardNo);

}
