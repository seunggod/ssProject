package com.book.notice.dao;

import java.util.HashMap;
import java.util.List;

import com.book.notice.vo.NoticeVo;

public interface NoticeDao {

	//공지사항 목록
	List<NoticeVo> noticeList(HashMap<String, Object> map);
	//공지 개수 조회
	int getBoardCount(HashMap<String, Object> map);
	//공지사항 작성
	void noticeWrite(HashMap<String, Object> map);
	//공지사항 열람
	NoticeVo boardView(HashMap<String, Object> map);
	//추천 여부 확인
	int likeStatus(HashMap<String, Object> map);
	//추천수 증감
	int likeBoard(HashMap<String, Object> map);
	//공지사항 수정
	void update(HashMap<String, Object> map);
	//공지사항 삭제
	void delete(HashMap<String, Object> map);
	//좋아요 취소
	void likeCancel(HashMap<String, Object> map);


}
