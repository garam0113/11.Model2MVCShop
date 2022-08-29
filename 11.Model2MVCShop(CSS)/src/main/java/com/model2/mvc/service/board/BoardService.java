package com.model2.mvc.service.board;

import java.util.Map;

import com.model2.mvc.service.domain.Board;

public interface BoardService {

	public Map<String, Object> listBoard(Map<String, Object> map) throws Exception;

	public void addBoard(Map<String, Object> map) throws Exception;

	public Board getBoard(int boardNo) throws Exception;

	public void updateBoard(Board board) throws Exception;

	public void deleteBoard(int boardNo);
	
}
