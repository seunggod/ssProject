package com.book.reply.dao;

import java.util.HashMap;
import java.util.List;

import com.book.reply.vo.ReplyVo;

public interface ReplyDao {

	//댓글 목록 가져오기
	List<ReplyVo> replyList(HashMap<String, Object> map);
	//댓글 작성
	void replyWrite(HashMap<String, Object> map);
	//댓글 수 가져오기
	int replycount(HashMap<String, Object> map);
	//댓글 수정
	void replyUpdate(HashMap<String, Object> map);
	//댓글 삭제
	void replyDelete(HashMap<String, Object> map);
	//댓글 좋아요
	int replyLike(HashMap<String, Object> map);

}
