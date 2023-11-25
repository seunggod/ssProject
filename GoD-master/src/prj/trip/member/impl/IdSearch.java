package prj.trip.member.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.member.dao.MemberDao;
import prj.trip.member.service.Action;

public class IdSearch implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String year = request.getParameter("birth");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String gender = request.getParameter("gender");
		
		System.out.println(name);
		System.out.println(year);
		System.out.println(month);
		System.out.println(day);
		System.out.println(gender);
		MemberDao dao = new MemberDao();
		String id = dao.getIdSearch(name,year,month,day,gender);
		System.out.println("찾은 아이디"+id);
		
		request.setAttribute("searchid", id);
		
		String path = "/view/common/ID_Search.jsp?id=" + id;
		request.getRequestDispatcher(path).forward(request, response);
		
		
		
	
	}

}
