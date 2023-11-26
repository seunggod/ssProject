package com.book.fboard.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.fboard.dao.FBoardDao;
import com.book.fboard.service.FBoardService;
import com.book.fboard.vo.FBoardVo;

@Service("fBoardService")
public class FBoardServiceImpl implements FBoardService {
	
	@Autowired
	private FBoardDao fBoardDao;
	
	//자유게시판 불러오기
	@Override
	public List<FBoardVo> boardList(HashMap<String, Object> map) {
		List<FBoardVo> list = fBoardDao.boardList(map);
		
		//작성일 처리
		int i = 0;
						
		Calendar today = Calendar.getInstance();
		int year       = today.get(Calendar.YEAR);
		int month      = today.get(Calendar.MONTH)+1;
		int day        = today.get(Calendar.DATE);
		String sToday  = String.format("%02d-%02d", month,day);
		System.out.println("today:"+year +"-"+ sToday);
		for (FBoardVo fBoardVo : list) {
			i++;
			String date = fBoardVo.getRegdate();
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
			fBoardVo.setRegdate(date);
		}
		return list;
	}
	
	//게시물 수 가져오기
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		int cnt = fBoardDao.getBoardCount(map);
		return cnt;
	}

	//자유게시판 글쓰기
	@Override
	public void freeWrite(HashMap<String, Object> map, HttpServletRequest request) {
		
		FBoardFile.save(map, request);
		fBoardDao.freeWrite(map);
		
	}

	//추천 여부 확인
	@Override
	public int likeStatus(HashMap<String, Object> map) {
		int cnt = fBoardDao.likeStatus(map);
		return cnt;
	}

	//게시물 가져오기
	@Override
	public FBoardVo boardView(HashMap<String, Object> map) {
		FBoardVo vo = fBoardDao.boardView(map);
		String date = vo.getRegdate();
		date = date.substring(0,16);
		vo.setRegdate(date);
		return vo;
	}

	//추천수 증감
	@Override
	public int likeBoard(HashMap<String, Object> map) {
		int cnt = fBoardDao.likeBoard(map);
		return cnt;
	}

	//게시물 수정
	@Override
	public void update(HashMap<String, Object> map, HttpServletRequest request) {
		FBoardFile.save(map, request);
		fBoardDao.update(map);
		
	}
	
	//게시물 삭제
	@Override
	public void delete(HashMap<String, Object> map) {
		fBoardDao.delete(map);
		
	}

	//내 정보 - 좋아요 취소
	@Override
	public void boardLikeCancel(HashMap<String, Object> map) {
		fBoardDao.boardLikeCancel(map);
		
	}

	
}
