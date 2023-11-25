package prj.trip.member.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.member.dao.MemberDao;
import prj.trip.member.service.Action;


public class Login implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		
		String id = request.getParameter("id");
		String pw = request.getParameter("pwd");
		
		//System.out.println(id+"  "+pw);
		
		MemberDao vo = new MemberDao();
		
		int login = vo.Login(id,pw);
		
		
		String msg ="";
		 if(login == 1)    // 로그인 성공
	        { 
	            // 세션에 현재 아이디 세팅
	            session.setAttribute("LoginId", id);
	            // 세션에 닉네임 세팅
	            session.setAttribute("LoginNick", vo.getNick(id));
	            
	            msg = "/view/common/index.jsp";
	        }
	        else if(login == 0) // 비밀번호가 틀릴경우
	        {
	            msg = "/view/common/Login.jsp?msg=0";
	        }
	        else    // 아이디가 틀릴경우
	        {
	            msg = "/view/common/Login.jsp?msg=-1";
	        }
	         
	        
	        response.sendRedirect(msg);


	
	}

}
