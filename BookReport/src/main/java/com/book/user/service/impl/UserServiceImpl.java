package com.book.user.service.impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.book.user.dao.UserDao;
import com.book.user.service.UserService;
import com.book.user.vo.UserVo;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao   userDao;
	
	
    //로그인
	@Override
	public UserVo login(HashMap<String, Object> map) {
		UserVo vo = userDao.login(map);
		return vo;
	}
	
    //회원가입
	@Override
	public void join(HashMap<String, Object> map) {
		//전화번호 합치기
		String tel= map.get("tel1")+"-"+map.get("tel2")+"-"+map.get("tel3");
		map.put("tel", tel);
		//생년월일 합치기
		int monthNum =Integer.parseInt(String.valueOf( map.get("month")));
		int dayNum =Integer.parseInt(String.valueOf( map.get("day")));
		String month="";
		if(monthNum<10) {
			month = "0"+monthNum;
		} else {
			month =  String.valueOf(monthNum);
		}
		String day="";
		if(dayNum<10) {
			day = "0"+dayNum;
		} else {
			day =  String.valueOf(dayNum);
		}
	
	    String birth = map.get("year")+"-"+month+"-"+day;
		map.put("birth", birth);
		
		//랜덤 회원 레벨 입력
		//100이상부터 관리자 레벨
		int lvl = (int) ((Math.random()*99)+1);
		map.put("mem_lvl", lvl);
		
		userDao.join(map);
		
	}

	//아이디 찾기
	@Override
	public String idSearch(HashMap<String, Object> map) {
		//전화번호 합치기
		String tel= map.get("tel1")+"-"+map.get("tel2")+"-"+map.get("tel3");
		System.out.println("tel:"+tel);
		map.put("tel", tel);
		String id = userDao.idSearch(map);
		return id;
	}

	//아이디 중복 체크
	@Override
	public String idDupCheck(HashMap<String, Object> map) {
		String id = userDao.idDupCheck(map);
		System.out.println("[ID:]"+id);
		String msg="";
		if(id!=null) {  //1=중복 0=사용 가능
			msg = "1";
		} else {
			msg = "0";
		}
		return msg;
	}

	//닉네임 중복 체크
	@Override
	public String nickDupCheck(HashMap<String, Object> map) {
		String nickname = userDao.nickDupCheck(map);
		System.out.println("[NICK:]"+nickname);
		String msg="";
		if(nickname!=null) {
			msg = "1";
		} else {
			msg = "0";
		}
		return msg;
	} 
	
	//신고
	@Override
	public int report(HashMap<String, Object> map) {
		
		//신고사유가 기타일 경우 기타사유를 신고사유에 저장
		String reason = (String) map.get("reason");
		if(reason.equals("기타")) {
			String etc = (String) map.get("etc");
			map.put("reason", etc);
		}
		
		int result = userDao.report(map);
		return result;
	}

	//내 정보 가져오기
	@Override
	public UserVo getProfile(String nickname) {
		UserVo userInfo = userDao.getProfile(nickname);
		return userInfo;
	}

	//비밀번호 변경
	@Override
	public void pwdChange(HashMap<String, Object> map) {
		userDao.pwdChange(map);
		
	}

	//회원 탈퇴
	@Override
	public void withdrawal(int mem_num) {
		userDao.withdrawal(mem_num);
		
	}

	//회원 정보 수정
	@Override
	public void updateProfile(HashMap<String, Object> map) {
		//전화번호 합치기
		String tel= map.get("tel1")+"-"+map.get("tel2")+"-"+map.get("tel3");
		System.out.println("tel:"+tel);
		map.put("tel", tel);
		userDao.updateProfile(map);
		
	}


}







