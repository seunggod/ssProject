package com.book.user.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.book.user.dao.UserDao;
import com.book.user.vo.UserVo;

@Repository("userDao")
public class UserDaoImpl implements UserDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	
    //로그인
	@Override
	public UserVo login(HashMap<String, Object> map) {
		UserVo vo = sqlSession.selectOne("User.Login", map);
		return vo;
	}
	
    //회원가입
	@Override
	public void join(HashMap<String, Object> map) {
		System.out.println(map.get("birth"));
		sqlSession.insert("User.Join", map);
		
	}
	
    //아이디 찾기
	@Override
	public String idSearch(HashMap<String, Object> map) {
		String id = sqlSession.selectOne("User.IdSearch", map);
		return id;
	}
	
	//아이디 중복 체크
	@Override
	public String idDupCheck(HashMap<String, Object> map) {
		String id = sqlSession.selectOne("User.IdDupCheck", map);
		return id;
	}
	
	//닉네임 중복 확인
	@Override
	public String nickDupCheck(HashMap<String, Object> map) {
		String nickname = sqlSession.selectOne("User.NickDupCheck", map);
		return nickname;
	}
	
	//신고
	@Override
	public int report(HashMap<String, Object> map) {
		System.out.println(map);
		sqlSession.selectList("User.Report", map);
		int result = Integer.parseInt(String.valueOf(map.get("result")));
		
		return result;
	}

	//내 정보 가져오기
	@Override
	public UserVo getProfile(String nickname) {
		UserVo userInfo = sqlSession.selectOne("User.Profile", nickname);
		return userInfo;
	}

	//비밀번호 변경
	@Override
	public void pwdChange(HashMap<String, Object> map) {
		sqlSession.update("User.PwdChange", map);
		
	}

	//회원 탈퇴
	@Override
	public void withdrawal(int mem_num) {
		sqlSession.update("User.Withdrawal", mem_num);
		
	}

	//회원 정보 수정
	@Override
	public void updateProfile(HashMap<String, Object> map) {
		sqlSession.update("User.Update", map);
		
	}

}




