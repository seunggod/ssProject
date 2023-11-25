package prj.trip.member.impl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.member.dao.MemberDao;
import prj.trip.member.service.Action;

public class PwUpdate implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		System.out.println("아이디"+id);
		System.out.println("비밀번호"+pw);
		
		MemberDao dao = new MemberDao();
		dao.PWUpdate(id,pw);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String str="";
		str = "<script>";
		str += " alert('비밀번호 수정완료');";  
		str += " window.opener.location.href='/view/common/Login.jsp';";  //로그인화면
		str += " self.close();";   // 창닫기
		str += " </script>";
		out.print(str);
		out.close();
				
	}

}
