package prj.trip.member.impl;

import java.io.IOException;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prj.trip.member.service.Action;


public class LoginOut implements Action{

	@Override
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession userSession = request.getSession();

		 userSession.invalidate();
		 response.sendRedirect("/view/common/index.jsp");
	}

}
