package prj.trip.member.impl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import prj.trip.member.dao.MemberDao;
import prj.trip.member.service.Action;

public class IdCheck implements Action {

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/html; charset=UTF-8");
		String id = request.getParameter("id");
		MemberDao dao = new MemberDao();
		int num = dao.IdCheck(id);
		response.getWriter().write(num + "");
		
	}

}
