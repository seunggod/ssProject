package com.book.reply.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.bboard.vo.BBoardVo;
import com.book.reply.dao.ReplyDao;
import com.book.reply.service.ReplyService;
import com.book.reply.vo.ReplyVo;

@Service("replyService")
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDao replyDao;
	
	//댓글 목록 가져오기
	@Override
	public List<ReplyVo> replyList(HashMap<String, Object> map) {
		List<ReplyVo> reList = replyDao.replyList(map);
		//작성일 처리
		int i = 0;
				
		Calendar today = Calendar.getInstance();
		int year       = today.get(Calendar.YEAR);
		int month      = today.get(Calendar.MONTH)+1;
		int day        = today.get(Calendar.DATE);
		String sToday  = String.format("%02d-%02d", month,day);
		System.out.println("today:"+year +"-"+ sToday);
		for (ReplyVo replyVo: reList) {
			i++;
			String date = replyVo.getReply_date();
			System.out.println("date"+i+":"+date);
			date = date.substring(0,16);
			int bYear = Integer.parseInt(date.substring(0, 4));
			String bMonth = date.substring(5, 10);
			System.out.println(bMonth);
			//같은 해에 작성된 경우 연도를 생략한다
			if(year == bYear)
				date = date.substring(5);
				//오늘 작성된 경우 날짜를 생략한다. 아니라면 시간을 생략한다
				if(bMonth.equals(sToday))
				date = date.substring(6);
			else {
				if(year == bYear) {
					date = date.substring(0, 6);
				} else {
					date = date.substring(0, 10);
				}
			}
			//vo에 처리된 작성일 값을 저장
			System.out.println(date);
			replyVo.setReply_date(date);
			}
		
		
		return reList;
	}

	
	//댓글 작성
	@Override
	public void replyWrite(HashMap<String, Object> map) {
		replyDao.replyWrite(map);
		
	}

	//댓글 수 가져오기
	@Override
	public int replycount(HashMap<String, Object> map) {
		int cnt = replyDao.replycount(map);
		return cnt;
	}

	//댓글 수정
	@Override
	public void replyUpdate(HashMap<String, Object> map) {
		replyDao.replyUpdate(map);
		
	}
	
	//댓글 삭제
	@Override
	public void replyDelete(HashMap<String, Object> map) {
		replyDao.replyDelete(map);
		
	}

	//댓글 좋아요
	@Override
	public int replyLike(HashMap<String, Object> map) {
		int cnt = replyDao.replyLike(map);
		return cnt;
	}

	


}
