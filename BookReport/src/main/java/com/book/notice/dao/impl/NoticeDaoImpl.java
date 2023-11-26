package com.book.notice.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.book.notice.dao.NoticeDao;
import com.book.notice.vo.NoticeVo;

@Repository("NoticeDao")
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	//공지사항 목록
	@Override
	public List<NoticeVo> noticeList(HashMap<String, Object> map) {
		List<NoticeVo> list = sqlSession.selectList("Notice.noticeList", map);
		

		return list;
	}
	
	//공지개수 조회
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		int totalCount = sqlSession.selectOne("Notice.noticeCnt", map);
		return totalCount;
	}
	
	//공지사항 작성
	@Override
	public void noticeWrite(HashMap<String, Object> map) {
		sqlSession.insert("Notice.noticeWrite", map);
		
	}

	//공지사항 열람
	@Override
	public NoticeVo boardView(HashMap<String, Object> map) {
		NoticeVo vo = sqlSession.selectOne("Notice.noticeView", map);
		return vo;
	}

	//추천 여부 확인
	@Override
	public int likeStatus(HashMap<String, Object> map) {
		int cnt = sqlSession.selectOne("Notice.likeStatus", map);
		return cnt;
	}

	//추천수 증감
	@Override
	public int likeBoard(HashMap<String, Object> map) {
		sqlSession.insert("Notice.likeNotice", map);
		int cnt = Integer.parseInt(String.valueOf(map.get("cnt")));
		return cnt;
	}

	//공지사항 수정
	@Override
	public void update(HashMap<String, Object> map) {
		sqlSession.update("Notice.updateNotice", map);
		
	}

	//공지사항 삭제
	@Override
	public void delete(HashMap<String, Object> map) {
		sqlSession.delete("Notice.deleteNotice", map);
		
	}

	@Override
	public void likeCancel(HashMap<String, Object> map) {
		sqlSession.delete("Notice.likeCancel", map);
		
	}



}
