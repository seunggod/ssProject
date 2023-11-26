package com.book.notice.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.bboard.vo.BBoardVo;
import com.book.notice.dao.NoticeDao;
import com.book.notice.service.NoticeService;
import com.book.notice.vo.NoticeVo;

@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	
	//공지사항 목록
	@Override
	public List<NoticeVo> noticeList(HashMap<String, Object> map) {
		List<NoticeVo> list = noticeDao.noticeList(map);
		
		//작성일 처리
		int i = 0;
				
		Calendar today = Calendar.getInstance();
		int year       = today.get(Calendar.YEAR);
		int month      = today.get(Calendar.MONTH)+1;
		int day        = today.get(Calendar.DATE);
		String sToday  = String.format("%02d-%02d", month,day);
		System.out.println("today:"+year +"-"+ sToday);
		for (NoticeVo noticeVo : list) {
			i++;
			String date = noticeVo.getRegdate();
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
			noticeVo.setRegdate(date);
		}
		
		return list;
	}
	
	//공지 개수 조회
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		int totalCount = noticeDao.getBoardCount(map);
		return totalCount;
	}
	
	//공지사항 작성
	@Override
	public void noticeWrite(HashMap<String, Object> map, HttpServletRequest request) {
		//request로 가져온 이미지 파일을 저장
		NoticeFile.save(map, request);
		System.out.println("file:"+map);
		
		noticeDao.noticeWrite(map);
	}

	//공지사항 열람
	@Override
	public NoticeVo boardView(HashMap<String, Object> map) {
		NoticeVo vo  = noticeDao.boardView(map);
		String date = vo.getRegdate();
		date = date.substring(0,16);
		vo.setRegdate(date);
		return vo;
	}
	
	//추천여부 확인
	@Override
	public int likeStatus(HashMap<String, Object> map) {
		int cnt = noticeDao.likeStatus(map);
		return cnt;
	}

	//추천수 증감
	@Override
	public int likeBoard(HashMap<String, Object> map) {
		int cnt = noticeDao.likeBoard(map);
		return cnt;
	}

	//공지사항 수정
	@Override
	public void update(HashMap<String, Object> map, HttpServletRequest request) {
		//request로 가져온 이미지 파일을 저장
		NoticeFile.save(map, request);
		System.out.println("file:"+map);
		
		noticeDao.update(map);
	}

	//공지사항 삭제
	@Override
	public void delete(HashMap<String, Object> map) {
		noticeDao.delete(map);
		
		
	}

	//좋아요 취소(ajax)
	@Override
	public void likeCancel(HashMap<String, Object> map) {
		noticeDao.likeCancel(map);
		
	}




}
