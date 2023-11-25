package prj.trip.member.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.member.dao.MemberDao;
import prj.trip.member.service.Action;

public class PwSearch implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String year = request.getParameter("birth");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String gender = request.getParameter("gender");
		String idd = request.getParameter("idd");
		
		System.out.println(idd);
		System.out.println(name);
		System.out.println(year);
		System.out.println(month);
		System.out.println(day);
		System.out.println(gender);
		
		MemberDao dao = new MemberDao();
		String pw = dao.getPwSearch(name,year,month,day,gender,idd);
		System.out.println("찾은 비밀번호"+pw);
		
		request.setAttribute("searchid", idd);
		request.setAttribute("searchpw", pw);
		
		String path = "/view/common/PW_Search.jsp?pw=" + pw;
		request.getRequestDispatcher(path).forward(request, response);
		
		
		
	
	}

}
