package prj.trip.member.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.member.dao.MemberDao;
import prj.trip.member.service.Action;
import prj.trip.member.vo.MemberVo;

public class getMemInfo implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String loginId = (String) session.getAttribute("LoginId");
		
		
		MemberDao dao = new MemberDao();
		MemberVo vo = dao.getmemInfo(loginId);
		
		System.out.println(vo);
		
		request.setAttribute("myinfo", vo);
		

		response.setContentType("text/html; charset=UTF-8");
		
		String path = "/view/myinfo/myinfo.jsp";
		
		request.getRequestDispatcher(path).forward(request, response);
		
		

	}

}
