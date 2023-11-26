package com.book.bboard.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.book.bboard.dao.BBoardDao;
import com.book.bboard.vo.BBoardVo;
import com.book.book.vo.BookVo;

@Repository("bBoardDao")
public class BBoardDaoImpl implements BBoardDao {
	
	@Autowired
	private SqlSession sqlSession;

	//게시판 가져오기
	@Override
	public List<BBoardVo> boardList(HashMap<String, Object> map) {
		List<BBoardVo> list =  sqlSession.selectList("BBoard.boardList", map);
		System.out.println("list:"+list);
		return list;
	}

	//도서 검색
	@Override
	public List<BookVo> bookSearch(HashMap<String, Object> map) {
		List<BookVo> bookList = sqlSession.selectList("BBoard.bookSearch", map);
		//List<BookVo> bookList = map.get("result");
		System.out.println(bookList);
		return bookList;
	}

	//검색한 자료 수 가져오기
	@Override
	public int bookSearchResultCnt(String keyword) {
		HashMap <String,Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		int resultCnt = sqlSession.selectOne("BBoard.bookSearchResultCnt",map);
		System.out.println("검색 결과 자료수:"+resultCnt);
		return resultCnt;
	}

	//도서 등록
	@Override
	public void bookWrite(HashMap<String, Object> map) {
		System.out.println(map.get("book_image"));
		sqlSession.insert("BBoard.bookWrite",map);
		System.out.println("map:"+map);
		
		
	}

	//총 게시물 수 가져오기
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		int totalCount = sqlSession.selectOne("BBoard.boardCount", map);
		return totalCount;
	}

	//게시물 가져오기
	@Override
	public BBoardVo boardView(HashMap<String, Object> map) {
		BBoardVo board = sqlSession.selectOne("BBoard.boardView", map);
		 
		return board;
	}

	//추천수 증감
	@Override
	public int likeBoard(HashMap<String, Object> map) {
		sqlSession.insert("BBoard.likeBoard", map);
		System.out.println(map);
		int cnt = Integer.parseInt(String.valueOf(map.get("cnt")));
		return cnt;
	}

	//추천 여부 확인
	@Override
	public int likeStatus(HashMap<String, Object> map) {
		int likeStatus  = sqlSession.selectOne("BBoard.likeStatus", map);
		return likeStatus;
	}

	//게시물 수정
	@Override
	public void update(HashMap<String, Object> map) {
		sqlSession.update("BBoard.updateBoard", map);
		
	}
	
	//게시물 삭제
	@Override
	public void delete(HashMap<String, Object> map) {
		sqlSession.delete("BBoard.deleteBoard", map);
		
	}

	//좋아요 취소
	@Override
	public void boardLikeCancel(HashMap<String, Object> map) {
		sqlSession.delete("BBoard.likeCancel", map);
		
	}

	
	
}
