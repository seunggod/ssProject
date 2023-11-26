package com.book.fboard.dao;

import java.util.HashMap;
import java.util.List;

import com.book.fboard.vo.FBoardVo;

public interface FBoardDao {
	//자유게시판 불러오기
	List<FBoardVo> boardList(HashMap<String, Object> map);
	//게시물 수 가져오기
	int getBoardCount(HashMap<String, Object> map);
	//자유게시판 글쓰기
	void freeWrite(HashMap<String, Object> map);
	//추천 여부 확인
	int likeStatus(HashMap<String, Object> map);
	//게시물 가져오기
	FBoardVo boardView(HashMap<String, Object> map);
	//추천수 증감
	int likeBoard(HashMap<String, Object> map);
	//게시물 수정
	void update(HashMap<String, Object> map);
	//게시물 삭제
	void delete(HashMap<String, Object> map);
	//내 정보 - 좋아요 취소
	void boardLikeCancel(HashMap<String, Object> map);

}
