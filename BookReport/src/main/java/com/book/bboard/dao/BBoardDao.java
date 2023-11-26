package com.book.bboard.dao;

import java.util.HashMap;
import java.util.List;

import com.book.bboard.vo.BBoardVo;
import com.book.book.vo.BookVo;

public interface BBoardDao {

	//게시판 가져오기
	List<BBoardVo> boardList(HashMap<String, Object> map);
    //도서 검색
	List<BookVo> bookSearch(HashMap<String, Object> map);
	//도서 검색 자료 수 가져오기
	int bookSearchResultCnt(String keyword);
	//도서 등록
	void bookWrite(HashMap<String, Object> map);
	//총 게시물 수 가져오기
	int getBoardCount(HashMap<String, Object> map);
	//게시물 가져오기
	BBoardVo boardView(HashMap<String, Object> map);
	//추천수 증감
	int likeBoard(HashMap<String, Object> map);
	//추천 여부 확인
	int likeStatus(HashMap<String, Object> map);
	//게시물 수정
	void update(HashMap<String, Object> map);
	//게시물 삭제
	void delete(HashMap<String, Object> map);
	//좋아요 취소
	void boardLikeCancel(HashMap<String, Object> map);

}
