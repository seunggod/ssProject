package com.book.bboard.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.book.bboard.dao.BBoardDao;
import com.book.bboard.service.BBoardService;
import com.book.bboard.vo.BBoardVo;
import com.book.book.vo.BookVo;

@Service("bBoardService")
public class BBoardServiceImpl implements BBoardService {

	@Autowired
	private BBoardDao bBoardDao;
	
	
	//게시판 가져오기
	@Override
	public List<BBoardVo> boardList(HashMap<String, Object> map) {
		
		List<BBoardVo> list = bBoardDao.boardList(map);
		
		//작성일 처리
		int i = 0;
		
		Calendar today = Calendar.getInstance();
		int year       = today.get(Calendar.YEAR);
		int month      = today.get(Calendar.MONTH)+1;
		int day        = today.get(Calendar.DATE);
		String sToday  = String.format("%02d-%02d", month,day);
		System.out.println("today:"+year +"-"+ sToday);
		for (BBoardVo bBoardVo : list) {
			i++;
			String date = bBoardVo.getRegdate();
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
			bBoardVo.setRegdate(date);
		}
		return list;
	}

	//도서 검색
	@Override
	public List<BookVo> bookSearch(HashMap<String, Object> map) {
		String keyword = (String) map.get("keyword");
		keyword =keyword.replace("\"", "");
		map.put("keyword", keyword);

		List<BookVo> bookList = bBoardDao.bookSearch(map);
		return bookList;
	}

	// 검색 결과 자료 수 가져오기
	@Override
	public int bookSearchResultCnt(String keyword) {
		keyword =keyword.replace("\"", "");
		int resultCnt = bBoardDao.bookSearchResultCnt(keyword);
		return resultCnt;
	}

	//도서 등록
	@Override
	public void bookWrite(HashMap<String, Object> map,HttpServletRequest request) {
		//request로 가져온 이미지 파일을 저장
		BBoardFile.save(map, request);
		System.out.println("file:"+map);
		
		bBoardDao.bookWrite(map);
	}

	//총 게시물 수 가져오기
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		int totalCount = bBoardDao.getBoardCount(map);
		return totalCount;
	}

	//게시물 가져오기
	@Override
	public BBoardVo boardView(HashMap<String, Object> map) {
		BBoardVo board = bBoardDao.boardView(map);
		String date = board.getRegdate();
		date = date.substring(0,16);
		board.setRegdate(date);
		return board;
	}

	//추천수 증감
	@Override
	public int likeBoard(HashMap<String, Object> map) {
		int cnt = bBoardDao.likeBoard(map);
		return cnt;
	}

	//추천 여부 확인
	@Override
	public int likeStatus(HashMap<String, Object> map) {
		int cnt = bBoardDao.likeStatus(map);
		return cnt;
	}

	//게시물 수정
	@Override
	public void update(HashMap<String, Object> map, HttpServletRequest request) {
		//파일 처리
		BBoardFile.save(map, request);
		System.out.println("file:"+map);
		
		bBoardDao.update(map);
		
	}
	
	//게시물 삭제
	@Override
	public void delete(HashMap<String, Object> map) {
		bBoardDao.delete(map);
		
	}

	//좋아요 취소
	@Override
	public void boardLikeCancel(HashMap<String, Object> map) {
		
		String board_num = "";
		List<Integer> list = (List<Integer>) map.get("boardNum");
		
		if(list != null) {
			for (int i = 0; i < list.size(); i++) {
				if(i == list.size()-1) 
					board_num += String.valueOf(list.get(i));
				else
					board_num += list.get(i)+",";
			}
			System.out.println("[board_num]:"+board_num);
			map.put("board_num", board_num);
			
		}
		
		bBoardDao.boardLikeCancel(map);
		
	}

}
