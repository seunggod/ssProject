package com.book.reply.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.book.reply.dao.ReplyDao;
import com.book.reply.vo.ReplyVo;

@Repository("replyDao")
public class ReplyDaoImpl implements ReplyDao {

	@Autowired
	private SqlSession sqlSession;
	
	//댓글 목록 가져오기
	@Override
	public List<ReplyVo> replyList(HashMap<String, Object> map) {
		
		List<ReplyVo> reList = null;
		//게시판 종류에 따라 다른 sql문 사용
		String board_num = (String) map.get("board_num");
		String free_num = (String) map.get("free_num");
		String notice_num = (String) map.get("notice_num");
		if(board_num!=null)
			reList = sqlSession.selectList("Reply.ReplyList", map);
		if(free_num!=null)
			reList = sqlSession.selectList("Reply.FreeReplyList", map);
		if(notice_num!=null)
			reList = sqlSession.selectList("Reply.NoticeReplyList", map);
		return reList;
	}

	//댓글 작성
	@Override
	public void replyWrite(HashMap<String, Object> map) {
		String sort = (String) map.get("sort");
		if(sort.equals("board"))
			sqlSession.insert("Reply.ReplyWrite", map);
		if(sort.equals("fboard"))
			sqlSession.insert("Reply.FreeReplyWrite", map);
		if(sort.equals("notice"))
			sqlSession.insert("Reply.NoticeReplyWrite", map);
			
		
		
	}

	//댓글 수 가져오기
	@Override
	public int replycount(HashMap<String, Object> map) {
		int cnt = sqlSession.selectOne("Reply.Replycount", map);
		return cnt;
	}

	//댓글 수정
	@Override
	public void replyUpdate(HashMap<String, Object> map) {
		sqlSession.update("Reply.ReplyUpdate", map);
		
	}
	
	//댓글 삭제
	@Override
	public void replyDelete(HashMap<String, Object> map) {
		String sort = (String) map.get("sort");
		
		if(sort.equals("board"))
			sqlSession.delete("Reply.ReplyDelete", map);
		if(sort.equals("fboard"))
			sqlSession.delete("Reply.FreeReplyDelete", map);
		if(sort.equals("notice"))
			sqlSession.delete("Reply.NoticeReplyDelete", map);
		

	}

	//댓글 좋아요
	@Override
	public int replyLike(HashMap<String, Object> map) {
		String sort = (String) map.get("sort");
		if(sort.equals("board"))
			sqlSession.insert("Reply.ReplyLike",map);
		if(sort.equals("fboard"))
			sqlSession.insert("Reply.FreeReplyLike",map);
		if(sort.equals("notice"))
			sqlSession.insert("Reply.NoticeReplyLike",map);
		int cnt = Integer.parseInt(String.valueOf(map.get("cnt")));
		return cnt;
	}


}
