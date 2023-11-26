package com.book.fboard.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.book.fboard.dao.FBoardDao;
import com.book.fboard.vo.FBoardVo;

@Repository("fBoardDao")
public class FBoardDaoImpl implements FBoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	//자유게시판 불러오기
	@Override
	public List<FBoardVo> boardList(HashMap<String, Object> map) {
		List<FBoardVo> list = sqlSession.selectList("FBoard.boardList", map);
		return list;
	}

	//게시물 수 가져오기
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		int cnt = sqlSession.selectOne("FBoard.boardCount",map);
		return cnt;
	}

	//자유게시판 글쓰기
	@Override
	public void freeWrite(HashMap<String, Object> map) {
		sqlSession.insert("FBoard.fBoardWrite", map);
		
	}

	//추천 여부 확인
	@Override
	public int likeStatus(HashMap<String, Object> map) {
		int cnt = sqlSession.selectOne("FBoard.likeStatus", map);
		return cnt;
	}

	//게시물 가져오기
	@Override
	public FBoardVo boardView(HashMap<String, Object> map) {
		FBoardVo vo = sqlSession.selectOne("FBoard.boardView", map);
		return vo;
	}

	//추천수 증감
	@Override
	public int likeBoard(HashMap<String, Object> map) {
		sqlSession.insert("FBoard.likeBoard", map);
		System.out.println(map);
		int cnt = Integer.parseInt(String.valueOf(map.get("cnt")));
		return cnt;
	}

	//게시물 수정
	@Override
	public void update(HashMap<String, Object> map) {
		sqlSession.update("FBoard.updateFBoard", map);
		
	}
	
	//게시물 삭제
	@Override
	public void delete(HashMap<String, Object> map) {
		sqlSession.delete("FBoard.deleteBoard", map);
	}

	//내 정보 - 좋아요 취소
	@Override
	public void boardLikeCancel(HashMap<String, Object> map) {
		sqlSession.delete("FBoard.likeCancel", map);
		
	}

	
	
	
	
	
	
}
