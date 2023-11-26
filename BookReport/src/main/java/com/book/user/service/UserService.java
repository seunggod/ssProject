package com.book.user.service;

import java.util.HashMap;
import java.util.List;

import com.book.user.vo.UserVo;

public interface UserService {

    //로그인
	UserVo login(HashMap<String, Object> map);
    //회원가입
	void join(HashMap<String, Object> map);
	//아이디 찾기
	String idSearch(HashMap<String, Object> map);
	//아이디 중복체크
	String idDupCheck(HashMap<String, Object> map);
	//닉네임 중복체크
	String nickDupCheck(HashMap<String, Object> map);
	//신고
	int report(HashMap<String, Object> map);
	//내 정보 가져오기
	UserVo getProfile(String nickname);
	//비밀번호 변경
	void pwdChange(HashMap<String, Object> map);
	//회원 탈퇴
	void withdrawal(int mem_num);
	//회원 정보 수정
	void updateProfile(HashMap<String, Object> map);

	
	
}
